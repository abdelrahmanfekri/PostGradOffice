<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ALLThesis.aspx.cs" Inherits="MichaelPart.ALLThesis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form" runat="server">
        <div>
            <h1>Add Extension to a Thesis</h1>
            <asp:Label ID="Label1" runat="server" Text="Enter Thesis Serial Numaber"></asp:Label>
            <br />
            <br />
            <asp:TextBox ID="Serial" runat="server" Width="282px" ></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="Add" OnClick ="AddExtension" style="margin-left: 46px" />
            <br />
            <br />
            <h1> View All Thesis</h1>
            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
        </div>
    </form>
</body>
</html>
