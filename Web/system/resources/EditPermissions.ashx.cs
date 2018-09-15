using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.resources
{
    /// <summary>
    /// Summary description for EditPermissions
    /// </summary>
    public class EditPermissions : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            int id = int.Parse(context.Request["id"]);
            string[] collection = context.Request["collec"].Split('!');
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var group = db.cms_groups.Where(x=>x.id == id).SingleOrDefault();
            var policies = db.cms_policies.Where(x => x.groupId == id).ToList();
            foreach(cms_policies pol in policies)
            {
                db.cms_policies.Remove(pol);
            }
            foreach (string val in collection)
            {
                if (val != "")
                {
                    string[] vals = val.Split('|');
                    
                    db.cms_policies.Add(new cms_policies() { permissionId = int.Parse(vals[1]), groupId = id, event_permitted = vals[0] });
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