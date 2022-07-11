using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using DapperTutorial.Core.Entities;
using DapperTutorial.Core.Interfaces;
using DapperTutorial.Infrastructure.Data;

namespace DapperTutorial.Infrastructure.Repositories
{
    public class EmployeeRepository : IRepository<Employee>
    {
        DbContext dbContext = new DbContext();
        public int DeleteById(int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<Employee> GetAll()
        {
            IDbConnection conn = dbContext.GetConnection();
            //return conn.Query<Employee>("SELECT Id, EName, Age, DeptId FROM Employee");
            string sql = "SELECT e.id, e.ename, e.age, d.id, d.dname, d.loc FROM Employee e INNER JOIN Department d ON e.deptid = d.id";
            return conn.Query<Employee, Department, Employee>(sql, (e, d) => { e.Dept = d; return e; });
        }

        public Employee GetById(int id)
        {
            throw new NotImplementedException();
        }

        public int Insert(Employee obj)
        {
            IDbConnection conn = dbContext.GetConnection();
            return conn.Execute("INSERT INTO Employee VALUES(@Id, @EName, @Age, @DeptId)", obj);
        }

        public int Update(Employee obj)
        {
            throw new NotImplementedException();
        }
    }
}
