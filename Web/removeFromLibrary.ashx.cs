using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web
{
    /// <summary>
    /// Summary description for removeFromLibrary
    /// </summary>
    public class removeFromLibrary : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int bookId = int.Parse(context.Request["bookId"]);
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            string msg = "success";
            try
            {
                int userId = (int)context.Session["UserId"];
                db.StudentLibraries.Remove(db.StudentLibraries.Where(x=>x.bookId == bookId && x.studentId == userId).FirstOrDefault());
                db.SaveChanges();
            }
            catch
            {
                msg = "error";
            }
            context.Response.Write(msg);
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