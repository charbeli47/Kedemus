using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Web.resources
{
    /// <summary>
    /// Summary description for editRow
    /// </summary>
    public class editRow : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string name = context.Request.Form["name"];
            string value = context.Request.Form["value"];
            int pk = int.Parse(context.Request.Form["pk"]);
            string success = "";
            string table = context.Request.QueryString["table"];
            if (table == null)
                table = context.Request.Form["table"];
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            switch (table)
            {
                case "cms_user":
                    var user = db.cms_user.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("username"))
                        user.username = value;
                    else if (name.Contains("cmsgroup"))
                        user.groupId = int.Parse(value);
                    else if (name.Contains("status"))
                        user.status = int.Parse(value);
                    else if (name.Contains("password"))
                        user.password = MD5Hash(value);
                    else if (name.Contains("firstname"))
                        user.firstname = value;
                    else if (name.Contains("lastname"))
                        user.lastname = value;
                    else if (name.Contains("email"))
                        user.email = value;
                    else if (name.Contains("phone"))
                        user.phone = value;
                    else if (name.Contains("address"))
                        user.address = value;
                    success = "success";
                    break;
                case "cms_groups":
                    var group = db.cms_groups.Where(x => x.id == pk).SingleOrDefault();
                    group.name = value;
                    success = "success";
                    break;
                case "Books":
                    var project = db.Books.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("title"))
                        project.title = value;
                    else if (name.Contains("lang"))
                        project.lang = value;
                    if (name.Contains("level"))
                        project.levelId = int.Parse(value);
                    else if (name.Contains("isAvailable"))
                        project.isAvailable = value == "YES";
                    success = "success";
                    break;
                case "BookUnites":
                    var unite = db.BookUnites.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("title"))
                        unite.title = value;
                    success = "success";
                    break;
                case "Posters":
                    var poster = db.BookPosters.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("title"))
                        poster.title = value;
                    break;
                case "Stories":
                    var story = db.BookStories.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("title"))
                        story.title = value;
                    break;
                case "Levels":
                    var level = db.BooksLevels.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("title"))
                        level.title = value;
                    if (name.Contains("lang"))
                        level.lang = value;
                    success = "success";
                    break;
                case "BooksCategories":
                    var cat = db.Categories.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("title"))
                        cat.title = value;
                    success = "success";
                    break;

                case "Schools":
                    var school = db.Schools.Where(x => x.id == pk).SingleOrDefault();
                    if (name.Contains("artitle"))
                        school.artitle = value;
                    if (name.Contains("entitle"))
                        school.title = value;
                    if (name.Contains("showGame"))
                        school.showGame = value == "YES";
                    success = "success";
                    break;
                case "Students":
                    var student = db.Students.Where(x => x.id == pk).SingleOrDefault();
                    student.levelId = int.Parse(value);
                    break;
            }
            db.SaveChanges();
            context.Response.Write(success);
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}