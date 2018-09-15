using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for SaveCategoriesBooks
    /// </summary>
    public class SaveSchoolGames : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int schoolId = int.Parse(context.Request["schoolId"]);
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var games = db.BookGames.ToList();
            var ps = db.SchoolGames.Where(x => x.schoolId == schoolId).ToList();
            foreach (var p in ps)
            {
                db.SchoolGames.Remove(p);
            }
            foreach (var game in games)
            {
                string spon = context.Request["game" + game.id];

                if (spon == "true")
                {
                    db.SchoolGames.Add(new SchoolGame { schoolId = schoolId, GameId = game.id });
                }
                else
                {
                    var r = db.SchoolGames.Where(x => x.schoolId == schoolId && x.GameId == game.id).SingleOrDefault();
                    if (r != null)
                        db.SchoolGames.Remove(r);
                }
            }
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