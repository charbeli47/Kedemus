using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Security.AccessControl;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for addLetterGame
    /// </summary>
    public class addBookUniteFiles : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int uniteId = int.Parse(context.Request["pageId"]);
            HttpPostedFile uniteFile = context.Request.Files["uniteFile"];
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            
            string game_file = "";
            if(uniteFile.ContentLength>0)
            {
                string sfiletype = uniteFile.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                game_file = uniteFile.FileName.Replace(".zip","");
                string _path = context.Server.MapPath("~/Media/Unites/" + uniteId + "/");
                DirectoryInfo dir = new DirectoryInfo(_path);

                if (!dir.Exists)
                    dir.Create();
                string filepath = _path + game_file + "." + sfiletype;
                uniteFile.SaveAs(filepath);
                FileInfo fi = new FileInfo(filepath);
                Decompress(filepath);
                fi.Delete();
            }
            db.BookUniteFiles.Add(new BookUniteFile { InteractiveFile = game_file, uniteId = uniteId });
            db.SaveChanges();
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public static void Decompress(string zipPath)
        {
            string extractPath = zipPath.Substring(0, zipPath.LastIndexOf("\\"));
            ZipFile.ExtractToDirectory(zipPath, extractPath);
        }
    }
}