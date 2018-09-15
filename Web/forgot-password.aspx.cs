using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class forgot_password : System.Web.UI.Page
    {
        protected string lang;
        protected void Page_Load(object sender, EventArgs e)
        {
            lang = Page.RouteData.Values["lang"].ToString();
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            if (IsPostBack)
            {
                string accCode = Request.Form["accesscode"];
                string uname = Request.Form["uname"];
                var student = db.Students.Where(x => x.AccessCode == accCode && x.UserName == uname).SingleOrDefault();
                if(student!=null)
                {
                    string password = StringCipher.Decrypt(student.Password);
                    if(lang == "en")
                        msg.Text = "<font color='green'>Your Password is : "+password+"</font>";
                    else
                        msg.Text = "<font color='green'>كلمة السر الخاصة بك هي: " +password + "</font>";
                }
                else
                {
                    if (lang == "en")
                        msg.Text = "<font color='red'>We didn't find your account. Please request it from your school or try again later.</font>";
                    else
                        msg.Text = "<font color='red'>لم نجد حسابك. يرجى طلب ذلك من مدرستك أو المحاولة مرة أخرى في وقت لاحق.</font>";
                }
            }
        }
    }
}