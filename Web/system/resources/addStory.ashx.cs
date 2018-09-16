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
    public class addStory : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int bookId = int.Parse(context.Request["pageId"]);
            HttpPostedFile thumbfile = context.Request.Files["Thumb"];
            HttpPostedFile pdffile = context.Request.Files["pdf"];
            HttpPostedFile gamefile = context.Request.Files["GameFile"];
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            string title = context.Request["title"];
            string pdf_file = "";            
            if (pdffile.ContentLength > 0)
            {
                string sfiletype = pdffile.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                pdf_file = Guid.NewGuid().ToString() + "." + sfiletype;
                string _path = context.Server.MapPath("~/Media");
                pdffile.SaveAs(_path + "/" + pdf_file);
            }
            string thumb_file = "";
            if (thumbfile.ContentLength > 0)
            {
                string sfiletype = thumbfile.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                thumb_file = Guid.NewGuid().ToString() + "." + sfiletype;
                string _path = context.Server.MapPath("~/Media");
                thumbfile.SaveAs(_path + "/" + thumb_file);
            }
            string game_file = "";
            if(gamefile.ContentLength>0)
            {
                string sfiletype = gamefile.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                game_file = gamefile.FileName.Replace(".zip","");
                string _path = context.Server.MapPath("~/Media/Stories/" + bookId + "/");
                DirectoryInfo dir = new DirectoryInfo(_path);

                if (!dir.Exists)
                    dir.Create();
                string filepath = _path + game_file + "." + sfiletype;
                gamefile.SaveAs(filepath);
                FileInfo fi = new FileInfo(filepath);
                Decompress(filepath);
                fi.Delete();
            }
            db.BookStories.Add(new BookStory { InteractiveFile = game_file, bookId = bookId, thumb = thumb_file, title = title, pdf = pdf_file });
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