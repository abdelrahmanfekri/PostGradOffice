using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MichaelPart
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void AdDir(object sender, EventArgs e)
        {
            Response.Redirect("AdminRegister.aspx");
        }

        protected void StDir(object sender, EventArgs e)
        {
            Response.Redirect("StudentRegister.aspx");
        }

        protected void SupDir(object sender, EventArgs e)
        {
            Response.Redirect("SupervisorRegister.aspx");
        }

        protected void ExDir(object sender, EventArgs e)
        {
            Response.Redirect("ExaminarRegister.aspx");
        }
    }
}