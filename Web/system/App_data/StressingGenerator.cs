using NPOI.HSSF.UserModel;
using NPOI.HSSF.Util;
using NPOI.SS.UserModel;
using NPOI.SS.Util;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;

namespace Web.system.App_data
{
    public class StressingGenerator
    {
        int pageNumOfRows = 46;
        int dataNumOfRows = 8;


        HSSFWorkbook workBook;
        HSSFSheet hssfSheet;

        string stressFileLocation = "";

        int numOfPages = 0;


        int localRow = 0;

        public StressingGenerator()
        {

        }

        public void GenerateStressing(ProjectInfo projectInfo, List<DXFData> dxfData, List<DXFTendonRef> dxfTendonRef, string saveLocation)
        {
            stressFileLocation = System.AppDomain.CurrentDomain.BaseDirectory + "\\Templates\\Stressing.xls";
            using (var fs = new FileStream(stressFileLocation, FileMode.Open, FileAccess.Read))
            {
                workBook = new HSSFWorkbook(fs);
            }


            hssfSheet = (HSSFSheet)workBook.GetSheet("Stressing");


            hssfSheet.GetRow(5).CreateCell(1).SetCellValue(projectInfo.projectName);
            hssfSheet.GetRow(6).CreateCell(1).SetCellValue(projectInfo.projectNumber);
            hssfSheet.GetRow(7).CreateCell(1).SetCellValue(projectInfo.generalContractor);

            numOfPages = ((dxfTendonRef.Count + 2) / dataNumOfRows) + 1;


            int localJackForce = 0;
            List<string> jackForceList = new List<string>();
            for (int i = 0; i < dxfData.Count; i++)
            {
                localJackForce = Convert.ToInt32(dxfData[i].JACK_FORCE.Replace("KN", ""));
                switch (localJackForce)
                {
                    case 140:
                        dxfData[i].GUAGEReadingCCL = 4500;
                        break;
                    case 143:
                        dxfData[i].GUAGEReadingCCL = 4570;
                        break;
                    case 144:
                        dxfData[i].GUAGEReadingCCL = 4600;
                        break;
                    case 145:
                        dxfData[i].GUAGEReadingCCL = 4700;
                        break;
                    case 147:
                        dxfData[i].GUAGEReadingCCL = 4730;
                        break;
                    case 149:
                        dxfData[i].GUAGEReadingCCL = 4800;
                        break;
                    case 209:
                        dxfData[i].GUAGEReadingCCL = 6670;
                        break;
                    case 210:
                        dxfData[i].GUAGEReadingCCL = 6700;
                        break;
                    case 215:
                        dxfData[i].GUAGEReadingCCL = 6860;
                        break;
                    case 218:
                        dxfData[i].GUAGEReadingCCL = 7000;
                        break;
                    case 219:
                        dxfData[i].GUAGEReadingCCL = 7050;
                        break;
                    default:
                        dxfData[i].GUAGEReadingCCL = -1;;
                        break;
                }

                if (!jackForceList.Contains(dxfData[i].JACK_FORCE))
                {
                    jackForceList.Add(dxfData[i].JACK_FORCE);
                    hssfSheet.GetRow(9).CreateCell(jackForceList.Count).SetCellValue(localJackForce);
                    hssfSheet.GetRow(10).CreateCell(jackForceList.Count).SetCellValue(dxfData[i].GUAGEReadingCCL);
                }
            }

            for (int i = 0; i < numOfPages; i++)
            {
                GenerateHeader(i);
            }

            for (int i = 0; i < dxfTendonRef.Count; i++)
            {
                for (int j = 0; j < dxfData.Count; j++)
                {
                    if(dxfData[j].TYPE_NO == dxfTendonRef[i].tendonType)
                    {
                        AddStressingRow(i, dxfData[j], dxfTendonRef[i]);
                    }
                }
                
            }

            using (var fs = new FileStream(saveLocation, FileMode.OpenOrCreate, FileAccess.Write))
            {
                workBook.Write(fs);
            }
        }

