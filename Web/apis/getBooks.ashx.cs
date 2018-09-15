using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace Web.apis
{
    /// <summary>
    /// Summary description for getBooks
    /// </summary>
    public class getBooks : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/json";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            var books = db.Books.Where(x => x.isAvailable == true).ToList();
            string lang = context.Request["lang"];
            List<ApiBook> apibooks = new List<ApiBook>();
            foreach(var book in books)
            {
                List<ApiBookSlide> apislides = new List<ApiBookSlide>();
                foreach(var slide in book.BookSlides)
                {
                    apislides.Add(new ApiBookSlide { id = slide.id, img = slide.img, OrderIndex = (int)slide.OrderIndex });
                }
                bool hasassessment = db.QuestionsCategories.Count() > 0;
                if(lang=="en")
                    apibooks.Add(new ApiBook { background = book.background, id = book.id, pdf = book.pdf, SignLanguageVideo = book.SignLanguageVideo, text = book.text, thumb = book.thumb, title = book.title, video = book.video, Slides = apislides, HasAssessment = hasassessment });
                else
                    apibooks.Add(new ApiBook { background = book.background, id = book.id, pdf = book.pdf, SignLanguageVideo = book.SignLanguageVideo, text = book.artext, thumb = book.thumb, title = book.artitle, video = book.video, Slides = apislides, HasAssessment = hasassessment });

            }
            JavaScriptSerializer js = new JavaScriptSerializer();
            context.Response.Write(js.Serialize(apibooks));
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
    public class ApiBook
    {
        public int id { get; set; }
        public string title { get; set; }
        public string pdf { get; set; }
        public string text { get; set; }
        public string thumb { get; set; }
        public string video { get; set; }
        public string background { get; set; }
        public string SignLanguageVideo { get; set; }
        public List<ApiBookSlide> Slides { get; set; }
        public bool HasAssessment { get; set; }
    }
    public class ApiBookSlide
    {
        public int id { get; set; }
        public string img { get; set; }
        public int OrderIndex { get; set; }
    }
}