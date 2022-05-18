using System;
using System.Collections.Generic;
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
    public partial class fill_pro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Convert.ToBoolean(Session["SignedGucianStudent"]) && !Convert.ToBoolean(Session["SignedNonGucianStudent"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            String connStr = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();

            SqlConnection conn = new SqlConnection(connStr);


            SqlCommand Thesis_progress = new SqlCommand("getThesisandprogress", conn);
            Thesis_progress.CommandType = CommandType.StoredProcedure;
            Thesis_progress.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Session["user"];

            try
            {
                conn.Open();
                SqlDataReader rdr2 = Thesis_progress.ExecuteReader(CommandBehavior.CloseConnection);
                DropDownList d = new DropDownList();
                while (rdr2.Read())

                {

                    Int32 serialNumber = rdr2.GetInt32(rdr2.GetOrdinal("serialNumber"));

                    String title = rdr2.GetString(rdr2.GetOrdinal("title"));

                    Int32 no = rdr2.GetInt32(rdr2.GetOrdinal("no"));

                    DropDownList1.Items.Add(serialNumber + ":" + title + ", " + "Progress Report No : " + no);

                }
            }
            catch (Exception)
            {
                MessageBox.Show("Please Enter a valid data");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String s = DropDownList1.SelectedValue.ToString();
            String y = "";
            int index = 0;
            bool nof = false;
            string x = "";
            for (int i = 0; i < s.Length && s[i] != ':'; i++)
            {
                x += s[i];
                index = i;
            }
            for (int i = index + 2; i < s.Length; i++)
            {
                if (s[i] == ':')
                {
                    nof = true;
                    i = i + 1; 
                }
                if (nof)
                {
                    y += s[i];
                }
            }
            try
            {
                Int32 serial_no = Int32.Parse(x);
                Int32 no = Int32.Parse(y);
                String description = TextBox1.Text;
                Int32 state = Int32.Parse(TextBox2.Text);
                SqlCommand fill_progress_report = new SqlCommand("FillProgressReport", conn);
                fill_progress_report.CommandType = CommandType.StoredProcedure;
                fill_progress_report.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = serial_no;
                fill_progress_report.Parameters.Add(new SqlParameter("@progressReportNo", SqlDbType.Int)).Value = no;
                fill_progress_report.Parameters.Add(new SqlParameter("@state", SqlDbType.Int)).Value = state;
                fill_progress_report.Parameters.Add(new SqlParameter("@description", SqlDbType.VarChar, 200)).Value = description;
                fill_progress_report.Parameters.Add(new SqlParameter("@studentID", SqlDbType.Int)).Value = Session["user"];
                conn.Open();
                fill_progress_report.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Data Filled Correctly");

            }
            catch (Exception)
            {
                MessageBox.Show("Please Enter a Valid Data");
                return;
            }
        }

    }
}