using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MichaelPart
{
    public partial class link_pub : System.Web.UI.Page
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


            SqlCommand Thesis = new SqlCommand("getongoingthesis", conn);
            Thesis.CommandType = CommandType.StoredProcedure;
            Thesis.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Session["user"];
            
            conn.Open();
            SqlDataReader rdr2 = Thesis.ExecuteReader(CommandBehavior.CloseConnection);


            DropDownList d = new DropDownList();

            while (rdr2.Read())

            {

                Int32 serialNumber = rdr2.GetInt32(rdr2.GetOrdinal("serialNumber"));

                String title = rdr2.GetString(rdr2.GetOrdinal("title"));

                DropDownList1.Items.Add(serialNumber + ":" + title);

            }
            conn.Close();

            SqlCommand Pub = new SqlCommand("getPub", conn);
            Pub.CommandType = CommandType.StoredProcedure;

            conn.Open();
            SqlDataReader rdr3 = Pub.ExecuteReader(CommandBehavior.CloseConnection);


            DropDownList d2 = new DropDownList();
            while (rdr3.Read())

            {

                Int32 id = rdr3.GetInt32(rdr3.GetOrdinal("id"));

                String title = rdr3.GetString(rdr3.GetOrdinal("title"));

                DropDownList2.Items.Add(id + ":" + title);

            }
            conn.Close();
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
            
            Int32 serial_no = Int32.Parse(x);

            String s2 = DropDownList2.SelectedValue.ToString();
            string x2 = "";
            for (int i = 0; i < s.Length && s[i] != ':'; i++)
            {
                x2 += s[i];
            }

            Int32 pub_id = Int32.Parse(x2);

            SqlCommand linkPubThesis = new SqlCommand("linkPubThesis", conn);
            linkPubThesis.CommandType = CommandType.StoredProcedure;

            linkPubThesis.Parameters.Add(new SqlParameter("@thesisSerialNo", SqlDbType.Int)).Value = serial_no;
            linkPubThesis.Parameters.Add(new SqlParameter("@PubID", SqlDbType.Int)).Value = pub_id;

            conn.Open();
            linkPubThesis.ExecuteNonQuery();
            conn.Close();
            ;
        }

     
    }
}