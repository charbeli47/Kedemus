using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class _default : System.Web.UI.Page
    {
        protected cms_user op;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CMSUser"] == null)
                Response.Redirect("login.aspx");
            else
            {
                op = (cms_user)Session["CMSUser"];
                
            }
        }
    }
}