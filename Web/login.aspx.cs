using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Web
{
    public partial class login1 : System.Web.UI.Page
    {
        protected string lang;
        protected void Page_Load(object sender, EventArgs e)
        {
            lang = Page.RouteData.Values["lang"].ToString();
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var sessionUsers = SessionUser.Get();
            if (sessionUsers == null)
                sessionUsers = new List<SessionUser>();
            if (!string.IsNullOrEmpty(Request.Form["header-email"]))
            {
                string uname = Request.Form["header-email"].ToLower();
                var student = db.Students.Where(x => x.UserName.ToLower() == uname).SingleOrDefault();
                if(student!=null)
                {
                    string key = student.id.ToString();
                    //var ssu = sessionUsers.Where(x => x.Key == key).SingleOrDefault();
                    //if (ssu == null)
                    //{
                        string decryptedPass = StringCipher.Decrypt(student.Password);
                        if (Request.Form["header-passwd"] == decryptedPass)
                        {
                            SessionUser.Add(key, student.UserName);
                            Session["UserId"] = student.id;
                            Response.Redirect("level-" + student.levelId);
                        }
                        else
                        {
                            if (lang == "en")
                                msg.Text = "<font color='red'>Invalid Username/Password.</font>";
                            if (lang == "fr")
                                msg.Text = "<font color='red'>Nom d'utilisateur / mot de passe invalide.</font>";
                        }
                    //}
                    //else
                    //{
                    //    msg.Text = lang=="fr"? "<font color='red'>Il y a une autre session utilisant ce compte, veuillez en utiliser une autre.</font>" : "<font color='red'>There is another Session using this account,please use another one.</font>";
                    //}
                }
                else
                {
                    if (lang == "en")
                        msg.Text = "<font color='red'>Invalid Username/Password.</font>";
                    if (lang == "fr")
                        msg.Text = "<font color='red'>Nom d'utilisateur / mot de passe invalide. </font>";
                }
            }
            else if (!string.IsNullOrEmpty(Request.Form["uname"]))
            {
                string uname = Request.Form["uname"].ToLower();
                var student = db.Students.Where(x => x.UserName.ToLower() == uname).SingleOrDefault();
                if (student != null)
                {
                    string key = student.id.ToString();
                    //var ssu = sessionUsers.Where(x => x.Key == key).SingleOrDefault();
                    //if (ssu == null)
                    //{
                        string decryptedPass = StringCipher.Decrypt(student.Password);
                        if (Request.Form["passwd"] == decryptedPass)
                        {
                            SessionUser.Add(key, student.UserName);
                            Session["UserId"] = student.id;
                            Response.Redirect("level-" + student.levelId);
                        }
                        else
                        {
                            if (lang == "en")
                                msg.Text = "<font color='red'>Invalid Username/Password.</font>";
                            if (lang == "ar")
                                msg.Text = "<font color='red'>Nom d'utilisateur / mot de passe invalide. </font>";
                        }
                    //}
                    //else
                    //{
                    //    msg.Text = lang == "fr" ? "<font color='red'>Il y a une autre session utilisant ce compte, veuillez en utiliser une autre.</font>" : "<font color='red'>There is another Session using this account,please another one.</font>";
                    //}
                }
                else
                {
                    if (lang == "en")
                        msg.Text = "<font color='red'>Invalid Username/Password.</font>";
                    if (lang == "fr")
                        msg.Text = "<font color='red'>Nom d'utilisateur / mot de passe invalide. </font>";
                }
            }
        }
    }
}