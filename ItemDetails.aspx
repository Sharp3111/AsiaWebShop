<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemDetails.aspx.cs" Inherits="ItemDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            color: #000080;
        }
        .style3
        {
            color: #000000;
        }
        .style4
        {
            font-size: large;
            color: #000080;
            text-transform: uppercase;
            font-weight: bold;
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; text-decoration: underline; font-size: large; font-weight: bold; color: #000080">
        ITEM INFORMATION</p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        ValidationGroup="QuantityValidationGroup" />
    <asp:Label ID="lblSearchResultMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    <p>
        <asp:DetailsView ID="dvItemDetails" runat="server" AutoGenerateRows="False" 
            CellPadding="4" DataKeyNames="upc" DataSourceID="AsiaWebShopDBSqlDataSource" 
            ForeColor="#333333" GridLines="None" Height="50px" Width="419px" 
            ondatabound="dvItemDetails_DataBound">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:TemplateField HeaderText="upc" SortExpression="upc" Visible="False">
                    <EditItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("upc") %>'></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("upc") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="upcLabel" runat="server" Text='<%# Bind("upc") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="category" HeaderText="Category" 
                    SortExpression="category" />
                <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                <asp:BoundField DataField="description" HeaderText="Description" 
                    SortExpression="description" />
                <asp:TemplateField HeaderText="Picture">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("upc") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("upc") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Height="60px" 
                            ImageUrl='<%# Eval("upc", "GetDBImage.ashx?upc={0}") %>' Width="60px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="normalPrice" HeaderText="NormalPrice" 
                    SortExpression="normalPrice" />
                <asp:BoundField DataField="discountPrice" HeaderText="DiscountPrice" 
                    SortExpression="discountPrice" />
                <asp:TemplateField HeaderText="QuantityAvailable" 
                    SortExpression="quantityAvailable">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="quantityAvailableLabel" runat="server" 
                            Text='<%# Bind("quantityAvailable") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quantity">
                    <ItemTemplate>
                        <asp:TextBox ID="tbQuantity" runat="server" Height="22px" 
                            ValidationGroup="QuantityValidationGroup" Width="30px">1</asp:TextBox>
                        <asp:RegularExpressionValidator ID="revQuantity" runat="server" 
                            ControlToValidate="tbQuantity" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Please input the correct quantity" ForeColor="Red" 
                            ValidationExpression="^[1-9]([0-9]+)?" 
                            ValidationGroup="QuantityValidationGroup">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvQuantity" runat="server" 
                            ControlToValidate="tbQuantity" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Available quantity for this item is not enough." ForeColor="Red" 
                            onservervalidate="cvQuantity_ServerValidate" 
                            ValidationGroup="QuantityValidationGroup">*</asp:CustomValidator>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btn_ShoppingCart" runat="server" Height="25px" 
                            onclick="btn_ShoppingCart_Click" Text="Add To Shopping Cart" 
                            ValidationGroup="QuantityValidationGroup" Width="150px" BackColor="Silver" 
                            BorderColor="Silver" BorderStyle="Solid" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <p>
        <asp:Label ID="UPC" runat="server" Visible="False"></asp:Label>
    </p>
    <p class="style4">
        Review information</p>
    <p>
        <span class="style3">Number of members who have reviewed this item:
        </span>
        <span class="style2"> 
        <asp:Label ID="numberOfPeople" runat="server"></asp:Label>
    </p>
        </span>
        <span class="style3">
    <p>
        Quality Aggregate Rating:&nbsp;</span><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="QualityAggregate" runat="server"></asp:Label>
    </p>
        </span>
        <span class="style3">
    <p>
        Features Aggregate Rating:</span><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="FeaturesAggregate" runat="server"></asp:Label>
    </p>
        </span>
        <span class="style3">
    <p>
        Appearance Aggregate Rating:</span><span class="style2">&nbsp;&nbsp;
        <asp:Label ID="AppearanceAggregate" runat="server"></asp:Label>
    </p>
        </span>
        <span class="style3">
    <p>
        Performance Aggregate Rating:&nbsp;
        <asp:Label ID="PerformanceAggregate" runat="server" style="color: #000080"></asp:Label>
    </p>
    <p>
        Durability Aggregate Rating:&nbsp;</span><span class="style2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="DurabilityAggregate" runat="server"></asp:Label>
        </span>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </p>
    <p>
        <asp:GridView ID="gvReview" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="AsiaWebShopDBSqlDataSource2" ForeColor="#333333" 
            GridLines="None" Width="920px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField HeaderText="User Name" SortExpression="userName" 
                    Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("userName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="userNameLabel" runat="server" Text='<%# Bind("userName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Quality Rating" SortExpression="qualityRating">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("qualityRating") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="qRatingLabel" runat="server" Text='<%# Bind("qualityRating") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Features Rating" SortExpression="featuresRating">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("featuresRating") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="fRatingLabel" runat="server" 
                            Text='<%# Bind("featuresRating") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Performance Rating" 
                    SortExpression="performanceRating">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" 
                            Text='<%# Bind("performanceRating") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="pRatingLabel" runat="server" 
                            Text='<%# Bind("performanceRating") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Appearance Rating" 
                    SortExpression="appearanceRating">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" 
                            Text='<%# Bind("appearanceRating") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="aRatingLabel" runat="server" 
                            Text='<%# Bind("appearanceRating") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Durability Rating" 
                    SortExpression="durabilityRating">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" 
                            Text='<%# Bind("durabilityRating") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="dRatingLabel" runat="server" 
                            Text='<%# Bind("durabilityRating") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Comment" SortExpression="comment">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("comment") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="commentLabel" runat="server" Text='<%# Bind("comment") %>'></asp:Label>
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
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT [upc], [category], [name], [description], [normalPrice], [picture], [discountPrice], [quantityAvailable] FROM [Item] WHERE ([upc] = @upc)">
            <SelectParameters>
                <asp:QueryStringParameter Name="upc" QueryStringField="upc" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT userName, qualityRating, featuresRating, performanceRating, appearanceRating, durabilityRating, comment, upc FROM Review WHERE (upc = @upc)">
            <SelectParameters>
                <asp:ControlParameter ControlID="UPC" Name="upc" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

