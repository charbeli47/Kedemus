using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for addProjects
    /// </summary>
    public class addBooks : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpPostedFile thumb = context.Request.Files["thumb"];
            HttpPostedFile Pdffile = context.Request.Files["pdf"];
            string thumb_file = "", pdf_file = "";
            if (thumb.ContentLength > 0)
            {
                string sfiletype1 = thumb.FileName;
                sfiletype1 = sfiletype1.Substring(sfiletype1.LastIndexOf('.') + 1).ToLower();
                thumb_file = Guid.NewGuid().ToString() + "." + sfiletype1;
                string _path1 = context.Server.MapPath("~/Media");
                thumb.SaveAs(_path1 + "/" + thumb_file);
            }
            if (Pdffile.ContentLength > 0)
            {
                string sfiletype1 = Pdffile.FileName;
                sfiletype1 = sfiletype1.Substring(sfiletype1.LastIndexOf('.') + 1).ToLower();
                pdf_file = Guid.NewGuid().ToString() + "." + sfiletype1;
                string _path1 = context.Server.MapPath("~/Media");
                Pdffile.SaveAs(_path1 + "/" + pdf_file);
            }
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            string title = context.Request["title"];
            string lang = context.Request["langselect"];
            bool isAvailable = context.Request["isAvailable"] == "on";
            int levelId = int.Parse(context.Request["levelselect"]);
            Book book = new Book { title = title, thumb = thumb_file, pdf = pdf_file, isAvailable = isAvailable, lang = lang, levelId = levelId};
            book = db.Books.Add(book);
            
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