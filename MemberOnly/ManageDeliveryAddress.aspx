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
                    SortExpression="userName" />
                <asp:BoundField DataField="building" HeaderText="building" 
                    SortExpression="building" />
                <asp:BoundField DataField="floor" HeaderText="floor" SortExpression="floor" />
                <asp:BoundField DataField="flatSuite" HeaderText="flatSuite" 
                    SortExpression="flatSuite" />
                <asp:BoundField DataField="blockTower" HeaderText="blockTower" 
                    SortExpression="blockTower" />
                <asp:BoundField DataField="streetAddress" HeaderText="streetAddress" 
                    SortExpression="streetAddress" />
                <asp:BoundField DataField="district" HeaderText="district" 
                    SortExpression="district" />
                <asp:BoundField DataField="nickname" HeaderText="nickname" 
                    SortExpression="nickname" />
                <asp:CommandField ShowEditButton="True" ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
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
            DeleteCommand="DELETE FROM [Address] WHERE ([nickname] = @nickname)" 
            InsertCommand="INSERT INTO [Address] ([userName], [building], [floor], [flatSuite], [blockTower], [streetAddress], [district], [nickname]) VALUES (@userName, @building, @floor, @flatSuite, @blockTower, @streetAddress, @district, @nickname)" 
            SelectCommand="SELECT * FROM [Address] WHERE (([userName] = @userName) AND ([nickname] = @nickname))" 
            UpdateCommand="UPDATE [Address] SET [building] = @building, [floor] = @floor, [flatSuite] = @flatSuite, [blockTower] = @blockTower, [streetAddress] = @streetAddress, [district] = @district, [nickname] = @nickname WHERE ([userName] = @userName AND [nickname] = @nickname)">
            <DeleteParameters>
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

