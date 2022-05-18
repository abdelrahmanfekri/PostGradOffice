using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.UI.WebControls;
using System.Windows;

namespace MichaelPart
{
    public partial class ALLThesis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["Signed"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }
            DataTable data = getData();
            int count = outGoingThesis();
            StringBuilder sb = new StringBuilder();
            String s = "The number of out going thesis is :" + count;
            sb.Append("<h1>" +  s + "</h1>");
            sb.Append("<Table border = '1'>");
            sb.Append("<tr bgcolor = gray>");
            foreach (DataColumn i in data.Columns)
            {
                sb.Append("<th>");
                sb.Append(i.ColumnName);
                sb.Append("</th>");
            }
            
            sb.Append("</tr>");
            

            foreach (DataRow i in data.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn j in data.Columns)
                {
                    sb.Append("<td>" + i[j.ColumnName] + "</td>");
                }
                sb.Append("</tr>");
            }
            sb.Append("</Table>");
            PlaceHolder1.Controls.Add(new Literal { Text = sb.ToString() });
        }
        protected void AddExtension(object sender, EventArgs e)
        {

            int Tid;
            try
            {
                Tid = Convert.ToInt32(Serial.Text.ToString());
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
                    CommandText = "AdminUpdateExtension",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };
                cmd.Parameters.AddWithValue("ThesisSerialNo", Tid);
                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    MessageBox.Show("The Extension added Correctly");
                    
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                    return;
                }
                Response.Redirect("ALLThesis.aspx");
            }
        }
        protected DataTable getData()
        {
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Exec AdminViewAllTheses"))
                {
                    using (SqlDataAdapter adp = new SqlDataAdapter())
                    {
                        cmd.Connection = conn;
                        adp.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            adp.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }
       
        protected int outGoingThesis()
        {
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                SqlCommand cmd = new SqlCommand()
                {
                    CommandText = "AdminViewOnGoingTheses",
                    Connection = conn,
                    CommandType = CommandType.StoredProcedure,
                };

                SqlParameter par = new SqlParameter()
                {
                    ParameterName = "@thesesCount",
                    SqlDbType = SqlDbType.Int,
                    Direction = ParameterDirection.Output
                };

                conn.Open();
                cmd.Parameters.Add(par);
                cmd.ExecuteNonQuery();
                conn.Close();
                return Convert.ToInt32(par.Value.ToString());
            }
        }
    }
}