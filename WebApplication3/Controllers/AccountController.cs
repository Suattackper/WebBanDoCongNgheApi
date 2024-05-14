using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http.Headers;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using WebApplication3.Models;
using VNPAY_CS_ASPX;

namespace WebApplication3.Controllers
{
    public class AccountController : Controller
    {
        webapidemoEntities db = new webapidemoEntities();
        // GET: Account
        public ActionResult Login()
        {
            return View();
        }
        public ActionResult Signup()
        {
            return View();
        }
        public ActionResult GoogleLogin()
        {
            string clientId = ConfigurationManager.AppSettings["GoogleClientId"];
            // tạo ra URL
            string redirectUri = Url.Action("GoogleLoginCallback", "Account", null, Request.Url.Scheme);
            // Thêm các phạm vi truy cập cần thiết vào đây
            string scope = "openid email profile";
            string googleUrl = string.Format("https://accounts.google.com/o/oauth2/auth?redirect_uri={0}&response_type=code&client_id={1}&scope={2}&approval_prompt=force&access_type=offline", redirectUri, clientId, scope);
            return Redirect(googleUrl);
        }
        public async Task<ActionResult> GoogleLoginCallback(string code)
        {
            //Lấy thông tin truy cập từ Google
            string clientId = ConfigurationManager.AppSettings["GoogleClientId"];
            string clientSecret = ConfigurationManager.AppSettings["GoogleClientSecret"];
            string redirectUri = Url.Action("GoogleLoginCallback", "Account", null, Request.Url.Scheme);

            //Tạo một dictionary tokenRequestParameters chứa các thông tin cần thiết cho yêu cầu mã truy cập từ Google.
            var tokenRequestParameters = new Dictionary<string, string>
            {
                { "code", code },
                { "client_id", clientId },
                { "client_secret", clientSecret },
                { "redirect_uri", redirectUri },
                { "grant_type", "authorization_code" }
            };

            var tokenClient = new HttpClient();
            var tokenResponse = await tokenClient.PostAsync("https://oauth2.googleapis.com/token", new FormUrlEncodedContent(tokenRequestParameters));
            //đọc nội dung của phản hồi dưới dạng một chuỗi
            var tokenResponseContent = await tokenResponse.Content.ReadAsStringAsync();
            //phân tích chuỗi JSON phản hồi từ Google thành một đối tượng Dictionary chứa thông tin về access token và các thông tin liên quan
            var tokenData = JsonConvert.DeserializeObject<Dictionary<string, string>>(tokenResponseContent);

            // Sử dụng token truy cập để lấy thông tin người dùng từ Google API
            var accessToken = tokenData["access_token"];
            var userInfoClient = new HttpClient();
            userInfoClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", accessToken);
            // gửi một yêu cầu GET đến https://www.googleapis.com/oauth2/v3/userinfo của Google API để lấy thông tin người dùng
            var userInfoResponse = await userInfoClient.GetAsync("https://www.googleapis.com/oauth2/v3/userinfo");
            //đọc nội dung của phản hồi dưới dạng một chuỗi
            var userInfoResponseContent = await userInfoResponse.Content.ReadAsStringAsync();
            //phân tích chuỗi JSON của nội dung phản hồi thành một đối tượng dynamic chứa thông tin về người dùng từ Google API
            var userInfo = JsonConvert.DeserializeObject<dynamic>(userInfoResponseContent);

            Account account = new Account();
            account.FirstName = userInfo.given_name; // Tên đệm của người dùng
            account.LastName = userInfo.family_name; // Họ của người dùngaaa23
            account.Email = userInfo.email;

            var checkMail = db.Accounts.Where(m => m.Email == account.Email).FirstOrDefault();

            if (checkMail != null)
            {
                // Kiểm tra email có trong CSDL
                //Session["info"] = checkMail;
                return RedirectToAction("Index", "Home", new {code=checkMail.AccountCode});
            }
            else
            {
                //string imagePath = Server.MapPath("~/Content/images/comments/profile_1.png");
                //byte[] imageBytes = System.IO.File.ReadAllBytes(imagePath);

                account.RoleID = 3;
                account.CreateAt = DateTime.Now;
                //account.Avatar = imageBytes;
                account.Update_By = account.Email;
                account.Update_At = DateTime.Now;

                db.Accounts.Add(account);
                db.SaveChanges();
                //var check = db.Accounts.SingleOrDefault(m => m.Email == account.Email);
                //Session["info"] = check;
                return RedirectToAction("Index", "Home", new { code = account.AccountCode });
            }

        }
        public ActionResult FacebookLogin()
        {
            string appId = ConfigurationManager.AppSettings["FacebookAppId"];
            string redirectUri = Url.Action("FacebookLoginCallback", "Account", null, Request.Url.Scheme);

            // Xác định các phạm vi truy cập mà bạn muốn yêu cầu
            string scope = "email public_profile";

            string facebookUrl = string.Format("https://www.facebook.com/v12.0/dialog/oauth?client_id={0}&redirect_uri={1}&response_type=code&scope={2}", appId, redirectUri, scope);
            //Chuyển hướng người dùng đến trang xác nhận đăng nhập
            return Redirect(facebookUrl);
        }
        public async Task<ActionResult> FacebookLoginCallback(string code)
        {
            string appId = ConfigurationManager.AppSettings["FacebookAppId"];
            string appSecret = ConfigurationManager.AppSettings["FacebookAppSecret"];
            string redirectUri = Url.Action("FacebookLoginCallback", "Account", null, Request.Url.Scheme);

            //Tạo một dictionary tokenRequestParameters chứa các thông tin cần thiết cho yêu cầu mã truy cập từ Facebook.
            var tokenRequestParameters = new Dictionary<string, string>
            {
                { "code", code },
                { "client_id", appId },
                { "client_secret", appSecret },
                { "redirect_uri", redirectUri }
            };

            var tokenClient = new HttpClient();
            var tokenResponse = await tokenClient.GetAsync("https://graph.facebook.com/v12.0/oauth/access_token?" + string.Join("&", tokenRequestParameters.Select(x => $"{x.Key}={x.Value}")));
            var tokenResponseContent = await tokenResponse.Content.ReadAsStringAsync();
            var tokenData = JsonConvert.DeserializeObject<Dictionary<string, string>>(tokenResponseContent);

            string accessToken = tokenData["access_token"];

            // Sử dụng accessToken để gọi API Facebook để lấy thông tin người dùng
            var userInfoClient = new HttpClient();
            var userInfoResponse = await userInfoClient.GetAsync($"https://graph.facebook.com/me?fields=id,name,email,first_name,last_name&access_token={accessToken}");

            var userInfoResponseContent = await userInfoResponse.Content.ReadAsStringAsync();
            var userInfo = JsonConvert.DeserializeObject<dynamic>(userInfoResponseContent);

            // Xử lý thông tin người dùng và lưu vào Session hoặc cơ sở dữ liệu
            Account account = new Account();
            account.FirstName = userInfo.first_name; // Tên đệm của người dùng
            account.LastName = userInfo.last_name; // Họ của người dùng
            account.Email = userInfo.email;


            var checkMail = db.Accounts.Where(m => m.Email == account.Email).FirstOrDefault();
            //var checkPhone = db.Accounts.Where(m => m.PhoneNumber == account.PhoneNumber).FirstOrDefault();

            if (checkMail != null)
            {
                // Kiểm tra email và sdt có trong CSDL
                //Session["info"] = checkMail;
                return RedirectToAction("Index", "Home", new { code = checkMail.AccountCode });
            }
            else
            {
                //string imagePath = Server.MapPath("~/Content/images/comments/profile_1.png");
                //byte[] imageBytes = System.IO.File.ReadAllBytes(imagePath);

                account.RoleID = 3;
                account.CreateAt = DateTime.Now;
                //account.Avatar = imageBytes;
                account.Update_By = account.Email;
                account.Update_At = DateTime.Now;

                db.Accounts.Add(account);
                db.SaveChanges();
                //var check = db.Accounts.SingleOrDefault(m => m.Email == account.Email);
                //Session["info"] = check;
                return RedirectToAction("Index", "Home", new { code = account.AccountCode });
            }
        }
        public ActionResult UrlVnpay(int accountaddresscode, int ordertotal)
        {
            var url = UrlPayment(0, accountaddresscode, ordertotal);
            return Redirect(url);
        }
        //thanh toan vnpay
        public string UrlPayment(int TypePaymentVN, int accountaddresscode, int ordertotal)
        {
            var urlPayment = "";
            Order order = new Order();
            order.AccountAddressCode = accountaddresscode;
            order.OrderTotal = ordertotal;
            order.Delivered = false;
            order.PaymentCode = 3;
            order.OrderDate = DateTime.Now;
            Account account = (Account)Session["UserId"];
            order.AccountCode = account.AccountCode;
            db.Orders.Add(order);
            db.SaveChanges();

            //Get Config Info
            string vnp_Returnurl = ConfigurationManager.AppSettings["vnp_Returnurl"]; //URL nhan ket qua tra ve 
            string vnp_Url = ConfigurationManager.AppSettings["vnp_Url"]; //URL thanh toan cua VNPAY 
            string vnp_TmnCode = ConfigurationManager.AppSettings["vnp_TmnCode"]; //Ma định danh merchant kết nối (Terminal Id)
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Secret Key

            //Build URL for VNPAY
            VnPayLibrary vnpay = new VnPayLibrary();
            var Price = ordertotal;
            vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnpay.AddRequestData("vnp_Amount", Price.ToString()); //Số tiền thanh toán. Số tiền không mang các ký tự phân tách thập phân, phần nghìn, ký tự tiền tệ. Để gửi số tiền thanh toán là 100,000 VND (một trăm nghìn VNĐ) thì merchant cần nhân thêm 100 lần (khử phần thập phân), sau đó gửi sang VNPAY là: 10000000
            if (TypePaymentVN == 1)
            {
                vnpay.AddRequestData("vnp_BankCode", "VNPAYQR");
            }
            else if (TypePaymentVN == 2)
            {
                vnpay.AddRequestData("vnp_BankCode", "VNBANK");
            }
            else if (TypePaymentVN == 3)
            {
                vnpay.AddRequestData("vnp_BankCode", "INTCARD");
            }

            vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());
            vnpay.AddRequestData("vnp_Locale", "vn");
            vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:" +order.OrderCode.ToString());
            vnpay.AddRequestData("vnp_OrderType", "other"); //default value: other

            vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
            vnpay.AddRequestData("vnp_TxnRef", order.OrderCode.ToString()); // Mã tham chiếu của giao dịch tại hệ thống của merchant. Mã này là duy nhất dùng để phân biệt các đơn hàng gửi sang VNPAY. Không được trùng lặp trong ngày
            urlPayment = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);

            return urlPayment;
        }
        public ActionResult VnpayReturn()
        {
            if (Request.QueryString.Count > 0)
            {
                string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Chuoi bi mat
                var vnpayData = Request.QueryString;
                VnPayLibrary vnpay = new VnPayLibrary();

                foreach (string s in vnpayData)
                {
                    //get all querystring data
                    if (!string.IsNullOrEmpty(s) && s.StartsWith("vnp_"))
                    {
                        vnpay.AddResponseData(s, vnpayData[s]);
                    }
                }
                long orderId = Convert.ToInt64(vnpay.GetResponseData("vnp_TxnRef"));
                long vnpayTranId = Convert.ToInt64(vnpay.GetResponseData("vnp_TransactionNo"));
                string vnp_ResponseCode = vnpay.GetResponseData("vnp_ResponseCode");
                string vnp_TransactionStatus = vnpay.GetResponseData("vnp_TransactionStatus");
                String vnp_SecureHash = Request.QueryString["vnp_SecureHash"];
                String TerminalID = Request.QueryString["vnp_TmnCode"];
                long vnp_Amount = Convert.ToInt64(vnpay.GetResponseData("vnp_Amount")) / 100;
                String bankCode = Request.QueryString["vnp_BankCode"];

                bool checkSignature = vnpay.ValidateSignature(vnp_SecureHash, vnp_HashSecret);
                if (checkSignature)
                {
                    if (vnp_ResponseCode == "00" && vnp_TransactionStatus == "00")
                    {
                        ViewBag.Thanhcong = 1;
                        Account account = (Account)Session["UserId"];
                        List<Cart> lc = db.Carts.Where(i => i.AccountCode == account.AccountCode).ToList();
                        foreach (Cart c in lc)
                        {
                            OrderDetail od = new OrderDetail();
                            od.OrderCode = (int)orderId;
                            od.ProductCode = c.ProductCode;
                            od.Price = c.Price;
                            od.Quantity = c.Quantity;
                            od.Total = c.Quantity * c.Price;
                            db.OrderDetails.Add(od);
                            db.Carts.Remove(c);
                            db.SaveChanges();
                        }
                        //var itemOrder = db.Orders.FirstOrDefault(x => x.OrderCode == orderId);
                        //if (itemOrder != null)
                        //{
                        //    itemOrder.PaymentCode = 2;
                        //    db.Orders.Attach(itemOrder);
                        //    db.Entry(itemOrder).State = System.Data.Entity.EntityState.Modified;
                        //    db.SaveChanges();
                        //}
                        //Thanh toan thanh cong
                        ViewBag.InnerText = "Giao dịch được thực hiện thành công. Cảm ơn quý khách đã sử dụng dịch vụ";
                        //log.InfoFormat("Thanh toan thanh cong, OrderId={0}, VNPAY TranId={1}", orderId, vnpayTranId);
                    }
                    else
                    {
                        Order order = db.Orders.FirstOrDefault(p => p.OrderCode == orderId);
                        AccountAddress accountAddress = db.AccountAddresses.OrderByDescending(p => p.AccountAddressCode).FirstOrDefault();

                        //Account account = (Account)Session["UserId"];
                        //List<OrderDetail> lc = db.OrderDetails.Where(i => i.OrderCode == order.OrderCode).ToList();
                        //foreach (OrderDetail c in lc)
                        //{
                        //    Cart od = new Cart();
                        //    od.AccountCode = account.AccountCode;
                        //    od.ProductCode = c.ProductCode;
                        //    od.Price = c.Price;
                        //    od.Quantity = c.Quantity;
                        //    db.Carts.Add(od);
                        //    db.OrderDetails.Remove(c);
                        //    db.SaveChanges();
                        //}
                        db.Orders.Remove(order);
                        db.AccountAddresses.Remove(accountAddress);
                        db.SaveChanges();
                        //Thanh toan khong thanh cong. Ma loi: vnp_ResponseCode
                        ViewBag.InnerText = "Có lỗi xảy ra trong quá trình xử lý.Mã lỗi: " + vnp_ResponseCode;
                        //log.InfoFormat("Thanh toan loi, OrderId={0}, VNPAY TranId={1},ResponseCode={2}", orderId, vnpayTranId, vnp_ResponseCode);
                    }
                    //displayTmnCode.InnerText = "Mã Website (Terminal ID):" + TerminalID;
                    ViewBag.Id = "Mã giao dịch thanh toán:" + orderId.ToString();
                    ViewBag.MaGiaoDich = "Mã giao dịch tại VNPAY:" + vnpayTranId.ToString();
                    ViewBag.ThanhToanThanhCong = "Số tiền thanh toán (VND):" + vnp_Amount.ToString();
                    ViewBag.NganHang = "ngân hàng thanh toán:" + bankCode;
                }
            }

            return View();
        }
    }
}