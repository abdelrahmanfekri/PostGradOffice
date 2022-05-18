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
    public partial class Evaluation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["SignedSupervisor"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "EvaluateProgressReport",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,

                };
                if (TextBox3.Text == "1" || TextBox3.Text == "2" || TextBox3.Text == "3")
                {
                    try

                    {
                        cmd.Parameters.AddWithValue("@supervisorID", 3);
                        cmd.Parameters.AddWithValue("@thesisSerialNo", Convert.ToInt32(TextBox1.Text.ToString()));
                        cmd.Parameters.AddWithValue("@progressReportNo", Convert.ToInt32(TextBox2.Text.ToString()));
                        cmd.Parameters.AddWithValue("@evaluation", Convert.ToInt32(TextBox3.Text.ToString()));
                    }
                    catch
                    {
                        MessageBox.Show("Enter valid Data");
                    }
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    MessageBox.Show("The Examiner is added");

                }
                else
                {
                    MessageBox.Show("Please enter from 0 to 3");

                }


            }
        }
    }
}