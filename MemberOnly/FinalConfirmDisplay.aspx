<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="FinalConfirmDisplay.aspx.cs" Inherits="MemberOnly_FinalConfirmDisplay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: x-large;
            font-family: "Times New Roman", Times, serif;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-weight: bold; color: #000080" class="style2">
        Final Order Confirmation</p>
    <p style="font-family: Arial, Helvetica, sans-serif; font-weight: normal; font-size: medium; color: #000080">
        Dear
        <asp:Label ID="userName" runat="server"></asp:Label>
        , please remember your Confirmation Code below and a receipt was sent to your 
        email:
        <asp:Label ID="email" runat="server"></asp:Label>
    </p>
    <p>
        <asp:Label ID="confirmationCode" runat="server" Font-Bold="True" 
            Font-Size="XX-Large" ForeColor="Red"></asp:Label>
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Default.aspx" 
            Text="Back to Homepage" Height="30px" 
            style="font-size: medium; font-family: 'Times New Roman', Times, serif" 
            Width="200px" />
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

