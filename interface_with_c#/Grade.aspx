<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Grade.aspx.cs" Inherits="MichaelPart.Grade" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            Grade</div>
        <asp:TextBox ID="TextBox1" runat="server" required = "required" Height="17px" Width="155px" OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
        <br />
        <span dir="ltr" role="presentation" style="left: 231.728px; top: 223.317px; font-size: 16.6043px; font-family: sans-serif; transform: scaleX(0.987779);">ThesisSerialNo</span><br />
        <asp:TextBox ID="TextBox2" runat="server" required = "required" OnTextChanged="TextBox2_TextChanged"></asp:TextBox>
        <br />
        <span dir="ltr" role="presentation" style="left: 231.728px; top: 361.765px; font-size: 16.6043px; font-family: sans-serif; transform: scaleX(0.985363);">DefenseDate<br />
        </span>
        <asp:TextBox ID="TextBox3" runat="server" required = "required" OnTextChanged="TextBox3_TextChanged"></asp:TextBox>
        <br />
&nbsp;<p>
            <asp:Button ID="Button1" runat="server" style="margin-left: 94px" Text="add" Width="156px" Height="38px" OnClick="Button1_Click" />
        </p>
        <p style="height: 49px; width: 760px; margin-left: 387px">
            &nbsp;</p>
    </form>
</body>
</html>
