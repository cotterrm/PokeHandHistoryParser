//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ModelFirst
{
    using System;
    using System.Collections.Generic;
    
    public partial class Performs
    {
        public long ActionID { get; set; }
        public string Name { get; set; }
    
        public virtual Player Player { get; set; }
        public virtual HandAction HandAction { get; set; }
    }
}