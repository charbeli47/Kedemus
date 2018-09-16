using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class stories : System.Web.UI.Page
    {
        protected string lang;
        protected int bookId;
        protected Student student;
        protected List<BookStory> results;
        protected Book book;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("login");
            else
            {
                lang = Page.RouteData.Values["lang"].ToString();
                bookId = int.Parse(Page.RouteData.Values["bookId"].ToString());
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                long sId = (long)Session["UserId"];
                book = db.Books.Where(x => x.id == bookId).SingleOrDefault();
                results = db.BookStories.Where(x => x.bookId == bookId).ToList();
                student = db.Students.Where(x=>x.id == sId).SingleOrDefault();
            }
        }
    }
}