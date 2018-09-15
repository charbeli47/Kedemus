using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for SaveCategoriesBooks
    /// </summary>
    public class SaveSchoolBooks : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int schoolId = int.Parse(context.Request["schoolId"]);
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var books = db.Books.ToList();
            var ps = db.SchoolBooks.Where(x => x.schoolId == schoolId).ToList();
            foreach (var p in ps)
            {
                db.SchoolBooks.Remove(p);
            }
            foreach (var book in books)
            {
                string spon = context.Request["book" + book.id];

                if (spon == "true")
                {
                    db.SchoolBooks.Add(new SchoolBook { schoolId = schoolId, bookId = book.id });
                }
                else
                {
                    var r = db.SchoolBooks.Where(x => x.schoolId == schoolId && x.bookId == book.id).SingleOrDefault();
                    if (r != null)
                        db.SchoolBooks.Remove(r);
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