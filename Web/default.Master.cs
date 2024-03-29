﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class _default1 : System.Web.UI.MasterPage
    {
        protected List<BooksLevel> levels;
        protected string lang;
        protected BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
        protected Student usr;
        protected void Page_Load(object sender, EventArgs e)
        {
            lang = "";
            if (Page.RouteData.Values["lang"] != null)
                lang = Page.RouteData.Values["lang"].ToString();
            
            levels = db.BooksLevels.ToList();
            usr = null;
            if(Session["UserId"]!=null)
            {
                long sId = (long)Session["UserId"];
                usr = db.Students.Where(x => x.id == sId).SingleOrDefault();
            }
        }
    }
}