<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemPurchaseReport.aspx.cs" Inherits="MemberOnly_ItemPurchaseReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 96%;
        }
        .style3
        {
            width: 149px;
        }
        .style4
        {
            width: 99px;
        }
        .style6
        {
            width: 123px;
        }
        .style7
        {
            width: 31px;
        }
        .style8
        {
            width: 29px;
        }
        .style9
        {
            width: 63px;
        }
        .style10
        {
            width: 19px;
        }
        .style11
        {
        }
        .style12
        {
            width: 9px;
        }
        .style13
        {
            width: 14px;
        }
        .style14
        {
            width: 44px;
        }
        .style15
        {
            width: 12px;
        }
        .style16
        {
            font-size: x-large;
            font-family: "Times New Roman", Times, serif;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="color: #000080" class="style16">
        <strong>Item Purchase Report</strong></p>
    <table class="style2">
        <tr>
            <td class="style3">
                Item purchased by user:</td>
            <td class="style4">
                <asp:Label ID="userName" runat="server"></asp:Label>
            </td>
            <td rowspan="3" class="style6">
                <asp:RadioButtonList ID="date" runat="server" Width="115px" 
                    ValidationGroup="itemReport" Height="70px" RepeatLayout="Flow">
                    <asp:ListItem Value="certain">in certain date: <br></br></asp:ListItem>
                    <asp:ListItem Value="any" Selected="True">at any time</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="style7">
                from</td>
            <td class="style8">
                Year:</td>
            <td class="style9">
                <asp:DropDownList ID="yearFrom" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="yearFrom_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style10">
                Month:</td>
            <td class="style15">
                <asp:DropDownList ID="monthFrom" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="monthFrom_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style12">
                Day:</td>
            <td class="style13">
                <asp:DropDownList ID="dayFrom" runat="server" AutoPostBack="True" ValidationGroup="itemReport">
                </asp:DropDownList>
            </td>
            <td class="style14">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style4">
                &nbsp;</td>
            <td class="style7">
                to</td>
            <td class="style8">
                Year</td>
            <td class="style9">
                <asp:DropDownList ID="yearTo" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="yearTo_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style10">
                Month:</td>
            <td class="style15">
                <asp:DropDownList ID="monthTo" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="monthTo_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style12">
                Day:</td>
            <td class="style13">
                <asp:DropDownList ID="dayTo" runat="server" AutoPostBack="True" ValidationGroup="itemReport">
                </asp:DropDownList>
            </td>
            <td class="style14">
                <asp:CustomValidator ID="CustomValidator2" runat="server" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Invalid date range." ForeColor="Red" 
                    ValidationGroup="itemReport" 
                    onservervalidate="CustomValidator2_ServerValidate">*</asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style4">
                &nbsp;</td>
            <td class="style7">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="date" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="You need to select a time range." ForeColor="Red" 
                    ValidationGroup="itemReport">*</asp:RequiredFieldValidator>
            </td>
            <td class="style8">
                &nbsp;</td>
            <td class="style9">
                &nbsp;</td>
            <td class="style10">
                &nbsp;</td>
            <td class="style11" colspan="2">
                &nbsp;</td>
            <td class="style13">
                &nbsp;</td>
            <td class="style14">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style4">
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
            <td class="style11" colspan="3">
                <asp:Button ID="Button1" runat="server" Text="Generate Report" 
                    ValidationGroup="itemReport" Width="120px" onclick="Button1_Click" 
                    Height="30px" 
                    style="font-family: 'Times New Roman', Times, serif; font-size: medium" />
            </td>
            <td class="style14">
                &nbsp;</td>
        </tr>
        </table>
    <br />
    <asp:Label ID="result" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="Red"></asp:Label>
    <br />
    <asp:GridView ID="report" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None" AutoGenerateColumns="False" DataKeyNames="userName" 
        DataSourceID="SqlDataSource1">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="userName" HeaderText="User" ReadOnly="True" 
                SortExpression="userName" />
            <asp:BoundField DataField="category" HeaderText="Category" 
                SortExpression="category" />
            <asp:BoundField DataField="name" HeaderText="Item Name" SortExpression="name" />
            <asp:BoundField DataField="unitPrice" HeaderText="Unit Price" 
                SortExpression="unitPrice" />
            <asp:BoundField DataField="totalQuantity" HeaderText="Total Quantity" 
                ReadOnly="True" SortExpression="totalQuantity" />
            <asp:BoundField DataField="totalPrice" HeaderText="Total Price" ReadOnly="True" 
                SortExpression="totalPrice" />
            <asp:BoundField DataField="saving" HeaderText="Amount Saving" ReadOnly="True" 
                SortExpression="saving" />
            <asp:BoundField DataField="customerName" HeaderText="Name" ReadOnly="True" 
                SortExpression="customerName" />
            <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
            <asp:BoundField DataField="phoneNumber" HeaderText="Phone Number" 
                SortExpression="phoneNumber" />
            <asp:BoundField DataField="address" HeaderText="Address" 
                SortExpression="address" />
            <asp:BoundField DataField="cardnumber" HeaderText="Card Number (Last 4 digits)" ReadOnly="True" 
                SortExpression="cardnumber" />
            <asp:BoundField DataField="type" HeaderText="Type" SortExpression="type" />
            <asp:BoundField DataField="authorizationCode" HeaderText="Authorization Code" 
                SortExpression="authorizationCode" />
            <asp:BoundField DataField="orderDateTime" HeaderText="Order Time" 
                SortExpression="orderDateTime" />
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        SelectCommand="SELECT Item.name, Item.category, SUM(OrderRecord.quantity) AS totalQuantity, OrderRecord.unitPrice, SUM(OrderRecord.quantity * OrderRecord.unitPrice) AS totalPrice, SUM(OrderRecord.quantity * (Item.normalPrice - OrderRecord.unitPrice)) AS saving, Member.firstName + ' ' + Member.lastName AS customerName, OrderRecord.email, OrderRecord.phoneNumber, OrderRecord.address, '**** **** **** ' + RIGHT (CreditCard.number, 4) AS cardnumber, CreditCard.type, OrderRecord.authorizationCode, OrderRecord.orderDateTime, Member.userName FROM OrderRecord INNER JOIN Member ON OrderRecord.userName = Member.userName INNER JOIN Item ON OrderRecord.upc = Item.upc INNER JOIN CreditCard ON OrderRecord.creditCardNumber = CreditCard.number GROUP BY Item.name, Item.category, OrderRecord.unitPrice, Member.firstName, Member.lastName, OrderRecord.email, OrderRecord.phoneNumber, OrderRecord.address, CreditCard.number, CreditCard.type, OrderRecord.authorizationCode, OrderRecord.orderDateTime, Member.userName"></asp:SqlDataSource>
    <br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following error occurred:" ValidationGroup="itemReport" />
</asp:Content>

