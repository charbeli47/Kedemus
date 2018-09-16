    using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class story : System.Web.UI.Page
    {
        protected string lang;
        protected int storyId;
        protected BookStory result;
        protected Student usr;
        protected BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("login");
            else
            {
                long sId = (long)Session["UserId"];
                
                usr = db.Students.Where(x => x.id == sId).SingleOrDefault();
                if (usr != null)
                {
                    lang = Page.RouteData.Values["lang"].ToString();
                    storyId = int.Parse(Page.RouteData.Values["id"].ToString());
                    result = db.BookStories.Where(x => x.id == storyId).SingleOrDefault();
                    int userLevelId = (int)usr.levelId;
                    if (result.Book.levelId != userLevelId)
                    {
                        Response.Redirect("home");
                    }
                }
                else
                {
                    Response.Redirect("login");
                }
            }
        }
    }
}