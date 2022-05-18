using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace MichaelPart
{
    public partial class comment : System.Web.UI.Page
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

            string coment = TextBox1.Text;
            string thesis1 = TextBox2.Text;
            string data1 = TextBox3.Text;
            DateTime date2;
            
            int thesis;
            try
            {
                date2 = DateTime.Parse(data1);
               
                thesis = int.Parse(thesis1);
            }
            catch
            {
                MessageBox.Show("You should enter valid data");
                return;
            }
           
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "AddCommentsGrade",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                cmd.Parameters.AddWithValue("DefenseDate", date2);
                cmd.Parameters.AddWithValue("ThesisSerialNo", thesis);
                cmd.Parameters.AddWithValue("comments", coment);



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

        protected void TextBox3_TextChanged(object sender, EventArgs e)
        {

        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }
    }
}