using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class cmsusers : System.Web.UI.Page
    {
        protected List<cms_user> users;
        protected List<cms_groups> groups;
        protected string groupsList;
        protected void Page_Load(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int opId = int.Parse(Request["opId"]);
            bool perm = Permissions.Check(opId, "CMS Users", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                users = db.cms_user.ToList();
                groups = db.cms_groups.ToList();
                selectgroup.DataSource = groups;
                selectgroup.DataTextField = "name";
                selectgroup.DataValueField = "id";
                selectgroup.DataBind();
                foreach (cms_groups group in groups)
                {
                    groupsList += ",{ value: " + group.id + ", text: '" + group.name + "' }";
                }
                if (groupsList.Length > 0)
                    groupsList = groupsList.Substring(1);
            }
        }
    }
}