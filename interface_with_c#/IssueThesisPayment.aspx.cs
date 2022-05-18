using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace MichaelPart
{
    public partial class IssueThesisPayment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["SignedAdmin"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }

        }
        protected void addPayment(object sender, EventArgs e)
        {
            int serial;
            decimal amount;
            int Ninstall;
            decimal PFund;
            try
            {
                serial = Convert.ToInt32(thSerial.Text.ToString());
                amount = Convert.ToDecimal(Amount.Text.ToString());
                Ninstall = Convert.ToInt32(NoInstall.Text.ToString());
                PFund = Convert.ToDecimal(Percentage.Text.ToString());
            }catch(Exception)
            {
                MessageBox.Show("Please Add a valid data");
                return;
            }

            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "AdminIssueThesisPayment",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                cmd.Parameters.AddWithValue("@ThesisSerialNo", serial);
                cmd.Parameters.AddWithValue("@amount", amount);
                cmd.Parameters.AddWithValue("@noOfInstallments", Ninstall);
                cmd.Parameters.AddWithValue("@fundPercentage", PFund);
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    MessageBox.Show("The Payment is issues to the Thesis correctly ");
                }
                catch (Exception)
                {
                    MessageBox.Show("Please Add a valid data");
                }
               
            }
        }
    }
    
}