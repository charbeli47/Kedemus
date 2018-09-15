using Microsoft.Web.Administration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Web.resources
{
    /// <summary>
    /// Summary description for deleteRow
    /// </summary>
    public class deleteRow : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string table = context.Request.Form["table"];
            string ips = context.Request.Form["ips"];
            int tableId = int.Parse(context.Request.Form["tableId"]);
            string key = context.Request["key"];
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            string success = "";
            switch (table)
            {
                case "cms_user":
                    cms_user user = db.cms_user.Where(x=>x.id == tableId).SingleOrDefault();
                    db.cms_user.Remove(user);
                    success = "success";
                    break;
                case "cms_groups":
                    cms_groups group = db.cms_groups.Where(x => x.id == tableId).SingleOrDefault();
                    db.cms_groups.Remove(group);
                    success = "success";
                    break;
                case "HomeBanners":
                    HomeBanner homebanner = db.HomeBanners.Where(x => x.id == tableId).SingleOrDefault();
                    db.HomeBanners.Remove(homebanner);
                    success = "success";
                    try
                    {
                        File.Delete(context.Server.MapPath("~/Media/" + homebanner.thumb));
                    }
                    catch { }
                    break;
                case "Slides":
                    BookSlide slide = db.BookSlides.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookSlides.Remove(slide);
                    success = "success";
                    try
                    {
                        File.Delete(context.Server.MapPath("~/Media/" + slide.img));
                    }
                    catch { }
                    break;
                case "BookUnites":
                    BookInteractiveChapter bunite = db.BookInteractiveChapters.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookInteractiveChapters.Remove(bunite);
                    success = "success";
                    break;
                case "BookUniteFiles":
                    BookChapterFile unitefile = db.BookChapterFiles.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookChapterFiles.Remove(unitefile);
                    success = "success";
                    break;
                case "Books":
                    Book b = db.Books.Where(x => x.id == tableId).SingleOrDefault();
                    db.Books.Remove(b);
                    success = "success";
                    try
                    {
                        File.Delete(context.Server.MapPath("~/Media/" + b.thumb));
                        File.Delete(context.Server.MapPath("~/Media/" + b.pdf));
                        File.Delete(context.Server.MapPath("~/Media/" + b.video));
                    }
                    catch { }
                    break;
                case "BooksCategories":
                    Category category = db.Categories.Where(x => x.id == tableId).SingleOrDefault();
                    db.Categories.Remove(category);
                    success = "success";
                    break;
                case "QuestionsCategories":
                    QuestionsCategory qcategory = db.QuestionsCategories.Where(x => x.id == tableId).SingleOrDefault();
                    db.QuestionsCategories.Remove(qcategory);
                    success = "success";
                    break;
                case "Questions":
                    Question question = db.Questions.Where(x => x.id == tableId).SingleOrDefault();
                    db.Questions.Remove(question);
                    success = "success";
                    break;
                case "QuestionsAnswers":
                    QuestionsAnswer qanswer = db.QuestionsAnswers.Where(x => x.id == tableId).SingleOrDefault();
                    db.QuestionsAnswers.Remove(qanswer);
                    success = "success";
                    break;
                case "Levels":
                    Level level = db.Levels.Where(x => x.id == tableId).SingleOrDefault();
                    db.Levels.Remove(level);
                    success = "success";
                    break;
                case "PressRoom":
                    PressRoom pressroom = db.PressRooms.Where(x => x.id == tableId).SingleOrDefault();
                    db.PressRooms.Remove(pressroom);
                    success = "success";
                    break;
                case "Schools":
                    School school = db.Schools.Where(x => x.id == tableId).SingleOrDefault();
                    db.Schools.Remove(school);
                    success = "success";
                    try
                    {
                        File.Delete(context.Server.MapPath("~/Media/" + school.thumb));
                    }
                    catch { }
                    break;
                case "Games":
                    BookGame game = db.BookGames.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookGames.Remove(game);
                    try
                    {
                        Directory.Delete(context.Server.MapPath("~/Media/Games/" + game.levelId + "/" + game.Folder));
                    }
                    catch { }
                    success = "success";
                    break;
                case "IPs":
                    AllowIP(ips);
                    break;
                case "Sessions":
                    SessionUser.Remove(key);
                    break;
            }
            db.SaveChanges();
            context.Response.Write(success);
        }
        static void AllowIP(string IP)
        {
            using (ServerManager serverManager = new ServerManager())
            {
                Microsoft.Web.Administration.Configuration config = serverManager.GetApplicationHostConfiguration();
                Microsoft.Web.Administration.ConfigurationSection ipSecuritySection = config.GetSection("system.webServer/security/ipSecurity", "BrandsMarketing");
                ConfigurationElementCollection ipSecurityCollection = ipSecuritySection.GetCollection();
                var ipAddress = ipSecurityCollection.Where(x => x["ipAddress"].ToString() == IP).SingleOrDefault();
                ipSecurityCollection.Remove(ipAddress);
                serverManager.CommitChanges();
            }
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