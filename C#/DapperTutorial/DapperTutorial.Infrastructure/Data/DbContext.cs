using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DapperTutorial.Infrastructure.Data
{
    public class DbContext
    {
        public SqlConnection GetConnection()
        {
            string conn = new ConfigurationBuilder().AddJsonFile("appSettings.json").Build().GetConnectionString("JuneBatchDb");
            return new SqlConnection(conn);
        }
    }
}
