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
            HttpPostedFile background = context.Request.Files["background"];
            HttpPostedFile Pdffile = context.Request.Files["pdf"];
            string thumb_file = "", pdf_file = "", background_file = "";
            if (thumb.ContentLength > 0)
            {
                string sfiletype1 = thumb.FileName;
                sfiletype1 = sfiletype1.Substring(sfiletype1.LastIndexOf('.') + 1).ToLower();
                thumb_file = Guid.NewGuid().ToString() + "." + sfiletype1;
                string _path1 = context.Server.MapPath("~/Media");
                thumb.SaveAs(_path1 + "/" + thumb_file);
            }
            if (background.ContentLength > 0)
            {
                string sfiletype1 = background.FileName;
                sfiletype1 = sfiletype1.Substring(sfiletype1.LastIndexOf('.') + 1).ToLower();
                background_file = Guid.NewGuid().ToString() + "." + sfiletype1;
                string _path1 = context.Server.MapPath("~/Media");
                background.SaveAs(_path1 + "/" + background_file);
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
            string artitle = context.Request["artitle"];
            string text = context.Request["text"];
            string artext = context.Request["artext"];
            bool isAvailable = context.Request["isAvailable"] == "on";
            bool isElearning = context.Request["isElearning"] == "on";
            bool isFeatured = context.Request["isFeatured"] == "on";
            string ISBN = context.Request["ISBN"];
            Book book = new Book { title = title, text = text, thumb = thumb_file, video = context.Request["youtubeId"],SignLanguageVideo = context.Request["SignLanguageVideo"], pdf = pdf_file, isAvailable = isAvailable, artext = artext, artitle = artitle, background = background_file};
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