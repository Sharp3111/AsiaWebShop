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
            width: 682px;
        }
    .style6
    {
        width: 239px;
        font-size: large;
        color: #000080;
        font-family: Arial, Helvetica, sans-serif;
    }
    .style7
    {
        font-family: Arial, Helvetica, sans-serif;
        font-size: large;
        color: #000080;
            width: 682px;
        }
        .style8
        {
            width: 682px;
        }
        .style9
        {
            font-family: "Segoe UI";
            color: #000080;
        }
        .style10
        {
            font-size: medium;
        }
        .style11
        {
            background-color: #3366CC;
        }
        .style12
        {
            font-family: "Segoe UI";
            color: #FFFFFF;
        }
        .style13
        {
            font-family: "Segoe UI";
            color: #B6B7BC;
        }
        .style14
        {
            color: #000000;
            background-color: #99CCFF;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <table class="style2">
    <tr>
        <td class="style6">
    Make a Selection
        </td>
        <td class="style7" width="250">
            Categories</td>
    </tr>
    <tr>
        <td class="style3">
    <asp:HyperLink ID="SearchLink" runat="server" NavigateUrl="~/ItemSearch.aspx">Search For Items</asp:HyperLink>
        </td>
        <td class="style8" width="250">
    <asp:HyperLink ID="AppliancesLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=Appliances">Appliances</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
    <asp:HyperLink ID="ManageInformationLink" runat="server" 
        NavigateUrl="~/MemberOnly/Default.aspx">Member Use Only</asp:HyperLink>
        </td>
        <td class="style8" width="250">
    <asp:HyperLink ID="BabyChildrenLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=BabyandChildren">Baby and Children</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style4">
    <asp:HyperLink ID="AdminLink" runat="server" 
        NavigateUrl="~/AdminOnly/AdminManagement.aspx">Admin Use Only</asp:HyperLink>
        </td>
        <td class="style8" width="250">
    <asp:HyperLink ID="ComputersElectronicsLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=ComputersandElectronics">Computers and Electronics</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style4">
            &nbsp;</td>
        <td class="style5" width="250">
    <asp:HyperLink ID="JewelryandWatchesLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=JewelryandWatches">Jewelry and Watches</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td class="style8" width="250">
    <asp:HyperLink ID="LuggageLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=Luggage">Luggage</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td class="style8" width="250">
    <asp:HyperLink ID="MenLink" runat="server" NavigateUrl="~/ItemSearch.aspx?category=Men">Men</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td class="style8" width="250">
    <asp:HyperLink ID="ToysGamesLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=ToysandGames">Toys and Games</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td class="style8" width="250">
    <asp:HyperLink ID="WomenLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=Women">Women</asp:HyperLink>
        </td>
    </tr>
</table>
    <br />
    <br />
    <asp:RadioButtonList ID="rangeRadioButtonList" runat="server"         
        style="color: #000080; font-family: 'Segoe UI'" AutoPostBack="True" 
        onselectedindexchanged="rangeRadioButtonList_SelectedIndexChanged" 
        RepeatDirection="Horizontal" Width="938px">
        <asp:ListItem Selected="True" Value="0">Daily Recommnendation</asp:ListItem>
        <asp:ListItem Value="1">Weekly Recommendation</asp:ListItem>
        <asp:ListItem Value="2">Monthly Recommendation</asp:ListItem>
        <asp:ListItem Value="3">Yearly Recommendation</asp:ListItem>
    </asp:RadioButtonList>
    <br />
    <span class="style9"><strong><span class="style10">RECOMMENDATIONS - TOP 5</span></strong></span><span 
        class="style10"><br />
    <table class="style2">
        <tr class="style12">
            <td class="style11">
                Ranking</td>
            <td class="style11">
                Item Name</td>
            <td class="style11">
                Discount Price</td>
            <td class="style11">
                Quantity Sold</td>
            <td class="style11">
                Editor&#39;s Choice</td>
        </tr>
        <tr class="style13">
            <td class="style14">
                <asp:Label ID="rankingLabel1" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="itemNameLabel1" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="discountPriceLabel1" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="quantitySoldLabel1" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="editorChoiceLabel1" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="style13">
            <td class="style14">
                <asp:Label ID="rankingLabel2" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="itemNameLabel2" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="discountPriceLabel2" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="quantitySoldLabel2" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="editorChoiceLabel2" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="style13">
            <td class="style14">
                <asp:Label ID="rankingLabel3" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="itemNameLabel3" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="discountPriceLabel3" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="quantitySoldLabel3" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="editorChoiceLabel3" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="style13">
            <td class="style14">
                <asp:Label ID="rankingLabel4" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="itemNameLabel4" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="discountPriceLabel4" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="quantitySoldLabel4" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="editorChoiceLabel4" runat="server"></asp:Label>
            </td>
        </tr>
        <tr class="style13">
            <td class="style14">
                <asp:Label ID="rankingLabel5" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="itemNameLabel5" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="discountPriceLabel5" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="quantitySoldLabel5" runat="server"></asp:Label>
            </td>
            <td class="style14">
                <asp:Label ID="editorChoiceLabel5" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <span class="style9">Note:&nbsp; -&nbsp; means that the datum for the entry is 
    unavailable.&nbsp; * in the column Editor&#39;s Choice indicates that the item in 
    the row is an Editor&#39;s Choice.</span><br />
    <br />
    </span>
    <br />
    </asp:Content>

