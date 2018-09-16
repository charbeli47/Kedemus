using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for addProjects
    /// </summary>
    public class addSchools : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpPostedFile thumb = context.Request.Files["thumb"];
            string thumb_file = "";
            if (thumb.ContentLength > 0)
            {
                string sfiletype1 = thumb.FileName;
                sfiletype1 = sfiletype1.Substring(sfiletype1.LastIndexOf('.') + 1).ToLower();
                thumb_file = Guid.NewGuid().ToString() + "." + sfiletype1;
                string _path1 = context.Server.MapPath("~/Media");
                thumb.SaveAs(_path1 + "/" + thumb_file);
            }
            
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            string title = context.Request["title"];
            string artitle = context.Request["artitle"];
            School school = new School { title = title, thumb = thumb_file, artitle = artitle};
            school = db.Schools.Add(school);
            
            db.SaveChanges();
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