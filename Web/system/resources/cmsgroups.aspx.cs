using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class cmsgroups : System.Web.UI.Page
    {
        protected List<cms_groups> groups;
        protected List<cms_permissions> permissions;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            bool perm = Permissions.Check(opId, "CMS Groups", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                groups = db.cms_groups.ToList();
                permissions = db.cms_permissions.ToList();
            }
        }
    }
}