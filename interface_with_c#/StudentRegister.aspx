<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentRegister.aspx.cs" Inherits="MichaelPart.StudentRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        h1{
            text-align : center
        }
        .register{
            margin: 75px auto;
            width: 700px;
            background-color: #e5e5e5;
            text-align:center;
        }
        .align{
            text-align : center;
  
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register">

            <h1> Registeration </h1><br />
            <h4> First name :&nbsp;&nbsp;&nbsp; <asp:TextBox required ="required" ID="TextBox1" runat="server" Width="291px"></asp:TextBox></h4><br />
            <h4> Last name :&nbsp;&nbsp;&nbsp; <asp:TextBox required ="required" ID="TextBox2" runat="server" Width="291px"></asp:TextBox> </h4><br />
            <h4> Password :&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox required ="required" type ="password"  ID ="TextBox3" runat="server" Width="291px"></asp:TextBox> </h4><br />
            <h4> Faculty :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox required ="required" ID="TextBox4" runat="server" Width="291px"></asp:TextBox></h4><br />
            <h4> Gucian :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <asp:CheckBox ID="Check1" runat="server" Text="Yes" />
            </h4> <br />       
            <h4> Email :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox required ="required" ID="TextBox5" runat="server" Width="291px"></asp:TextBox> </h4><br />
            <h4> Adress :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox required ="required" ID="TextBox6" runat="server" Width="291px"></asp:TextBox></h4>     <br />   
            <div class ="align">
                <asp:Button   Height ="50px" Width ="50%" OnClick ="Register"  BackColor ="LightCyan"  ID ="Button1" runat="server" Text="Register"  />
            </div> 
            <br />
            <br />
            
        </div>
        
    </form>
</body>
</html>
