using NPOI.HSSF.UserModel;
using System;
using System.Collections.Generic;
using System.DirectoryServices;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using Microsoft.Web.Administration;


namespace Web.resources
{
    /// <summary>
    /// Summary description for AddRow
    /// </summary>
    public class AddRow : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string table = context.Request.Form["table"];
            string Rows = context.Request.Form["Rows"];
            string[] split = Rows.Split('|');
            string success = "";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int lastOrderId = 1;
            switch (table)
            {
                case "cms_user":
                    db.cms_user.Add(new cms_user() { username = split[0], password = MD5Hash(split[1]), groupId = int.Parse(split[2]), status = int.Parse(split[3]), firstname = split[4], lastname = split[5], phone = split[6], email = split[7], address = split[8] });
                    success = "success";
                    break;
                case "cms_groups":
                    db.cms_groups.Add(new cms_groups() { name = split[0] });
                    success = "success";
                    break;
                case "BooksCategories":
                    db.Categories.Add(new Category() { title = split[0],artitle = split[1], OrderIndex = 0, ForGame = bool.Parse(split[2]) });
                    success = "success";
                    break;
                case "QuestionsCategories":
                    db.QuestionsCategories.Add(new QuestionsCategory() { title = split[0], bookId = int.Parse(split[1]) });
                    success = "success";
                    break;
                case "Levels":
                    var orderId = db.Levels.OrderByDescending(x => x.OrderIndex).FirstOrDefault();
                    
                    if (orderId != null)
                        lastOrderId = (int)orderId.OrderIndex + 1;
                    db.Levels.Add(new Level() { title = split[0], OrderIndex = lastOrderId, artitle = split[1] });
                    success = "success";
                    break;
                case "BookUnites":
                    var lastunite = db.BookInteractiveChapters.OrderByDescending(x => x.OrderIndex).FirstOrDefault();
                    
                    if (lastunite != null)
                        lastOrderId = (int)lastunite.OrderIndex + 1;
                    db.BookInteractiveChapters.Add(new BookInteractiveChapter { title = split[0], bookId = int.Parse(split[1]), OrderIndex = lastOrderId });
                    break;
                case "IPs":
                    string val = split[0];
                    BlockIP(val);
                    break;
            }
            
            db.SaveChanges();
            context.Response.Write(success);
        }
        static void BlockIP(string IP)
        {
            using (ServerManager serverManager = new ServerManager())
            {
                Microsoft.Web.Administration.Configuration config = serverManager.GetApplicationHostConfiguration();
                Microsoft.Web.Administration.ConfigurationSection ipSecuritySection = config.GetSection("system.webServer/security/ipSecurity", "BrandsMarketing");
                ConfigurationElementCollection ipSecurityCollection = ipSecuritySection.GetCollection();

                ConfigurationElement addElement = ipSecurityCollection.CreateElement("add");
                addElement["ipAddress"] = IP;
                addElement["allowed"] = false;
                ipSecurityCollection.Add(addElement);

               
                serverManager.CommitChanges();
            }
        }
        public static string MD5Hash(string text)
        {
            MD5 md5 = new MD5CryptoServiceProvider();

            //compute hash from the bytes of text
            md5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(text));

            //get hash result after compute it
            byte[] result = md5.Hash;

            StringBuilder strBuilder = new StringBuilder();
            for (int i = 0; i < result.Length; i++)
            {
                //change it into 2 hexadecimal digits
                //for each byte
                strBuilder.Append(result[i].ToString("x2"));
            }

            return strBuilder.ToString();
        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

        public string  GetMonthName(int monthNum )
        {
            try
            {
                DateTime strDate = new DateTime(1, monthNum, 1);
                return strDate.ToString("MMM");
            }
            catch( Exception ex ) 
            {
                return "";
            }
        
        }
    }
}