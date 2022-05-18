using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace MichaelPart
{
    public partial class SuperVisor : System.Web.UI.Page
    {
        public object PlaceHolder1 { get; private set; }
        public object Serial { get; private set; }

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

            Response.Redirect("StudentName.aspx");




        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Session["StudentID"] = TextBox13.Text;
            Response.Redirect("StudentPublication.aspx");

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void Button3_Click(object sender, EventArgs e)
        {

            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {

                string Proc = "AddDefenseNonGucian";
                if (DropDownList1.SelectedValue.ToString() == "Gucian")
                    Proc = "AddDefenseGucian";

                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = Proc,
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                cmd.Parameters.AddWithValue("@ThesisSerialNo", Convert.ToInt32(TextBox1.Text.ToString()));
                cmd.Parameters.AddWithValue("@DefenseDate", Convert.ToDateTime(TextBox2.Text.ToString()));
                cmd.Parameters.AddWithValue("@DefenseLocation", TextBox3.Text.ToString());
               try
               
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("The Defense is added");
                    conn.Close();
                }
                catch (Exception)
                {
                    MessageBox.Show("Please Add a valid data");

                }





            }
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "AddExaminer",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                try
                {
                    cmd.Parameters.AddWithValue("@ThesisSerialNo", Convert.ToInt32(TextBox5.Text.ToString()));
                    cmd.Parameters.AddWithValue("@DefenseDate", Convert.ToDateTime(TextBox6.Text.ToString()));
                    cmd.Parameters.AddWithValue("@ExaminerName", TextBox7.Text.ToString());
                    cmd.Parameters.AddWithValue("@Password", TextBox8.Text.ToString());
                    cmd.Parameters.AddWithValue("@National", Convert.ToInt32(TextBox9.Text.ToString()));
                    cmd.Parameters.AddWithValue("@fieldOfWork", TextBox10.Text.ToString());
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

            }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Redirect("Evaluation.aspx");

        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "CancelThesis",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                try
                {
                    cmd.Parameters.AddWithValue("@ThesisSerialNo", Convert.ToInt32(TextBox12.Text.ToString()));
                   
                }
                catch
                {
                    MessageBox.Show("Enter valid Data!");
                }
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    MessageBox.Show("Done");
                    conn.Close();
                }
                catch
                {
                    MessageBox.Show("Enter valid Data!");
                }

            }

        }
    }
}