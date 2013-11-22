<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="MemberOnly_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: large;
            color: #000080;
            text-transform: uppercase;
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong>Member Support Tools</strong></p>
    <p>
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/MemberOnly/ViewMemberInformation.aspx">View and Edit Member Information</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink4" runat="server" 
            NavigateUrl="~/MemberOnly/ReviewProcessingOrder.aspx">View Your Processing Orders</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink2" runat="server" 
            NavigateUrl="~/MemberOnly/ItemPurchaseReport.aspx">View Item Purchase Report</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink3" runat="server" 
            NavigateUrl="~/MemberOnly/ItemReview.aspx">Review Purchased Items</asp:HyperLink>
    </p>
</asp:Content>

