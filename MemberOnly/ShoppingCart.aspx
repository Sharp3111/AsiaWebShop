<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ShoppingCart.aspx.cs" Inherits="MemberOnly_ShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            color: #000080;
            font-weight: bold;
        }
        .style3
        {
            color: #000080;
            font-weight: bold;
            font-size: x-large;
            font-family: "Times New Roman", Times, serif;
        }
        .style4
        {
            color: #000080;
            font-weight: bold;
            text-align: right;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style3">
        Shopping Cart</p>
    <p class="style2">
        <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
&nbsp;<asp:HyperLink ID="ShopAround" runat="server" ForeColor="#FF9900" 
            NavigateUrl="~/ItemSearch.aspx" 
            style="text-decoration: underline; color: #800080; font-weight: 400;">Go Shopping Around</asp:HyperLink>
    &nbsp;.</p>
    <p class="style2">
        Dear
        <asp:Label ID="UserName" runat="server"></asp:Label>
        , items in your shopping cart are as follows:</p>
    <p class="style2">
        <asp:GridView ID="gvShoppingCart" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
            GridLines="None" Width="922px" DataKeyNames="upc">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Delete" ShowHeader="False">
                    <ItemTemplate>
                        <asp:Button ID="deleteButton" runat="server" onclick="deleteButton_Click1" 
                            Text="Delete" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Select">
                    <ItemTemplate>
                        <asp:CheckBox ID="SelectLabel" runat="server" 
                            oncheckedchanged="CheckBox3_CheckedChanged" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox2" runat="server" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Selected" Visible="False">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("isChecked") %>' />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="upc" HeaderText="upc" ReadOnly="True" 
                    SortExpression="upc" Visible="False" />
                <asp:BoundField DataField="name" HeaderText="Item Name" SortExpression="name" />
                <asp:BoundField DataField="unitPrice" HeaderText="Unit Price" 
                    SortExpression="unitPrice" />
                <asp:BoundField DataField="quantityAvailable" HeaderText="Quantity Available" 
                    SortExpression="quantityAvailable" />
                <asp:TemplateField HeaderText="Quantity" SortExpression="quantity">
                    <ItemTemplate>
                        <asp:TextBox ID="QuantityTextBox" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="QuantityTextBox" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Item Quantity Required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                            ControlToValidate="QuantityTextBox" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Quantity can only be nonnegative integer." ForeColor="Red" 
                            ValidationExpression="^[1-9]([0-9]+)?">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="CustomValidator1" runat="server" 
                            ControlToValidate="QuantityTextBox" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Quantity is not enough." 
                            ForeColor="Red" onservervalidate="CustomValidator1_ServerValidate">*</asp:CustomValidator>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("quantity") %>'></asp:TextBox>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Price" 
                    SortExpression="TotalPriceOfEachItem">
                    <ItemTemplate>
                        <asp:Label ID="TotalPriceOfEachItemLabel" runat="server" 
                            Text='<%# Bind("TotalPriceOfEachItem") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%# Eval("TotalPriceOfEachItem") %>'></asp:Label>
                    </EditItemTemplate>
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
        </p>
    <p class="style2">
        <asp:Label ID="OutOfStockMessage" runat="server" ForeColor="Red" 
            Visible="False"></asp:Label>
    </p>
    <p class="style4">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Selected Total Price:
        <asp:Label ID="SelectedPriceLabel" runat="server"></asp:Label>
        </p>
    <p class="style4">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Total Price:
        <asp:Label ID="TotalPriceLabel" runat="server"></asp:Label>
    </p>
    <p class="style2">
        <asp:Button ID="Next" runat="server" Text="Next: Specify Delivery Information" 
            ValidationGroup="ShoppingCartValidation" onclick="Next_Click" 
            Height="30px" 
            style="font-family: 'Times New Roman', Times, serif; font-size: medium" 
            Width="250px" />
    </p>
    <p class="style2">
        &nbsp;</p>
    <p class="style2">
        &nbsp;</p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" 
        ValidationGroup="ShoppingCartValidation" />
    <p>
    </p>
    <p class="style2">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            
            SelectCommand="SELECT ShoppingCart.isChecked, Item.upc, Item.name, ShoppingCart.unitPrice , ShoppingCart.quantity, Item.quantityAvailable, ShoppingCart.unitPrice * ShoppingCart.quantity AS TotalPriceOfEachItem FROM Item INNER JOIN ShoppingCart ON Item.upc = ShoppingCart.upc WHERE (ShoppingCart.userName = @userName)" 
            DeleteCommand="DELETE FROM ShoppingCart WHERE userName = ''">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" 
                    PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

