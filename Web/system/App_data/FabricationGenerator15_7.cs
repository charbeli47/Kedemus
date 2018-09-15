using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using NPOI.HSSF.UserModel;

namespace Web.system.App_data
{
    public class FabricationGenerator15_7
    {
        int pageNumOfRows = 46;
        int dataNumOfRows = 44;

        HSSFWorkbook workBook;
        HSSFSheet hssfSheet;

        string fabFileLocation = "";

        int excelLocation = 0;

        int numOfPages = 0;
        int localRow = 0;

        double overallLength = 0;

        public FabricationGenerator15_7()
        {

        }

        public void GenerateFabrication(ProjectInfo projectInfo, List<DXFData> dxfData, string saveLocation)
        {
            fabFileLocation = System.AppDomain.CurrentDomain.BaseDirectory + "\\Templates\\Fabrication15_7.xls";
            using (var fs = new FileStream(fabFileLocation, FileMode.Open, FileAccess.Read))
            {
                workBook = new HSSFWorkbook(fs);
            }

            hssfSheet = (HSSFSheet)workBook.GetSheet("Fabrication");

            hssfSheet.GetRow(4).CreateCell(1).SetCellValue(projectInfo.projectName);
            hssfSheet.GetRow(5).CreateCell(1).SetCellValue(projectInfo.projectNumber);
            hssfSheet.GetRow(6).CreateCell(1).SetCellValue(projectInfo.generalContractor);
            hssfSheet.GetRow(7).CreateCell(1).SetCellValue(projectInfo.workParcel);

            numOfPages = ((dxfData.Count - 33) / dataNumOfRows) + (((dxfData.Count - 33) % dataNumOfRows) > 0 ? 2 : 1);

            AddProjectInfo(dxfData[0]);

            for (int i = 0; i < numOfPages; i++)
            {
                GenerateHeader(i);
            }
            for (int i = 0; i < dxfData.Count; i++)
            {
                AddFabricationRow(i, dxfData[i]);
            }


            GenerateMaterials(projectInfo, dxfData);
            using (var fs = new FileStream(saveLocation, FileMode.OpenOrCreate, FileAccess.Write))
            {
                workBook.Write(fs);
            }
        }

        public void GenerateHeader(int pageNumber)
        {
            if (pageNumber == 0)
            {
                for (int i = 15; i < pageNumOfRows; i++)
                {
                    hssfSheet.CreateRow(i);
                    hssfSheet.GetRow(i).Height = 345;
                }
                return;
            }

            localRow = pageNumber * pageNumOfRows;
            for (int i = localRow; i < localRow + pageNumOfRows; i++)
            {
                hssfSheet.CreateRow(i);
                hssfSheet.GetRow(i).Height = 345;
            }

            hssfSheet.GetRow(localRow + 1).CreateCell(0).SetCellValue("Carrying Forward ");
            hssfSheet.GetRow(localRow + 1).GetCell(0).CellStyle = hssfSheet.GetRow(6).GetCell(3).CellStyle;

            hssfSheet.GetRow(localRow + 2).CreateCell(0).SetCellValue("Type No.");
            hssfSheet.GetRow(localRow + 2).CreateCell(1).SetCellValue("Strands  #");
            hssfSheet.GetRow(localRow + 2).CreateCell(2).SetCellValue("Length (m)");
            hssfSheet.GetRow(localRow + 2).CreateCell(3).SetCellValue("Length (ft)");
            hssfSheet.GetRow(localRow + 2).CreateCell(4).SetCellValue("Remarks");

            // Applying Styles
            for (int i = 0; i < 5; i++)
            {
                hssfSheet.GetRow(localRow + 2).GetCell(i).CellStyle = hssfSheet.GetRow(12).GetCell(i).CellStyle;
            }
        }

        public void AddProjectInfo(DXFData dxfData)
        {
            hssfSheet.GetRow(6).GetCell(4).SetCellValue(": " + DateTime.Now.ToShortDateString());
            hssfSheet.GetRow(9).GetCell(1).SetCellValue(": " + dxfData.STRAND_TYPE);
        }

