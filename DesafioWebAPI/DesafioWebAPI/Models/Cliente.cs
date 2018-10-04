using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DesafioWebAPI.Controllers
{
    public class Cliente
    {
        public int ClienteId{ get; set; }
        public string Nome { get; set; }
        public string Email { get; set; }
        public DateTime DatadeNascimento { get; set; }
        public int Telefone { get; set; }
        public int EndereçoID { get; set; }
    }
}