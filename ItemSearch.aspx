<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemSearch.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: large;
            color: #000080;
            text-decoration: underline;
        }
        .style3
        {
            width: 100%;
        }
        .style4
        {
            width: 81px;
        }
        .style5
        {
            width: 134px;
        }
        .style6
        {
            width: 38px;
        }
        .style7
        {
            width: 88px;
        }
        .style8
        {
            width: 111px;
        }
        .style9
        {
            width: 74px;
        }
        .style10
        {
            width: 321px;
        }
        .style11
        {
            width: 81px;
            height: 26px;
        }
        .style12
        {
            width: 134px;
            height: 26px;
        }
        .style13
        {
            width: 38px;
            height: 26px;
        }
        .style14
        {
            width: 88px;
            height: 26px;
        }
        .style15
        {
            width: 111px;
            height: 26px;
        }
        .style16
        {
            width: 74px;
            height: 26px;
        }
        .style17
        {
            width: 321px;
            height: 26px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        ITEM SEARCH</p>
    <table class="style3">
        <tr>
            <td class="style11">
                Search for:</td>
            <td class="style12">
                <asp:TextBox ID="txtSearchString" runat="server"></asp:TextBox>
            </td>
            <td class="style13">
                in</td>
            <td class="style14">
                <asp:CheckBox ID="cbItemName" runat="server" Text="Name" />
            </td>
            <td class="style15">
                <asp:CheckBox ID="cbItemDescription" runat="server" Text="Description" />
            </td>
            <td class="style16">
                Category:</td>
            <td class="style17">
                <asp:DropDownList ID="categoryDropDownList" runat="server" 
                    onselectedindexchanged="categoryDropDownList_SelectedIndexChanged">
                    <asp:ListItem>All Categories</asp:ListItem>
                    <asp:ListItem>Appliances</asp:ListItem>
                    <asp:ListItem>Baby and Children</asp:ListItem>
                    <asp:ListItem>Computers and Electronics</asp:ListItem>
                    <asp:ListItem>Jewelry and Watches</asp:ListItem>
                    <asp:ListItem>Luggage</asp:ListItem>
                    <asp:ListItem>Men</asp:ListItem>
                    <asp:ListItem>Toys and Games</asp:ListItem>
                    <asp:ListItem>Women</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style4">
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                    onclick="btnSearch_Click" Height="30px" 
                    style="font-size: medium; font-family: 'Times New Roman', Times, serif" 
                    Width="80px" />
            </td>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
            <td class="style8">
                &nbsp;</td>
            <td class="style9">
                &nbsp;</td>
            <td class="style10">
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <asp:Label ID="lblSearchResultMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        ValidationGroup="QuantityValidationGroup" />
    <br />
    <br />
    <asp:GridView ID="gvItemSearchResult" runat="server" 
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="upc" 
        DataSourceID="AsiaWebShopDBSqlDataSource" ForeColor="#333333" 
        GridLines="None" onrowdatabound="gvItemSearchResult_RowDataBound">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="upc" HeaderText="upc" ReadOnly="True" 
                SortExpression="upc" Visible="False" />
            <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
            <asp:TemplateField HeaderText="Picture">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("upc") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="60px" 
                        ImageUrl='<%# Eval("upc", "GetDBImage.ashx?upc={0}") %>' Width="60px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="normalPrice" HeaderText="NormalPrice" 
                SortExpression="normalPrice" />
            <asp:BoundField DataField="discountPrice" HeaderText="DiscountPrice" 
                SortExpression="discountPrice" />
            <asp:BoundField DataField="quantityAvailable" HeaderText="Quantity Available" 
                SortExpression="quantityAvailable" />
            <asp:HyperLinkField DataNavigateUrlFields="upc" 
                DataNavigateUrlFormatString="ItemDetails.aspx?upc={0}" 
                Text="View item details" />
            <asp:TemplateField HeaderText="Purchase Quantity">
                <ItemTemplate>
                    <asp:TextBox ID="tbQuantity" runat="server" Height="22px" 
                        ValidationGroup="QuantityValidationGroup" Width="30px" MaxLength="10">1</asp:TextBox>
                    <asp:RegularExpressionValidator ID="revQuantity" runat="server" 
                        ControlToValidate="tbQuantity" Display="Dynamic" EnableClientScript="False" 
                        ErrorMessage="Please input the correct quantity" ForeColor="Red" 
                        ValidationExpression="^[1-9]([0-9]+)?" 
                        ValidationGroup="QuantityValidationGroup">*</asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="cvQuantity" runat="server" 
                        ControlToValidate="tbQuantity" Display="Dynamic" EnableClientScript="False" 
                        ErrorMessage="Available quantity for this item is not enough." ForeColor="Red" 
                        onservervalidate="cvQuantity_ServerValidate" 
                        ValidationGroup="QuantityValidationGroup">*</asp:CustomValidator>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="btn_ShoppingCart" runat="server" Height="30px" 
                        Text="Add To Shopping Cart" Width="170px" 
                        onclick="btn_ShoppingCart_Click" 
                        ValidationGroup="QuantityValidationGroup" 
                        style="font-size: medium; font-family: 'Times New Roman', Times, serif" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <EditRowStyle BackColor="#2461BF" />
        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#EFF3FB" />
        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#F5F7FB" />
        <SortedAscendingHeaderStyle BackColor="#6D95E1" />
        <SortedDescendingCellStyle BackColor="#E9EBEF" />
        <SortedDescendingHeaderStyle BackColor="#4870BE" />
    </asp:GridView>
    <br />
    <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="">
    </asp:SqlDataSource>
    <br />
</asp:Content>

