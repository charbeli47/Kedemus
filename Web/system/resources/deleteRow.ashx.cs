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
                    BookUnite bunite = db.BookUnites.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookUnites.Remove(bunite);
                    success = "success";
                    break;
                case "BookUniteFiles":
                    BookUniteFile unitefile = db.BookUniteFiles.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookUniteFiles.Remove(unitefile);
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
                    }
                    catch { }
                    break;
                
                case "Levels":
                    BooksLevel level = db.BooksLevels.Where(x => x.id == tableId).SingleOrDefault();
                    db.BooksLevels.Remove(level);
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
                case "Posters":
                    BookPoster game = db.BookPosters.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookPosters.Remove(game);
                    try
                    {
                        Directory.Delete(context.Server.MapPath("~/Media/Games/" + game.bookId + "/" + game.InteractiveFile));
                        File.Delete(context.Server.MapPath("~/Media/" + game.thumb));
                    }
                    catch { }
                    success = "success";
                    break;
                case "Stories":
                    BookStory story = db.BookStories.Where(x => x.id == tableId).SingleOrDefault();
                    db.BookStories.Remove(story);
                    try
                    {
                        Directory.Delete(context.Server.MapPath("~/Media/Games/" + story.bookId + "/" + story.InteractiveFile));
                        File.Delete(context.Server.MapPath("~/Media/" + story.thumb));
                        File.Delete(context.Server.MapPath("~/Media/" + story.pdf));
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