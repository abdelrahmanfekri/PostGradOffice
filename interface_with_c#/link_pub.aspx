<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="link_pub.aspx.cs" Inherits="MichaelPart.link_pub" %>

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
            <h2> Linking Publication</h2>
            <h4>Choose thesis : <asp:DropDownList ID="DropDownList1" runat="server" required ="required">
            </asp:DropDownList>
            </h4>
            <h4>Choose publication : <asp:DropDownList  required ="required" ID ="DropDownList2" runat="server" >
            </asp:DropDownList>
            </h4>
        </div>
        <asp:Button ID="Button1" runat="server" Text="Link" OnClick="Button1_Click" />
    
         <p>
             &nbsp;</p>
    </form>
</body>
</html>
