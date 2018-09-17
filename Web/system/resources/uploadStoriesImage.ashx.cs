using Ghostscript.NET;
using iTextSharp.text.pdf;
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
    /// Summary description for uploadDivisionsImage
    /// </summary>
    public class uploadStoriesImage : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int imId = int.Parse(context.Request["id"]);
            var row = db.BookStories.Where(x => x.id == imId).SingleOrDefault();
            switch (context.Request["field"])
            {
                case "thumb":
                    row.thumb = SaveImage(context, context.Request["img"]);
                    break;
                case "pdf":
                    row.pdf = SavePdf(context, context.Request["img"]);
                    string pdfPath = context.Server.MapPath("~/Media/") + row.pdf;
                    PdfReader reader = new PdfReader(pdfPath);
                    int iorder = 1;
                    var slides = db.BookSlides.Where(x => x.bookId == row.id).ToList();
                    db.BookSlides.RemoveRange(slides);
                    for (int page = 1; page <= reader.NumberOfPages; page++)
                    {
                        string img = LoadImage(pdfPath, page, context);
                        db.BookSlides.Add(new BookSlide { img = img, bookId = row.id, OrderIndex = iorder });
                        iorder++;
                    }
                    break;
                case "interactive":
                    string filename = row.InteractiveFile;
                    row.InteractiveFile = SaveZip(context, context.Request["img"], filename, row.bookId);
                    break;
            }
            db.SaveChanges();
            context.Response.Write("success");
        }
        public string LoadImage(string InputPDFFile, int PageNumber, HttpContext context)
        {

            string outImageName = Path.GetFileNameWithoutExtension(InputPDFFile);
            outImageName = outImageName + "_" + PageNumber.ToString() + "_.jpg";


            GhostscriptJpegDevice dev = new GhostscriptJpegDevice(GhostscriptJpegDeviceType.Jpeg);
            dev.GraphicsAlphaBits = GhostscriptImageDeviceAlphaBits.V_4;
            dev.TextAlphaBits = GhostscriptImageDeviceAlphaBits.V_4;
            dev.ResolutionXY = new GhostscriptImageDeviceResolution(250, 250);
            dev.InputFiles.Add(InputPDFFile);
            dev.Pdf.FirstPage = PageNumber;
            dev.Pdf.LastPage = PageNumber;
            dev.CustomSwitches.Add("-dDOINTERPOLATE");
            dev.OutputPath = context.Server.MapPath(@"~/Media/" + outImageName);
            dev.Process();
            return outImageName;
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
        public string SavePdf(HttpContext context, string base64)
        {
            string basea = base64.Substring(0, base64.LastIndexOf(";base64,") + 8);
            string guid;
            using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(base64.Replace(basea, ""))))
            {
                guid = Guid.NewGuid().ToString() + ".pdf";
                string path = context.Server.MapPath("~/Media/" + guid);
                FileStream fs = new FileStream(path, FileMode.CreateNew);
                ms.WriteTo(fs);
                fs.Close();
                ms.Close();
            }
            return guid;
        }
        public string SaveZip(HttpContext context, string base64, string filename, int? bookId)
        {
            string basea = base64.Substring(0, base64.LastIndexOf(";base64,") + 8);
            string guid;
            string dirpath = "";
            string path = "";
            using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(base64.Replace(basea, ""))))
            {
                guid = filename + ".zip";
                path = context.Server.MapPath("~/Media/Stories/"+bookId+"/" + guid);
                dirpath = context.Server.MapPath("~/Media/Stories/" + bookId + "/" + filename);
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
        public string SaveVideo(HttpContext context, string base64)
        {
            string basea = base64.Substring(0, base64.LastIndexOf(";base64,") + 8);
            string guid;
            using (MemoryStream ms = new MemoryStream(Convert.FromBase64String(base64.Replace(basea, ""))))
            {
                guid = Guid.NewGuid().ToString() + ".mp4";
                string path = context.Server.MapPath("~/Media/" + guid);
                FileStream fs = new FileStream(path, FileMode.CreateNew);
                ms.WriteTo(fs);
                fs.Close();
                ms.Close();
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