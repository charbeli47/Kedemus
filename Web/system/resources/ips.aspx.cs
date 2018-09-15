using Microsoft.Web.Administration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web.resources
{
    public partial class ips : System.Web.UI.Page
    {
        protected List<IPSecurity> results;
        protected void Page_Load(object sender, EventArgs e)
        {
            int opId = int.Parse(Request["opId"]);
            bool perm = Permissions.Check(opId, "IP Security", "view");
            if (!perm)
                Response.Write("<script>getContent('accessdenied.html');</script>");
            else
            {
                results = GetBlockedIP();
            }
        }
        static List<IPSecurity> GetBlockedIP()
        {
            List<IPSecurity> sec = new List<IPSecurity>();
            using (ServerManager serverManager = new ServerManager())
            {
                Microsoft.Web.Administration.Configuration config = serverManager.GetApplicationHostConfiguration();
                Microsoft.Web.Administration.ConfigurationSection ipSecuritySection = config.GetSection("system.webServer/security/ipSecurity", "BrandsMarketing");
                ConfigurationElementCollection ipSecurityCollection = ipSecuritySection.GetCollection();

                foreach(var ip in ipSecurityCollection)
                {
                    if((bool)ip["allowed"] == false)
                        sec.Add(new IPSecurity { IP = ip["ipAddress"].ToString() });
                }


                return sec;
            }
        }
    }
    
    public class IPSecurity
    {
        public string IP { get; set; }
    }
}