        public void AddFabricationRow(int index, DXFData dxfData)
        {
            excelLocation = ExcelLocation(index);

            if (index < 2)
            {
                hssfSheet.GetRow(excelLocation).GetCell(0).SetCellValue(dxfData.TYPE_NO);
                hssfSheet.GetRow(excelLocation).GetCell(1).SetCellValue(dxfData.NO_OF_TYPES * dxfData.NO_OF_STRANDS);
            }
            else
            {
                hssfSheet.GetRow(excelLocation).CreateCell(0).SetCellValue(dxfData.TYPE_NO);
                hssfSheet.GetRow(excelLocation).CreateCell(1).SetCellValue(dxfData.NO_OF_TYPES * dxfData.NO_OF_STRANDS);
            }


            overallLength = dxfData.NO_OF_LIVES == 1 ? dxfData.LENGTH + 0.5 : dxfData.LENGTH + 1.1;
            overallLength = overallLength == 1.1 ? 0 : overallLength;
            if (overallLength >= 25)
            {
                if (overallLength <= 33)
                {
                    overallLength += 0.1;
                }
                else if (overallLength <= 39)
                {
                    overallLength += 0.2;
                }
                else
                {
                    overallLength += 0.3;
                }
            }

            hssfSheet.GetRow(excelLocation).CreateCell(2).SetCellValue(Convert.ToDouble((Math.Ceiling(overallLength * 10) / 10).ToString("0.0")));

            hssfSheet.GetRow(excelLocation).CreateCell(3).SetCellValue(Convert.ToDouble((Math.Ceiling(overallLength * 10 * 3.27) / 10.0).ToString("0.0")));

            if (dxfData.NO_OF_LIVES == 1)
            {
                hssfSheet.GetRow(excelLocation).CreateCell(4).SetCellValue(0);
            }
            else
            {
                hssfSheet.GetRow(excelLocation).CreateCell(4).SetCellValue("بلا بصلة");
            }


            if (index % 2 != 0)
            {
                for (int i = 0; i < 5; i++)
                {
                    hssfSheet.GetRow(excelLocation).GetCell(i).CellStyle = hssfSheet.GetRow(14).GetCell(0).CellStyle;
                }
            }
            else
            {
                for (int i = 0; i < 5; i++)
                {
                    hssfSheet.GetRow(excelLocation).GetCell(i).CellStyle = hssfSheet.GetRow(13).GetCell(0).CellStyle;
                }
            }
        }

        public int ExcelLocation(int index)
        {
            if (index < 33)
            {
                return (index % dataNumOfRows + (int)((index / dataNumOfRows) * pageNumOfRows)) + 13;
            }
            else
            {
                index -= 32;
                return (index % dataNumOfRows + (int)((index / dataNumOfRows) * pageNumOfRows)) + pageNumOfRows + 2;
            }
        }

