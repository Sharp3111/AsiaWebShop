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
        NavigateUrl="~/MemberOnly/ViewMemberInformation.aspx">Manage Your Information</asp:HyperLink>
        </td>
        <td class="style8" width="250">
    <asp:HyperLink ID="BabyChildrenLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=BabyandChildren">Baby and Children</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style4">
            <asp:HyperLink ID="ItemPurchaseReport" runat="server" 
                NavigateUrl="~/MemberOnly/ItemPurchaseReport.aspx">View Your Item Purchase Report</asp:HyperLink>
        </td>
        <td class="style8" width="250">
    <asp:HyperLink ID="ComputersElectronicsLink" runat="server" 
                NavigateUrl="~/ItemSearch.aspx?category=ComputersandElectronics">Computers and Electronics</asp:HyperLink>
        </td>
    </tr>
    <tr>
        <td class="style4">
    <asp:HyperLink ID="AdminLink" runat="server" 
        NavigateUrl="~/AdminOnly/AdminManagement.aspx">Admin Use Only</asp:HyperLink>
        </td>
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
    <span class="style9"><strong><span class="style10">RECOMMENDATIONS - </span>
    <asp:HyperLink ID="NumberLabel" runat="server" style="font-size: medium">[NumberLabel]</asp:HyperLink>
    </strong></span><span 
        class="style10"><br />
    </span>
    <asp:GridView ID="gvRecommendation" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="upc" DataSourceID="SqlDataSource" 
        ForeColor="#333333" GridLines="None" 
        Width="367px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="upc" HeaderText="upc" ReadOnly="True" 
                SortExpression="upc" />
            <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
            <asp:BoundField DataField="discountPrice" HeaderText="discountPrice" 
                SortExpression="discountPrice" />
            <asp:BoundField DataField="quantitySold" HeaderText="quantitySold" 
                SortExpression="quantitySold" />
            <asp:BoundField DataField="ranking" HeaderText="ranking" 
                SortExpression="ranking" />
            <asp:CheckBoxField DataField="isEditorChoice" HeaderText="isEditorChoice" 
                SortExpression="isEditorChoice" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT * FROM [RecommendationDay] ORDER BY [ranking]">
    </asp:SqlDataSource>
</asp:Content>

