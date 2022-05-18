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
    public partial class Thesis : System.Web.UI.Page
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

            SqlCommand Thesis = new SqlCommand("getThesis", conn);
            Thesis.CommandType = CommandType.StoredProcedure;
            Thesis.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Session["user"];

            conn.Open();
            SqlDataReader rdr2 = Thesis.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr2.Read())
            {

                TableRow r = new TableRow();

                try
                {
                    Int32 serialNumber = rdr2.GetInt32(rdr2.GetOrdinal("serialNumber"));
                    TableCell serialNumberr = new TableCell();
                    serialNumberr.Controls.Add(new LiteralControl("serialNumber :" + serialNumber));
                    r.Cells.Add(serialNumberr);
                }
                catch
                {
                    TableCell serialNumber2 = new TableCell();
                    serialNumber2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(serialNumber2);
                }

                try
                {
                    String field = rdr2.GetString(rdr2.GetOrdinal("field"));
                    TableCell fieldd = new TableCell();
                    fieldd.Controls.Add(new LiteralControl("field :" + field));
                    r.Cells.Add(fieldd);
                }
                catch
                {
                    TableCell field2 = new TableCell();
                    field2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(field2);
                }




                try
                {
                    String type = rdr2.GetString(rdr2.GetOrdinal("type"));
                    TableCell typee = new TableCell();
                    typee.Controls.Add(new LiteralControl("type : " + type));
                    r.Cells.Add(typee);
                }
                catch
                {
                    TableCell type2 = new TableCell();
                    type2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(type2);
                }
                try
                {
                    String title = rdr2.GetString(rdr2.GetOrdinal("title"));
                    TableCell titlee = new TableCell();
                    titlee.Controls.Add(new LiteralControl("title :" + title));
                    r.Cells.Add(titlee);
                }
                catch
                {
                    TableCell title2 = new TableCell();
                    title2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(title2);
                }

                try
                {
                    DateTime startDate = rdr2.GetDateTime(rdr2.GetOrdinal("startDate"));
                    TableCell startDatee = new TableCell();
                    startDatee.Controls.Add(new LiteralControl("startDate :" + startDate));
                    r.Cells.Add(startDatee);
                }
                catch
                {
                    TableCell startDate2 = new TableCell();
                    startDate2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(startDate2);
                }

                try
                {
                    DateTime endDate = rdr2.GetDateTime(rdr2.GetOrdinal("endDate"));
                    TableCell endDatee = new TableCell();
                    endDatee.Controls.Add(new LiteralControl("endDate :" + endDate));
                    r.Cells.Add(endDatee);
                }
                catch
                {
                    TableCell endDate2 = new TableCell();
                    endDate2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(endDate2);
                }

                try
                {
                    DateTime DefenseDate = rdr2.GetDateTime(rdr2.GetOrdinal("defenseDate"));
                    TableCell DefenseDatee = new TableCell();
                    DefenseDatee.Controls.Add(new LiteralControl("DefenseDate :" + DefenseDate));
                    r.Cells.Add(DefenseDatee);
                }
                catch
                {
                    TableCell DefenseDate2 = new TableCell();
                    DefenseDate2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(DefenseDate2);
                }

                try
                {
                    Int32 years = rdr2.GetInt32(rdr2.GetOrdinal("years"));
                    TableCell yearss = new TableCell();
                    yearss.Controls.Add(new LiteralControl("years :" + years));
                    r.Cells.Add(yearss);
                }
                catch
                {
                    TableCell years2 = new TableCell();
                    years2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(years2);
                }


                try
                {
                    Decimal grade = rdr2.GetDecimal(rdr2.GetOrdinal("grade"));
                    TableCell gradee = new TableCell();
                    gradee.Controls.Add(new LiteralControl("grade :" + grade));
                    r.Cells.Add(gradee);
                }
                catch
                {
                    TableCell grade2 = new TableCell();
                    grade2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(grade2);
                }

                try
                {
                    Int32 payment_id = rdr2.GetInt32(rdr2.GetOrdinal("payment_id"));
                    TableCell payment_idd = new TableCell();
                    payment_idd.Controls.Add(new LiteralControl("payment_id :" + payment_id));
                    r.Cells.Add(payment_idd);
                }
                catch
                {
                    TableCell payment_id2 = new TableCell();
                    payment_id2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(payment_id2);
                }

                try
                {
                    Int32 noExtension = rdr2.GetInt32(rdr2.GetOrdinal("noOfExtensions"));
                    TableCell noExtensionn = new TableCell();
                    noExtensionn.Controls.Add(new LiteralControl("noExtensions :" + noExtension));
                    r.Cells.Add(noExtensionn);
                }
                catch
                {
                    TableCell noExtension2 = new TableCell();
                    noExtension2.Controls.Add(new LiteralControl("Null"));
                    r.Controls.Add(noExtension2);
                }

                    Table1.Rows.Add(r);

            }
            conn.Close();
        }


    }
}