using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.system.resources
{
    public partial class assessmentquestions: System.Web.UI.Page
    {
        protected List<Question> results;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            bool perm = Permissions.Check(opId, "Assessment", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                results = db.Questions.ToList().ToList();
                var qcategories = db.QuestionsCategories.ToList();
                categorySelect.DataSource = qcategories;
                categorySelect.DataTextField = "title";
                categorySelect.DataValueField = "id";
                categorySelect.DataBind();
            }
        }
    }
}