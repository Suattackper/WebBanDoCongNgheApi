using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WebApplication3.Controllers
{
    public class ProductController : Controller
    {
        // GET: Product
        public ActionResult Shop()
        {
            ViewBag.Shop = 0;
            ViewBag.Title = "Shop";
            return View();
        }
        public ActionResult ShopSmartHome()
        {
            ViewBag.Shop = 1;
            ViewBag.Title = "SmartHome";
            return View("Shop");
        }
        public ActionResult ShopPhuKien()
        {
            ViewBag.Shop = 2;
            ViewBag.Title = "PhuKien";
            return View("Shop");
        }
        public ActionResult ShopGamingGear()
        {
            ViewBag.Shop = 3;
            ViewBag.Title = "GamingGear";
            return View("Shop");
        }
    }
}