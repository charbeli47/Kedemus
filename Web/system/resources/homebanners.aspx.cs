using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class homebanners : System.Web.UI.Page
    {
        protected List<HomeBanner> results;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            bool perm = Permissions.Check(opId, "Home Banners", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                results = db.HomeBanners.ToList();
            }
        }
    }
}