using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DapperTutorial.Core.Entities
{
    public class Employee
    {
        public int Id { get; set; }
        public string EName { get; set; }
        public int Age { get; set; }
        public int DeptId { get; set; }
        //navigation property
        public Department Dept { get; set; }
    }
}
