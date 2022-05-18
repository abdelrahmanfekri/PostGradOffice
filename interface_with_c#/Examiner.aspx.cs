using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MichaelPart
{
    public partial class Examiner : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["SignedExaminer"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        protected void Button1_Click1(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("view.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("comment.aspx");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Redirect("Grade.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Session["search"] = TextBox1.Text;
            
            Response.Redirect("search result.aspx");
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}