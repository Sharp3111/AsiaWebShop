<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ManagePaymentMethod.aspx.cs" Inherits="MemberOnly_PaymentMethodManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: large;
            text-decoration: underline;
            text-transform: uppercase;
        }
        .style3
        {
            font-size: medium;
            text-decoration: underline;
            color: #0000FF;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong style="font-weight: 700; color: #0000CC">Manage Payment Information</strong></p>
    <p class="style3">
        Dear
        <asp:Label ID="UserName" runat="server"></asp:Label>
        , your default credit card information is as follows:</p>
    <p class="style3">
        <asp:GridView ID="gvCreditCard" runat="server" CellPadding="4" 
            DataSourceID="SqlDataSource1" GridLines="None" AutoGenerateColumns="False">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="cardHolderName" HeaderText="Cardholder Name" 
                    ReadOnly="True" SortExpression="cardHolderName" />
                <asp:BoundField DataField="type" HeaderText="Type" ReadOnly="True" 
                    SortExpression="type" />
                <asp:BoundField DataField="number" HeaderText="Number" ReadOnly="True" 
                    SortExpression="number" />
                <asp:BoundField DataField="expiryMonth" HeaderText="Expiry Month" 
                    SortExpression="expiryMonth" />
                <asp:BoundField DataField="expiryYear" HeaderText="Expiry Year" 
                    SortExpression="expiryYear" />
                <asp:CheckBoxField DataField="creditCardDefault" HeaderText="creditCardDefault" 
                    SortExpression="creditCardDefault" />
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
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT [cardHolderName], [type], [number], [expiryMonth], [expiryYear], [creditCardDefault] FROM [CreditCard] WHERE (([userName] = @userName) AND ([creditCardDefault] = @creditCardDefault))">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
                <asp:Parameter DefaultValue="True" Name="creditCardDefault" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style3">
        Your credit card list is as follows:</p>
    <p class="style3">
        <asp:GridView ID="gvCreditCard1" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="cardHolderName" HeaderText="cardHolderName" 
                    SortExpression="cardHolderName" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" />
                <asp:BoundField DataField="number" HeaderText="number" 
                    SortExpression="number" />
                <asp:BoundField DataField="expiryMonth" HeaderText="expiryMonth" 
                    SortExpression="expiryMonth" />
                <asp:BoundField DataField="expiryYear" HeaderText="expiryYear" 
                    SortExpression="expiryYear" />
                <asp:CheckBoxField DataField="creditCardDefault" HeaderText="creditCardDefault" 
                    SortExpression="creditCardDefault" />
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
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT [cardHolderName], [type], [number], [expiryMonth], [expiryYear], [creditCardDefault] FROM [CreditCard] WHERE (([userName] = @userName) AND ([creditCardDefault] = @creditCardDefault))">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
                <asp:Parameter DefaultValue="False" Name="creditCardDefault" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style3">
        &nbsp;</p>
    <p class="style3">
        &nbsp;</p>
</asp:Content>

