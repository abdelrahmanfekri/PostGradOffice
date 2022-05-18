<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Thesis.aspx.cs" Inherits="MichaelPart.Thesis" %>

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
         <div >
            <h2>Your Thesis</h2>
            <asp:Table id="Table1" 
        GridLines="Both" 
        HorizontalAlign="Center" 
        Font-Names="Verdana" 
        Font-Size="8pt" 
        CellPadding="15" 
        CellSpacing="0" 
        Runat="server"/>
        </div>
         <p>
             &nbsp;</p>
    
    </form>
</body>
</html>