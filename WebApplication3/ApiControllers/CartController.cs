using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApplication3.Models;

namespace WebApplication3.ApiControllers
{
    public class CartController : ApiController
    {
        webapidemoEntities db = new webapidemoEntities();
        [HttpGet]
        public List<Cart> GetCarts()
        {
            List<Cart> p = db.Carts.ToList();
            return p;
        }
        [HttpGet]
        public List<Cart> GetCarts(int AccountCode)
        {
            List<Cart> p = db.Carts.Where(i=>i.AccountCode==AccountCode).ToList();
            return p;
        }
        [HttpPost]
        public void PostCart(Cart res)
        {
            Cart c = db.Carts.FirstOrDefault(i => i.AccountCode == res.AccountCode && i.ProductCode == res.ProductCode);
            if(c != null)
            {
                c.Quantity = c.Quantity + 1;
                db.SaveChanges();
            }
            else
            {
                Product p = db.Products.FirstOrDefault(i => i.ProductCode == res.ProductCode);
                res.ProductName = p.ProductName;
                res.CategoryCode = p.CategoryCode;
                res.ImageProduct = p.ImageProduct;
                res.Quantity = 1;
                res.Price = p.Price;
                db.Carts.Add(res);
                db.SaveChanges();
            }
        }
        [HttpDelete]
        [Route("api/cart/deleteclick")]
        public void DeleteCartClick(Cart res)
        {
            Cart c = db.Carts.FirstOrDefault(i => i.AccountCode == res.AccountCode && i.ProductCode == res.ProductCode);
            if (c.Quantity==1)
            {
                db.Carts.Remove(c);
                db.SaveChanges();
            }
            else
            {
                c.Quantity--;
                db.SaveChanges();
            }
        }
        [HttpDelete]
        public void DeleteCart(Cart res)
        {
            Cart c = db.Carts.FirstOrDefault(i => i.AccountCode == res.AccountCode && i.ProductCode == res.ProductCode);
            db.Carts.Remove(c);
            db.SaveChanges();
        }
    }
}
