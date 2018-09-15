using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web
{
    public class Permissions
    {
        public static bool Check(int opId, string Section, string action)
        {
            bool isAdmin = false;
            HttpContext context = System.Web.HttpContext.Current;
            BrandsMktgBooksEntities dc = new BrandsMktgBooksEntities();
            var user = dc.cms_user.ToList().Where(x => x.id == opId).SingleOrDefault();
            string groupname = dc.cms_groups.ToList().Where(x => x.id == user.groupId).Single().name.ToLower();
            if (!groupname.ToLower().Contains("admin"))
            {
                var policies = dc.cms_policies.ToList().Where(x => x.groupId == user.groupId && x.cms_permissions.name == Section).ToArray();
                for (int i = 0; i < policies.Length; i++)
                {
                    if (policies[i].event_permitted == action)
                    {
                        isAdmin = true;
                    }
                }
            }
            else
            {
                isAdmin = true;
            }
            return isAdmin;
        }
        public static bool IsForman(int opId)
        {
            HttpContext context = System.Web.HttpContext.Current;
            BrandsMktgBooksEntities dc = new BrandsMktgBooksEntities();
            var user = dc.cms_user.ToList().Where(x => x.id == opId).SingleOrDefault();
            string groupname = dc.cms_groups.ToList().Where(x => x.id == user.groupId).Single().name.ToLower();
            return (groupname.ToLower().Contains("foreman") || groupname.ToLower().Contains("foremen"));
            
        }
    }
}