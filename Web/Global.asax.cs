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
                routes.MapPageRoute("ENPosters", "en/posters",
                       "~/games.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "posters" } });
                
                routes.MapPageRoute("ENVerifyAccount", "en/verify-account",
                       "~/verify-account.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "verify-account" } });
                routes.MapPageRoute("ENForgotPassword", "en/forgot-password",
                       "~/forgot-password.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "forgot-password" } });

                //French 
                routes.MapPageRoute("FRLogin", "fr/login",
                       "~/login.aspx", true, new RouteValueDictionary { { "lang", "fr" }, { "page", "login" } });
                routes.MapPageRoute("FRLogout", "fr/logout",
                       "~/logout.aspx", true, new RouteValueDictionary { { "lang", "fr" }, { "page", "logout" } });
                routes.MapPageRoute("FRPosters", "fr/posters",
                       "~/games.aspx", true, new RouteValueDictionary { { "lang", "fr" }, { "page", "posters" } });
                
                routes.MapPageRoute("FRVerifyAccount", "fr/verify-account",
                       "~/verify-account.aspx", true, new RouteValueDictionary { { "lang", "fr" }, { "page", "verify-account" } });
                routes.MapPageRoute("FRForgotPassword", "fr/forgot-password",
                       "~/forgot-password.aspx", true, new RouteValueDictionary { { "lang", "fr" }, { "page", "forgot-password" } });
            }
            catch { }

            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var books = db.Books.ToList();
            foreach (var book in books)
            {
                try
                {
                    if (book.lang == "en")
                    {
                        routes.MapPageRoute("ENBook" + book.id.ToString(), "en/book-" + book.id.ToString(),
                    "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "en" }, { "levelId", book.levelId }, { "page", "book-" + book.id } });
                        routes.MapPageRoute("ENStories" + book.id.ToString(), "en/stories-" + book.id,
                       "~/stories.aspx", true, new RouteValueDictionary { { "lang", "en" }, { "page", "stories-" + book.id }, { "bookId", book.id } });
                    }
                    else
                    {
                        routes.MapPageRoute("FRBook" + book.id.ToString(), "fr/book-" + book.id.ToString(),
                        "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "fr" }, { "levelId", book.levelId }, { "page", "book-" + book.id } });
                        routes.MapPageRoute("FRStories" + book.id.ToString(), "fr/stories-" + book.id,
                       "~/stories.aspx", true, new RouteValueDictionary { { "lang", "fr" }, { "page", "stories-" + book.id }, { "bookId", book.id } });
                    }
                }
                catch { }
            }
            var stories = db.BookStories.ToList();
            foreach (var story in stories)
            {
                try
                {
                    if (story.Book.lang == "en")
                    {
                        routes.MapPageRoute("ENStory" + story.id.ToString(), "en/story-" + story.id.ToString(),
                        "~/story.aspx", true, new RouteValueDictionary { { "id", story.id }, { "lang", "en" }, { "bookId", story.bookId }, { "page", "story-" + story.id } });
                    }
                    else
                    {

                        routes.MapPageRoute("FRStory" + story.id.ToString(), "fr/story-" + story.id.ToString(),
                        "~/story.aspx", true, new RouteValueDictionary { { "id", story.id }, { "lang", "fr" }, { "bookId", story.bookId }, { "page", "story-" + story.id } });
                    }
                }
                catch { }
            }
            var levels = db.BooksLevels.ToList();
            foreach(var level in levels)
            {
                try
                {
                    routes.MapPageRoute("ENLevel" + level.id.ToString(), "en/level-" + level.id.ToString(),
                    "~/books.aspx", true, new RouteValueDictionary { { "id", level.id }, { "lang", "en" }, { "levelId", level.id }, { "page", "level-" + level.id } });

                    routes.MapPageRoute("FRLevel" + level.id.ToString(), "fr/level-" + level.id.ToString(),
                    "~/books.aspx", true, new RouteValueDictionary { { "id", level.id }, { "lang", "fr" }, { "levelId", level.id }, { "page", "level-" + level.id } });
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
                    routes.Remove(RouteTable.Routes["FRBook" + book.id.ToString()]);
                }
                catch
                {

                }
                try
                {
                    routes.MapPageRoute("ENBook" + book.id.ToString(), "en/book-" + book.id.ToString(),
                    "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "en" }, { "levelId", book.levelId }, { "page", "book-" + book.id } });

                    routes.MapPageRoute("FRBook" + book.id.ToString(), "fr/book-" + book.id.ToString(),
                    "~/product.aspx", true, new RouteValueDictionary { { "id", book.id }, { "lang", "fr" }, { "levelId", book.levelId }, { "page", "book-" + book.id } });
                }
                catch { }
            }
            var levels = db.BooksLevels.ToList();
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

                    routes.MapPageRoute("FRLevel" + level.id.ToString(), "fr/level-" + level.id.ToString(),
                    "~/books.aspx", true, new RouteValueDictionary { { "id", level.id }, { "lang", "fr" }, { "levelId", level.id }, { "page", "level-" + level.id } });
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