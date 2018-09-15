using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;

namespace Web.system.App_data
{
    public class DXFParser
    {
        string valueExtracted;
        int tempTendonRef = 0;
        List<DXFTendonRef> localDxfTendonRef;

        public DXFParser()
        {
            localDxfTendonRef = new List<DXFTendonRef>();
        }


        /// <summary>
        /// Parsing DXF File
        /// </summary>
        /// <param name="dxfFileLocation">Dxf File Location</param>
        /// <param name="dxfData">Replicating data to simplify Stressing</param>
        /// <param name="dxfData12_9">Splitting data for better sorting 12,9</param>
        /// <param name="dxfData15_7">Splitting data for better sorting 15.7</param>
        /// <param name="dxfTendonRef"></param>
        public void ParseDXFFile(string dxfFileLocation, ref string projectNumber ,ref List<DXFData> dxfData,
             ref List<DXFData> dxfData12_9, ref List<DXFData> dxfData15_7
            , ref List<DXFTendonRef> dxfTendonRef)
        {
            dxfData.Clear();

            dxfData12_9.Clear();
            dxfData15_7.Clear();
            
            dxfTendonRef.Clear();

            localDxfTendonRef.Clear();

            //int counter = 0;
            string line;

            // Read the file and display it line by line.
            System.IO.StreamReader file = new System.IO.StreamReader(dxfFileLocation);

            DXFData row = new DXFData();
            bool falg = false;
            while ((line = file.ReadLine()) != null)
            {
                // Select that this is the the ACDbText Type Input
                if (line != "AcDbText")
                {
                    continue;
                }

                // Skip Settings to reach value
                for (int i = 0; i < 9; i++)
                {
                    file.ReadLine();
                }

                //line = file.ReadLine();
                //if(line.StartsWith("B-"))
                //{
                //    Console.WriteLine(line);
                //}

                // Save Value
                valueExtracted = file.ReadLine();
                if (valueExtracted.StartsWith("B-"))
                {
                    string[] projectValues = valueExtracted.Split('-');
                    projectNumber = "B961-" + projectValues[1];
                }
                if (valueExtracted.Contains("TYPE "))
                {

                    for (int i = 0; i < 80; i++)
                    {
                        line = file.ReadLine();
                        if (line == "TEXT")
                        {
                            break;
                        }
                    }

                    for (int i = 0; i < 19; i++)
                    {
                        file.ReadLine();
                    }

                    line = file.ReadLine();


                    if (!falg)
                    {
                        falg = true;
                    }
                    else
                    {
                        //if (int.TryParse(, out tempTendonRef))
                        //{
                        DXFTendonRef dxfTendonRefLocal = new DXFTendonRef();
                        dxfTendonRefLocal.tendonType = valueExtracted.Remove(0, 5);
                        dxfTendonRefLocal.tendonNumber = line;
                        localDxfTendonRef.Add(dxfTendonRefLocal);


                        //
                    }

                    continue;
                }


                // Skip Settings to reach Type of input
                for (int i = 0; i < 17; i++)
                {
                    file.ReadLine();
                }

                // Save Input Type
                line = file.ReadLine();

                try
                {
                    // This switch is just to save that this value
                    // is known and it's linked to these selected types
                    switch (line)
                    {
                        case "TYPE_NO":
                            row.TYPE_NO = valueExtracted;
                            
                            dxfData.Add(row);

                            if(row.STRAND_TYPE.Contains("12.9"))
                            {
                                dxfData12_9.Add(row);
                            }else
                            {
                                dxfData15_7.Add(row);
                            }

                            row = new DXFData();
                            break;
                        case "NO_OF_TYPES":
                            row.NO_OF_TYPES = int.Parse(valueExtracted);
                            break;
                        case "ANCHOR_TYPE":
                            row.ANCHOR_TYPE = valueExtracted;
                            break;
                        case "NO_OF_LIVES":
                            row.NO_OF_LIVES = int.Parse(valueExtracted);
                            break;
                        case "NO_OF_STRANDS":
                            row.NO_OF_STRANDS = int.Parse(valueExtracted);
                            break;
                        case "STRAND_TYPE":
                            row.STRAND_TYPE = valueExtracted;
                            break;
                        case "GUTS":
                            row.GUTS = int.Parse(valueExtracted);
                            break;
                        case "LENGTH":
                            row.LENGTH = double.Parse(valueExtracted);
                            break;
                        case "JACK_FORCE":
                            row.JACK_FORCE = valueExtracted;
                            break;
                        case "EXTENSION":
                            row.EXTENSION = int.Parse(valueExtracted);
                            break;
                        case "STRESSING":
                            row.STRESSING = valueExtracted;

                            break;
                    }

                }
                catch(Exception ex)
                {
                    Trace.TraceInformation("Error Input:" + ex.Message);
                    continue;
                }
            }

            file.Close();

            for (int i = 0; i < dxfData.Count; i++)
            {
                for (int j = 0; j < localDxfTendonRef.Count; j++)
                {
                    if(localDxfTendonRef[j].tendonType == dxfData[i].TYPE_NO)
                    {
                        dxfTendonRef.Add(localDxfTendonRef[j]);
                    }
                }
            }

            //// 1a Problemmmmmmmm
            //dxfTendonRef.Sort(delegate(DXFTendonRef a, DXFTendonRef b)
            //{
            //    int xdiff = a.tendonType.CompareTo(b.tendonType);
            //    if (xdiff != 0) return xdiff;
            //    else return a.tendonNumber.CompareTo(b.tendonNumber);
            //});
        }
    }
}