using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class logout1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string key = "";
            if (Session["UserId"] != null)
                key = Session["UserId"].ToString();
            Session["UserId"] = null;
            SessionUser.Remove(key);
            Response.Redirect("/");
        }
    }
}