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
    
    public partial class Table
    {
        public Table()
        {
            this.PlayedOn = new HashSet<PlayedOn>();
        }
    
        public string TableID { get; set; }
        public int MaxPlayers { get; set; }
        public string Stakes { get; set; }
        public string Limit { get; set; }
        public string Site { get; set; }
    
        public virtual ICollection<PlayedOn> PlayedOn { get; set; }
    }
}