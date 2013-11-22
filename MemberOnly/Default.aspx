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
        <strong>Member Dashboard</strong></p>
    <p>
        <asp:HyperLink ID="HyperLink1" runat="server" 
            NavigateUrl="~/MemberOnly/ViewMemberInformation.aspx">View and Edit Member Information</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink6" runat="server" 
            NavigateUrl="~/MemberOnly/ManageDelivery.aspx">Manage Your Delivery Address List</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink7" runat="server" 
            NavigateUrl="~/MemberOnly/ManagePaymentMethod.aspx">Manage Your Credit Card List</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink9" runat="server" 
            NavigateUrl="~/Account/ChangePassword.aspx">Change Your Password</asp:HyperLink>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:HyperLink ID="HyperLink5" runat="server" 
            NavigateUrl="~/MemberOnly/ShoppingCart.aspx">View Your Shopping Cart</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink2" runat="server" 
            NavigateUrl="~/MemberOnly/ItemPurchaseReport.aspx">View Item Purchase Report</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink4" runat="server" 
            NavigateUrl="~/MemberOnly/ReviewProcessingOrder.aspx">View Your Processing Orders</asp:HyperLink>
    </p>
    <p>
        <asp:HyperLink ID="HyperLink3" runat="server" 
            NavigateUrl="~/MemberOnly/ItemReview.aspx">Review Purchased Items</asp:HyperLink>
    </p>
    </asp:Content>

