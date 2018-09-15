using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web.assessment
{
    /// <summary>
    /// Summary description for saveResult
    /// </summary>
    public class saveResult : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int bookId = int.Parse(context.Request["bookId"]);
            int score = int.Parse(context.Request["score"]);
            int userId = (int)context.Session["UserId"];
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            db.StudentScores.Add(new StudentScore { bookId = bookId, score = score, studentId = userId });
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