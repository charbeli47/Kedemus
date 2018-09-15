using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.system.resources
{
    public partial class books : System.Web.UI.Page
    {
        protected int pageSize = 10;
        protected int page = 1;
        protected int PageCount;
        protected int resultCount;
        protected List<Book> results;
        protected List<Category> categories;
        protected List<Level> levels;
        protected string searchKey = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            int.TryParse(Request["page"], out page);
            bool perm = Permissions.Check(opId, "Books", "view");
            searchKey = Request["key"];
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                
                var allresults = db.Books.OrderByDescending(x => x.id).ToList();
                if (!string.IsNullOrEmpty(searchKey))
                    allresults = allresults.Where(x => x.title.ToLower().Contains(searchKey) || x.text.ToLower().Contains(searchKey) || x.artitle.ToLower().Contains(searchKey) || x.artext.ToLower().Contains(searchKey)).ToList();
                resultCount = allresults.Count;
                PageCount = resultCount / pageSize;
                if (allresults.Count % pageSize > 0)
                    PageCount += 1;
                if (page < 1 || page > PageCount)
                    page = 1;
                results = allresults.Skip((page - 1) * pageSize)
                       .Take(pageSize).ToList();
                categories = db.Categories.ToList();
                levels = db.Levels.ToList();                
            }
        }
    }
}