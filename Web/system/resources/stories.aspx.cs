using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class stories : System.Web.UI.Page
    {
        protected List<BookStory> results;
        protected Book book;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            int bookId = int.Parse(Request["pageId"]);
            bool perm = Permissions.Check(opId, "Books", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                results = db.BookStories.Where(x=>x.bookId == bookId).ToList();
                book = db.Books.Where(x => x.id == bookId).SingleOrDefault();
            }
        }
    }
}