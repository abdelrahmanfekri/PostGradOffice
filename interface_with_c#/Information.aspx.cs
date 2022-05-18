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
    public partial class Information : System.Web.UI.Page
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

            SqlCommand data = new SqlCommand("GucianandNonStudentData", conn);
            data.CommandType = CommandType.StoredProcedure;
            data.Parameters.Add(new SqlParameter("@id", SqlDbType.Int)).Value = Session["user"];

            conn.Open();
            SqlDataReader rdr = data.ExecuteReader(CommandBehavior.CloseConnection);
            while (rdr.Read())
            {
                try
                {
                    Int32 id = rdr.GetInt32(rdr.GetOrdinal("id"));
                    TableRow r0 = new TableRow();
                    TableCell id1 = new TableCell();
                    id1.Controls.Add(new LiteralControl("ID"));
                    r0.Cells.Add(id1);
                    TableCell id2 = new TableCell();
                    id2.Controls.Add(new LiteralControl(id + ""));
                    r0.Cells.Add(id2);
                    Table2.Rows.Add(r0);
                }
                catch
                {
                    TableRow r0 = new TableRow();
                    TableCell id3 = new TableCell();
                    id3.Controls.Add(new LiteralControl("ID"));
                    r0.Cells.Add(id3);
                    TableCell id4 = new TableCell();
                    id4.Controls.Add(new LiteralControl("Null"));
                    r0.Cells.Add(id4);
                    Table2.Rows.Add(r0);
                }

                try
                {
                    String firstName = rdr.GetString(rdr.GetOrdinal("firstName"));

                    TableRow r1 = new TableRow();
                    TableCell firstName1 = new TableCell();
                    firstName1.Controls.Add(new LiteralControl("First Name"));
                    r1.Cells.Add(firstName1);
                    TableCell firstName2 = new TableCell();
                    firstName2.Controls.Add(new LiteralControl(firstName));
                    r1.Cells.Add(firstName2);
                    Table2.Rows.Add(r1);
                }
                catch
                {

                    TableRow r1 = new TableRow();
                    TableCell firstName3 = new TableCell();
                    firstName3.Controls.Add(new LiteralControl("First Name"));
                    r1.Cells.Add(firstName3);
                    TableCell firstName4 = new TableCell();
                    firstName4.Controls.Add(new LiteralControl("Null"));
                    r1.Cells.Add(firstName4);
                    Table2.Rows.Add(r1);
                }

                try
                {
                    String lastName = rdr.GetString(rdr.GetOrdinal("lastName"));
                    TableRow r2 = new TableRow();
                    TableCell lastName1 = new TableCell();
                    lastName1.Controls.Add(new LiteralControl("lastName"));
                    r2.Cells.Add(lastName1);
                    TableCell lastName2 = new TableCell();
                    lastName2.Controls.Add(new LiteralControl(lastName));
                    r2.Cells.Add(lastName2);
                    Table2.Rows.Add(r2);
                }
                catch
                {
                    TableRow r2 = new TableRow();
                    TableCell lastName3 = new TableCell();
                    lastName3.Controls.Add(new LiteralControl("lastName"));
                    r2.Cells.Add(lastName3);
                    TableCell lastName4 = new TableCell();
                    lastName4.Controls.Add(new LiteralControl("Null"));
                    r2.Cells.Add(lastName4);
                    Table2.Rows.Add(r2);
                }

                try
                {
                    String type = rdr.GetString(rdr.GetOrdinal("type"));
                    TableRow r3 = new TableRow();
                    TableCell type1 = new TableCell();
                    type1.Controls.Add(new LiteralControl("type"));
                    r3.Cells.Add(type1);
                    TableCell type2 = new TableCell();
                    type2.Controls.Add(new LiteralControl(type));
                    r3.Cells.Add(type2);
                    Table2.Rows.Add(r3);
                }
                catch
                {

                    TableRow r3 = new TableRow();
                    TableCell type3 = new TableCell();
                    type3.Controls.Add(new LiteralControl("type"));
                    r3.Cells.Add(type3);
                    TableCell type4 = new TableCell();
                    type4.Controls.Add(new LiteralControl("Null"));
                    r3.Cells.Add(type4);
                    Table2.Rows.Add(r3);

                }

                try
                {
                    String faculty = rdr.GetString(rdr.GetOrdinal("faculty"));
                    TableRow r4 = new TableRow();
                    TableCell faculty1 = new TableCell();
                    faculty1.Controls.Add(new LiteralControl("faculty"));
                    r4.Cells.Add(faculty1);
                    TableCell faculty2 = new TableCell();
                    faculty2.Controls.Add(new LiteralControl(faculty));
                    r4.Cells.Add(faculty2);
                    Table2.Rows.Add(r4);
                }
                catch
                {
                    TableRow r4 = new TableRow();
                    TableCell faculty3 = new TableCell();
                    faculty3.Controls.Add(new LiteralControl("faculty"));
                    r4.Cells.Add(faculty3);
                    TableCell faculty4 = new TableCell();
                    faculty4.Controls.Add(new LiteralControl("Null"));
                    r4.Cells.Add(faculty4);
                    Table2.Rows.Add(r4);
                }

                try
                {
                    Decimal GPA = rdr.GetDecimal(rdr.GetOrdinal("GPA"));
                    TableRow r5 = new TableRow();
                    TableCell GPA1 = new TableCell();
                    GPA1.Controls.Add(new LiteralControl("GPA"));
                    r5.Cells.Add(GPA1);
                    TableCell GPA2 = new TableCell();
                    GPA2.Controls.Add(new LiteralControl(GPA + ""));
                    r5.Cells.Add(GPA2);
                    Table2.Rows.Add(r5);
                }
                catch
                { 
                    TableRow r5 = new TableRow();
                    TableCell GPA3 = new TableCell();
                    GPA3.Controls.Add(new LiteralControl("GPA"));
                    r5.Cells.Add(GPA3);
                    TableCell GPA4 = new TableCell();
                    GPA4.Controls.Add(new LiteralControl("Null"));
                    r5.Cells.Add(GPA4);
                    Table2.Rows.Add(r5);
                }

                try
                {
                    String address = rdr.GetString(rdr.GetOrdinal("address"));
                    TableRow r6 = new TableRow();
                    TableCell address1 = new TableCell();
                    address1.Controls.Add(new LiteralControl("address"));
                    r6.Cells.Add(address1);
                    TableCell address2 = new TableCell();
                    address2.Controls.Add(new LiteralControl(address));
                    r6.Cells.Add(address2);
                    Table2.Rows.Add(r6);

                }
                catch
                {
                    String address = rdr.GetString(rdr.GetOrdinal("address"));
                    TableRow r6 = new TableRow();
                    TableCell address3 = new TableCell();
                    address3.Controls.Add(new LiteralControl("address"));
                    r6.Cells.Add(address3);
                    TableCell address4 = new TableCell();
                    address4.Controls.Add(new LiteralControl("Null"));
                    r6.Cells.Add(address4);
                    Table2.Rows.Add(r6);

                }
                if (Session["type"].ToString() == "GucianStudent")
                {
                    try
                    {
                        Int32 undergradID = rdr.GetInt32(rdr.GetOrdinal("undergradID"));
                        TableRow r7 = new TableRow();
                        TableCell undergradID1 = new TableCell();
                        undergradID1.Controls.Add(new LiteralControl("undergradID"));
                        r7.Cells.Add(undergradID1);
                        TableCell undergradID2 = new TableCell();
                        undergradID2.Controls.Add(new LiteralControl(undergradID + ""));
                        r7.Cells.Add(undergradID2);
                        Table2.Rows.Add(r7);
                    }
                    catch
                    {
                        TableRow r7 = new TableRow();
                        TableCell undergradID3 = new TableCell();
                        undergradID3.Controls.Add(new LiteralControl("undergradID"));
                        r7.Cells.Add(undergradID3);
                        TableCell undergradID4 = new TableCell();
                        undergradID4.Controls.Add(new LiteralControl("Null"));
                        r7.Cells.Add(undergradID4);
                        Table2.Rows.Add(r7);
                    }
                }




            }
            conn.Close();

        }

       
    }
}