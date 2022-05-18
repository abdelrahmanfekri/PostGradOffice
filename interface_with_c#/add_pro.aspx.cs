using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;

namespace MichaelPart
{
    public partial class add_pro : System.Web.UI.Page
    {
        static bool add = false;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Convert.ToBoolean(Session["SignedGucianStudent"]) && !Convert.ToBoolean(Session["SignedNonGucianStudent"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }


            String connStr = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand Thesis = new SqlCommand("getThesis", conn);
            Thesis.CommandType = CommandType.StoredProcedure;
            Thesis.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Session["user"];

            conn.Open();
            SqlDataReader rdr2 = Thesis.ExecuteReader(CommandBehavior.CloseConnection);


            DropDownList d = new DropDownList();
            DropDownList1.Items.Clear();
            while (rdr2.Read())

            {


                Int32 serialNumber = rdr2.GetInt32(rdr2.GetOrdinal("serialNumber"));

                String title = rdr2.GetString(rdr2.GetOrdinal("title"));

                DropDownList1.Items.Add(serialNumber + ":" + title);


            }
            
        
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String s = DropDownList1.SelectedValue.ToString();
            string x = "";
            for (int i = 0; i < s.Length && s[i] != ':'; i++)
            {
                x += s[i];
            }

           

            SqlCommand ProgressReport = new SqlCommand("AddProgressReport", conn);
            ProgressReport.CommandType = CommandType.StoredProcedure;
            try
            {
                Int32 serial_no = Int32.Parse(x);
                DateTime d = Convert.ToDateTime(Calendar1.Text);
                Int32 progressreportnumber = Int32.Parse(TextBox1.Text);
                ProgressReport.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = serial_no;
                ProgressReport.Parameters.Add(new SqlParameter("@progressReportDate", SqlDbType.DateTime)).Value = d;
                ProgressReport.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = progressreportnumber;
            }
            catch (Exception)
            {
                MessageBox.Show("Please Enter a Valid data");
                return;
            }
            
            ProgressReport.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = Session["user"];
            try
            {
                conn.Open();
                ProgressReport.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("The Progress Report is added Correctly");
            }
            catch (Exception)
            {
                MessageBox.Show("Your data is not valid");
            }
            
        }

    }
}