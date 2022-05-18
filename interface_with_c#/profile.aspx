<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="profile.aspx.cs" Inherits="MichaelPart.profile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <p>
            &nbsp;</p>
        <p>
            Name:&nbsp;&nbsp;
        </p>
        <p>
            <asp:TextBox ID="TextBox1" runat="server" required = "required" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
        </p>
        <p>
            <span dir="ltr" role="presentation" style="left: 168.453px; top: 602.46px; font-size: 16.6043px; font-family: sans-serif; transform: scaleX(1.02305);">fieldOfWork</span></p>
        <p>
            <asp:TextBox ID="TextBox2" runat="server" required = "required" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
        </p>
        <asp:Button ID="Button1" runat="server" Height="45px" OnClick="Button1_Click" style="margin-left: 286px" Text="Edit" Width="221px" />
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
