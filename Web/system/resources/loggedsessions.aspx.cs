using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.system.resources
{
    public partial class loggedsessions : System.Web.UI.Page
    {
        protected List<SessionUser> users;
        protected void Page_Load(object sender, EventArgs e)
        {
            users = SessionUser.Get();
            if (users == null)
                users = new List<SessionUser>();
        }
    }
}