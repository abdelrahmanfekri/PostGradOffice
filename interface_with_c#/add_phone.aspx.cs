using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using System.Windows;

namespace MichaelPart
{
    public partial class add_phone : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["SignedGucianStudent"]) && !Convert.ToBoolean(Session["SignedNonGucianStudent"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        protected void Addphone_Click(object sender, EventArgs e)
        {
            
            String connStr = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            String phone1 = TextBox1.Text;
            
            SqlCommand addMobileProc = new SqlCommand("addMobile", conn);
            addMobileProc.CommandType = CommandType.StoredProcedure;

            addMobileProc.Parameters.Add(new SqlParameter("@ID", SqlDbType.VarChar)).Value = Session["user"];
            addMobileProc.Parameters.Add(new SqlParameter("@mobile_number", SqlDbType.VarChar)).Value = phone1;
            

            
            try
            {
                conn.Open();
                addMobileProc.ExecuteNonQuery();
                MessageBox.Show("Done");
                conn.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Please Enter a Valid data");
                Response.Redirect("add_phone.aspx");
            }
            
        }
    }
}