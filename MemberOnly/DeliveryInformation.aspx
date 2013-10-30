<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="DeliveryInformation.aspx.cs" Inherits="MemberOnly_DeliveryInformation" %>

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
        <strong>SPECIFY Delivery Information</strong></p>
    <p>
        &nbsp;</p>
    <p>
        <asp:GridView ID="gvAddress" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebShopDBSqlDataSource" 
            ForeColor="#333333" GridLines="None" DataKeyNames="nickname">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    SortExpression="userName" />
                <asp:BoundField DataField="building" HeaderText="building" 
                    SortExpression="building" />
                <asp:BoundField DataField="floor" HeaderText="floor" 
                    SortExpression="floor" />
                <asp:BoundField DataField="flatSuite" HeaderText="flatSuite" 
                    SortExpression="flatSuite" />
                <asp:BoundField DataField="blockTower" HeaderText="blockTower" 
                    SortExpression="blockTower" />
                <asp:BoundField DataField="streetAddress" HeaderText="streetAddress" 
                    SortExpression="streetAddress" />
                <asp:BoundField DataField="district" HeaderText="district" 
                    SortExpression="district" />
                <asp:BoundField DataField="nickname" HeaderText="nickname" ReadOnly="True" 
                    SortExpression="nickname" />
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
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM [Address]"></asp:SqlDataSource>
    </p>
    <p>
        <asp:Button ID="ContinueButton" runat="server" onclick="ContinueButton_Click" 
            Text="Continue" />
    </p>
</asp:Content>

