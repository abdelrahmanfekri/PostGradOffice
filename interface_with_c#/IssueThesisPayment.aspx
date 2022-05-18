<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IssueThesisPayment.aspx.cs" Inherits="MichaelPart.IssueThesisPayment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        
        .register{
            margin: 75px auto;
            width: 550px;
            background-color: #e5e5e5;
            
        }
        .align{
            text-align : center;
        }
    </style>
</head>
 
<body>
    <form id="form1" runat="server">
        <div class ="register">
            <h1>Issue a Thesis Payment </h1>
            <asp:Label width ="250px" ID ="Label1" runat="server" Text="enter Thesis Serial Number"></asp:Label>
            <asp:TextBox required="required" height ="20px" width ="240px" ID="thSerial" runat="server" ></asp:TextBox>
            <br />
            <br />
            <asp:Label  ID ="Label2" width ="250px"  runat="server" Text="Amount" b ="20px"></asp:Label>
            <asp:TextBox required="required" height ="20px" width ="240px" ID="Amount" runat="server" ></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label3" width ="250px"  runat="server" Text="noOfInstallments"></asp:Label>
            <asp:TextBox required="required" height ="20px" width ="240px" ID="NoInstall" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label4" runat="server" width ="250px"  Text="fundPercentage"></asp:Label>
            <asp:TextBox required="required" height ="20px" width ="240px" ID="Percentage" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button center ="Center" OnClick ="addPayment" ID="Add" runat="server" Text="ADD" Width="500px"  height="40px" BackColor="Cyan"/>
            <br />
            <br />
        </div>
    </form>
</body>
</html>
