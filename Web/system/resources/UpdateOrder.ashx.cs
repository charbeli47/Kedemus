using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for UpdateProjectsOrder
    /// </summary>
    public class UpdateOrder : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int id = int.Parse(context.Request["id"]);
            int toPosition = int.Parse(context.Request["toPosition"]);
            int fromPosition = int.Parse(context.Request["fromPosition"]);
            string direction = context.Request["direction"];
            string table = context.Request["table"];
            
            switch (table)
            {
                
                case "Levels":
                    if (direction == "back")
                    {
                        var moved = db.BooksLevels.Where(c => (toPosition <= c.OrderIndex && c.OrderIndex <= fromPosition))
                            .ToList();
                        foreach (var p in moved)
                        {
                            p.OrderIndex++;
                        }
                    }
                    else
                    {
                        var moved = db.BooksLevels.Where(c => (fromPosition <= c.OrderIndex && c.OrderIndex <= toPosition))
                            .ToList();
                        foreach (var p in moved)
                        {
                            p.OrderIndex--;
                            if (p.OrderIndex < 0)
                                p.OrderIndex = 0;
                        }
                    }
                    db.BooksLevels.Where(x => x.id == id).SingleOrDefault().OrderIndex = toPosition;
                    break;
                case "Slides":
                    if (direction == "back")
                    {
                        var moved = db.BookSlides.Where(c => (toPosition <= c.OrderIndex && c.OrderIndex <= fromPosition))
                            .ToList();
                        foreach (var p in moved)
                        {
                            p.OrderIndex++;
                        }
                    }
                    else
                    {
                        var moved = db.BookSlides.Where(c => (fromPosition <= c.OrderIndex && c.OrderIndex <= toPosition))
                            .ToList();
                        foreach (var p in moved)
                        {
                            p.OrderIndex--;
                            if (p.OrderIndex < 0)
                                p.OrderIndex = 0;
                        }
                    }
                    db.BookSlides.Where(x => x.id == id).SingleOrDefault().OrderIndex = toPosition;
                    break;
                case "BookUnites":
                    if (direction == "back")
                    {
                        var moved = db.BookUnites.Where(c => (toPosition <= c.OrderIndex && c.OrderIndex <= fromPosition))
                            .ToList();
                        foreach (var p in moved)
                        {
                            p.OrderIndex++;
                        }
                    }
                    else
                    {
                        var moved = db.BookUnites.Where(c => (fromPosition <= c.OrderIndex && c.OrderIndex <= toPosition))
                            .ToList();
                        foreach (var p in moved)
                        {
                            p.OrderIndex--;
                            if (p.OrderIndex < 0)
                                p.OrderIndex = 0;
                        }
                    }
                    db.BookUnites.Where(x => x.id == id).SingleOrDefault().OrderIndex = toPosition;
                    break;
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