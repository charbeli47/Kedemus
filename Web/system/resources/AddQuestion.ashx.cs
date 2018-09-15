using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for AddQuestion
    /// </summary>
    public class AddQuestion : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            string title = "";
            switch(context.Request["typeSelect"])
            {
                case "text":
                    title = context.Request["typetext"];
                    break;
                case "image":
                    HttpPostedFile thumb = context.Request.Files["typeimage"];
                    string thumb_file = "";
                    if (thumb.ContentLength > 0)
                    {
                        string sfiletype1 = thumb.FileName;
                        sfiletype1 = sfiletype1.Substring(sfiletype1.LastIndexOf('.') + 1).ToLower();
                        thumb_file = Guid.NewGuid().ToString() + "." + sfiletype1;
                        string _path1 = context.Server.MapPath("~/Media");
                        title = "/Media/" + thumb_file;
                        thumb.SaveAs(_path1 + "/" + thumb_file);
                    }
                    break;
            }
            HttpPostedFile audio = context.Request.Files["audio"];
            string audio_file = "", audio_path = "";
            if (audio.ContentLength > 0)
            {
                string sfiletype1 = audio.FileName;
                sfiletype1 = sfiletype1.Substring(sfiletype1.LastIndexOf('.') + 1).ToLower();
                audio_file = Guid.NewGuid().ToString() + "." + sfiletype1;
                string _path1 = context.Server.MapPath("~/Media");
                audio.SaveAs(_path1 + "/" + audio_file);
                audio_path = "/Media/" + audio_file;
            }
            db.Questions.Add(new Question { AnswersLayout = context.Request["AnswersLayout"], categoryId = int.Parse(context.Request["categorySelect"]), title = title, audio = audio_path, correctAnswer = context.Request["correctAnswer"], type = context.Request["typeSelect"] });
            db.SaveChanges();
            context.Response.Write("success");
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