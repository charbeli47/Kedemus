using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class games : System.Web.UI.Page
    {
        protected List<BookGame> results;
        protected Level level;
        protected List<Category> categories;
        protected string categoriesList = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            int levelId = int.Parse(Request["pageId"]);
            bool perm = Permissions.Check(opId, "Books", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                level = db.Levels.Where(x => x.id == levelId).SingleOrDefault();
                results = db.BookGames.Where(x=>x.levelId == levelId).ToList();
                categories = db.Categories.Where(x => x.ForGame == true).ToList();
                categoriesSelect.DataSource = categories;
                categoriesSelect.DataTextField = "title";
                categoriesSelect.DataValueField = "id";
                categoriesSelect.DataBind();
                categoriesSelect.Items.Insert(0, new ListItem("None", "0"));
                foreach (var category in categories)
                {
                    categoriesList += ",{ value: '"+category.id+"', text: '"+category.title+"' }";
                }
                if (categoriesList != "")
                    categoriesList = categoriesList.Substring(1);
            }
        }
    }
}