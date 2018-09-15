using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.game
{
    public partial class edit : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["CMSUser"] == null)
                Response.Redirect("~/system/login.aspx?red=~/assessment/edit.aspx");
        }
    }
}