using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class games : System.Web.UI.Page
    {
        protected List<HomeBanner> banners;
        protected string lang;
        protected int levelId;
        protected List<BookGame> gamesList;
        protected Student student;
        protected List<Category> categories;
        protected Category GameCategory;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("login");
            else
            {
                int categoryId = int.Parse(Request["categoryId"]);
                lang = Page.RouteData.Values["lang"].ToString();
                levelId = int.Parse(Request["levelId"]);
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                GameCategory = db.Categories.Where(x => x.id == categoryId).SingleOrDefault();
                categories = db.Categories.OrderBy(x => x.OrderIndex).ToList();
                banners = db.HomeBanners.ToList();
                int sId = (int)Session["UserId"];
                student = db.Students.Where(x => x.id == sId).SingleOrDefault();
                gamesList = db.BookGames.Where(x => x.levelId == levelId && x.SchoolGames.Where(z=>z.schoolId == student.schoolId).Count()>0 && x.categoryId == categoryId).ToList();
                
                if (student.School.showGame == false)
                    Response.Redirect("level-" + levelId);
            }
        }
    }
}