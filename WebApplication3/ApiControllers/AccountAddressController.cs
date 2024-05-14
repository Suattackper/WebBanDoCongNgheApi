using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication3.Models;

namespace WebApplication3.ApiControllers
{
    public class AccountAddressController : ApiController
    {
        webapidemoEntities db = new webapidemoEntities();
        [HttpGet]
        public List<AccountAddress> GetAccountAddresses()
        {
            List<AccountAddress> p = db.AccountAddresses.ToList();
            return p;
        }
        [HttpPost]
        public AccountAddress PostAccountAdress(AccountAddress p)
        {
            db.AccountAddresses.Add(p);
            db.SaveChanges();
            return p;
        }
    }
}
