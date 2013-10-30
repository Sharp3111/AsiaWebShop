<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
    .style2
    {
        width: 100%;
    }
    .style3
    {
        width: 239px;
    }
    .style4
    {
        width: 239px;
        height: 21px;
    }
    .style5
    {
        height: 21px;
    }
    .style6
    {
        width: 239px;
        font-size: large;
        text-decoration: underline;
        color: #000080;
        font-family: Arial, Helvetica, sans-serif;
    }
    .style7
    {
        font-family: Arial, Helvetica, sans-serif;
        font-size: large;
        text-decoration: underline;
        color: #000080;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <table class="style2">
    <tr>
        <td class="style6">
    Make a Selection
        </td>
        <td class="style7">
            Categories</td>
    </tr>
    <tr>
        <td class="style3">
    <asp:HyperLink ID="SearchLink" runat="server" NavigateUrl="~/ItemSearch.aspx">Search For Items</asp:HyperLink>
        </td>
        <td>
    <asp:HyperLink ID="AppliancesLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=Appliances">Appliances</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
    <asp:HyperLink ID="ManageInformationLink" runat="server" 
        NavigateUrl="~/MemberOnly/ViewMemberInformation.aspx">Manage Your Information</asp:HyperLink>
        </td>
        <td>
    <asp:HyperLink ID="BabyChildrenLink" runat="server" 
                NavigateUrl="~/BabyandChildrenList.aspx">Baby and Children</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style4">
    <asp:HyperLink ID="AdminLink" runat="server" 
        NavigateUrl="~/AdminOnly/AdminManagement.aspx">Admin Use Only</asp:HyperLink>
        </td>
        <td>
    <asp:HyperLink ID="ComputersElectronicsLink" runat="server" 
                NavigateUrl="~/ComputersandElectronicsList.aspx">Computers and Electronics</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style4">
            &nbsp;</td>
        <td class="style5">
    <asp:HyperLink ID="JewelryandWatchesLink" runat="server" 
                NavigateUrl="~/JewelryandWatchesList.aspx">Jewelry and Watches</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td>
    <asp:HyperLink ID="LuggageLink" runat="server" 
                NavigateUrl="~/LuggageList.aspx">Luggage</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td>
    <asp:HyperLink ID="MenLink" runat="server" NavigateUrl="~/MenList.aspx">Men</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td>
    <asp:HyperLink ID="ToysGamesLink" runat="server" 
                NavigateUrl="~/ToysandGamesList.aspx">Toys and Games</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td>
    <asp:HyperLink ID="WomenLink" runat="server" 
                NavigateUrl="~/WomenList.aspx">Women</asp:HyperLink>
        </td>
    </tr>
</table>
</asp:Content>

