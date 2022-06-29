using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp3
{
    public static class GenericsDemo <T> where T : struct
    {
        //public static bool AreEqual(int a, int b)
        //{
        //    return a.Equals(b);
        //}

        //public static bool AreEqual(double a, double b)
        //{
        //    return a.Equals(b);
        //}

        //public static bool AreEqual(object a, object b)
        //{
        //    return a.Equals(b);
        //}

        public static bool AreEqual(T a, T b)
        {
            return a.Equals(b);
        }
    }
}
