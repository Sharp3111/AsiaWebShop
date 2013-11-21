<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ManageDelivery.aspx.cs" Inherits="MemberOnly_PaymentMethodManagement" %>

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
            color: #0000FF;
        }
        .style4
        {
            font-size: medium;
            text-decoration: underline;
            color: #000080;
        }
        .style5
        {
            color: #000080;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong style="font-weight: 700; " class="style5">Manage Delivery Information</strong></p>
    <p class="style4">
        Dear
        <asp:Label ID="UserName" runat="server"></asp:Label>
        , your delivery information is as follows:</p>
    <p class="style3">
        <asp:GridView ID="gvDelivery" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" DataKeyNames = "nickname,userName"
            GridLines="None" Width="915px" onselectedindexchanged="gvDelivery_SelectedIndexChanged" 
            >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    SortExpression="userName" Visible="False" />
                <asp:TemplateField HeaderText="Nickname" SortExpression="nickname">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("nickname") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="nickname" runat="server" Text='<%# Bind("nickname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Building" SortExpression="building">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("building") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="building" runat="server" Text='<%# Bind("building") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="floor" HeaderText="Floor" SortExpression="floor" />
                <asp:BoundField DataField="flatSuite" HeaderText="Flat/Suite" 
                    SortExpression="flatSuite" />
                <asp:BoundField DataField="blockTower" HeaderText="Block/Tower" 
                    SortExpression="blockTower" />
                <asp:BoundField DataField="streetAddress" HeaderText="Street Address" 
                    SortExpression="streetAddress" />
                <asp:BoundField DataField="district" HeaderText="District" 
                    SortExpression="district" />
                <asp:CheckBoxField DataField="isSelected" HeaderText="isSelected" 
                    SortExpression="isSelected" Visible="False" />
                <asp:TemplateField HeaderText="isDefault" SortExpression="isDefault">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("isDefault") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="isDefault" runat="server" Checked='<%# Bind("isDefault") %>' 
                            Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="RemoveButton" runat="server" BackColor="Silver" 
                            BorderColor="Silver" BorderStyle="Outset" onclick="RemoveButton_Click" 
                            Text="Remove" />
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
    <p class="style3">
        <asp:DetailsView ID="dvDelivery" runat="server" AutoGenerateRows="False" 
            CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" 
            GridLines="None" Height="50px" Width="696px" 
            oniteminserted="dvDelivery_ItemInserted1" 
            oniteminserting="dvDelivery_ItemInserting" 
            onitemupdated="dvDelivery_ItemUpdated" 
            onitemupdating="dvDelivery_ItemUpdating" onload="dvDelivery_Load" 
            ondatabound="dvDelivery_DataBound">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:TemplateField HeaderText="User Name" SortExpression="userName">
                    <EditItemTemplate>
                        <asp:Label ID="EditUserName" runat="server" Text='<%# Bind("userName") %>' onload="InsertUserName_Load"></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Label ID="InsertUserName" runat="server" Text='<%# Bind("userName") %>' onload="InsertUserName_Load"></asp:Label>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("userName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Nickname" SortExpression="nickname">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditNickname" runat="server" MaxLength="10" 
                            Text='<%# Bind("nickname") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditNickname" runat="server" 
                            ControlToValidate="EditNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="NickName is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditNickname" runat="server" 
                            ControlToValidate="EditNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname already exists." ForeColor="Red" 
                            onservervalidate="cvEditNickname_ServerValidate">*</asp:CustomValidator>
                        <asp:RegularExpressionValidator ID="revEditNickname" runat="server" 
                            ControlToValidate="EditNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname must be alphanumeric only." ForeColor="Red" 
                            ValidationExpression="^[a-zA-Z0-9]+$">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertNickname" runat="server" MaxLength="10" 
                            Text='<%# Bind("nickname") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertNickname" runat="server" 
                            ControlToValidate="InsertNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertNickname" runat="server" 
                            ControlToValidate="InsertNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname already exists." ForeColor="Red" 
                            onservervalidate="cvInsertNickname_ServerValidate">*</asp:CustomValidator>
                        <asp:RegularExpressionValidator ID="revInsertNickname" runat="server" 
                            ControlToValidate="InsertNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname must be alphanumeric only." ForeColor="Red" 
                            ValidationExpression="^[a-zA-Z0-9]+$">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("nickname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Building" SortExpression="building">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="20" 
                            Text='<%# Bind("building") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="20" 
                            Text='<%# Bind("building") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("building") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Floor" SortExpression="floor">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="3" 
                            Text='<%# Bind("floor") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="3" 
                            Text='<%# Bind("floor") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("floor") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Flat/Suite" SortExpression="flatSuite">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" MaxLength="5" 
                            Text='<%# Bind("flatSuite") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" MaxLength="5" 
                            Text='<%# Bind("flatSuite") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("flatSuite") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Block/Tower" SortExpression="blockTower">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" MaxLength="2" 
                            Text='<%# Bind("blockTower") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" MaxLength="2" 
                            Text='<%# Bind("blockTower") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("blockTower") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Street Address" SortExpression="streetAddress">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" MaxLength="30" 
                            Text='<%# Bind("streetAddress") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditStreet" runat="server" 
                            ControlToValidate="TextBox5" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Street is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" MaxLength="30" 
                            Text='<%# Bind("streetAddress") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertStreet" runat="server" 
                            ControlToValidate="TextBox5" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Street is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("streetAddress") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="District" SortExpression="district">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditDistrict" runat="server" MaxLength="20" 
                            Text='<%# Bind("district") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditDistrict" runat="server" 
                            ControlToValidate="EditDistrict" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="District is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditDistrict" runat="server" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="You have to choose from the following: Central and Western, Eastern, Islands, Kowloon City, Kwai Tsing, Kwun Tong, North, Sai Kung, Sha Tin, Sham Shui Po, Southern, Tai Po, Tsuen Wan, Tuen Mun, Wan Chai, Wong Tai Sin, Yau Tsim Mong, Yuen Long." 
                            ForeColor="Red" onservervalidate="cvEditDistrict_ServerValidate" 
                            ControlToValidate="EditDistrict">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertDistrict" runat="server" MaxLength="20" 
                            Text='<%# Bind("district") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertDistrict" runat="server" 
                            ControlToValidate="InsertDistrict" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="District is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertDistrict" runat="server" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="You have to choose from the following: Central and Western, Eastern, Islands, Kowloon City, Kwai Tsing, Kwun Tong, North, Sai Kung, Sha Tin, Sham Shui Po, Southern, Tai Po, Tsuen Wan, Tuen Mun, Wan Chai, Wong Tai Sin, Yau Tsim Mong, Yuen Long." 
                            ForeColor="Red" onservervalidate="cvInsertDistrict_ServerValidate" 
                            ControlToValidate="InsertDistrict">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("district") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CheckBoxField DataField="isSelected" HeaderText="isSelected" 
                    SortExpression="isSelected" Visible="False" />
                <asp:TemplateField HeaderText="isDefault" SortExpression="isDefault" 
                    Visible="False">
                    <EditItemTemplate>
                        <asp:CheckBox ID="EditIsDefault" runat="server" 
                            Checked='<%# Bind("isDefault") %>' 
                            oncheckedchanged="EditIsDefault_CheckedChanged" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="InsertIsDefault" runat="server" 
                            Checked='<%# Bind("isDefault") %>' 
                            oncheckedchanged="InsertIsDefault_CheckedChanged" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("isDefault") %>' 
                            Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" 
                    ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" />
    <p>
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </p>
    <p>
        <asp:Button ID="Return" runat="server" BackColor="Silver" BorderColor="Silver" 
            BorderStyle="Solid" Height="30px" 
            PostBackUrl="~/MemberOnly/EditMemberInformation.aspx" 
            Text="Return to Manage Member Information" Width="300px" 
             />
    </p>
    <p>
        &nbsp;</p>
    <p class="style3">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT * FROM [Address] WHERE ([userName] = @userName) ORDER BY [nickname]">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style3">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT * FROM [Address] WHERE ([userName] = @userName AND [nickname] = @nickname)" 
            DeleteCommand="DELETE FROM [Address] WHERE ([userName] = @userName AND [nickname] = @nickname)" 
            InsertCommand="INSERT INTO [Address] ([userName], [building], [floor], [flatSuite], [blockTower], [streetAddress], [district], [nickname]) VALUES (@userName, @building, @floor, @flatSuite, @blockTower, @streetAddress, @district, @nickname)" 
            
            
            
            
            
            UpdateCommand="UPDATE Address SET building = @building, floor = @floor, flatSuite = @flatSuite, blockTower = @blockTower, streetAddress = @streetAddress, district = @district WHERE (userName = @userName) AND (isSelected = 'true')">
            <DeleteParameters>
                <asp:Parameter Name="userName" />
                <asp:Parameter Name="nickname" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userName" />
                <asp:Parameter Name="building" />
                <asp:Parameter Name="floor" />
                <asp:Parameter Name="flatSuite" />
                <asp:Parameter Name="blockTower" />
                <asp:Parameter Name="streetAddress" />
                <asp:Parameter Name="district" />
                <asp:Parameter Name="nickname" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" 
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="gvDelivery" Name="nickname" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="building" />
                <asp:Parameter Name="floor" />
                <asp:Parameter Name="flatSuite" />
                <asp:Parameter Name="blockTower" />
                <asp:Parameter Name="streetAddress" />
                <asp:Parameter Name="district" />
                <asp:Parameter Name="userName" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style3">
        &nbsp;</p>
</asp:Content>

