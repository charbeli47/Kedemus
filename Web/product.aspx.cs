    using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class product : System.Web.UI.Page
    {
        protected string lang;
        protected int bookId;
        protected Book result;
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
                    bookId = int.Parse(Page.RouteData.Values["id"].ToString());
                    result = db.Books.Where(x => x.id == bookId).SingleOrDefault();
                    int userLevelId = (int)usr.levelId;
                    if (result.levelId != userLevelId &&  (result.isSingleBook==null || result.isSingleBook == false))
                    {
                        Response.Redirect("/");
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