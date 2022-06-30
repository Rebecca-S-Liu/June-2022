using ConsoleApp4.DataModel;
using ConsoleApp4.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp4.Presentation
{
   

    public class ManageEmployee
    {
        EmployeeRepository employeeRepsitory = new EmployeeRepository();
        private bool Check(Employee employee)
        {
            if (employee.Department == "IT")
            {
                return true;
            }
            return false;
        }
        public void Print()
        {
            List<Employee> empColeection = employeeRepsitory.Search(Check);
            //List<Employee> empColeection = employeeRepsitory.Search(emp => emp.Department == "IT");
            foreach (var item in empColeection)
            {
                Console.WriteLine(item.Id + "\t" + item.FullName + "\t" + item.City + "\t" + item.Department + "\t" + item.Salary);
            }
        }
    }
}
