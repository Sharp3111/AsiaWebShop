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
            font-size: large;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style3">
        shopping cart</p>
    <p class="style2">
        <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
&nbsp;<asp:HyperLink ID="ShopAround" runat="server" ForeColor="#FF9900" 
            NavigateUrl="~/ItemSearch.aspx" style="text-decoration: underline">Go shopping around</asp:HyperLink>
    </p>
    <p class="style2">
        <asp:GridView ID="gvShoppingCart" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="Delete">
                    <ItemTemplate>
                        <asp:Button ID="deleteButton" runat="server" BackColor="Silver" 
                            BorderColor="Silver" BorderStyle="Solid" CausesValidation="false" 
                            CommandName="Delete" Height="30px" onclick="deleteButton_Click" Text="Delete" 
                            Width="60px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="NameLabel" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Unit Purchase Price" 
                    SortExpression="discountPrice">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("discountPrice") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="UnitPurchasePriceLabel" runat="server" 
                            Text='<%# Bind("discountPrice") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity" SortExpression="quantity">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("quantity") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="QuantityTextBox" runat="server"  
                            ValidationGroup="ShoppingCartValidation" MaxLength="10" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" 
                            ErrorMessage="Quantity is required." ControlToValidate="QuantityTextBox" 
                            Display="Dynamic" EnableClientScript="False" ForeColor="Red" 
                            ValidationGroup="ShoppingCartValidation">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revQuantity" runat="server" 
                            ErrorMessage="Quantity can only be nonnegative integer." 
                            ControlToValidate="QuantityTextBox" Display="Dynamic" 
                            EnableClientScript="False" ForeColor="Red" 
                            ValidationExpression="^[1-9]([0-9]+)?" 
                            ValidationGroup="ShoppingCartValidation">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvQuantity" runat="server" 
                            ControlToValidate="QuantityTextBox" Display="Dynamic" 
                            EnableClientScript="False" ForeColor="Red" 
                            onservervalidate="cvQuantity_ServerValidate" 
                            ErrorMessage="Quantity must range from 1 to max quantity available" 
                            ValidationGroup="ShoppingCartValidation">*</asp:CustomValidator>
                        <br />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Max Quantity Available" 
                    SortExpression="quantityAvailable">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("quantityAvailable") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="MaxQuantityAvailableLabel" runat="server" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Total Price Of Each Item" 
                    SortExpression="TotalPriceOfEachItem">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" 
                            Text='<%# Eval("TotalPriceOfEachItem") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="TotalPriceOfEachItemLabel" runat="server" 
                            Text='<%# Bind("TotalPriceOfEachItem") %>'></asp:Label>
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
        &nbsp;</p>
    <p class="style2">
        <asp:Button ID="Next" runat="server" Text="Next: Specify Delivery Information" 
            ValidationGroup="ShoppingCartValidation" onclick="Next_Click" 
            BackColor="Silver" BorderColor="Silver" BorderStyle="Solid" />
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" 
        ValidationGroup="ShoppingCartValidation" />
    <p>
    </p>
    <p class="style2">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT Item.name, Item.discountPrice, ShoppingCart.quantity, Item.quantityAvailable, Item.discountPrice * ShoppingCart.quantity AS TotalPriceOfEachItem FROM Item INNER JOIN ShoppingCart ON Item.upc = ShoppingCart.upc">
        </asp:SqlDataSource>
    </p>
</asp:Content>

