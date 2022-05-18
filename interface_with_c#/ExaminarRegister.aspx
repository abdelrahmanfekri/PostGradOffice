<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExaminarRegister.aspx.cs" Inherits="MichaelPart.ExaminarRegister" %>

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
            width: 500px;
            background-color: #e5e5e5;
            
        }
        .align{
            text-align : center;
  
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div class="register">

            <h1> Registeration </h1><br />
            <h3> First name :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox Height="30px" ID="TextBox1" runat="server" Width="291px"></asp:TextBox></h3><br />
            <h3> Last name :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox Height="30px" ID="TextBox2" runat="server" Width="291px"></asp:TextBox> </h3><br />
            <h3> Email :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox Height="30px"  ID="TextBox5" runat="server" Width="291px"></asp:TextBox> </h3><br />
            <h3> Password :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <asp:TextBox Height="30px" type ="password" ID="TextBox3" runat="server" Width="291px"></asp:TextBox> </h3><br />
            <h3> Field Of Work : <asp:TextBox ID="TextBox4" runat="server" Width="291px" Height="30px"></asp:TextBox></h3><br />
            <h3> Is National? :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <asp:Checkbox ID="check1" runat="server" Text="Yes" />
                </h3> <br />       
            <div class ="align">
                <asp:Button   Height ="50px" Width ="50%" OnClick ="Register"  BackColor ="LightCyan"  ID ="Button1" runat="server" Text="Register"  />
            </div> 
            <br />
            <br />
            
        </div>
        
    </form>
</body>
</html>
