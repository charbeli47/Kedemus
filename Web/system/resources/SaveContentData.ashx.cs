using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for SaveContentData
    /// </summary>
    public class SaveContentData : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            Content content = new Content();
            var contentList = db.Contents;
            
            if (contentList.Count() > 0)
            {
                content = contentList.FirstOrDefault();
                content.AboutUs = context.Request["AboutUs"];
                content.Description = context.Request["Description"];
                content.keywords = context.Request["Keywords"];
                content.Email = context.Request["Email"];
                content.AddressLine = context.Request["AddressLine"];
                content.Phone = context.Request["Phone"];
                content.Fax = context.Request["Fax"];
                content.longitude = context.Request["Longitude"];
                content.latitude = context.Request["Latitude"];
                content.SmtpServer = context.Request["SmtpServer"];
                content.SmtpPort = context.Request["SmtpPort"];
                content.IsSSL = context.Request["IsSSL"] == "on";
                content.SystemEmail = context.Request["SystemEmail"];
                content.SystemEmailPassword = context.Request["SystemEmailPassword"];
                content.InfoEmail = context.Request["InfoEmail"];
                content.SmartLearningVideo = context.Request["SmartLearningVideo"];
            }
            else
            {
                content.AboutUs = context.Request["AboutUs"];
                content.Description = context.Request["Description"];
                content.keywords = context.Request["Keywords"];
                content.Email = context.Request["Email"];
                content.AddressLine = context.Request["AddressLine"];
                content.Phone = context.Request["Phone"];
                content.Fax = context.Request["Fax"];
                content.longitude = context.Request["Longitude"];
                content.latitude = context.Request["Latitude"];
                content.SmtpServer = context.Request["SmtpServer"];
                content.SmtpPort = context.Request["SmtpPort"];
                content.IsSSL = context.Request["IsSSL"] == "on";
                content.SystemEmail = context.Request["SystemEmail"];
                content.SystemEmailPassword = context.Request["SystemEmailPassword"];
                content.InfoEmail = context.Request["InfoEmail"];
                content.SmartLearningVideo = context.Request["SmartLearningVideo"];
                db.Contents.Add(content);
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