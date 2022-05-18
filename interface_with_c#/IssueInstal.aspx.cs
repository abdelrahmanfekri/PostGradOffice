using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace MichaelPart
{
    public partial class IssueInstal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["Signed"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }
        protected void addInstall(object sender, EventArgs e)
        {
           
            int Pid;
            DateTime startDate;
            try
            {
                Pid = Convert.ToInt32(PaymentId.Text.ToString());
                startDate = Convert.ToDateTime(InstallDate.Text.ToString());

            }
            catch (Exception)
            {
                MessageBox.Show("Please Add a valid data");
                return;
            }

            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "AdminIssueInstallPayment",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                cmd.Parameters.AddWithValue("@paymentID", Pid);
                cmd.Parameters.AddWithValue("@InstallStartDate", startDate);
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    MessageBox.Show("The Installment of the Payment is added");
                }
                catch (Exception)
                {
                    MessageBox.Show("Please Add a valid data");
                }
                
            }
        }
    }
}