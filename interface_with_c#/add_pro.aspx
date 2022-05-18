<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_pro.aspx.cs" Inherits="MichaelPart.add_pro" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        h2{
    height: 50%;
    margin: 0 auto;
    text-align: center;
    font-weight: bold;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2> Adding Progress Report</h2>

            <h4>Choose one from Your Thesis : <asp:DropDownList Required ="Required" ID ="DropDownList1" runat="server">
            </asp:DropDownList>
            </h4>

        </div>
        <h4>Enter Progress Report date : <asp:TextBox ID="Calendar1" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}" runat="server" style="margin-bottom: 0px" Required ="Required"></asp:TextBox></h4>
                <h5>Enter the date in format MM/DD/YYYY like 02/04/2020</h5>
   
        <h4>Enter your progress report number : <asp:TextBox ID="TextBox1" pattern="[0-9]" runat="server" style="margin-bottom: 0px" Required ="Required"></asp:TextBox>
        </h4>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Add" />
            

       
      </form>      
</body>
</html>
