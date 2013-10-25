﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="ItemManagement.aspx.cs" Inherits="ItemManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080; text-decoration: underline">
        ITEM MANAGEMENT</p>
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080; text-decoration: underline">
        <asp:GridView ID="gvItem" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="upc" DataSourceID="AsiaWebShopDBSqlDataSource1" 
            ForeColor="#333333" GridLines="None" 
            >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="upc" HeaderText="UPC" ReadOnly="True" 
                    SortExpression="upc" />
                <asp:BoundField DataField="category" HeaderText="Category" 
                    SortExpression="category" />
                <asp:BoundField DataField="name" HeaderText="Item Name" SortExpression="name" />
                <asp:BoundField DataField="description" HeaderText="Item Description" 
                    SortExpression="description" />
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
                <asp:BoundField DataField="quantityAvailable" HeaderText="QuantityAvailable" 
                    SortExpression="quantityAvailable" />
                <asp:CheckBoxField DataField="visible" HeaderText="Visible" 
                    SortExpression="visible" />
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
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080; text-decoration: underline">
        <asp:DetailsView ID="dvItem" runat="server" AutoGenerateRows="False" 
            DataKeyNames="upc" DataSourceID="AsiaWebShopDBSqlDataSource2" Height="50px" 
            Width="629px"
            OnItemInserted="dvItem_ItemInserted"
            OnItemUpdated="dvItem_ItemUpdated"
            OnItemDeleted="dvItem_ItemDeleted"
            >
            <Fields>
                <asp:TemplateField HeaderText="UPC" SortExpression="upc">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("upc") %>'></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertUPC" runat="server" MaxLength="12" 
                            Text='<%# Bind("upc") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertUPC" runat="server" 
                            ControlToValidate="InsertUPC" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="UPC is required." Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertUPC" runat="server" 
                            ControlToValidate="InsertUPC" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="UPC must be exactly 12 digits" Font-Underline="False" ForeColor="Red" 
                            ValidationExpression="^\d{12}">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvInsertUPC" runat="server" 
                            ControlToValidate="InsertUPC" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="UPC already exists." Font-Underline="False" ForeColor="Red" 
                            onservervalidate="cvInsertUPC_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("upc") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Category" SortExpression="category">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditCategory" runat="server" MaxLength="25" 
                            Text='<%# Bind("category") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditCategory" runat="server" 
                            ControlToValidate="EditCategory" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Category is required." Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditCategory" runat="server" 
                            ControlToValidate="EditCategory" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Only 8 categories &quot;Appliances&quot;,&quot;Jewelry and Watches&quot;,&quot;Toys and Games&quot;,&quot;Baby and Children&quot;,&quot;Luggage&quot;,&quot;Women&quot;,&quot;Men&quot;,&quot;Computers and Electronics&quot; are allowed." 
                            Font-Underline="False" ForeColor="Red" 
                            onservervalidate="cvEditCategory_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertCategory" runat="server" MaxLength="25" 
                            Text='<%# Bind("category") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertCategory" runat="server" 
                            ControlToValidate="InsertCategory" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Category is required." Font-Underline="False" 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertCategory" runat="server" 
                            ControlToValidate="InsertCategory" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Only 8 categories &quot;Appliances&quot;,&quot;Jewelry and Watches&quot;,&quot;Toys and Games&quot;,&quot;Baby and Children&quot;,&quot;Luggage&quot;,&quot;Women&quot;,&quot;Men&quot;,&quot;Computers and Electronics&quot; are allowed." 
                            Font-Underline="False" ForeColor="Red" 
                            onservervalidate="cvInsertCategory_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("category") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Name" SortExpression="name">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditName" runat="server" MaxLength="50" 
                            Text='<%# Bind("name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditName" runat="server" 
                            ControlToValidate="EditName" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Name is required." Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertName" runat="server" MaxLength="50" 
                            Text='<%# Bind("name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertName" runat="server" 
                            ControlToValidate="InsertName" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Name is required." Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Description" SortExpression="description">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditDescription" runat="server" MaxLength="2500" 
                            Text='<%# Bind("description") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditDescription" runat="server" 
                            ControlToValidate="EditDescription" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Description is required." 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertDescription" runat="server" MaxLength="2500" 
                            Text='<%# Bind("description") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertDescription" runat="server" 
                            ControlToValidate="InsertDescription" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Description is required." 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("description") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               <asp:TemplateField HeaderText="Picture" SortExpression="Picture">
                    <EditItemTemplate>
                        <asp:FileUpload ID="pictureFileUpload" runat="server" FileBytes='<%# Bind("Picture") %>'></asp:FileUpload>
                        <asp:CustomValidator ID="cvEditPicture" runat="server" 
                            ControlToValidate="pictureFileUpload" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="the picture must be in jpg format and can be at most 512KB." 
                            Font-Underline="False" ForeColor="Red" 
                            onservervalidate="cvEditPicture_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:FileUpload ID="pictureFileUpload" runat="server" FileBytes='<%# Bind("Picture") %>'></asp:FileUpload>
                        <asp:CustomValidator ID="cvInsertPicture" runat="server" 
                            ControlToValidate="pictureFileUpload" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="the picture must be in jpg format and can be at most 512KB." 
                            Font-Underline="False" ForeColor="Red" 
                            onservervalidate="cvInsertPicture_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("Picture") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="NormalPrice" SortExpression="normalPrice">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditNormalPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("normalPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditNormalPrice" runat="server" 
                            ControlToValidate="EditNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price is required." 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEditNormalPrice" runat="server" 
                            ControlToValidate="EditNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price should be money values." 
                            Font-Underline="False" ForeColor="Red" 
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertNormalPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("normalPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertNormalPrice" runat="server" 
                            ControlToValidate="InsertNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price is required." 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertNomalPrice" runat="server" 
                            ControlToValidate="InsertNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price should be money values." 
                            Font-Underline="False" ForeColor="Red" 
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("normalPrice") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DiscountPrice" SortExpression="discountPrice">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditDiscountPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("discountPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditDiscountPrice" runat="server" 
                            ControlToValidate="EditDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Discount Price is required." 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEditDiscountPrice" runat="server" 
                            ControlToValidate="EditDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Discount Price should be money values." 
                            Font-Underline="False" ForeColor="Red" 
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertDiscountPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("discountPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertDiscountPrice" runat="server" 
                            ControlToValidate="InsertDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="RequiredFieldValidator" 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertDiscountPrice" runat="server" 
                            ControlToValidate="InsertDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Discount Price should be money values." 
                            Font-Underline="False" ForeColor="Red" 
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("discountPrice") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="QuantityAvailable" 
                    SortExpression="quantityAvailable">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditQuantityAvailable" runat="server" MaxLength="4" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditQuantityAvailable" runat="server" 
                            ControlToValidate="EditQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Quantity Available is required." 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEditQuantityAvailable" runat="server" 
                            ControlToValidate="EditQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Quantity Available should be only integer digits." 
                            Font-Underline="False" ForeColor="Red" ValidationExpression="\d+">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertQuantityAvailable" runat="server" MaxLength="4" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertQuantityAvailable" runat="server" 
                            ControlToValidate="InsertQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Quantity Available is required." 
                            Font-Underline="False" ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertQuantityAvailable" runat="server" 
                            ControlToValidate="InsertQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Quantity Available should be only integer digits." 
                            Font-Underline="False" ForeColor="Red" ValidationExpression="\d+">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("quantityAvailable") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CheckBoxField DataField="visible" HeaderText="Visible" 
                    SortExpression="visible" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" 
                    ShowInsertButton="True" />
            </Fields>
        </asp:DetailsView>
    </p>
    <asp:ValidationSummary ID="svItem" runat="server" EnableClientScript="False" 
        Font-Underline="False" ForeColor="Red" 
        HeaderText="The following errors occurred:" />
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080; text-decoration: underline">
        <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM [Item]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            DeleteCommand="DELETE FROM [Item] WHERE [upc] = @upc" 
            InsertCommand="INSERT INTO [Item] ([upc], [category], [name], [description], [picture], [normalPrice], [discountPrice], [quantityAvailable], [visible]) VALUES (@upc, @category, @name, @description, @picture, @normalPrice, @discountPrice, @quantityAvailable, @visible)" 
            SelectCommand="SELECT * FROM [Item] WHERE ([upc] = @upc)" 
            UpdateCommand="UPDATE [Item] SET [category] = @category, [name] = @name, [description] = @description, [picture] = @picture, [normalPrice] = @normalPrice, [discountPrice] = @discountPrice, [quantityAvailable] = @quantityAvailable, [visible] = @visible WHERE [upc] = @upc">
            <DeleteParameters>
                <asp:Parameter Name="upc" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="upc" Type="String" />
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="picture" />
                <asp:Parameter Name="normalPrice" Type="Decimal" />
                <asp:Parameter Name="discountPrice" Type="Decimal" />
                <asp:Parameter Name="quantityAvailable" Type="Int32" />
                <asp:Parameter Name="visible" Type="Boolean" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="gvItem" Name="upc" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="category" Type="String" />
                <asp:Parameter Name="name" Type="String" />
                <asp:Parameter Name="description" Type="String" />
                <asp:Parameter Name="picture"/>
                <asp:Parameter Name="normalPrice" Type="Decimal" />
                <asp:Parameter Name="discountPrice" Type="Decimal" />
                <asp:Parameter Name="quantityAvailable" Type="Int32" />
                <asp:Parameter Name="visible" Type="Boolean" />
                <asp:Parameter Name="upc" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>
