using DapperTutorial.Core.Entities;
using DapperTutorial.Infrastructure.Repositories;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DapperTutorial.Presentation.UI
{
    public class ManageDepartment
    {
        DepartmentRepository departmentRepository = new DepartmentRepository();

        private void AddDepartment()
        {
            Department d = new Department();

            Console.WriteLine("Enter Id =>");
            d.Id = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Enter Name =>");
            d.DName = Console.ReadLine();
            Console.WriteLine("Enter Location =>");
            d.Loc = Console.ReadLine();

            departmentRepository.Insert(d);
        }

        private void UpdateDepartment()
        {
            Department d = new Department();

            Console.WriteLine("Enter Id =>");
            d.Id = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Enter Name =>");
            d.DName = Console.ReadLine();
            Console.WriteLine("Enter Location =>");
            d.Loc = Console.ReadLine();

            departmentRepository.Update(d);
        }

        private void RemoveDepartment()
        {
            Console.WriteLine("Enter ID =>");
            int id = Convert.ToInt32(Console.ReadLine());
            departmentRepository.DeleteById(id);
        }

        private void GetAllDepartments()
        {
            IEnumerable<Department> departments = departmentRepository.GetAll();
            foreach (Department department in departments)
            {
                Console.WriteLine(department.Id + "\t" + department.DName + "\t" + department.Loc);
            }
        }

        private void GetDepartment()
        {
            Console.WriteLine("Enter ID =>");
            int id = Convert.ToInt32(Console.ReadLine());
            Department department = departmentRepository.GetById(id);
            Console.WriteLine(department.Id + "\t" + department.DName + "\t" + department.Loc);

        }

        public void Run()
        {
            GetDepartment();
        }
    }
}
