<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="ItemManagement.aspx.cs" Inherits="ItemManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: large;
            color: #000080;
            font-weight: bold;
            text-decoration: underline;
            text-align: left;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        ITEM MANAGEMENT</p>
    <p>
        <asp:GridView ID="gvItem" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="upc" DataSourceID="AsiaWebShopDBSqlDataSource1" 
            ForeColor="#333333" GridLines="None" AllowPaging="True" PageSize="5" 
            AllowSorting="True" style="text-align: left">
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
                <asp:BoundField DataField="normalPrice" HeaderText="Normal Price" 
                    SortExpression="normalPrice" />
                <asp:BoundField DataField="discountPrice" HeaderText="Discount Price" 
                    SortExpression="discountPrice" />
                <asp:BoundField DataField="quantityAvailable" HeaderText="Quantity Available" 
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
    <p>
        <asp:DetailsView ID="dvItem" 
            runat="server" Height="50px" Width="916px" 
            AutoGenerateRows="False" CellPadding="4" DataKeyNames="upc" 
            DataSourceID="AsiaWebShopDBSqlDataSource2" ForeColor="#333333" 
            GridLines="None"
            OnItemInserted="dvItem_ItemInserted"
            OnItemUpdated="dvItem_ItemUpdated"
            OnItemDeleted="dvItem_ItemDeleted" style="text-align: left">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
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
                            ErrorMessage="UPC is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertUPC" runat="server" 
                            ControlToValidate="InsertUPC" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="UPC must be exactly 12 digits." ForeColor="Red" 
                            ValidationExpression="^\d{12}$">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvInsertUPC" runat="server" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="UPC already exists." ForeColor="Red" 
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
                            ErrorMessage="Category is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditCategory" runat="server" 
                            ControlToValidate="EditCategory" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Please select from the following 8 categories: (case-sensitive)
Appliances; 
Baby and Children; 
Computers and Electronics; 
Jewelry and Watches; 
Luggage; 
Men; 
Toys and Games; 
Women." ForeColor="Red" onservervalidate="cvEditCategory_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertCategory" runat="server" MaxLength="25" 
                            Text='<%# Bind("category") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertCategory" runat="server" 
                            ControlToValidate="InsertCategory" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Category is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertCategory" runat="server" 
                            ControlToValidate="InsertCategory" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Please select from the following 8 categories: (case-sensitive)
Appliances; 
Baby and Children; 
Computers and Electronics; 
Jewelry and Watches; 
Luggage; 
Men; 
Toys and Games; 
Women." ForeColor="Red" onservervalidate="cvInsertCategory_ServerValidate">*</asp:CustomValidator>
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
                            ControlToValidate="EditName" Display="Dynamic" ErrorMessage="Name is required." 
                            ForeColor="Red" EnableClientScript="False">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertName" runat="server" MaxLength="50" 
                            Text='<%# Bind("name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertName" runat="server" 
                            ControlToValidate="InsertName" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Name is required." ForeColor="Red">*</asp:RequiredFieldValidator>
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
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertDescription" runat="server" MaxLength="2500" 
                            Text='<%# Bind("description") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertDescription" runat="server" 
                            ControlToValidate="InsertDescription" ErrorMessage="Description is required." 
                            ForeColor="Red" Display="Dynamic" EnableClientScript="False">*</asp:RequiredFieldValidator>
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
                            EnableClientScript="False" ErrorMessage="The picture must be in jpg format and can be at most 512KB. 
" ForeColor="Red" onservervalidate="cvEditPicture_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:FileUpload ID="pictureFileUpload" runat="server" FileBytes='<%# Bind("Picture") %>'></asp:FileUpload>
                        <asp:CustomValidator ID="cvInsertPicture" runat="server" 
                            ControlToValidate="pictureFileUpload" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="The picture must be in jpg format and can be at most 512KB. 
" ForeColor="Red" onservervalidate="cvInsertPicture_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image2" runat="server" 
                            DescriptionUrl="~/App_Data/AsiaWebShopDB.mdf" Height="60px" 
                            ImageUrl='<%# Eval("upc", "GetDBImage.ashx?upc={0}") %>' Width="60px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Normal Price" SortExpression="normalPrice">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditNormalPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("normalPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditNormalPrice" runat="server" 
                            ControlToValidate="EditNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEditNormalPrice" runat="server" 
                            ControlToValidate="EditNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price should be positive money values." 
                            ForeColor="Red" 
                            
                            
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertNormalPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("normalPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertNormalPrice" runat="server" 
                            ControlToValidate="InsertNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertNormalPrice" runat="server" 
                            ControlToValidate="InsertNormalPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Normal Price should be positive money values." 
                            ForeColor="Red" 
                            
                            
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("normalPrice") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Discount Price" SortExpression="discountPrice">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditDiscountPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("discountPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditDiscountPrice" runat="server" 
                            ControlToValidate="EditDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Discount Price is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEditDiscountPrice" runat="server" 
                            ControlToValidate="EditDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Discount Price should be positve money values." 
                            ForeColor="Red" 
                            
                            
                            
                            
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertDiscountPrice" runat="server" MaxLength="12" 
                            Text='<%# Bind("discountPrice") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertDiscountPrice" runat="server" 
                            ControlToValidate="InsertDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Discount Price is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertDiscountPrice" runat="server" 
                            ControlToValidate="InsertDiscountPrice" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Discount Price should be positive money values." 
                            ForeColor="Red" 
                            
                            
                            
                            
                            ValidationExpression="^([1-9]{1}[\d]{0,2}(\,[\d]{3})*(\.[\d]{0,2})?|[1-9]{1}[\d]{0,}(\.[\d]{0,2})?|0(\.[\d]{0,2})?|(\.[\d]{1,2})?)$">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("discountPrice") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity Available" 
                    SortExpression="quantityAvailable">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditQuantityAvailable" runat="server" MaxLength="4" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditQuantityAvailable" runat="server" 
                            ControlToValidate="EditQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Quantity Available is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertQuantityAvailable" runat="server" 
                            ControlToValidate="EditQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Quantity Available should only be a nonnegative integer." ForeColor="Red" 
                            
                            
                            
                            ValidationExpression="\d{1,4}">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertQuantityAvailable" runat="server" MaxLength="4" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertQuantityAvailable" runat="server" 
                            ControlToValidate="InsertQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Quantity Available is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertQuantityAvailable" runat="server" 
                            ControlToValidate="InsertQuantityAvailable" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Quantity Available should only be a nonnegative integer." ForeColor="Red" 
                            
                            
                            
                            ValidationExpression="\d{1,4}">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("quantityAvailable") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CheckBoxField DataField="visible" HeaderText="visible" 
                    SortExpression="visible" />
                <asp:CommandField ShowEditButton="True" 
                    ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <p>
        <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM [Item]"></asp:SqlDataSource>
    </p>
    <p>
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
                <asp:Parameter Name="picture" />
                <asp:Parameter Name="normalPrice" Type="Decimal" />
                <asp:Parameter Name="discountPrice" Type="Decimal" />
                <asp:Parameter Name="quantityAvailable" Type="Int32" />
                <asp:Parameter Name="visible" Type="Boolean" />
                <asp:Parameter Name="upc" Type="String" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <asp:ValidationSummary ID="vs" runat="server" EnableClientScript="False" 
        ForeColor="Red" HeaderText="The following errors occurred:" />
</asp:Content>

