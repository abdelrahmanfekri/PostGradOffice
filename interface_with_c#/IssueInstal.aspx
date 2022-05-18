<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IssueInstal.aspx.cs" Inherits="MichaelPart.IssueInstal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        
        .register{
            margin: 75px auto;
            width: 500px;
            background-color: #e5e5e5;
            text-align:center
        }
        .align{
            text-align : center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class ="register">
            <h1>Issue Payment installments</h1>
            <br />
            <h3>Enter Payment Id:&nbsp;&nbsp;<asp:TextBox height ="30px" ID="PaymentId" runat="server" Width="256px" required ="required"></asp:TextBox>
            </h3>
            <br />
            <h3>Start Date :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;<asp:TextBox pattern ="[0-9]{2}/[0-9]{2}/[0-9]{4}" required ="required" height ="30px" Width="256px" ID="InstallDate" runat="server"></asp:TextBox>
            </h3>
            <h5>required pattern MM/DD/YYYY</h5>
            <br />
            <br />
            <asp:Button height ="40px" float ="Center" ID="ADD" runat="server" Text="Add Installments" Width="345px" BackColor="Cyan" OnClick ="addInstall" />
            <br />
            <br />
        </div>
    </form>
</body>
</html>
