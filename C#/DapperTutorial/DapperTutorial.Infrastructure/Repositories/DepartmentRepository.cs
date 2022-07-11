using DapperTutorial.Core.Entities;
using DapperTutorial.Core.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using DapperTutorial.Infrastructure.Data;
using System.Data;

namespace DapperTutorial.Infrastructure.Repositories
{

    public class DepartmentRepository : IRepository<Department>
    {
        DbContext dbContext = new DbContext();

        public int DeleteById(int id)
        {
            IDbConnection conn = dbContext.GetConnection();
            return conn.Execute("DELETE FROM Department WHERE id = @DeptId", new { DeptId = id });
        }

        public IEnumerable<Department> GetAll()
        {
            IDbConnection conn = dbContext.GetConnection();
            return conn.Query<Department>("SELECT Id, DName, Loc FROM Department");
        }

        public Department GetById(int id)
        {
            IDbConnection conn = dbContext.GetConnection();
            return conn.QuerySingleOrDefault<Department>("SELECT Id, DName, Loc FROM Department WHERE id = @DeptId", new { DeptId = id });

        }

        public int Insert(Department obj)
        {
            IDbConnection conn = dbContext.GetConnection();
            return conn.Execute("INSERT INTO Department VALUES(@Id, @DName, @Loc)", obj);
        }

        public int Update(Department obj)
        {
            IDbConnection conn = dbContext.GetConnection();
            return conn.Execute("UPDATE Department SET dName = @DName, loc = @Loc where id = @Id", obj);
        }
    }
}
