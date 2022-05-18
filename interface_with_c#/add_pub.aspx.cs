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
    public partial class add_pub : System.Web.UI.Page
    {
        static bool add = false;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Convert.ToBoolean(Session["SignedGucianStudent"]) && !Convert.ToBoolean(Session["SignedNonGucianStudent"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!add)
            {
                add = true;
                DropDownList d = new DropDownList();
                DropDownList1.Items.Add("0");
                DropDownList1.Items.Add("1");
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            String connStr = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            
            String title = TextBox1.Text;
           
            
            String host = TextBox2.Text;
            String place = TextBox3.Text;
            String accepted = DropDownList1.SelectedValue.ToString();

            SqlCommand Pub = new SqlCommand("addPublication", conn);
            Pub.CommandType = CommandType.StoredProcedure;

            Pub.Parameters.Add(new SqlParameter("@title", SqlDbType.VarChar,50)).Value = title;
            try
            {
                DateTime datte = Convert.ToDateTime(Calendar.Text);
                Pub.Parameters.Add(new SqlParameter("@pubDate", SqlDbType.DateTime)).Value = datte;

            }
            catch (Exception)
            {
                MessageBox.Show("Please Enter a Valid Data");
            }
            Pub.Parameters.Add(new SqlParameter("@host", SqlDbType.VarChar, 50)).Value = host;
            Pub.Parameters.Add(new SqlParameter("@place", SqlDbType.VarChar, 50)).Value = place;
            Pub.Parameters.Add(new SqlParameter("@accepted", SqlDbType.VarChar, 50)).Value = accepted;
            try{
                conn.Open();
                Pub.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("The Publication is added Correctly");
            }
            catch (Exception)
            {
                MessageBox.Show("Please add a Valid data");
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

       
    }
}