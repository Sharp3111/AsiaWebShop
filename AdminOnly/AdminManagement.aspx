<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="AdminManagement.aspx.cs" Inherits="AdminOnly_AdminManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:HyperLink ID="ItemManagement" runat="server" 
        NavigateUrl="ItemManagement.aspx">Item Management</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="MemberSearch" runat="server" NavigateUrl="MemberSearch.aspx">Member Information Edit</asp:HyperLink>
</asp:Content>

