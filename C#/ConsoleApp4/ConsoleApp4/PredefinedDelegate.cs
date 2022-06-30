using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp4
{
    public class PredefinedDelegate
    {
        //0,1,1,2,3,5
        private void Fibonacci(int length)
        {
            int a = 0;
            int b = 1;
            int c = 0;
            for (int i = 0; i < length; i++)
            {
                Console.WriteLine(a + " ");
                c = a + b;
                a = b;
                b = c;
            }
        }

        public void ActionExample()
        {
            //Action<int> fib = new Action<int>(Fibonacci);
            //Lambda operator: =>
            Action<int> fib = length =>
            {
                int a = 0;
                int b = 1;
                int c = 0;
                for (int i = 0; i < length; i++)
                {
                    Console.WriteLine(a + " ");
                    c = a + b;
                    a = b;
                    b = c;
                }
            };
            fib(10);
        }

        public void PredicateExample()
        {
            //abba
            //abcd
            Predicate<string> palindrome = str =>
            {
                for (int i = 0, j = str.Length - 1; i < j; i++, j--)
                {
                    if (str[i] != str[j])
                    {
                        return false;
                    }
                }
                return true;
            };
            Console.WriteLine(palindrome("LEVEL"));
        }

        public void FuncExample()
        {
            Func<int, string> factorial = number =>
            {
                int f = 1;
                for (int i = number; i> 1; i--)
                {
                    f = f * i;
                }
                return f.ToString();
            };
            Console.WriteLine("Factorial = " + factorial(5));
        }
    }
}
