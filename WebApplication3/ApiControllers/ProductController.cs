using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication3.Models;

namespace WebApplication3.ApiControllers
{
    public class ProductController : ApiController
    {
        webapidemoEntities db = new webapidemoEntities();
        [HttpGet]
        public List<Product> GetProducts()
        {
            List<Product> p = db.Products.ToList();
            return p;
        }
        [HttpGet]
        public List<Product> GetProductsByCate(int catecode)
        {
            List<Product> p = db.Products.Where(i=>i.CategoryCode== catecode).ToList();
            return p;
        }
        [HttpGet]
        [Route("api/product/search")]
        public List<Product> GetProductByName(string name)
        {
            List<Product> p = db.Products.Where(i => i.ProductName.Contains(name)).ToList();
            return p;
        }
    }
}
