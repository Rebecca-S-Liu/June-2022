using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp4.Repository
{
    public interface IRepository<T> where T : class
    {
        List<T> Search(Func<T,bool> condition);
    }
}
