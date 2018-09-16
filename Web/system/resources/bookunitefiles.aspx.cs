using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class bookunitefiles : System.Web.UI.Page
    {
        protected List<BookUniteFile> results;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            int uniteId = int.Parse(Request["pageId"]);
            bool perm = Permissions.Check(opId, "Books", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                results = db.BookUniteFiles.Where(x=>x.uniteId == uniteId).ToList();
            }
        }
    }
}