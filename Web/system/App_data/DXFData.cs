using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.system.App_data
{
    public class DXFData
    {
        public string TENDON_NO { get; set; }
        public string TYPE_NO { get; set; }
        public int NO_OF_TYPES { get; set; }
        public string ANCHOR_TYPE { get; set; }
        public int NO_OF_LIVES { get; set; }
        public int NO_OF_STRANDS { get; set; }
        public string STRAND_TYPE { get; set; }
        public int GUTS { get; set; }
        public double LENGTH { get; set; }
        public string JACK_FORCE { get; set; }
        public int EXTENSION { get; set; }
        public string STRESSING { get; set; }
        public int GUAGEReadingCCL { get; set; }
        public string ActualExtension { get; set; }
        public string UpdatedAverageExtension { get; set; }
        public string UpdatedDeviationPerc { get; set; }
        public string Remarks { get; set; }
    }
    public class ActualExtension
    {
        public int value { get; set; }
    }
}