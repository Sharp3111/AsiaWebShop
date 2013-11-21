<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="FinalConfirmation.aspx.cs" Inherits="MemberOnly_FinalConfirmationPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 76%;
            margin-bottom: 3px;
        }
        .style3
        {
            width: 182px;
        }
        .style4
        {
            width: 287px;
        }
        .style5
        {
            width: 96px;
        }
        .style6
        {
            color: #000080;
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
        The item(s) you purchased:</p>
    <p>
        <asp:GridView ID="itemPurchase" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebDataSource" ForeColor="#333333" 
            GridLines="None" Width="383px" DataKeyNames="upc">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="upc" SortExpression="upc" Visible="False">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("upc") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="upcLabel" runat="server" Text='<%# Bind("upc") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="name" HeaderText="Item Name" 
                    SortExpression="name" />
                <asp:BoundField DataField="unitPrice" HeaderText="Unit Price" 
                    SortExpression="unitPrice" />
                <asp:BoundField DataField="quantity" HeaderText="Quantity" 
                    SortExpression="quantity" />
                <asp:BoundField DataField="product" HeaderText="Total Price of Item" 
                    ReadOnly="True" SortExpression="product" />
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
        <span class="style6">Total Price:<asp:Label ID="totalPrice" runat="server"></asp:Label>
        </span>
    </p>
    <p>
        <asp:Button ID="shoppingCart" runat="server" 
            PostBackUrl="~/MemberOnly/ShoppingCart.aspx" Text="Back to Shopping Cart" 
             />
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        Your delivery address:</p>
    <p>
        <asp:GridView ID="deliverAddress" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebDataSource2" ForeColor="#333333" 
            GridLines="None" ondatabound="deliverAddress_DataBound">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="name" HeaderText="Username" 
                    SortExpression="name" />
                <asp:TemplateField HeaderText="Email" SortExpression="email">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("email") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="EmailLabel" runat="server" Text='<%# Bind("email") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="phoneNumber" HeaderText="Phone Number" 
                    SortExpression="phoneNumber" />
                <asp:BoundField DataField="address" HeaderText="Deliver Address" 
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
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
&nbsp;<asp:GridView ID="paymentMethod" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebDataSource3" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Card Number" SortExpression="number">
                    <ItemTemplate>
                        <asp:Label ID="cardNumberLabel" runat="server" Text='<%# Bind("number") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("number") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
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
                    ( The receipt will be sent to your email address:
                </td>
                <td class="style5">
                    <asp:Label ID="emailAddress" runat="server"></asp:Label>
                    &nbsp;)</td>
            </tr>
        </table>
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        <asp:SqlDataSource ID="AsiaWebDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            
            SelectCommand="SELECT Item.upc, Item.name, OrderRecord.unitPrice, OrderRecord.quantity, OrderRecord.unitPrice * OrderRecord.quantity AS product FROM OrderRecord INNER JOIN Item ON Item.upc = OrderRecord.upc WHERE (OrderRecord.userName = @userName) AND (OrderRecord.isConfirmed = 'False')">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        <asp:SqlDataSource ID="AsiaWebDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            
            SelectCommand="SELECT name, email, phoneNumber, address, deliveryDate, deliveryTime FROM OrderRecord WHERE (userName = @userName) AND (isConfirmed = 'False') GROUP BY name, email, phoneNumber, address, deliveryDate, deliveryTime">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        <asp:SqlDataSource ID="AsiaWebDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            
            
            SelectCommand="SELECT CreditCard.number, CreditCard.type, CreditCard.cardHolderName, CreditCard.expiryMonth, CreditCard.expiryYear FROM OrderRecord INNER JOIN CreditCard ON OrderRecord.creditCardNumber = CreditCard.number WHERE (OrderRecord.userName = @userName AND OrderRecord.isConfirmed = 'False') GROUP BY CreditCard.number, CreditCard.type, CreditCard.cardHolderName, CreditCard.expiryMonth, CreditCard.expiryYear">
            <SelectParameters>
                <asp:ControlParameter ControlID="userName" Name="userName" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

