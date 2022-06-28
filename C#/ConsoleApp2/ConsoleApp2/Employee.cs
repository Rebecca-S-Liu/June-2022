using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp2
{
    public abstract class Employee
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public abstract void PerformWork();
        public virtual void VitrualMethodDemo()
        {
            Console.WriteLine("This is a virtual method from base class");
        }
        public Employee()
        {

        }
    }

    public class FullTimeEmployee : Employee
    {
        public decimal BiweeklyPay { get; set; }
        public string Benefits { get; set; }
        public override void PerformWork()
        {
            Console.WriteLine("Full-time employees will work 40hrs per week");
        }
        public override void VitrualMethodDemo()
        {
            Console.WriteLine("Override in full time employee class");
        }
        public FullTimeEmployee()
        {

        }
    }

    public class Manager : FullTimeEmployee
    {
        public decimal ExtraBonus { get; set; }
        public void AttendMeeting()
        {
            Console.WriteLine("Managers have to attend meetings");
        }
    }


    public sealed class PartTimeEmployee : Employee
    {
        public decimal HourlyPay { get; set; }
        public override void PerformWork()
        {
            Console.WriteLine("Part-time employees will work 20hrs per week");
        }
    }

    //public class Test : PartTimeEmployee
    //{

    //}
}
