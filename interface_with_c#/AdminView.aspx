<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminView.aspx.cs" Inherits="MichaelPart.ListAllSub" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 
<style>
    .overlay{
    opacity:0.8;
    background-color:#00ddff;
    position:fixed;
    width:30%;
    padding:0;
    height:100%;
    text-align : center;
}
.overlay1{
    background-color: #ccc;
    height:100%;
}
header {
  background-color: #666;
  text-align:center;
  font-size: 50px;
  color: white;
  padding:20px;
    }
</style>
</head>
<body class="overlay1">
    <form id="form" runat="server">
    <header>
       Admin page
    </header>
        <div class ="overlay">
            <asp:Button ID="ListSub" runat="server" OnClick="AllSub" Height="57px" Style="margin-left: 12px; margin-top: 22px;" Text="List all Supervisor" Width="263px" BackColor="Red" />

            <asp:Button ID="ListAllTh" runat="server" OnClick="AllTh" Height="57px" Style="margin-left: 12px; margin-top: 22px;" Text="List all Thesis" Width="263px" BackColor="Red" />
            
            <asp:Button ID="IssueThPayment" runat="server" OnClick="IssuP" Height="57px" Style="margin-left: 12px; margin-top: 22px;" Text="Issue a Thesis Payment" Width="263px" BackColor="Red" />
           
            <asp:Button ID="IsIntallment" runat="server" OnClick="IssuInstal" Height="57px" Style="margin-left: 12px; margin-top: 22px;" Text="Issue an Installments" Width="263px" BackColor="Red" />
            
             
        </div>
    </form>
</body>
</html>

