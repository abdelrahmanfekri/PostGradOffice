<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MichaelPart.Login" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Login</title>
<style>

.login {
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
<div class="login">
<h3>Welcome. Please login.</h3>
<form id ="fram1" runat ="server">
<fieldset>
 <br />
<br />
<asp:Label runat ="server" Text ="Email"></asp:Label>
<input ID ="email" runat ="server" ClientIDMode="static" type ="text"  >
<br />
 <br />
<asp:Label runat ="server" Text ="password"></asp:Label>
<input ID ="password"   runat ="server" ClientIDMode="static" type="password" value="Password" >&nbsp;
<br />
<br />
<br />
<asp:Button Id ="Button1" runat ="server" OnClick="login" text="Login"/>
    <br />
    <br />
    <asp:Button  ID ="Button2" runat ="server" OnClick="Register" text="Register For the First Time"/>
</fieldset>
</form>


</div> 
</body>
</html>