using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MichaelPart
{
    public partial class ListAllSub : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["Signed"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }
        protected void AllSub(object sender ,EventArgs e)
        {
            Response.Redirect("ViewAllSubervisor.aspx");
        }

        protected void AllTh(object sender, EventArgs e)
        {
            Response.Redirect("ALLThesis.aspx");
        }
        protected void IssuP(object sender, EventArgs e)
        {
            Response.Redirect("IssueThesisPayment.aspx");
        }
        protected void IssuInstal(object sender, EventArgs e)
        {
            Response.Redirect("IssueInstal.aspx");
        }

    }

}