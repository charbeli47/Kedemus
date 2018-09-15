using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for addDivisions
    /// </summary>
    public class addPressRoom : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            HttpPostedFile thumbfile = context.Request.Files["Img"];
            string thumb_file = "";
            if (thumbfile.ContentLength > 0)
            {
                string sfiletype = thumbfile.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                thumb_file = Guid.NewGuid().ToString() + "." + sfiletype;
                string _path = context.Server.MapPath("~/Media");
                thumbfile.SaveAs(_path + "/" + thumb_file);
            }
            
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            db.PressRooms.Add(new PressRoom { title = context.Request["title"], text = context.Request["text"], link = context.Request["link"], img = thumb_file, DateIn = DateTime.Now });
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