<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="PersonalReport.aspx.cs" Inherits="AdminOnly_PersonalReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">

        .style2
        {
            width: 100%;
        }
        .style5
        {
            width: 131px;
        }
        .style6
        {
            width: 336px;
        }
        .style7
        {
            width: 3px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080; text-decoration: underline;">
        Personal Report</p>
    <p>
        <table class="style2">
            <tr>
                <td class="style6">
                    Generate report of certain user whose username contains:</td>
                <td class="style7">
                    <asp:TextBox ID="userName" runat="server" Width="85px"></asp:TextBox>
                </td>
                <td class="style5">
                    (empty for all user),</td>
                <td>
                    <asp:CheckBox ID="group" runat="server" Text="Group by district" />
                </td>
            </tr>
            <tr>
                <td class="style6">
                    &nbsp;</td>
                <td class="style7">
                    &nbsp;</td>
                <td class="style5">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="Button1" runat="server" onclick="Button1_Click" 
                        Text="General Report" />
                </td>
            </tr>
        </table>
    </p>
    <p>
        <asp:Label ID="result" runat="server" Font-Bold="True" Font-Size="Medium" 
            ForeColor="Red"></asp:Label>
    </p>
    <p>
        <asp:GridView ID="report" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="userName1" DataSourceID="SqlDataSource1" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="userName" HeaderText="User name" 
                    SortExpression="userName" />
                <asp:BoundField DataField="email" HeaderText="Email" SortExpression="email" />
                <asp:BoundField DataField="firstName" HeaderText="First name" 
                    SortExpression="firstName" />
                <asp:BoundField DataField="lastName" HeaderText="Last name" 
                    SortExpression="lastName" />
                <asp:BoundField DataField="phoneNumber" HeaderText="Phone number" 
                    SortExpression="phoneNumber" />
                <asp:BoundField DataField="renewalDate" HeaderText="Renewal date" 
                    SortExpression="renewalDate" />
                <asp:CheckBoxField DataField="active" HeaderText="Active" 
                    SortExpression="active" />
                <asp:BoundField DataField="buildingAddress" HeaderText="Building" 
                    SortExpression="buildingAddress" />
                <asp:BoundField DataField="streetAddress" HeaderText="Street" 
                    SortExpression="streetAddress" />
                <asp:BoundField DataField="district" HeaderText="District" 
                    SortExpression="district" />
                <asp:BoundField DataField="number" HeaderText="Credit card number" 
                    SortExpression="number" />
                <asp:BoundField DataField="type" HeaderText="Card type" SortExpression="type" />
                <asp:BoundField DataField="cardHolderName" HeaderText="Card holder name" 
                    SortExpression="cardHolderName" />
                <asp:BoundField DataField="expiryMonth" HeaderText="Expiry month" 
                    SortExpression="expiryMonth" />
                <asp:BoundField DataField="expiryYear" HeaderText="Expiry year" 
                    SortExpression="expiryYear" />
                <asp:BoundField DataField="userName1" HeaderText="invisiable1" ReadOnly="True" 
                    SortExpression="userName1" Visible="False" />
                <asp:BoundField DataField="userName2" HeaderText="invisiable2" 
                    SortExpression="userName2" Visible="False" />
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
        <br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM Address
JOIN  Member ON Address.userName = Member.userName
JOIN Creditcard ON Address.userName = Creditcard.userName"></asp:SqlDataSource>
    </p>
</asp:Content>

