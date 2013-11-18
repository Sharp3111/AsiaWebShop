<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="AdminManagement.aspx.cs" Inherits="AdminOnly_AdminManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <asp:HyperLink ID="ItemManagement" runat="server" 
        NavigateUrl="ItemManagement.aspx" Font-Bold="True" Font-Size="Large">Item Management</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="MemberSearch" runat="server" 
    NavigateUrl="~/AdminOnly/MemberLoginManagement.aspx" Font-Bold="True" 
        Font-Size="Large">Member Management</asp:HyperLink>
<br />
<br />
    <asp:HyperLink ID="PersonalReport" runat="server" 
    NavigateUrl="~/AdminOnly/PersonalReport.aspx" Font-Bold="True" 
    Font-Size="Large">Generate Personal Details Report</asp:HyperLink>
<br />
<br />
    <asp:HyperLink ID="AmountReport" runat="server" 
    NavigateUrl="~/AdminOnly/AmountReport.aspx" Font-Bold="True" Font-Size="Large">Generate Purchase Amount Report</asp:HyperLink>
    <br />
    <br />
    <asp:HyperLink ID="ItemPurchaseReport" runat="server" Font-Bold="True" 
        Font-Size="Large" NavigateUrl="~/AdminOnly/ItemPurchaseReport.aspx">General Item Purchase Report</asp:HyperLink>
    <br />
<br />
    <asp:HyperLink ID="RecommendationManagement" runat="server" 
        style="color: #034AF3; font-weight: 700; font-family: 'Segoe UI'; font-size: large; text-decoration: underline">Recommendation Management</asp:HyperLink>
    <br />
<br />
</asp:Content>

