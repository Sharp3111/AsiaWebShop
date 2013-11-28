<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="MemberLoginManagement.aspx.cs" Inherits="AdminOnly_MemberLoginManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2" 
        style="font-family: Arial, Helvetica, sans-serif; font-size: large; color: #000080">
        <strong style="font-size: medium">Manage member login</strong></p>
    <p style="color: #000080">
        To enable certain member login, please enter the member user name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="enableUser" runat="server" Height="22px" MaxLength="10" 
            Width="130px"></asp:TextBox>
        <asp:Button ID="enable" runat="server" 
            Height="30px" onclick="Execute_Click" 
            style="font-family: 'Times New Roman', Times, serif; font-size: medium" Text="Enable" 
            Width="100px" />
    </p>
    <p>
    <asp:Label ID="lblEnableMemberLoginMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    </p>
    <p style="color: #000080">
        To disable certain member login, please enter the member user name:&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="disableUser" runat="server" Height="22px" MaxLength="10" 
            Width="130px"></asp:TextBox>
        <asp:Button ID="disable" runat="server" Height="30px" 
            style="font-family: 'Times New Roman', Times, serif; font-size: medium" Text="Disable" 
            Width="100px" onclick="disable_Click" />
    </p>
    <p>
    <asp:Label ID="lblDisableMemberLoginMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    </p>
    <p>
        &nbsp;</p>
</asp:Content>

