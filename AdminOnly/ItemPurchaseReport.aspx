<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="ItemPurchaseReport.aspx.cs" Inherits="AdminOnly_ItemPurchaseReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 96%;
        }
        .style3
        {
            width: 149px;
        }
        .style4
        {
            width: 99px;
        }
        .style5
        {
            width: 85px;
        }
        .style6
        {
            width: 123px;
        }
        .style7
        {
            width: 31px;
        }
        .style8
        {
            width: 29px;
        }
        .style9
        {
            width: 63px;
        }
        .style10
        {
            width: 19px;
        }
        .style11
        {
        }
        .style12
        {
            width: 9px;
        }
        .style13
        {
            width: 14px;
        }
        .style14
        {
            width: 44px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; text-decoration: underline; color: #000080">
        Item Purchase Report</p>
    <table class="style2">
        <tr>
            <td class="style3">
                Item purchased by user:</td>
            <td class="style4">
                <asp:TextBox ID="userName" runat="server" Width="91px"></asp:TextBox>
            </td>
            <td class="style5">
                (empty for all)</td>
            <td rowspan="3" class="style6">
                <asp:RadioButtonList ID="date" runat="server" Width="115px" 
                    ValidationGroup="itemReport" Height="70px" RepeatLayout="Flow">
                    <asp:ListItem Value="certain">in certain date: <br></br></asp:ListItem>
                    <asp:ListItem Value="any">at any time</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="style7">
                from</td>
            <td class="style8">
                Year:</td>
            <td class="style9">
                <asp:DropDownList ID="yearFrom" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="yearFrom_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style10">
                Month:</td>
            <td class="style11">
                <asp:DropDownList ID="monthFrom" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="monthFrom_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style12">
                Day:</td>
            <td class="style13">
                <asp:DropDownList ID="dayFrom" runat="server" AutoPostBack="True" ValidationGroup="itemReport">
                </asp:DropDownList>
            </td>
            <td class="style14">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style4">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style7">
                to</td>
            <td class="style8">
                Year</td>
            <td class="style9">
                <asp:DropDownList ID="yearTo" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="yearTo_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style10">
                Month:</td>
            <td class="style11">
                <asp:DropDownList ID="monthTo" runat="server" AutoPostBack="True" 
                    ValidationGroup="itemReport" 
                    onselectedindexchanged="monthTo_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
            <td class="style12">
                Day:</td>
            <td class="style13">
                <asp:DropDownList ID="dayTo" runat="server" AutoPostBack="True" ValidationGroup="itemReport">
                </asp:DropDownList>
            </td>
            <td class="style14">
                <asp:CustomValidator ID="CustomValidator2" runat="server" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Invalid date range." ForeColor="Red" 
                    ValidationGroup="itemReport" 
                    onservervalidate="CustomValidator2_ServerValidate">*</asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style4">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style7">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="date" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="You need to select a time range." ForeColor="Red" 
                    ValidationGroup="itemReport">*</asp:RequiredFieldValidator>
            </td>
            <td class="style8">
                &nbsp;</td>
            <td class="style9">
                &nbsp;</td>
            <td class="style10">
                &nbsp;</td>
            <td class="style11" colspan="2">
                &nbsp;</td>
            <td class="style13">
                &nbsp;</td>
            <td class="style14">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                &nbsp;</td>
            <td class="style4">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style7">
                &nbsp;</td>
            <td class="style8">
                &nbsp;</td>
            <td class="style9">
                &nbsp;</td>
            <td class="style10">
                &nbsp;</td>
            <td class="style11" colspan="3">
                <asp:Button ID="Button1" runat="server" Text="General Report" 
                    ValidationGroup="itemReport" Width="117px" onclick="Button1_Click" />
            </td>
            <td class="style14">
                &nbsp;</td>
        </tr>
        </table>
    <br />
    <asp:Label ID="result" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="Red"></asp:Label>
    <br />
    <asp:GridView ID="report" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None">
        <AlternatingRowStyle BackColor="White" />
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
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT * FROM [Address]"></asp:SqlDataSource>
    <br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following error occurred:" ValidationGroup="itemReport" />
</asp:Content>

