using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;

namespace DesafioWebAPI.Controllers
{
    [Route("api/cliente/{id}")]
    public class ClienteController : ApiController
    {
        [HttpGet]
        [ActionName("GetClienteByID")]
        public Cliente Get(int id)
        {
            SqlDataReader reader = null;
            SqlConnection myConnection = new SqlConnection();
            myConnection.ConnectionString = @"data source=FELIPE\SQLEXPRESS; Integrated Security=SSPI; Initial Catalog=DesafioBD";

            SqlCommand sqlCmd = new SqlCommand();
            sqlCmd.CommandType = CommandType.Text;
            sqlCmd.CommandText = "Select* from Cliente where Id= " + id + "";
            sqlCmd.Connection = myConnection;
            myConnection.Open();
            reader = sqlCmd.ExecuteReader();
            Cliente emp = null;
            while (reader.Read())
            {
                emp = new Cliente();
                emp.ClienteId = Convert.ToInt32(reader.GetValue(0));
                emp.Nome = reader.GetValue(1).ToString();
                emp.Email = reader.GetValue(2).ToString();
                emp.DatadeNascimento = Convert.ToDateTime(reader.GetValue(3));
                emp.Telefone = Convert.ToInt32(reader.GetValue(4));
                emp.EndereçoID = Convert.ToInt32(reader.GetValue(5));
            }
            return emp;
        }
    }
}
