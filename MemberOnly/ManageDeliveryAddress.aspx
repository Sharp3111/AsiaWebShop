<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ManageDeliveryAddress.aspx.cs" Inherits="MemberOnly_DeliveryAddressManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">

        .style5
        {
            color: #000080;
        }
        .style6
        {
            font-size: large;
            text-decoration: underline;
            text-transform: uppercase;
        }
        .style7
        {
            font-size: medium;
            text-decoration: underline;
            color: #0000FF;
        }
        .style8
        {
            font-size: medium;
            text-decoration: underline;
            color: #000080;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style6">
        <strong style="font-weight: 700; " class="style5">Manage Delivery Information</strong></p>
    <p class="style8">
        Dear
        <asp:Label ID="UserName" runat="server"></asp:Label>
        , your delivery information is as follows:</p>
    <p class="style7">
        <asp:GridView ID="gvDelivery" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="nickname" DataSourceID="SqlDataSource1" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="nickname" HeaderText="nickname" 
                    SortExpression="nickname" />
                <asp:BoundField DataField="district" HeaderText="district" 
                    SortExpression="district" />
                <asp:BoundField DataField="streetAddress" HeaderText="streetAddress" 
                    SortExpression="streetAddress" />
                <asp:BoundField DataField="blockTower" HeaderText="blockTower" 
                    SortExpression="blockTower" />
                <asp:BoundField DataField="flatSuite" HeaderText="flatSuite" 
                    SortExpression="flatSuite" />
                <asp:BoundField DataField="floor" HeaderText="floor" SortExpression="floor" />
                <asp:BoundField DataField="building" HeaderText="building" 
                    SortExpression="building" />
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
    <p class="style7">
        <asp:DetailsView ID="dvDelivery" runat="server" AutoGenerateRows="False" 
            CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" 
            GridLines="None" Height="50px">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    SortExpression="userName" ReadOnly="True" />
                <asp:TemplateField HeaderText="building" SortExpression="building">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="17" 
                            Text='<%# Bind("building") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" MaxLength="17" 
                            Text='<%# Bind("building") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("building") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="floor" SortExpression="floor">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="3" 
                            Text='<%# Bind("floor") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" MaxLength="3" 
                            Text='<%# Bind("floor") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("floor") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="flatSuite" SortExpression="flatSuite">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" MaxLength="5" 
                            Text='<%# Bind("flatSuite") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" MaxLength="5" 
                            Text='<%# Bind("flatSuite") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("flatSuite") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="blockTower" SortExpression="blockTower">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" MaxLength="2" 
                            Text='<%# Bind("blockTower") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" MaxLength="2" 
                            Text='<%# Bind("blockTower") %>'></asp:TextBox>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("blockTower") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="streetAddress" SortExpression="streetAddress">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" MaxLength="30" 
                            Text='<%# Bind("streetAddress") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditStreet" runat="server" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Street is required." 
                            ForeColor="Red" ControlToValidate="TextBox5">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" MaxLength="30" 
                            Text='<%# Bind("streetAddress") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertStreet" runat="server" 
                            Display="Dynamic" EnableClientScript="False" ErrorMessage="Street is required." 
                            ForeColor="Red" ControlToValidate="TextBox5">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("streetAddress") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="district" SortExpression="district">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditDistrict" runat="server" Text='<%# Bind("district") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditDistrict" runat="server" 
                            Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="District is required." ForeColor="Red" 
                            ControlToValidate="EditDistrict">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditDistrict" runat="server" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="You have to choose from the following: Central and Western, Eastern, Islands, Kowloon City, Kwai Tsing, Kwun Tong, North, Sai Kung, Sha Tin, Sham Shui Po, Southern, Tai Po, Tsuen Wan, Tuen Mun, Wan Chai, Wong Tai Sin, Yau Tsim Mong, Yuen Long." ForeColor="Red" 
                            onservervalidate="cvEditDistrict_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertDistrict" runat="server" Text='<%# Bind("district") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertDistrict" runat="server" 
                            Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="District is required." ForeColor="Red" 
                            ControlToValidate="InsertDistrict">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertDistrict" runat="server" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="You have to choose from the following: Central and Western, Eastern, Islands, Kowloon City, Kwai Tsing, Kwun Tong, North, Sai Kung, Sha Tin, Sham Shui Po, Southern, Tai Po, Tsuen Wan, Tuen Mun, Wan Chai, Wong Tai Sin, Yau Tsim Mong, Yuen Long." 
                            ForeColor="Red" onservervalidate="cvInsertDistrict_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("district") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="nickname" SortExpression="nickname">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditNickname" runat="server" Text='<%# Bind("nickname") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditNickname" runat="server" 
                            ControlToValidate="EditNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="NickName is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditNickname" runat="server" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Nickname already exists." 
                            ForeColor="Red" onservervalidate="cvEditNickname_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertNickname" runat="server" Text='<%# Bind("nickname") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertNickname" runat="server" 
                            ControlToValidate="InsertNickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertNickname" runat="server" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Nickname already exists." 
                            ForeColor="Red" onservervalidate="cvInsertNickname_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("nickname") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following errors occur:" />
    <p>
    </p>
    <p class="style7">
        <asp:Button ID="Return" runat="server" BackColor="Silver" BorderColor="Silver" 
            BorderStyle="Solid" Height="30px" 
            PostBackUrl="~/MemberOnly/EditMemberInformation.aspx" 
            Text="Return to Manage Member Information" Width="300px" />
    </p>
    <p class="style7">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT [nickname], [district], [streetAddress], [blockTower], [flatSuite], [floor], [building] FROM [Address] WHERE ([userName] = @userName)">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style7">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            DeleteCommand="DELETE FROM [Address] WHERE ([userName] = @userName AND [nickname] = @nickname)" 
            InsertCommand="INSERT INTO [Address] ([userName], [building], [floor], [flatSuite], [blockTower], [streetAddress], [district], [nickname]) VALUES (@userName, @building, @floor, @flatSuite, @blockTower, @streetAddress, @district, @nickname)" 
            SelectCommand="SELECT * FROM [Address] WHERE (([userName] = @userName) AND ([nickname] = @nickname))" 
            
            UpdateCommand="UPDATE [Address] SET [building] = @building, [floor] = @floor, [flatSuite] = @flatSuite, [blockTower] = @blockTower, [streetAddress] = @streetAddress, [district] = @district, [nickname] = @nickname WHERE ([userName] = @userName AND [nickname] = @nickname)">
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
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
                <asp:ControlParameter ControlID="gvDelivery" Name="nickname" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="building" />
                <asp:Parameter Name="floor" />
                <asp:Parameter Name="flatSuite" />
                <asp:Parameter Name="blockTower" />
                <asp:Parameter Name="streetAddress" />
                <asp:Parameter Name="district" />
                <asp:Parameter Name="nickname" />
                <asp:Parameter Name="userName" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

