using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for SaveCategoriesBooks
    /// </summary>
    public class SaveCategoriesBooks : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int bookId = int.Parse(context.Request["bookId"]);
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var categories = db.Categories.ToList();
            var ps = db.ItemsCategories.Where(x => x.BookId == bookId).ToList();
            foreach (var p in ps)
            {
                db.ItemsCategories.Remove(p);
            }
            foreach (var category in categories)
            {
                string spon = context.Request["category" + category.id];

                if (spon == "true")
                {
                    db.ItemsCategories.Add(new ItemsCategory { BookId = bookId, CategoryId = category.id });
                }
                else
                {
                    var r = db.ItemsCategories.Where(x => x.BookId == bookId && x.CategoryId == category.id).SingleOrDefault();
                    if (r != null)
                        db.ItemsCategories.Remove(r);
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