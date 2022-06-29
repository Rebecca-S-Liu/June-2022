// See https://aka.ms/new-console-template for more information

using ConsoleApp3;
using ConsoleApp3.Presentation;

//int a = 10;
//Console.WriteLine($"The number {a} is {a.EvenOrOdd()}");

//Console.WriteLine(GenericsDemo.AreEqual(12,23));
//Console.WriteLine(GenericsDemo.AreEqual("segoudf", 23.3324));

//Console.WriteLine(GenericsDemo<string>.AreEqual("hello","world"));
//Console.WriteLine(GenericsDemo<double>.AreEqual(3.23,2342));

ManageCustomer manageCustomer = new ManageCustomer();
manageCustomer.Run();
