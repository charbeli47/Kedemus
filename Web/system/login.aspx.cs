using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Security.Cryptography;
using System.Text;

namespace Web
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Unnamed1_Click(object sender, EventArgs e)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();

            var usr = db.cms_user.ToList().SingleOrDefault(x => x.username == Request["userid"] && x.password == MD5Hash(Request["password"]));
            
            if (usr != null && usr.status == 1)
            {
                usr.date_login = DateTime.Now;
                usr.isOnline = true;
                Session["CMSUser"] = usr;
                db.SaveChanges();
                if(!string.IsNullOrEmpty(Request["red"]))
                    Response.Redirect(Request["red"]);
                else
                    Response.Redirect("~/system");

            }
            else
            {
                Msg.Text = @"<div class=""alert alert-danger alert-dismissable"">
                                        <i class=""fa fa-ban""></i>
                                        <b>Alert!</b> Invalid Username / Password
                                    </div>
<script>
document.addEventListener('DOMContentLoaded', function () {
  if (Notification.permission !== ""granted"")
    Notification.requestPermission();
            });

            function notifyMe() {
                if (Notification.permission !== ""granted"")
                    Notification.requestPermission();
                else
                {
                    var notification = new Notification('Error', {
      icon: 'http://maizonpub.com/images/logo-shrink.png',
      body: ""Invalid username / password please try again"",
    });

                /*notification.onclick = function() {
                    window.open("");
                };*/

            }

        }
notifyMe();
</script>
";
            }
            
        }
        public static string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            //get hash result after compute it
            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                //change it into 2 hexadecimal digits
                //for each byte
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }
    }
}