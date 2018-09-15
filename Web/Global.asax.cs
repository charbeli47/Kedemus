using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Web
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
        }
        public static void RegisterRoutes(RouteCollection routes)
        {
            try
            {
                routes.MapPageRoute("ENHome", "en/home",
                       "~/default.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "home" } });
                routes.MapPageRoute("ENLogin", "en/login",
                       "~/login.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "login" } });
                routes.MapPageRoute("ENLogout", "en/logout",
                       "~/logout.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "logout" } });
                routes.MapPageRoute("ENGames", "en/games",
                       "~/games.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "games" } });
                routes.MapPageRoute("ENVerifyAccount", "en/verify-account",
                       "~/verify-account.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "verify-account" } });
                routes.MapPageRoute("ENForgotPassword", "en/forgot-password",
                       "~/forgot-password.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "forgot-password" } });

                //Arabic 
                routes.MapPageRoute("ARHome", "ar/home",
                    "~/default.aspx", true, new RouteValueDictionary { { "lang", "ar" }, { "page", "home" } });
                routes.MapPageRoute("ARLogin", "ar/login",
                       "~/login.aspx", true, new RouteValueDictionary { { "lang", "ar" }, { "page", "login" } });
                routes.MapPageRoute("ARLogout", "ar/logout",
                       "~/logout.aspx", true, new RouteValueDictionary { { "lang", "ar" }, { "page", "logout" } });
                routes.MapPageRoute("ARGames", "ar/games",
                       "~/games.aspx", true, new RouteValueDictionary { { "lang", "ar" }, { "page", "games" } });
                routes.MapPageRoute("ARVerifyAccount", "ar/verify-account",
                       "~/verify-account.aspx", true, new RouteValueDictionary { { "lang", "ar" }, { "page", "verify-account" } });
                routes.MapPageRoute("ARForgotPassword", "ar/forgot-password",
                       "~/forgot-password.aspx", true, new RouteValueDictionary { { "lang", "ar" }, { "page", "forgot-password" } });
            }
            catch { }

            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var books = db.Books.ToList();
            foreach (var book in books)
            {
                try
                {
                    var itemLevel = book.ItemsLevels.FirstOrDefault() != null ? book.ItemsLevels.FirstOrDefault().LevelId : 0;
                    routes.MapPageRoute("ENBook" + book.id.ToString(), "en/book-" + book.id.ToString(),
                    "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "en" }, { "levelId", itemLevel }, {"page","book-" + book.id } });

                    routes.MapPageRoute("ARBook" + book.id.ToString(), "ar/book-" + book.id.ToString(),
                    "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "ar" }, { "levelId", itemLevel }, { "page", "book-" + book.id } });
                }
                catch { }
            }
            var levels = db.Levels.ToList();
            foreach(var level in levels)
            {
                try
                {
                    routes.MapPageRoute("ENLevel" + level.id.ToString(), "en/level-" + level.id.ToString(),
                    "~/books.aspx", true, new RouteValueDictionary { { "id", level.id }, { "lang", "en" }, { "levelId", level.id }, { "page", "level-" + level.id } });

                    routes.MapPageRoute("ARLevel" + level.id.ToString(), "ar/level-" + level.id.ToString(),
                    "~/books.aspx", true, new RouteValueDictionary { { "id", level.id }, { "lang", "ar" }, { "levelId", level.id }, { "page", "level-" + level.id } });
                }
                catch { }
            }
            
        }
        public static void UpdateRoutes(RouteCollection routes)
        {
            

            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var books = db.Books.ToList();
            foreach (var book in books)
            {
                try
                {
                    routes.Remove(RouteTable.Routes["ENBook" + book.id.ToString()]);
                    routes.Remove(RouteTable.Routes["ARBook" + book.id.ToString()]);
                }
                catch
                {

                }
                try
                {
                    var itemLevel = book.ItemsLevels.FirstOrDefault() != null ? book.ItemsLevels.FirstOrDefault().LevelId : 0;
                    routes.MapPageRoute("ENBook" + book.id.ToString(), "en/book-" + book.id.ToString(),
                    "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "en" }, { "levelId", itemLevel }, { "page", "book-" + book.id } });

                    routes.MapPageRoute("ARBook" + book.id.ToString(), "ar/book-" + book.id.ToString(),
                    "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "ar" }, { "levelId", itemLevel }, { "page", "book-" + book.id } });
                }
                catch { }
            }
            var levels = db.Levels.ToList();
            foreach (var level in levels)
            {
                try
                {
                    routes.Remove(RouteTable.Routes["ENLevel" + level.id.ToString()]);
                    routes.Remove(RouteTable.Routes["ARLevel" + level.id.ToString()]);
                }
                catch
                {

                }
                try
                {
                    routes.MapPageRoute("ENLevel" + level.id.ToString(), "en/level-" + level.id.ToString(),
                    "~/books.aspx", true, new RouteValueDictionary { { "id", level.id }, { "lang", "en" }, { "levelId", level.id }, { "page", "level-" + level.id } });

                    routes.MapPageRoute("ARLevel" + level.id.ToString(), "ar/level-" + level.id.ToString(),
                    "~/books.aspx", true, new RouteValueDictionary { { "id", level.id }, { "lang", "ar" }, { "levelId", level.id }, { "page", "level-" + level.id } });
                }
                catch { }
            }

        }
        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {
            UpdateRoutes(RouteTable.Routes);
        }
        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {
            string key = "";
            if (Session["UserId"] != null)
                key = Session["UserId"].ToString();
            Session["UserId"] = null;
            List<SessionUser> usersList = new List<SessionUser>();
            if (System.Web.HttpRuntime.Cache["UsersList"] != null)
            {
                usersList = (List<SessionUser>)System.Web.HttpRuntime.Cache["UsersList"];
                var user = usersList.Where(x => x.Key == key).SingleOrDefault();
                if (user != null)
                    usersList.Remove(user);
                System.Web.HttpRuntime.Cache["UsersList"] = usersList;
            }
            //SessionUser.Remove(key);
        }

        protected void Application_End(object sender, EventArgs e)
        {
            string key = "";
            if (Session["UserId"] != null)
                key = Session["UserId"].ToString();
            Session["UserId"] = null;
            List<SessionUser> usersList = new List<SessionUser>();
            if (System.Web.HttpRuntime.Cache["UsersList"] != null)
            {
                usersList = (List<SessionUser>)System.Web.HttpRuntime.Cache["UsersList"];
                var user = usersList.Where(x => x.Key == key).SingleOrDefault();
                if (user != null)
                    usersList.Remove(user);
                System.Web.HttpRuntime.Cache["UsersList"] = usersList;
            }
        }
    }
}