        public void GenerateMaterials(ProjectInfo projectInfo, List<DXFData> dxfData)
        {

            hssfSheet = (HSSFSheet)workBook.GetSheet("Materials");

            hssfSheet.GetRow(4).CreateCell(1).SetCellValue(projectInfo.projectName);
            hssfSheet.GetRow(5).CreateCell(1).SetCellValue(projectInfo.projectNumber);
            hssfSheet.GetRow(6).CreateCell(1).SetCellValue(projectInfo.generalContractor);
            hssfSheet.GetRow(7).CreateCell(1).SetCellValue(projectInfo.workParcel);

            List<int> numXF10 = new List<int>();
            List<int> numXF20 = new List<int>();
            List<int> numXF30 = new List<int>();
            for (int i = 0; i < dxfData.Count; i++)
            {
                if (dxfData[i].NO_OF_STRANDS < 3)
                {
                    numXF10.Add(dxfData[i].NO_OF_TYPES * dxfData[i].NO_OF_LIVES);
                    numXF20.Add(0);
                    numXF30.Add(0);
                }
                else if (dxfData[i].NO_OF_STRANDS > 2 && dxfData[i].NO_OF_STRANDS != 5)
                {
                    numXF10.Add(0);
                    numXF20.Add(dxfData[i].NO_OF_TYPES * dxfData[i].NO_OF_LIVES);
                    numXF30.Add(0);
                }
                else if (dxfData[i].NO_OF_STRANDS == 5)
                {
                    numXF10.Add(0);
                    numXF20.Add(0);
                    numXF30.Add(dxfData[i].NO_OF_TYPES * dxfData[i].NO_OF_LIVES);
                }
            }

            hssfSheet.GetRow(10).GetCell(0).SetCellValue(numXF10.Sum());
            hssfSheet.GetRow(11).GetCell(0).SetCellFormula("A11");
            hssfSheet.GetRow(12).GetCell(0).SetCellFormula("A11");
            hssfSheet.GetRow(13).GetCell(0).SetCellFormula("A11");

            hssfSheet.GetRow(14).GetCell(0).SetCellValue(numXF20.Sum());
            hssfSheet.GetRow(15).GetCell(0).SetCellFormula("A15");
            hssfSheet.GetRow(16).GetCell(0).SetCellFormula("A15");
            hssfSheet.GetRow(17).GetCell(0).SetCellFormula("A15");

            hssfSheet.GetRow(18).GetCell(0).SetCellValue(numXF30.Sum());
            hssfSheet.GetRow(19).GetCell(0).SetCellFormula("A19");
            hssfSheet.GetRow(20).GetCell(0).SetCellFormula("A19");
            hssfSheet.GetRow(21).GetCell(0).SetCellFormula("A19");


            List<double> length6mX20 = new List<double>();
            List<double> length6mX30 = new List<double>();
            List<double> length6mX10 = new List<double>();
            //List<double> numXF20 = new List<double>();
            //List<double> numXF30 = new List<double>();
            for (int i = 0; i < dxfData.Count; i++)
            {
                if (dxfData[i].NO_OF_LIVES == 1)
                {
                    length6mX20.Add(numXF20[i] * (dxfData[i].LENGTH - 1.3));
                    length6mX30.Add(numXF30[i] * (dxfData[i].LENGTH - 1.3));
                    length6mX10.Add(numXF10[i] * (dxfData[i].LENGTH - 1.3));
                }
                else
                {
                    length6mX20.Add((numXF20[i] * dxfData[i].LENGTH) / 2.0);
                    length6mX30.Add((numXF30[i] * dxfData[i].LENGTH) / 2.0);
                    length6mX10.Add((numXF10[i] * dxfData[i].LENGTH) / 2.0);
                }

            }

            hssfSheet.GetRow(22).GetCell(0).SetCellValue(Math.Ceiling(length6mX20.Sum() / 5.7));
            hssfSheet.GetRow(23).GetCell(0).SetCellFormula("A23");

            hssfSheet.GetRow(24).GetCell(0).SetCellValue(Math.Ceiling(length6mX30.Sum() / 5.7));
            hssfSheet.GetRow(25).GetCell(0).SetCellFormula("A25");

            hssfSheet.GetRow(26).GetCell(0).SetCellValue(Math.Ceiling(length6mX10.Sum() / 5.7));
            hssfSheet.GetRow(27).GetCell(0).SetCellFormula("A27");

            hssfSheet.GetRow(28).GetCell(0).SetCellFormula("ROUNDUP((A11+A15+A19)*2,0)");
            hssfSheet.GetRow(29).GetCell(0).SetCellFormula("ROUNDUP((A11+A15+A19)/15,0)");
            hssfSheet.GetRow(30).GetCell(0).SetCellFormula("ROUNDUP((A23+A25+A27)/35,0)*6");
            hssfSheet.GetRow(31).GetCell(0).SetCellFormula("ROUNDUP((A11+A15+A19)/15,0)");
            hssfSheet.GetRow(32).GetCell(0).SetCellFormula("SUM(A11+A15+A19)");


            int sumOfStrands = 0;
            double overallLength = 0;
            double strandLength = 0;
            double sumOfStrandLength = 0;
            double sumOfStrandWeight = 0;
            int sumOfAnchors = 0;
            for (int i = 0; i < dxfData.Count; i++)
            {
                sumOfStrands += dxfData[i].NO_OF_TYPES * dxfData[i].NO_OF_STRANDS;

                overallLength = dxfData[i].NO_OF_LIVES == 1 ? dxfData[i].LENGTH + 0.5 : dxfData[i].LENGTH + 1.1;
                if (overallLength >= 25)
                {
                    if (overallLength <= 29)
                    {
                        overallLength += 0.1;
                    }
                    else if (overallLength <= 39)
                    {
                        overallLength += 0.2;
                    }
                    else
                    {
                        overallLength += 0.3;
                    }
                }

                strandLength = Convert.ToDouble((Math.Ceiling(overallLength * 10) / 10)) * dxfData[i].NO_OF_TYPES * dxfData[i].NO_OF_STRANDS;
                sumOfStrandLength += strandLength;

                sumOfStrandWeight += strandLength * 1.18;

                sumOfAnchors += dxfData[i].NO_OF_TYPES * dxfData[i].NO_OF_LIVES;
            }
            hssfSheet.GetRow(41).GetCell(2).SetCellValue(sumOfStrands);
            hssfSheet.GetRow(42).GetCell(2).SetCellValue(sumOfStrandLength);
            hssfSheet.GetRow(43).GetCell(2).SetCellValue(sumOfAnchors);
            hssfSheet.GetRow(44).GetCell(2).SetCellValue(sumOfStrandWeight);
            hssfSheet.GetRow(45).GetCell(2).SetCellValue(Math.Ceiling(sumOfStrandWeight));
        }
    }
}