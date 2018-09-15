using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for addHomeBanners
    /// </summary>
    public class addHomeBanners : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpFileCollection thumbs = context.Request.Files;
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            for (int i = 0; i < thumbs.Count; i++)
            {
                HttpPostedFile thumb = thumbs[i];
                string sfiletype = thumb.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                string thumb_file = Guid.NewGuid().ToString() + "." + sfiletype;
                string _path = context.Server.MapPath("~/Media");
                thumb.SaveAs(_path + "/" + thumb_file);


                db.HomeBanners.Add(new HomeBanner { thumb = thumb_file });
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