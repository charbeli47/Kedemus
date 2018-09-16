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
        protected int bookId;
        protected List<BookPoster> gamesList;
        protected Student student;
        protected Book book;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
                Response.Redirect("login");
            else
            {
                int bookId = int.Parse(Request["bookId"]);
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                long sId = (long)Session["UserId"];
                student = db.Students.Where(x => x.id == sId).SingleOrDefault();
                gamesList = db.BookPosters.Where(x => x.bookId == bookId).ToList();
                book = db.Books.Where(x => x.id == bookId).SingleOrDefault();
                if (student.School.showGame == false)
                    Response.Redirect("books");
            }
        }
    }
}