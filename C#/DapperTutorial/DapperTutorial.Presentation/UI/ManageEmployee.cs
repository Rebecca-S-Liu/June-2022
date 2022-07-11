using DapperTutorial.Core.Entities;
using DapperTutorial.Infrastructure.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DapperTutorial.Presentation.UI
{
    public class ManageEmployee
    {
        EmployeeRepository employeeRepository = new EmployeeRepository();
        private void AddEmployee()
        {
            Employee e = new Employee();

            Console.Write("Enter Id ==>");
            e.Id = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter Name ==>");
            e.EName = Console.ReadLine();
            Console.Write("Enter Age ==>");
            e.Age = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter Department Id ==>");
            e.DeptId = Convert.ToInt32(Console.ReadLine());

            employeeRepository.Insert(e);
        }

        private void GetAllEmployee()
        {
            IEnumerable<Employee> employees = employeeRepository.GetAll();
            foreach (Employee employee in employees)
            {
                Console.WriteLine(employee.Id + "\t" + employee.EName + "\t" + employee.Age + "\t" + employee.Dept.Id + "\t" + employee.Dept.DName + "\t" + employee.Dept.Loc);
            }
        }

        public void Run()
        {
            GetAllEmployee();
        }
    }
}
