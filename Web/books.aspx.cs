using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class books : System.Web.UI.Page
    {
        protected string lang;
        protected int levelId;
        protected Student student;
        protected List<Book> results;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("login");
            else
            {
                lang = Page.RouteData.Values["lang"].ToString();
                levelId = int.Parse(Page.RouteData.Values["levelId"].ToString());
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                long sId = (long)Session["UserId"];
                results = db.Books.Where(x => x.lang == lang && x.isAvailable == true && x.levelId == levelId).ToList();
                student = db.Students.Where(x=>x.id == sId).SingleOrDefault();
            }
        }
    }
}