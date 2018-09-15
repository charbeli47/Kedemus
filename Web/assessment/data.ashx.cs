using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace Web.assessment
{
    /// <summary>
    /// Summary description for data
    /// </summary>
    public class data : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/xml";
            string xmlData = "";
            int bookId = int.Parse(context.Request["bookId"]);
            if (context.Session["UserId"] != null)
            {
                BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
                var questions = db.Questions.Where(x=>x.QuestionsCategory.bookId == bookId).ToList();
                xmlData = @"<?xml version=""1.0"" encoding=""UTF-8""?>
<questions bookid="""+bookId+@""">";
                foreach (var question in questions)
                {
                    string correctAnswer = "";
                    string answersData = "";
                    int i = 0;
                    foreach (var answer in question.QuestionsAnswers)
                    {
                        i++;
                        if (question.correctAnswer == answer.text)
                            correctAnswer = i.ToString();
                        answersData += @"
			        <answer " + (!string.IsNullOrEmpty(answer.width) ? "width=\"" + answer.width + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.x) ? "x=\"" + answer.x + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.y) ? "y=\"" + answer.y + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.audio) ? "audio=\"" + answer.audio + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.type) ? "type=\"" + answer.type + "\"" : "") + ">" + (answer.type != "image" ? "<![CDATA[" + answer.text + "]]>" : answer.text) + @"</answer>";
                    }

                        xmlData += @"<item>
		<category>" + question.QuestionsCategory.title + @"</category>
		<question type=""" + question.type + @""" audio=""" + question.audio + @""">" + question.title + @"</question>
		<answers answerLayout=""" + question.AnswersLayout + @""" correctAnswer=""" + correctAnswer + @""" answerRandom=""true"">" + answersData;
           //         foreach (var answer in question.QuestionsAnswers)
           //         {
           //             xmlData += @"
			        //<answer " + (!string.IsNullOrEmpty(answer.width) ? "width=\"" + answer.width + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.x) ? "x=\"" + answer.x + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.y) ? "y=\"" + answer.y + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.audio) ? "audio=\"" + answer.audio + "\"" : "") + @" " + (!string.IsNullOrEmpty(answer.type) ? "type=\"" + answer.type + "\"" : "") + ">" + (answer.type != "image" ? "<![CDATA[" + answer.text + "]]>" : answer.text) + @"</answer>";
           //         }
                    xmlData += @"</answers>
	</item>";
                }
                xmlData += "</questions>";
            }
            context.Response.Write(xmlData);
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