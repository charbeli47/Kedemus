using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for downloadStudentsExcel
    /// </summary>
    public class downloadStudentsExcel : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            int sId = int.Parse(context.Request["sId"]);
            var result = db.Students.Where(x => x.schoolId == sId).ToList();
            var school = db.Schools.Where(x => x.id == sId).SingleOrDefault();
            StringBuilder sb = new StringBuilder();
            sb.Append("FirstName\tLastName\tEmail \t Phone\t Address\t Accesscode\r\n");
            foreach (var row in result)
            {
                sb.AppendFormat("{0}\t{1}\t{2}\t{3}\t{4}\t{5}\r\n", row.FirstName, row.LastName, row.Email, row.Phone, row.Address, row.AccessCode);
            }
            context.Response.Buffer = true;
            context.Response.Charset = "";
            context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
            context.Response.ContentType = "application/vnd.ms-exce";
            context.Response.AddHeader("content-disposition", "attachment;filename=" + school.title.Replace(" ","-") + "-students.xls");
            context.Response.Write(sb.ToString());
            context.Response.Flush();
            context.Response.End();
            context.Response.Write("Hello World");
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