﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="FinalConfirmation.aspx.cs" Inherits="MemberOnly_FinalConfirmationPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 62%;
            margin-bottom: 3px;
        }
        .style3
        {
            width: 182px;
        }
        .style4
        {
            width: 310px;
        }
        .style5
        {
            width: 96px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; color: #000080; font-weight: bold;">
        Final Order Confirmation</p>
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: medium; color: #000080;">
        Dear
        <asp:Label ID="userName" runat="server"></asp:Label>
        , following is the detail of your order, please confirm or change the incorret 
        information:</p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        The item you purchased:</p>
    <p>
        <asp:GridView ID="itemPurchase" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebDataSource" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="name" HeaderText="Item Name" SortExpression="name" />
                <asp:BoundField DataField="unitPrice" HeaderText="Unit Price" 
                    SortExpression="unitPrice" />
                <asp:BoundField DataField="quantity" HeaderText="Quantity" 
                    SortExpression="quantity" />
                <asp:BoundField DataField="product" HeaderText="Total Price" ReadOnly="True" 
                    SortExpression="product" />
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
        Total Price:<asp:Label ID="totalPrice" runat="server"></asp:Label>
    </p>
    <p>
        <asp:Button ID="shoppingCart" runat="server" 
            PostBackUrl="~/MemberOnly/ShoppingCart.aspx" Text="Back to Shopping Cart" />
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        Your deliver address:</p>
    <p>
        <asp:GridView ID="deliverAddress" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebDataSource2" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="name" HeaderText="Name" 
                    SortExpression="name" />
                <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                <asp:BoundField DataField="phoneNumber" HeaderText="Phone Number" 
                    SortExpression="phoneNumber" />
                <asp:BoundField DataField="address" HeaderText="Delivery Address" 
                    SortExpression="address" />
                <asp:BoundField DataField="deliveryDate" HeaderText="Delivery Date" 
                    SortExpression="deliveryDate" />
                <asp:BoundField DataField="deliveryTime" HeaderText="Delivery Time" 
                    SortExpression="deliveryTime" />
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
        <asp:Button ID="address" runat="server" 
            PostBackUrl="~/MemberOnly/DeliveryInformation.aspx" 
            Text="Back to Change Deliver Address" />
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        Your payment method:</p>
    <p>
&nbsp;<asp:GridView ID="paymentMethod" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebDataSource3" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="number" HeaderText="Card Number" 
                    SortExpression="number" />
                <asp:BoundField DataField="type" HeaderText="Card Type" SortExpression="type" />
                <asp:BoundField DataField="cardHolderName" HeaderText="Holder Name" 
                    SortExpression="cardHolderName" />
                <asp:BoundField DataField="expiryMonth" HeaderText="Expiry Month" 
                    SortExpression="expiryMonth" />
                <asp:BoundField DataField="expiryYear" HeaderText="Expiry Year" 
                    SortExpression="expiryYear" />
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
        <asp:Button ID="payment" runat="server" 
            PostBackUrl="~/MemberOnly/PaymentInformation.aspx" 
            Text="Back to Change Payment Method" />
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
&nbsp;<table class="style2">
            <tr>
                <td class="style3">
                    <asp:Button ID="confirm" runat="server" onclick="confirm_Click" Text="Confirm Your Order" 
                        ValidationGroup="finalConfirm" />
                </td>
                <td class="style4">
                    (The receipt will be sent to your email address:
                </td>
                <td class="style5">
                    <asp:Label ID="emailAddress" runat="server"></asp:Label>
                    )</td>
            </tr>
        </table>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following Error Occurred:" ValidationGroup="finalConfirm" />
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        <asp:SqlDataSource ID="AsiaWebDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT Item.name, OrderRecord.unitPrice, OrderRecord.quantity, OrderRecord.unitPrice * OrderRecord.quantity AS product FROM OrderRecord INNER JOIN Item ON Item.upc = OrderRecord.upc WHERE (OrderRecord.userName = @userName)">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        <asp:SqlDataSource ID="AsiaWebDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT name, email, phoneNumber, address, deliveryDate, deliveryTime FROM OrderRecord WHERE (userName = @userName) GROUP BY name, email, phoneNumber, address, deliveryDate, deliveryTime">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        <asp:SqlDataSource ID="AsiaWebDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT CreditCard.number, CreditCard.type, CreditCard.cardHolderName, CreditCard.expiryMonth, CreditCard.expiryYear FROM OrderRecord INNER JOIN CreditCard ON OrderRecord.creditCardNumber = CreditCard.number WHERE (OrderRecord.userName = @userName) GROUP BY CreditCard.number, CreditCard.type, CreditCard.cardHolderName, CreditCard.expiryMonth, CreditCard.expiryYear">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

