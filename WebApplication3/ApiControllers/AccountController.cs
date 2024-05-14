using electronics_shop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Principal;
using System.Text.RegularExpressions;
using System.Web.Helpers;
using System.Web.Http;
using WebApplication3.Models;

namespace WebApplication3.ApiControllers
{
    public class AccountController : ApiController
    {
        webapidemoEntities db = new webapidemoEntities();
        [HttpGet]
        [Route("api/account/read")]
        public List<Account> GetAccounts()
        {
            List<Account> p = db.Accounts.ToList();
            return p;
        }
        [HttpGet]
        public Account GetAccountByEmail(int id)
        {
            Account p = db.Accounts.FirstOrDefault(i=>i.AccountCode==id);
            return p;
        }
        [HttpPost]
        [Route("api/account/check")]
        public Account Check(Account p)
        {
            // Biểu thức chính quy để kiểm tra định dạng email
            Regex regex = new Regex(@"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
            if (!regex.IsMatch(p.Email)) return null;

            var password = Encryptor.MD5Hash(p.Password);
            Account q = db.Accounts.SingleOrDefault(i => i.Email == p.Email && i.Password == password);
            if (q != null) return q;
            else return q;
        }
        [HttpPost]
        [Route("api/account/create")]
        public Account PostAccounts(Account p)
        {
            // Biểu thức chính quy để kiểm tra định dạng email
            Regex regex = new Regex(@"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
            if (!regex.IsMatch(p.Email)) return null;

            Account q = db.Accounts.FirstOrDefault(i => i.Email == p.Email);
            if (q != null) return null;
            else
            {
                p.Password = Encryptor.MD5Hash(p.Password);
                p.RoleID = 3;
                p.CreateAt = DateTime.Now;
                p.Update_By = p.Email;
                p.Update_At = DateTime.Now;
                db.Accounts.Add(p);
                db.SaveChanges();
                return p;
            }
        }
    }
}
