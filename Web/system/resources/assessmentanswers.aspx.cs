using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class assessmentanswers : System.Web.UI.Page
    {
        protected List<QuestionsAnswer> results;
        protected Question question;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            int questionId = int.Parse(Request["pageId"]);
            bool perm = Permissions.Check(opId, "Assessment", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                results = db.QuestionsAnswers.Where(x=>x.questionId == questionId).ToList();
                question = db.Questions.Where(x => x.id == questionId).SingleOrDefault();
            }
        }
    }
}