        public void GenerateHeader(int pageNumber)
        {
            if(pageNumber == 0)
            {
                for (int i = 21; i < pageNumOfRows; i++)
                {
                    hssfSheet.CreateRow(i);
                    hssfSheet.GetRow(i).Height = 345;
                }
                return;
            }

            // Jump In Pages
            localRow =  pageNumber * pageNumOfRows;
            for (int i = localRow; i < localRow + pageNumOfRows; i++)
            {
                hssfSheet.CreateRow(i);
                hssfSheet.GetRow(i).Height = 345;
            }

            hssfSheet.GetRow(localRow + 1).CreateCell(0).SetCellValue("Carrying Forward ");
            hssfSheet.GetRow(localRow + 1).GetCell(0).CellStyle = hssfSheet.GetRow(7).GetCell(7).CellStyle;

            hssfSheet.GetRow(localRow + 2).CreateCell(0).SetCellValue("Tendon reference");
            hssfSheet.GetRow(localRow + 2).CreateCell(1).SetCellValue("Sequence (strand)");
            hssfSheet.GetRow(localRow + 2).CreateCell(2).SetCellValue("Jacking Force KN");
            hssfSheet.GetRow(localRow + 2).CreateCell(3).SetCellValue("Gauge Reading PSI");
            hssfSheet.GetRow(localRow + 2).CreateCell(4).SetCellValue("Actual Extension MM");
            hssfSheet.GetRow(localRow + 2).CreateCell(5).SetCellValue("Average Extension MM");
            hssfSheet.GetRow(localRow + 2).CreateCell(6).SetCellValue("Theor. Extension MM");
            hssfSheet.GetRow(localRow + 2).CreateCell(7).SetCellValue("Deviation %");
            hssfSheet.GetRow(localRow + 2).CreateCell(8).SetCellValue("Remarks");


            hssfSheet.AddMergedRegion(new CellRangeAddress(0, 0, 0, 5));

            //merged cells on mutiple rows
            for (int i = 0; i < 9; i++)
            {
                hssfSheet.GetRow(localRow + 3).CreateCell(i).SetCellValue("");
                hssfSheet.GetRow(localRow + 4).CreateCell(i).SetCellValue("");
                CellRangeAddress region = new CellRangeAddress(localRow + 2, localRow + 4, i, i);
                hssfSheet.AddMergedRegion(region);

                hssfSheet.GetRow(localRow + 2).GetCell(i).CellStyle = hssfSheet.GetRow(13).GetCell(i).CellStyle;
                hssfSheet.GetRow(localRow + 3).GetCell(i).CellStyle = hssfSheet.GetRow(14).GetCell(i).CellStyle;
                hssfSheet.GetRow(localRow + 4).GetCell(i).CellStyle = hssfSheet.GetRow(15).GetCell(i).CellStyle;
            }



        }

