using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class _default2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            categories = db.Categories.OrderBy(x => x.OrderIndex).ToList();
            banners = db.HomeBanners.ToList();
            news = db.PressRooms.ToList();
            content = db.Contents.FirstOrDefault();
            if (Request.Url.AbsolutePath.Contains("default.aspx"))
            {
                Response.RedirectToRoute("ARHome");
            }
            else
            {
                lang = Page.RouteData.Values["lang"].ToString();
                student = null;
                if (Session["UserId"] != null)
                {
                    int sId = (int)Session["UserId"];
                    student = db.Students.Where(x => x.id == sId).SingleOrDefault();
                }
            }*/
            if (Session["UserId"] != null)
            {
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                var studentId = (long)Session["UserId"];
                var student = db.Students.Where(x => x.id == studentId).SingleOrDefault();
                Response.Redirect("/fr/level-" + student.levelId);
            }
            else
                Response.Redirect("/fr/login");
        }
    }
}