using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for uploadPartnersImage
    /// </summary>
    public class uploadUniteFileImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int imId = int.Parse(context.Request["id"]);
            var row = db.BookUniteFiles.Where(x => x.id == imId).SingleOrDefault();
            switch (context.Request["field"])
            {
                case "Img":
                    row.thumb = SaveImage(context, context.Request["img"]);
                    break;
                case "interactive":
                    string filename = row.InteractiveFile;
                    row.InteractiveFile = SaveZip(context, context.Request["img"], filename, row.uniteId);
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
        public string SaveZip(HttpContext context, string base64, string filename, int? uniteId)
        {
            string basea = base64.Substring(0, base64.LastIndexOf(";base64,") + 8);
            string guid;
            string dirpath = "";
            string path = "";
            using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(base64.Replace(basea, ""))))
            {
                guid = filename + ".zip";
                path = context.Server.MapPath("~/Media/Unites/" + uniteId + "/" + guid);
                dirpath = context.Server.MapPath("~/Media/Unites/" + uniteId + "/" + filename);
                FileStream fs = new FileStream(path, FileMode.CreateNew);
                ms.WriteTo(fs);
                fs.Close();
                ms.Close();
            }
            DirectoryInfo dir = new DirectoryInfo(dirpath);

            if (dir.Exists)
            {
                dir.Delete(true);
            }
            FileInfo fi = new FileInfo(path);
            Decompress(path);
            fi.Delete();
            return guid;
        }
        public static void Decompress(string zipPath)
        {
            string extractPath = zipPath.Substring(0, zipPath.LastIndexOf("\\"));
            ZipFile.ExtractToDirectory(zipPath, extractPath);
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