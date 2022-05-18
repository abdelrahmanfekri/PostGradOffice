using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MichaelPart
{
    public partial class Student2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Convert.ToBoolean(Session["SignedNonGucianStudent"]))
            {
                Response.Redirect("Login.aspx");
                return;
            }

        }

        protected void Information_Click(object sender, EventArgs e)
        {
            Response.Redirect("Information.aspx");
        }

        protected void Thesis_Click(object sender, EventArgs e)
        {
            Response.Redirect("Thesis.aspx");
        }

        protected void AddProgress_Click(object sender, EventArgs e)
        {
            Response.Redirect("add_pro.aspx");
        }

        protected void FillProgress_Click(object sender, EventArgs e)
        {
            Response.Redirect("fill_pro.aspx");
        }

        protected void AddPublication_Click(object sender, EventArgs e)
        {
            Response.Redirect("add_pub.aspx");
        }

        protected void LinkPublication_Click(object sender, EventArgs e)
        {
            Response.Redirect("link_pub.aspx");
        }

        protected void Courses_Click(object sender, EventArgs e)
        {
            Response.Redirect("courses.aspx");
        }

        protected void AddPhone_Click(object sender, EventArgs e)
        {
            Response.Redirect("add_phone.aspx");
        }
    }
}