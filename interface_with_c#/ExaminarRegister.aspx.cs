using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace MichaelPart
{
    public partial class ExaminarRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Register(object sender, EventArgs e)
        {
            string first_name = TextBox1.Text.ToString();
            string last_name = TextBox2.Text.ToString();
            string pass = TextBox3.Text.ToString();
            string field = TextBox4.Text.ToString();
            bool isNational = check1.Checked;
            string mail = TextBox5.Text.ToString();

            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "ExaminerRegister",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                cmd.Parameters.AddWithValue("@first_name", first_name);
                cmd.Parameters.AddWithValue("@last_name", last_name);
                cmd.Parameters.AddWithValue("@password", pass);
                cmd.Parameters.AddWithValue("@email", mail);
                cmd.Parameters.AddWithValue("@isNational",isNational);
                cmd.Parameters.AddWithValue("@fieldOfWork", field);
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("registeration is completed");
                Thread.Sleep(50);
                Response.Redirect("Login.aspx");
            }
        }
    }
}