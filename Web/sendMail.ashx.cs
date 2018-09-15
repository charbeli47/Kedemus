using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace Web
{
    /// <summary>
    /// Summary description for sendMail
    /// </summary>
    public class sendMail : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/json";
            try {
                string recipient = context.Request["recipient"];
                string name = context.Request["your-name"];
                List<HttpPostedFile> files = new List<HttpPostedFile>();
                HttpFileCollection filesCollection = context.Request.Files;
                for(int i=0;i< filesCollection.Count;i++)
                    files.Add(filesCollection[i]);
                string email = context.Request["email"];
                string phone = context.Request["phone"];
                string description = context.Request["message"];
                string body = "<table><tr><th>Name:</th><td>{0}</td></tr><tr><th>Email:</th><td>{1}</td></tr><tr><th>Phone number:</th><td>{2}</td></tr><tr><td colspan='2'>Body</td></tr><tr><td colspan='2'>{3}</td></tr></table>";
                body = string.Format(body, name, email, phone, description);

                bool b = SendEmail(name + " sent you an email via website", body, null, null, false, files);
                if (b)
                    context.Response.Write("Your message sent successfully.");
                else
                    context.Response.Write("Sorry, your message was not delivered, please try again later.");
            }
            catch(Exception ex) { context.Response.Write(ex.Message); }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
        public static bool SendEmail(String subject, String body, List<string> cc, List<string> bcc, bool isArabic, List<HttpPostedFile> files)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            Content c = db.Contents.ToList().FirstOrDefault();
            string recipient = c.InfoEmail;
            int Port = int.Parse(c.SmtpPort);
            bool isSSL = c.IsSSL!=null?(bool)c.IsSSL:false;
            string username = c.SystemEmail;
            string password = c.SystemEmailPassword;
            var fromAddress = new MailAddress(c.InfoEmail);
            var toAddress = new MailAddress(recipient);

            var smtp = new SmtpClient
            {
                Host = c.SmtpServer,
                Port = Port,
                DeliveryMethod = SmtpDeliveryMethod.Network,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(username, password)
            };
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
            smtp.EnableSsl = isSSL;
            try
            {
                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    Subject = subject,
                    IsBodyHtml = true,
                    Body = body
                }
                )
                {
                    if (files != null)
                    {
                        foreach (HttpPostedFile file in files)
                        {
                            message.Attachments.Add(new Attachment(file.InputStream, Path.GetFileName(file.FileName), file.ContentType));
                        }
                    }
                    smtp.Send(message);
                }
                return true;
            }
            catch (System.Net.Mail.SmtpException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}