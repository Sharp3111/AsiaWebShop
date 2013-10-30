<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="MenList.aspx.cs" Inherits="MenList" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: medium;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        <span class="style2"><strong>Category: </strong></span>&nbsp;&nbsp;&nbsp;
        <asp:Label ID="MenLabel" runat="server" 
            style="font-size: medium; font-weight: 700" Text="Men"></asp:Label>
    </p>
    <p>
        <asp:Label ID="lblSearchResultMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    </p>
    <asp:GridView ID="gvItemSearchResult" runat="server" 
        AutoGenerateColumns="False" CaptionAlign="Top" CellPadding="4" 
        DataKeyNames="upc" DataSourceID="AsiaWebShopDBSqlDataSource" 
        ForeColor="#333333" GridLines="None" style="text-align: left">
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
            <asp:BoundField DataField="normalPrice" HeaderText="Normal Price" 
                SortExpression="normalPrice" />
            <asp:BoundField DataField="discountPrice" HeaderText="Discount Price" 
                SortExpression="discountPrice" />
            <asp:BoundField DataField="quantityAvailable" HeaderText="Quantity Available" 
                SortExpression="quantityAvailable" />
            <asp:HyperLinkField DataNavigateUrlFields="upc" 
                DataNavigateUrlFormatString="ItemDetails.aspx?upc={0}" 
                Text="View item details" />
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
        SelectCommand=></asp:SqlDataSource>
</asp:Content>

