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
        protected List<Category> categories;
        protected List<HomeBanner> banners;
        protected string lang;
        protected int levelId;
        protected Student student;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("login");
            else
            {
                lang = Page.RouteData.Values["lang"].ToString();
                levelId = int.Parse(Page.RouteData.Values["id"].ToString());
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                categories = db.Categories.OrderBy(x => x.OrderIndex).ToList();
                banners = db.HomeBanners.ToList();
                int sId = (int)Session["UserId"];
                student = db.Students.Where(x=>x.id == sId).SingleOrDefault();
            }
        }
    }
}