<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="fill_pro.aspx.cs" Inherits="MichaelPart.fill_pro" %>

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
            <h2> Filling Progress Report</h2>
           <h4>Choose Thesis with Progress Report Number : <asp:DropDownList ID="DropDownList1" runat="server"  required="required"></asp:DropDownList>
            </h4> 
        </div>
       <h4>Description : <asp:TextBox ID="TextBox1" runat="server" required="required"></asp:TextBox>
        </h4>
        <h4>State : <asp:TextBox ID="TextBox2" runat="server" required="required"></asp:TextBox>
        </h4>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Fill" OnClick="Button1_Click" />
    
         <p>
             &nbsp;</p>
    
    </form>
</body>
</html>
