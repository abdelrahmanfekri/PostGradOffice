using System.Data;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MichaelPart
{
    public partial class ViewAllSubervisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["Signed"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }
            DataTable data = getData();
            StringBuilder sb = new StringBuilder();
            sb.Append("<Table border = '1'>");
            sb.Append("<tr bgcolor = gray>");
            foreach(DataColumn i in data.Columns)
            {
                sb.Append("<th>");
                sb.Append(i.ColumnName);
                sb.Append("</th>");
            }
            sb.Append("</tr>");
            

            foreach(DataRow i in data.Rows)
            {
                sb.Append("<tr>");
                foreach (DataColumn j in data.Columns)
                {
                    sb.Append("<td>"+i[j.ColumnName]+"</td>");
                }
                sb.Append("</tr>");
            }
            sb.Append("</Table>");
            PlaceHolder1.Controls.Add(new Literal{ Text =  sb.ToString() });
        }
        protected DataTable getData()
        {
            String constr = ConfigurationManager.ConnectionStrings["PostGradOffice"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("Exec AdminListSup"))
                {
                    using (SqlDataAdapter adp = new SqlDataAdapter())
                    {
                        cmd.Connection = conn;
                        adp.SelectCommand = cmd;
                        using(DataTable dt = new DataTable())
                        {
                            adp.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
            

        }
    }
}