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
    public partial class courses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Convert.ToBoolean(Session["SignedNonGucianStudent"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }

            String connStr = WebConfigurationManager.ConnectionStrings["PostGradOffice"].ToString();

            SqlConnection conn = new SqlConnection(connStr);

            SqlCommand NonGucianCourseAndGrade = new SqlCommand("NonGucianCourse", conn);
            NonGucianCourseAndGrade.CommandType = CommandType.StoredProcedure;
            NonGucianCourseAndGrade.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Session["user"];

            conn.Open();
            SqlDataReader rdr3 = NonGucianCourseAndGrade.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr3.Read())
            {
                TableRow k = new TableRow();

                try
                {
                    Int32 id_course = rdr3.GetInt32(rdr3.GetOrdinal("id"));
                    TableCell id_coursee = new TableCell();
                    id_coursee.Controls.Add(new LiteralControl("Course_id :" + id_course));
                    k.Cells.Add(id_coursee);
                }
                catch
                {
                    TableCell id_course2 = new TableCell();
                    id_course2.Controls.Add(new LiteralControl("Null"));
                    k.Controls.Add(id_course2);
                }
                try
                {
                    Int32 fees = rdr3.GetInt32(rdr3.GetOrdinal("fees"));
                    TableCell feess = new TableCell();
                    feess.Controls.Add(new LiteralControl("Fees :" + fees));
                    k.Cells.Add(feess);
                }
                catch
                {
                    TableCell fees2 = new TableCell();
                    fees2.Controls.Add(new LiteralControl("Null"));
                    k.Controls.Add(fees2);
                }

                try
                    {
                        Int32 creditHours = rdr3.GetInt32(rdr3.GetOrdinal("creditHours"));
                        TableCell CreditHourss = new TableCell();
                        CreditHourss.Controls.Add(new LiteralControl("CreditHours : " + creditHours));
                        k.Cells.Add(CreditHourss);
                    }
                catch
                {
                    TableCell creditHours2 = new TableCell();
                    creditHours2.Controls.Add(new LiteralControl("Null"));
                    k.Controls.Add(creditHours2);
                }

                try
                        {
                            String code = rdr3.GetString(rdr3.GetOrdinal("code"));
                            TableCell codee = new TableCell();
                            codee.Controls.Add(new LiteralControl("Code :" + code));
                            k.Cells.Add(codee);
                        }
                catch
                {
                    TableCell code2 = new TableCell();
                    code2.Controls.Add(new LiteralControl("Null"));
                    k.Controls.Add(code2);
                }
                
                try
                        {
                            Decimal grade = rdr3.GetDecimal(rdr3.GetOrdinal("grade"));
                            TableCell gradee = new TableCell();
                            gradee.Controls.Add(new LiteralControl("Grade :" + grade));
                            k.Cells.Add(gradee);
                        }
                catch
                {
                    TableCell grade2 = new TableCell();
                    grade2.Controls.Add(new LiteralControl("Null"));
                    k.Controls.Add(grade2);
                }













                Table3.Rows.Add(k);

            }
            conn.Close();

        }

     
    }
}