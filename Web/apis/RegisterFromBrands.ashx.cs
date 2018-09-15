using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Web;

namespace Web.apis
{
    /// <summary>
    /// Summary description for RegisterFromBrands
    /// </summary>
    public class RegisterFromBrands : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int levelId = int.Parse(context.Request["levelId"]);
            string accessCode = Get8Digits();
            string FirstName = context.Request["FirstName"];
            string LastName = context.Request["LastName"];
            string CountryName = context.Request["Country"];
            string City = context.Request["City"];
            string AddressLine = context.Request["Street"];
            string Building = context.Request["Building"];
            string Phone = context.Request["Phone"];
            string Email = context.Request["Email"];
            string APIUser = context.Request["APIUser"];
            string APIPassword = context.Request["APIPassword"];
            if (APIUser == "BrandsMktg" && APIPassword == "Br@nd$")
            {
                var student = db.Students.Add(new Student { AccessCode = accessCode, Address = AddressLine, Email = Email, FirstName = FirstName, LastName = LastName, Phone = Phone, levelId = levelId });
                string subject = "Your registration Access Code at teachkids.me";
                string body = string.Format("Dear {0} {1},<br/>Kindly find below your Access code and click on this <a href=\"http://teachkids.me/en/verify-account\">link</a> to create your account.<br/>Please note that You should verify your account at first, and then set your username and password.<br/><b>Access Code:</b>{3}", FirstName, LastName, accessCode);
                SendEmail(Email, subject, body, null, null, false, null);
                context.Response.Write("success");
            }
            else
                context.Response.Write("failure");
        }
        public string Get8Digits()
        {

            var bytes = new byte[4];

            var rng = RandomNumberGenerator.Create();

            rng.GetBytes(bytes);

            uint random = BitConverter.ToUInt32(bytes, 0) % 100000000;

            return String.Format("{0:D8}", random);

        }
        public static bool SendEmail(String recipient, String subject, String body, List<string> cc, List<string> bcc, bool isArabic, List<HttpPostedFile> files)
        {
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            Content c = db.Contents.ToList().FirstOrDefault();
            int Port = int.Parse(c.SmtpPort);
            bool isSSL = c.IsSSL != null ? (bool)c.IsSSL : false;
            string username = c.SystemEmail;
            string password = c.SystemEmailPassword;
            var fromAddress = new MailAddress(c.SystemEmail);
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
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}