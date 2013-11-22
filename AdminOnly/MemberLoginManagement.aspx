<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="MemberLoginManagement.aspx.cs" Inherits="AdminOnly_MemberLoginManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong style="font-size: medium">Manage member login</strong></p>
    <p>
        To enable certain member login, please enter the member userName:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="enableUser" runat="server" Height="22px" MaxLength="10" 
            Width="130px"></asp:TextBox>
    </p>
    <p>
    <asp:Label ID="lblEnableMemberLoginMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    </p>
    <p>
        To disable certain member login, please enter the member userName:&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="disableUser" runat="server" Height="22px" MaxLength="10" 
            Width="130px"></asp:TextBox>
    </p>
    <p>
    <asp:Label ID="lblDisableMemberLoginMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    </p>
    <p>
        <asp:Button ID="Execute" runat="server" 
            Height="30px" onclick="Execute_Click" 
            style="font-family: 'Times New Roman', Times, serif; font-size: medium" Text="Execute" 
            Width="100px" />
    </p>
</asp:Content>

