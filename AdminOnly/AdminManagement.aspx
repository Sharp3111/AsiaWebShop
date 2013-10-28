<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="AdminManagement.aspx.cs" Inherits="AdminOnly_AdminManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:HyperLink ID="ItemManagement" runat="server" 
        NavigateUrl="ItemManagement.aspx" Font-Bold="True" Font-Size="Large">Item Management</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="MemberSearch" runat="server" 
    NavigateUrl="MemberSearch.aspx" Font-Bold="True" Font-Size="Large">Member Information Edit</asp:HyperLink>
<br />
<br />
    <asp:HyperLink ID="PersonalReport" runat="server" 
    NavigateUrl="~/AdminOnly/PersonalReport.aspx" Font-Bold="True" 
    Font-Size="Large">Generate personal details report</asp:HyperLink>
<br />
<br />
    <asp:HyperLink ID="AmountReport" runat="server" 
    NavigateUrl="~/AdminOnly/AmountReport.aspx" Font-Bold="True" Font-Size="Large">Generate purchase amount report</asp:HyperLink>
<br />
<br />
</asp:Content>

