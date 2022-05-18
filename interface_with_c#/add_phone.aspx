<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="add_phone.aspx.cs" Inherits="MichaelPart.add_phone" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
 <style>
        h1 {
    height: 50%;
    margin: 0 auto;
    background: gray;
    text-align: center;
    font-weight: bold;
}
        .leftpane{
    width: 25%;
    min-width: 350px;
    height: 791px;
    min-height: 400px;
    float: left;
    background-color: rosybrown;
    border-collapse: collapse;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1> Phones Page </h1>
        </div>
   
       <h3>Please Add Your Phone Number(s) Here :</h3> 
        <asp:TextBox   ID="TextBox1" runat="server" Width="382px" required="required"></asp:TextBox>
        <p>
            <asp:Button ID="Addphone" runat="server" Text="Add" OnClick="Addphone_Click" />
        </p>
      
    </form>
</body>
</html>
