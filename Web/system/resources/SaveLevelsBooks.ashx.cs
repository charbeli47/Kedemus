using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for SaveLevelsBooks
    /// </summary>
    public class SaveLevelsBooks : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int bookId = int.Parse(context.Request["bookId"]);
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var levels = db.Levels.ToList();
            var ps = db.ItemsLevels.Where(x => x.bookId == bookId).ToList();
            foreach (var p in ps)
            {
                db.ItemsLevels.Remove(p);
            }
            foreach (var level in levels)
            {
                string spon = context.Request["level" + level.id];

                if (spon == "true")
                {
                    db.ItemsLevels.Add(new ItemsLevel { bookId = bookId, LevelId = level.id });
                }
                else
                {
                    var r = db.ItemsLevels.Where(x => x.bookId == bookId && x.LevelId == level.id).SingleOrDefault();
                    if (r != null)
                        db.ItemsLevels.Remove(r);
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