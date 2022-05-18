<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student1.aspx.cs" Inherits="MichaelPart.Student1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        h1 {
    height: 50%;
    margin: 0 auto;
    background: gray;
    text-align: center;
    font-weight: bold;
}
        .leftpane{
    width: 25%;
    min-width: 350px;
    height: 791px;
    min-height: 400px;
    float: left;
    background-color: rosybrown;
    border-collapse: collapse;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1> Student Page </h1>
        </div>
        <div class="leftpane">

        <asp:Button ID="Information" runat="server" Text="View My Information" Height="54px" Width="376px" OnClick="Information_Click" />

            <asp:Button ID="Thesis" runat="server" Text="View My Thesis" Height="54px" Width="376px" OnClick="Thesis_Click" />

            <asp:Button ID="AddProgress" runat="server" Text="Add Progress Report" Height="54px" Width="376px" OnClick="AddProgress_Click" />

            <asp:Button ID="FillProgress" runat="server" Text="Fill Progress Report" Height="54px" Width="376px" OnClick="FillProgress_Click" />

            <asp:Button ID="AddPublication" runat="server" Text="Add Publication"  Height="54px" Width="376px" OnClick="AddPublication_Click" />

            <asp:Button ID="LinkPublication" runat="server" Text="Link Publication to Thesis" Height="54px" Width="376px" OnClick="LinkPublication_Click" />

            <asp:Button ID="AddPhone" runat="server" Text="Add Phone Number" OnClick="AddPhone_Click" />

        </div>


    </form>
</body>
</html>
