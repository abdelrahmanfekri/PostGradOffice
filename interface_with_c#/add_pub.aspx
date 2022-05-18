<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_pub.aspx.cs" Inherits="MichaelPart.add_pub" %>

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
            <h2> Adding Publication </h2>
            <h4>Add title for publication : <asp:TextBox ID="TextBox1" Required ="Required" runat="server"></asp:TextBox>
            </h4>
       <h4>Add date for publication :  <asp:TextBox ID="Calendar" pattern="[0-9]{2}/[0-9]{2}/[0-9]{4}" runat="server" style="margin-bottom: 0px" Required ="Required"></asp:TextBox>
        </h4>
           <h5>Enter the date in format MM/DD/YYYY like 02/04/2020</h5>
        <h4>Add host for publication : <asp:TextBox ID="TextBox2" Required ="Required" runat="server"></asp:TextBox>
        </h4>
        <h4>Add place for publication : <asp:TextBox ID="TextBox3" Required ="Required" runat="server"></asp:TextBox>
        </h4>
        <h4>Choose Accepted or Not : <asp:DropDownList ID="DropDownList1" Required ="Required" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
        </asp:DropDownList>
        </h4>
        <h5>Choose 0 for No .. 1 for Yes </h5> 

            </div>
        <p>
            <asp:Button ID="Button1" runat="server" Text="Add" OnClick="Button1_Click" />
        </p>

             <p>
                 &nbsp;</p>
    </form>
</body>
</html>
