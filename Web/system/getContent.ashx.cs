using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;

namespace Web
{
    /// <summary>
    /// Summary description for getContent
    /// </summary>
    public class getContent : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/html; charset=utf-8";
            string content = "";
            string section = context.Request["section"];
            string opId = context.Request["opId"];
            string args = context.Request["args"];
            WebClient c = new WebClient();
            c.Encoding = System.Text.Encoding.UTF8;
            string expr = "http://" + HttpContext.Current.Request.Url.Host + ":" + HttpContext.Current.Request.Url.Port + "/system/resources/" + section + "?opId=" + opId + "&" + args;
            content = c.DownloadString(expr);
            context.Response.Write(content);
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