        public void AddStressingRow(int index, DXFData dxfData, DXFTendonRef dxfTendonRef)
        {
            if(index <6)
            {
                localRow = 16 + index * 5;
            }else
            {
                index -=6;
                localRow = pageNumOfRows + (index/ dataNumOfRows) * pageNumOfRows;
                localRow += 5 + (index % dataNumOfRows) * 5;
            }

            if (localRow > 16)
            {
                for (int i = 0; i < 5; i++)
                {
                    for (int j = 0; j < 11; j++)
                    {
                        hssfSheet.GetRow(localRow + i).CreateCell(j);
                        hssfSheet.GetRow(localRow + i).GetCell(j).CellStyle = hssfSheet.GetRow(16 + i).GetCell(j).CellStyle;
                    }
                }
            }

            CellRangeAddress region = new CellRangeAddress(localRow + 1, localRow + 4, 0, 0);
            hssfSheet.AddMergedRegion(region);
            for (int i = 5; i < 11; i++)
            {
                region = new CellRangeAddress(localRow, localRow + 4, i, i);
                hssfSheet.AddMergedRegion(region);
            }



            hssfSheet.GetRow(localRow).GetCell(0).SetCellValue(dxfTendonRef.tendonType);
            hssfSheet.GetRow(localRow + 1).GetCell(0).SetCellValue("#" + dxfTendonRef.tendonNumber);

            switch (dxfData.NO_OF_STRANDS)
            {
                case 5:
                    hssfSheet.GetRow(localRow + 0).GetCell(1).SetCellValue("Center");
                    hssfSheet.GetRow(localRow + 1).GetCell(1).SetCellValue("Left int.");
                    hssfSheet.GetRow(localRow + 2).GetCell(1).SetCellValue("right int.");
                    hssfSheet.GetRow(localRow + 3).GetCell(1).SetCellValue("left ext.");
                    hssfSheet.GetRow(localRow + 4).GetCell(1).SetCellValue("Right ext.");
                    break;
                case 4:
                    hssfSheet.GetRow(localRow + 0).GetCell(1).SetCellValue("Left int.");
                    hssfSheet.GetRow(localRow + 1).GetCell(1).SetCellValue("Right int.");
                    hssfSheet.GetRow(localRow + 2).GetCell(1).SetCellValue("left ext.");
                    hssfSheet.GetRow(localRow + 3).GetCell(1).SetCellValue("Right ext.");
                    hssfSheet.GetRow(localRow + 4).GetCell(1).SetCellValue("");
                    break;
                case 3:
                    hssfSheet.GetRow(localRow + 0).GetCell(1).SetCellValue("Left int.");
                    hssfSheet.GetRow(localRow + 1).GetCell(1).SetCellValue("Right int.");
                    hssfSheet.GetRow(localRow + 2).GetCell(1).SetCellValue("left ext.");
                    hssfSheet.GetRow(localRow + 3).GetCell(1).SetCellValue("");
                    hssfSheet.GetRow(localRow + 4).GetCell(1).SetCellValue("");
                    break;
                case 2:
                    hssfSheet.GetRow(localRow + 0).GetCell(1).SetCellValue("Left int.");
                    hssfSheet.GetRow(localRow + 1).GetCell(1).SetCellValue("Right int.");
                    hssfSheet.GetRow(localRow + 2).GetCell(1).SetCellValue("");
                    hssfSheet.GetRow(localRow + 3).GetCell(1).SetCellValue("");
                    hssfSheet.GetRow(localRow + 4).GetCell(1).SetCellValue("");
                    break;
                case 1:
                    hssfSheet.GetRow(localRow + 0).GetCell(1).SetCellValue("Left int.");
                    hssfSheet.GetRow(localRow + 1).GetCell(1).SetCellValue("Right int.");
                    hssfSheet.GetRow(localRow + 2).GetCell(1).SetCellValue("");
                    hssfSheet.GetRow(localRow + 3).GetCell(1).SetCellValue("");
                    hssfSheet.GetRow(localRow + 4).GetCell(1).SetCellValue("");
                    hssfSheet.GetRow(localRow + 1).GetCell(2).SetCellValue(Convert.ToInt32(dxfData.JACK_FORCE.Replace("KN", "")));
                    hssfSheet.GetRow(localRow + 1).GetCell(3).SetCellValue(dxfData.GUAGEReadingCCL);
                    break;
                default:
                    break;
            }

            for (int i = 0; i < dxfData.NO_OF_STRANDS; i++)
            {
                hssfSheet.GetRow(localRow + i).GetCell(2).SetCellValue(Convert.ToInt32(dxfData.JACK_FORCE.Replace("KN", "")));
                hssfSheet.GetRow(localRow + i).GetCell(3).SetCellValue(dxfData.GUAGEReadingCCL);
                //hssfSheet.GetRow(localRow + i).GetCell(4).SetCellValue(dxfData.ActualExtension);
            }
            string[] arrayExtension = dxfData.ActualExtension.Split(',');
            for (int i = 0; i < arrayExtension.Length; i++)
            {
                hssfSheet.GetRow(localRow + i).GetCell(4).SetCellValue(arrayExtension[i]);
            }
            hssfSheet.GetRow(localRow).GetCell(5).SetCellFormula("AVERAGE(E"+(localRow+1)+":E"+(localRow+5)+")");
            hssfSheet.GetRow(localRow).GetCell(6).SetCellValue(dxfData.EXTENSION);
            hssfSheet.GetRow(localRow).GetCell(7).SetCellFormula(dxfData.UpdatedAverageExtension);
            hssfSheet.GetRow(localRow).GetCell(8).SetCellFormula("(F" + (localRow + 1) + "-G" + (localRow + 1) + ")/G" + (localRow + 1) + "");
            hssfSheet.GetRow(localRow).GetCell(9).SetCellFormula(dxfData.UpdatedDeviationPerc);
            hssfSheet.GetRow(localRow).GetCell(10).SetCellValue(dxfData.Remarks);
        }

