using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for uploadPartnersImage
    /// </summary>
    public class uploadPressRoomImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int imId = int.Parse(context.Request["id"]);
            var row = db.PressRooms.Where(x => x.id == imId).SingleOrDefault();
            switch (context.Request["field"])
            {
                case "Img":
                    row.img = SaveImage(context, context.Request["img"]);
                    break;
            }
            db.SaveChanges();
            context.Response.Write("success");
        }
        public string SaveImage(HttpContext context, string base64)
        {
            string basea = base64.Substring(0, base64.LastIndexOf(";base64,") + 8);
            string guid;
            using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(base64.Replace(basea, ""))))
            {
                using (Bitmap bm2 = new Bitmap(ms))
                {
                    guid = Guid.NewGuid().ToString() + ".jpg";
                    bm2.Save(context.Server.MapPath("~/Media/") + guid);
                }
            }
            return guid;
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