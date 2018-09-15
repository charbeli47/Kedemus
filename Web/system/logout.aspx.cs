using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                cms_user usr = (cms_user)Session["CMSUser"];
                var u = db.cms_user.ToList().Where(x => x.id == usr.id).SingleOrDefault();
                u.isOnline = false;
                db.SaveChanges();
                Session["CMSUser"] = null;
                if (Request["logout"] != null)
                {
                    Response.Redirect("~/system/login.aspx");
                }
            }
            catch
            {
                if (Request["logout"] != null)
                {
                    Response.Redirect("~/system/login.aspx");
                }
            }
        }
    }
}