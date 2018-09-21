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
        protected List<BooksLevel> levels;
        protected string searchKey = "", levelsList, categoriesList;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            int.TryParse(Request["page"], out page);
            bool perm = Permissions.Check(opId, "Books", "view");
            searchKey = !string.IsNullOrEmpty(Request["key"])? Request["key"].ToLower():"" ;
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                
                var allresults = db.Books.OrderByDescending(x => x.id).ToList();
                if (!string.IsNullOrEmpty(searchKey))
                    allresults = allresults.Where(x => x.title.ToLower().Contains(searchKey)).ToList();
                resultCount = allresults.Count;
                PageCount = resultCount / pageSize;
                if (allresults.Count % pageSize > 0)
                    PageCount += 1;
                if (page < 1 || page > PageCount)
                    page = 1;
                results = allresults.Skip((page - 1) * pageSize)
                       .Take(pageSize).ToList();
                levels = db.BooksLevels.ToList();
                levelselect.DataSource = levels;
                levelselect.DataTextField = "title";
                levelselect.DataValueField = "id";
                levelselect.DataBind();
                foreach (BooksLevel level in levels)
                {
                    levelsList += ",{ value: " + level.id + ", text: '" + level.title + "' }";
                }
                if (!string.IsNullOrEmpty(levelsList))
                    levelsList = levelsList.Substring(1);

                var categories = db.Categories.ToList();
                categoryselect.DataSource = categories;
                categoryselect.DataTextField = "title";
                categoryselect.DataValueField = "id";
                categoryselect.DataBind();
                foreach (Category category in categories)
                {
                    categoriesList += ",{ value: " + category.id + ", text: '" + category.title + "' }";
                }
                if (!string.IsNullOrEmpty(categoriesList))
                    categoriesList = categoriesList.Substring(1);
            }
        }
    }
}