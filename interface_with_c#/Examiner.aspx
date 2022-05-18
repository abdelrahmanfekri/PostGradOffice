<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Examiner.aspx.cs" Inherits="MichaelPart.Examiner" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <p>
                Examiner</p>
        </div>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Edit Profile" Height="42px" OnClick="Button1_Click1" Width="158px" />
        </p>
        <p>
            <asp:Button ID="Button2" runat="server" Text="List all theses " Height="42px" Width="158px" OnClick="Button2_Click" />
        </p>
        <p>
            <asp:Button ID="Button3" runat="server" Text="Add comments " Height="40px" Width="158px" OnClick="Button3_Click" />
        </p>
        <p>
            <asp:Button ID="Button4" runat="server" Text="Add grade " Height="42px" OnClick="Button4_Click" Width="159px" />
        </p>
        <p>
            <asp:TextBox ID="TextBox1" runat="server" Height="37px"  OnTextChanged="TextBox1_TextChanged"></asp:TextBox>
            <asp:Button ID="Button5" runat="server" Text="Search" Width="123px" Height="40px" OnClick="Button5_Click" />
        </p>
    </form>
</body>
</html>
