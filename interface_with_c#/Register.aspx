<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MichaelPart.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        
.Register {
margin: 50px auto;
width: 300px;
}
form fieldset input[type="text"], input[type="password"] {
background-color: #e5e5e5;
color: #5a5656;
height: 50px;
width: 280px;
}
form fieldset input[type="submit"] {
background-color: #008dde;
color: #f4f4f4;
height: 50px;
width: 300px;
}
    </style>
</head>
    
<body>
    <div class ="Register">
    
<form id ="fram1" runat ="server">
<fieldset>
    <h3>Register As</h3>
<br />
<asp:Button Id ="Button1" runat ="server" OnClick="StDir" text="Student"/>
    <br />
    <br />

<asp:Button Id ="Button3" runat ="server" OnClick="SupDir" text="Supervisor"/>
    <br />
    <br />
<asp:Button Id ="Button4" runat ="server" OnClick="ExDir" text="Examinar"/>
    <br />
    <br />
</fieldset>
</form>


</div> 
</body>
</html>
