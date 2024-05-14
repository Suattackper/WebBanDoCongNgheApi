using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication3.Models;

namespace WebApplication3.ApiControllers
{
    public class OrderController : ApiController
    {
        webapidemoEntities db = new webapidemoEntities();
        [HttpGet]
        public List<Order> GetOrders()
        {
            List<Order> p = db.Orders.ToList();
            return p;
        }
        [HttpPost]
        [Route("api/order/create")]
        public Order PostOrder(Order p)
        {
            p.OrderDate = DateTime.Now;
            //p.Delivered = false;
            db.Orders.Add(p);
            db.SaveChanges();
            return p;
        }
        [HttpPut]
        public void PutOrder(Order p)
        {
            Order c = db.Orders.FirstOrDefault(i=>i.OrderCode==p.OrderCode);
            c.OrderTotal = p.OrderTotal;    
            db.SaveChanges();
        }

        //[HttpPost]
        //public void PostOrders(string PhoneNumber, string Address, string City, string PaymentCode, string AccountCode)
        //{
        //    //Thêm địa chỉ tài khoản
        //    AccountAddress a = new AccountAddress();
        //    a.Address = Address;
        //    a.City = City;
        //    a.AccountCode = int.Parse(AccountCode);
        //    a.PhoneNumber = PhoneNumber;
        //    db.AccountAddresses.Add(a);
        //    db.SaveChanges();

        //    //Tạo đơn hàng
        //    Order o = new Order();
        //    o.AccountCode = int.Parse(AccountCode);
        //    o.PaymentCode = int.Parse(PaymentCode);
        //    o.OrderDate = DateTime.Now;
        //    o.AccountAddressCode = a.AccountAddressCode;
        //    o.Delivered = false;
        //    db.Orders.Add(o);
        //    db.SaveChanges();

        //    //Tính tổng đơn và thêm chi tiết đơn hàng, xóa giỏ hàng
        //    decimal? total = 30000;
        //    List<Cart> lc = db.Carts.Where(i => i.AccountCode == int.Parse(AccountCode)).ToList();
        //    foreach (Cart c in lc)
        //    {
        //        OrderDetail od = new OrderDetail();
        //        od.OrderCode = o.OrderCode;
        //        od.ProductCode = c.ProductCode;
        //        od.Price = c.Price;
        //        od.Quantity = c.Quantity;
        //        od.Total = c.Quantity * c.Price;
        //        db.OrderDetails.Add(od);
        //        db.Carts.Remove(c);
        //        db.SaveChanges();
        //        total = total + od.Total;
        //    }

        //    o.OrderTotal = total;
        //    db.SaveChanges();
        //}
    }
}
