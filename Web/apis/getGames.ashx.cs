using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace Web.apis
{
    /// <summary>
    /// Summary description for getGames
    /// </summary>
    public class getGames : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/json";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var games = db.BookGames.ToList();
            List<ApiGame> apigames = new List<ApiGame>();
            foreach(var game in games)
            {
                apigames.Add(new ApiGame { Folder = game.Folder, id = game.id, Thumb = game.Thumb, levelId = (int)game.levelId });
            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(apigames));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
    public class ApiGame
    {
        public int id { get; set; }
        public int levelId { get; set; }
        public string Folder { get; set; }
        public string Thumb { get; set; }
    }
}