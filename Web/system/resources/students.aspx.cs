using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.system.resources
{
    public partial class students : System.Web.UI.Page
    {
        protected int pageSize = 10;
        protected int page = 1;
        protected int PageCount;
        protected int resultCount;
        protected List<Student> results;
        protected string searchKey = "";
        protected School school;
        public string levelsList;
        protected int pageId;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            int.TryParse(Request["page"], out page);
            pageId = int.Parse(Request["pageId"]);
            bool perm = Permissions.Check(opId, "Web Users", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                school = db.Schools.Where(x => x.id == pageId).SingleOrDefault();
                searchKey = Request["key"];
                var allresults = db.Students.Where(x => x.schoolId == pageId).OrderByDescending(x => x.id).ToList();
                if (!string.IsNullOrEmpty(searchKey))
                    allresults = allresults.Where(x => x.Address.Contains(searchKey) || (x.School != null ? x.School.title.Contains(searchKey) : false) || x.Email.Contains(searchKey) || x.FirstName.Contains(searchKey) || x.LastName.Contains(searchKey) || x.Phone.Contains(searchKey)).ToList();
                resultCount = allresults.Count;
                PageCount = resultCount / pageSize;
                if (allresults.Count % pageSize > 0)
                    PageCount += 1;
                if (page < 1 || page > PageCount)
                    page = 1;
                results = allresults.Skip((page - 1) * pageSize)
                       .Take(pageSize).OrderByDescending(x => x.id).ToList();
                var levels = db.BooksLevels.ToList();
                levelsSelect.DataSource = levels;
                levelsSelect.DataTextField = "title";
                levelsSelect.DataValueField = "id";
                levelsSelect.DataBind();
                levelsSelect.Items.Insert(0, new ListItem("Select Level","-1"));
                foreach (BooksLevel level in levels)
                {
                    levelsList += ",{ value: " + level.id + ", text: '" + level.title + "' }";
                }
                if (levelsList.Length > 0)
                    levelsList = levelsList.Substring(1);
            }
        }
    }
}