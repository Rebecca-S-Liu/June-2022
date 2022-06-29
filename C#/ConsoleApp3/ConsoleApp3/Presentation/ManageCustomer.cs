using ConsoleApp3.DataModel;
using ConsoleApp3.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp3.Presentation
{
    public class ManageCustomer
    {
        CustomerRepository customerRepository = new CustomerRepository();
        private void AddCustomer()
        {
            Customer c = new Customer();
            Console.Write("Enter ID =>");
            c.Id = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter Name => ");
            c.Name = Console.ReadLine();
            Console.Write("Enter Email => ");
            c.Email = Console.ReadLine();

            if (customerRepository.Insert(c) > 0)
            {
                Console.WriteLine("Customer has been added");
            } else
            {
                Console.WriteLine("Some error has occurred");
            }
        }

        private void PrintAllCustomer()
        {
            List<Customer> allCustomers = customerRepository.GetAll();
            foreach (Customer c in allCustomers)
            {
                Console.WriteLine(c.Id + "\t" + c.Name + "\t" + c.Email);
            }
        }

        private void DeleteCustomer()
        {
            Console.WriteLine("Enter Id =>");
            int id = Convert.ToInt32(Console.ReadLine());
            if (customerRepository.DeleteById(id) > 0)
            {
                Console.WriteLine("Customer has been deleted");
            } else
            {
                Console.WriteLine("Some error has occurred");
            }
        }

        public void Run()
        {
            Console.Clear();
            Console.WriteLine("Press 1 to add");
            Console.WriteLine("Press 2 to print all");
            Console.WriteLine("Press 3 to delete");
            Console.WriteLine("Press 9 to exit");

            Console.Write("Enter choice =>");
            int choice = Convert.ToInt32(Console.ReadLine());

            while (choice != 9)
            {
                switch (choice)
                {
                    case 1:
                        AddCustomer();
                        break;
                    case 2:
                        PrintAllCustomer();
                        break;
                    case 3:
                        DeleteCustomer();
                        break;
                    default:
                        Console.WriteLine("Invalid Option");
                        break;
                }
                Console.WriteLine("Press number to continue");
                choice = Convert.ToInt32(Console.ReadLine());
            }

        }
    }
}