        private void CopyRow(HSSFWorkbook workbook, HSSFSheet worksheet, int sourceRowNum, int destinationRowNum)
        {
            // Get the source / new row
            HSSFRow newRow = (HSSFRow) worksheet.GetRow(destinationRowNum);
            HSSFRow sourceRow = (HSSFRow)worksheet.GetRow(sourceRowNum);

            // If the row exist in destination, push down all rows by 1 else create a new row
            if (newRow != null)
            {
                worksheet.ShiftRows(destinationRowNum, worksheet.LastRowNum, 1);
            }
            else
            {
                newRow = (HSSFRow) worksheet.CreateRow(destinationRowNum);
            }

            // Loop through source columns to add to new row
            for (int i = 0; i < sourceRow.LastCellNum; i++)
            {
                // Grab a copy of the old/new cell
                HSSFCell oldCell = (HSSFCell) sourceRow.GetCell(i);
                HSSFCell newCell = (HSSFCell) newRow.CreateCell(i);

                // If the old cell is null jump to next cell
                if (oldCell == null)
                {
                    newCell = null;
                    continue;
                }

                // Copy style from old cell and apply to new cell
                HSSFCellStyle newCellStyle = (HSSFCellStyle) workbook.CreateCellStyle();
                newCellStyle.CloneStyleFrom(oldCell.CellStyle); ;
                newCell.CellStyle = newCellStyle;

                // If there is a cell comment, copy
                if (newCell.CellComment != null) newCell.CellComment = oldCell.CellComment;

                // If there is a cell hyperlink, copy
                if (oldCell.Hyperlink != null) newCell.Hyperlink = oldCell.Hyperlink;

                // Set the cell data type
                newCell.SetCellType(oldCell.CellType);

                //// Set the cell data value
                //switch (oldCell.CellType)
                //{
                //    case  HSSFCellType.BLANK:
                //        newCell.SetCellValue(oldCell.StringCellValue);
                //        break;
                //    case HSSFCellType.BOOLEAN:
                //        newCell.SetCellValue(oldCell.BooleanCellValue);
                //        break;
                //    case HSSFCellType.ERROR:
                //        newCell.SetCellErrorValue(oldCell.ErrorCellValue);
                //        break;
                //    case HSSFCellType.FORMULA:
                //        newCell.SetCellFormula(oldCell.CellFormula);
                //        break;
                //    case HSSFCellType.NUMERIC:
                //        newCell.SetCellValue(oldCell.NumericCellValue);
                //        break;
                //    case HSSFCellType.STRING:
                //        newCell.SetCellValue(oldCell.RichStringCellValue);
                //        break;
                //    case HSSFCellType.Unknown:
                //        newCell.SetCellValue(oldCell.StringCellValue);
                //        break;
                //}
            }

            // If there are are any merged regions in the source row, copy to new row
            for (int i = 0; i < worksheet.NumMergedRegions; i++)
            {
                CellRangeAddress cellRangeAddress = worksheet.GetMergedRegion(i);
                if (cellRangeAddress.FirstRow == sourceRow.RowNum)
                {
                    CellRangeAddress newCellRangeAddress = new CellRangeAddress(newRow.RowNum,
                                                                                (newRow.RowNum +
                                                                                 (cellRangeAddress.FirstRow -
                                                                                  cellRangeAddress.LastRow)),
                                                                                cellRangeAddress.FirstColumn,
                                                                                cellRangeAddress.LastColumn);
                    worksheet.AddMergedRegion(newCellRangeAddress);
                }
            }

        }
    }
}
