using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.system.resources
{
    public partial class content : System.Web.UI.Page
    {
        protected Content row = new Content();
        protected List<Content> contentList = new List<Content>();
        protected void Page_Load(object sender, EventArgs e)
        {
            int opId = int.Parse(Request["opId"]);
            bool perm = Permissions.Check(opId, "CMS Users", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                contentList = db.Contents.ToList();
                if (contentList.Count() > 0)
                {
                    row = contentList.FirstOrDefault();
                    AboutUs.Value = row.AboutUs;
                    Description.Value = row.Description;
                    Keywords.Value = row.keywords;
                    Email.Value = row.Email;
                    AddressLine.Value = row.AddressLine;
                    Phone.Value = row.Phone;
                    Fax.Value = row.Fax;
                    Longitude.Value = row.longitude.ToString();
                    Latitude.Value = row.latitude.ToString();
                    SmtpServer.Value = row.SmtpServer;
                    SmtpPort.Value = row.SmtpPort;
                    IsSSL.Checked = row.IsSSL != null ? (bool)row.IsSSL : false;
                    SystemEmail.Value = row.SystemEmail;
                    SystemEmailPassword.Value = row.SystemEmailPassword;
                    InfoEmail.Value = row.InfoEmail;
                    SmartLearningVideo.Value = row.SmartLearningVideo;
                }
            }
        }
    }
}