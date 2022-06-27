// See https://aka.ms/new-console-template for more information

using ConsoleApp1;

ParamPassing demo = new ParamPassing();
//int x = 10, y = 30;
//Console.WriteLine($"Passing by value: Before calling x = {x}, y = {y}");
//demo.PassingByValue(x, y);
//Console.WriteLine($"Passing by value: After calling x = {x}, y = {y}");

//Console.WriteLine("----------------");
//Console.WriteLine($"Passing by reference: Before calling x = {x}, y = {y}");
//demo.PassingByReference(ref x, ref y);
//Console.WriteLine($"Passing by reference: After calling x = {x}, y = {y}");

//demo.AreaOfCircle(10);
//demo.AreaOfCircle(10, 3);

//string str;

//Console.WriteLine(demo.IsAuthentic("rebecca", "liu", out str));
//Console.WriteLine(str);

Console.WriteLine(demo.AddNumbers(10,20));
Console.WriteLine(demo.AddNumbers(10, 20,30,40));

demo.AddTwoNumbers(10, 20);

//int sunday = 1;
//int monday = 2;
//int tuesday = 3;
//int wednesday = 4;
//int thursday = 5;
//int friday = 6;
//int saturday = 7;

//int dayOfWeek = 2;
//if (dayOfWeek == 2)
//{
//    Console.WriteLine("It's Monday");
//}

//DaysOfWeek today = DaysOfWeek.Monday;
//Console.WriteLine(today);

////using System.Text;

//int a = 10;
//Console.WriteLine("The value for a is " + a);

//double b = 2.1353;
//Console.WriteLine($"The value for b is {b}");

//float f = 2.3534f;
//Console.WriteLine(f);

//decimal d = 3.2353m;
//Console.WriteLine(d);

//string s = "hellow World";
////s[0] = 'H';

//StringBuilder sb = new StringBuilder("hello World");
//Console.WriteLine($"before change:{sb}");
//sb[0] = 'H';
//Console.WriteLine($"after change:{sb}");
//Console.WriteLine(s);

//bool flag = true;
//Console.WriteLine(flag);