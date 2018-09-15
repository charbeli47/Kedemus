using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for addHomeBanners
    /// </summary>
    public class addSlides : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpFileCollection thumbs = context.Request.Files;
            int bookId = int.Parse(context.Request["bookId"]);
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int iorder = 1;
            var lastslide = db.BookSlides.Where(x=>x.bookId == bookId).OrderByDescending(x=>x.OrderIndex).FirstOrDefault();
            if (lastslide != null)
            {
                iorder = (int)lastslide.OrderIndex;
                iorder++;
            }
            for (int i = 0; i < thumbs.Count; i++)
            {
                HttpPostedFile thumb = thumbs[i];
                string sfiletype = thumb.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                string thumb_file = Guid.NewGuid().ToString() + "." + sfiletype;
                string _path = context.Server.MapPath("~/Media");
                thumb.SaveAs(_path + "/" + thumb_file);


                db.BookSlides.Add(new BookSlide { img = thumb_file, bookId = bookId, OrderIndex = iorder });
                iorder++;
            }
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