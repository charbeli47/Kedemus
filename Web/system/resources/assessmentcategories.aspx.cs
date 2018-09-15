using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.system.resources
{
    public partial class assessmentcategories : System.Web.UI.Page
    {
        protected List<QuestionsCategory> results;
        protected string booksList;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            bool perm = Permissions.Check(opId, "Assessment", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                results = db.QuestionsCategories.ToList().ToList();
                var books = db.Books.ToList();
                bookSelect.DataSource = books;
                bookSelect.DataTextField = "title";
                bookSelect.DataValueField = "id";
                bookSelect.DataBind();
                foreach(var book in books)
                {
                    booksList += ",{ value: " + book.id + ", text: \"" + book.title + "\" }";
                }
                if (!string.IsNullOrEmpty(booksList))
                    booksList = booksList.Substring(1);
            }
        }
    }
}