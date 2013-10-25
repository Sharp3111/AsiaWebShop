<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="MemberSearch.aspx.cs" Inherits="ItemSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style3
        {
            color: #000080;
            text-decoration: underline;
            font-size: large;
        }
        .style4
        {
            width: 38%;
        }
        .style6
        {
            width: 143px;
        }
        .style11
    {
        width: 140px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h2 class="style3">
        <strong style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; text-decoration: underline;">
        MEMBER MANAGEMENT</strong></h2>
    <table class="style4">
        <tr>
            <td class="style11">
                Search user:</td>
            <td class="style6">
                <asp:TextBox ID="txtSearchString" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style11">
                <asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" 
                    Text="Search" />
            </td>
            <td class="style6">
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <br />
    <asp:Label ID="lblSearchResultMessage" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    <br />
    <br />
    <asp:GridView ID="gvItemSearchResult" runat="server" 
        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="userName" 
        DataSourceID="AsiaWebShopDBSqlDataSource" ForeColor="#333333" 
        GridLines="None" Width="765px">
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
        <Columns>
            <asp:BoundField DataField="userName" HeaderText="User name" ReadOnly="True" 
                SortExpression="userName" />
            <asp:BoundField DataField="email" HeaderText="email" SortExpression="email" />
            <asp:BoundField DataField="firstName" HeaderText="First name" 
                SortExpression="firstName" />
            <asp:BoundField DataField="lastName" HeaderText="Last Name" 
                SortExpression="lastName" />
            <asp:BoundField DataField="phoneNumber" HeaderText="Phone number" 
                SortExpression="phoneNumber" />
            <asp:BoundField DataField="renewalDate" HeaderText="Renewal date" 
                SortExpression="renewalDate" />
            <asp:CheckBoxField DataField="active" HeaderText="active" 
                SortExpression="active" />
            <asp:HyperLinkField DataNavigateUrlFields="userName" 
                DataNavigateUrlFormatString="MemberEdit.aspx?userName={0}" Text="View Detail" />
        </Columns>
        <EditRowStyle BackColor="#999999" />
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <SortedAscendingCellStyle BackColor="#E9E7E2" />
        <SortedAscendingHeaderStyle BackColor="#506C8C" />
        <SortedDescendingCellStyle BackColor="#FFFDF8" />
        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />

<SortedAscendingCellStyle BackColor="#E9E7E2"></SortedAscendingCellStyle>

<SortedAscendingHeaderStyle BackColor="#506C8C"></SortedAscendingHeaderStyle>

<SortedDescendingCellStyle BackColor="#FFFDF8"></SortedDescendingCellStyle>

<SortedDescendingHeaderStyle BackColor="#6F8DAE"></SortedDescendingHeaderStyle>
    </asp:GridView>
    <br />
    <br />



    <asp:SqlDataSource ID="AsiaWebShopDBSqlDataSource" runat="server" 
        
    ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" SelectCommand="SELECT * FROM [Member] WHERE ([userName] = @userName)" 
        >
        <SelectParameters>
            <asp:ControlParameter ControlID="txtSearchString" Name="userName" 
                PropertyName="Text" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

