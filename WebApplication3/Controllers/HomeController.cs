using System;
using System.Collections.Generic;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebApplication3.Models;

namespace WebApplication3.Controllers
{
    public class HomeController : Controller
    {
        webapidemoEntities db = new webapidemoEntities();
        // GET: Home
        //public ActionResult Index()
        //{
        //    return View();
        //}
        public ActionResult Index(int? code)
        {
            if (code != null)
            {
                Account p = db.Accounts.FirstOrDefault(i => i.AccountCode == code);
                Session["UserId"] = p;
            }
            else
            {

                Session.Remove("UserId");
            }
            return View();
        }
        public ActionResult Checkout(int? subtt)
        {
            if (subtt != null)
            {
                int? x = subtt + 30000;
                string formattedsubtt = String.Format("{0:N0}", subtt);
                string formattedtotal = String.Format("{0:N0}", x);
                ViewBag.subtotal = formattedsubtt;
                ViewBag.total = formattedtotal;
                ViewBag.tong = x;
            }
            return View();
        }
        public ActionResult Complete()
        {
            return View();
        }
    }
}