using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication3.Models;

namespace WebApplication3.ApiControllers
{
    public class OrderDetailController : ApiController
    {
        webapidemoEntities db = new webapidemoEntities();
        [HttpGet]
        public List<OrderDetail> GetOrderDetails()
        {
            List<OrderDetail> p = db.OrderDetails.ToList();
            return p;
        }
        [HttpPost]
        public void PostOrderDetail(OrderDetail res)
        {
            db.OrderDetails.Add(res);
            db.SaveChanges();
        }
    }
}
