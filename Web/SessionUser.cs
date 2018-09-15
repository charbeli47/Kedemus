using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.SessionState;

namespace Web
{
    public class SessionUser
    {
        public string Key { get; set; }
        public string Value { get; set; }
        public static List<SessionUser> Get()
        {
            return (List<SessionUser>)HttpContext.Current.Cache["UsersList"];
        }
        public static void Add(string key, string value)
        {
            List<SessionUser> usersList = new List<SessionUser>();
            if (HttpContext.Current.Cache["UsersList"] != null)
                usersList = (List<SessionUser>)HttpContext.Current.Cache["UsersList"];
            SessionUser user = new SessionUser();
            user.Key = key;
            user.Value = value;
            usersList.Add(user);
            HttpContext.Current.Cache["UsersList"] = usersList;
        }
        public static void Remove(string key)
        {
            List<SessionUser> usersList = new List<SessionUser>();
            if (HttpContext.Current.Cache["UsersList"] != null)
            {
                usersList = (List<SessionUser>)HttpContext.Current.Cache["UsersList"];
                var user = usersList.Where(x => x.Key == key).SingleOrDefault();
                if (user != null)
                    usersList.Remove(user);
                HttpContext.Current.Cache["UsersList"] = usersList;
            }
        }
    }
}