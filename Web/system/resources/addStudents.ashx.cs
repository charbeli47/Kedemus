using Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;

namespace Web.system.resources
{
    /// <summary>
    /// Summary description for addStudents
    /// </summary>
    public class addStudents : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            BrandsMktgBooksEntities db = new BrandsMktgBooksEntities();
            HttpPostedFile codesfile = context.Request.Files["studentsfile"];
            int levelId = int.Parse(context.Request["levelsSelect"]);
            int schoolId = int.Parse(context.Request["pageId"]);
            if (codesfile.ContentLength > 0)
            {
                string sfiletype = codesfile.FileName;
                sfiletype = sfiletype.Substring(sfiletype.LastIndexOf('.') + 1).ToLower();
                string codes_file = Guid.NewGuid().ToString() + "." + sfiletype;
                string _path = context.Server.MapPath("~/Media");
                codesfile.SaveAs(_path + "/" + codes_file);
                IEnumerable<ExcelStudent> students = ReadInData.GetDataReg(_path + "/" + codes_file, "Sheet1");
                foreach(var row in students)
                {
                    string accessCode = Get8Digits();
                    var student = db.Students.Add(new Student { AccessCode = accessCode, Address = row.Address, Email = row.Email, FirstName = row.FirstName, LastName = row.LastName, Phone = row.Phone, schoolId = schoolId, levelId = levelId });
                }
            }
            db.SaveChanges();
                context.Response.Write("Success");
        }
        public string Get8Digits()
        {

            var bytes = new byte[4];

            var rng = RandomNumberGenerator.Create();

            rng.GetBytes(bytes);

            uint random = BitConverter.ToUInt32(bytes, 0) % 100000000;

            return String.Format("{0:D8}", random);

        }
        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
    public class ExcelStudent
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
    }
    public class ReadInData
    {
        private string path;
        private string worksheetName;

        public ReadInData(string path, string worksheetName)
        {
            this.path = path;
            this.worksheetName = worksheetName;
        }
        public static IEnumerable<ExcelStudent> GetDataReg(string path, string worksheetName, bool isFirstRowAsColumnNames = true)
        {
            return new ExcelData(path).GetData(worksheetName, isFirstRowAsColumnNames)
                .Select(dataRow => new ExcelStudent()
                {
                    FirstName = dataRow["FirstName"].ToString(),
                    LastName = dataRow["LastName"].ToString(),
                    Email = dataRow["Email"].ToString(),
                    Address = dataRow["Address"].ToString(),
                   Phone = dataRow["Phone"].ToString()
                });
        }
    }
    public class ExcelData
    {
        private string path;

        public ExcelData(string path)
        {
            this.path = path;
        }
        private static IExcelDataReader GetExcelDataReader(string path, bool isFirstRowAsColumnNames)
        {
            using (FileStream fileStream = File.Open(path, FileMode.Open, FileAccess.Read))
            {
                IExcelDataReader dataReader;

                if (path.EndsWith(".xls"))
                    dataReader = ExcelReaderFactory.CreateBinaryReader(fileStream);
                else if (path.EndsWith(".xlsx"))
                    dataReader = ExcelReaderFactory.CreateOpenXmlReader(fileStream);
                else
                    throw new Exception("The file to be processed is not an Excel file");

                dataReader.IsFirstRowAsColumnNames = isFirstRowAsColumnNames;
                return dataReader;
            }
        }

        private static DataSet GetExcelDataAsDataSet(string path, bool isFirstRowAsColumnNames)
        {
            return GetExcelDataReader(path, isFirstRowAsColumnNames).AsDataSet();
        }

        private static DataTable GetExcelWorkSheet(string path, string workSheetName, bool isFirstRowAsColumnNames)
        {
            DataTable workSheet = GetExcelDataAsDataSet(path, isFirstRowAsColumnNames).Tables[workSheetName];
            if (workSheet == null)
                throw new Exception(string.Format("The worksheet {0} does not exist, has an incorrect name, or does not have any data in the worksheet", workSheetName));
            return workSheet;
        }
        private IExcelDataReader GetExcelDataReader(bool isFirstRowAsColumnNames)
        {
            using (FileStream fileStream = File.Open(path, FileMode.Open, FileAccess.Read))
            {
                IExcelDataReader dataReader;

                if (path.EndsWith(".xls"))
                {
                    dataReader = ExcelReaderFactory.CreateBinaryReader(fileStream);
                }
                else if (path.EndsWith(".xlsx"))
                {
                    dataReader = ExcelReaderFactory.CreateOpenXmlReader(fileStream);
                }
                else
                {
                    //Throw exception for things you cannot correct
                    throw new Exception("The file to be processed is not an Excel file");
                }

                dataReader.IsFirstRowAsColumnNames = isFirstRowAsColumnNames;

                return dataReader;
            }
        }

        private DataSet GetExcelDataAsDataSet(bool isFirstRowAsColumnNames)
        {
            return GetExcelDataReader(isFirstRowAsColumnNames).AsDataSet();
        }
        private DataTable GetExcelWorkSheet(string workSheetName, bool isFirstRowAsColumnNames)
        {
            DataSet dataSet = GetExcelDataAsDataSet(isFirstRowAsColumnNames);
            DataTable workSheet = dataSet.Tables[workSheetName];

            if (workSheet == null)
            {
                throw new Exception(string.Format("The worksheet {0} does not exist, has an incorrect name, or does not have any data in the worksheet", workSheetName));
            }

            return workSheet;
        }
        private static IEnumerable<DataRow> GetData(string path, string workSheetName, bool isFirstRowAsColumnNames = true)
        {
            return from DataRow row in GetExcelWorkSheet(path, workSheetName, isFirstRowAsColumnNames).Rows select row;
        }
        public IEnumerable<DataRow> GetData(string workSheetName, bool isFirstRowAsColumnNames = true)
        {
            DataTable workSheet = GetExcelWorkSheet(workSheetName, isFirstRowAsColumnNames);

            IEnumerable<DataRow> rows = from DataRow row in workSheet.Rows
                                        select row;

            return rows;
        }
    }
}