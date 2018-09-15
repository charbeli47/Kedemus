using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class verify_account : System.Web.UI.Page
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
                var userExists = db.Students.Where(x => x.UserName == uname).Count() > 0;
                if (!userExists)
                {
                    var student = db.Students.Where(x => x.AccessCode == accCode && x.UserName==null).SingleOrDefault();
                    if (student != null)
                    {
                        student.Password = StringCipher.Encrypt(Request.Form["passwd"]);
                        student.UserName = Request.Form["uname"];
                        db.SaveChanges();
                        Session["UserId"] = student.id;
                        Response.Redirect("level-" + student.levelId);
                    }
                    else
                    {
                        if (lang == "en")
                            msg.Text = "<font color='red'>The Access Code you entered is not correct, please use another one.</font>";
                        if (lang == "ar")
                            msg.Text = "<font color='red'>إن رمز الدخول غير صحيح, الرجاء إستعمال واحد آخر.</font>";
                    }
                }
                else
                {
                    if (lang == "en")
                        msg.Text = "<font color='red'>Username is used. Please choose another one.</font>";
                    if (lang == "ar")
                        msg.Text = "<font color='red'>إسم المستخدم قيد الإستعمال, الرجاء إستعمال واحد آخر.</font>";
                }
            }
        }
    }
}