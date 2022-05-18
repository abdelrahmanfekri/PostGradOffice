using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace MichaelPart
{
    public partial class profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["SignedExaminer"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string name = TextBox1.Text;
            string filed = TextBox2.Text;
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                int tid = 8;
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "editexaminer",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                cmd.Parameters.AddWithValue("filed", filed);
                cmd.Parameters.AddWithValue("id", Session["user"]);
                cmd.Parameters.AddWithValue("name", name);


     
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Done");
                    conn.Close();
                }
                catch (Exception)
                {
                    MessageBox.Show("Please Add a valid data");
                }

            }
          

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}