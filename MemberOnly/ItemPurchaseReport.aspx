<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemPurchaseReport.aspx.cs" Inherits="MemberOnly_ItemPurchaseReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 73%;
        }
        .style3
        {
            width: 131px;
        }
        .style4
        {
            width: 107px;
        }
        .style5
        {
            height: 26px;
        }
        .style6
        {
            width: 131px;
            height: 26px;
        }
        .style7
        {
            width: 107px;
            height: 26px;
        }
        .style8
        {
            width: 87px;
            height: 26px;
            font-family: "Segoe UI";
            color: #000080;
        }
        .style9
        {
            width: 87px;
            font-family: "Segoe UI";
            color: #000080;
        }
        .style10
        {
            width: 76px;
            height: 26px;
        }
        .style11
        {
            width: 76px;
        }
        .style12
        {
            width: 94px;
            height: 26px;
        }
        .style13
        {
            width: 94px;
        }
        .style14
        {
            color: #000080;
        }
        .style15
        {
            font-family: "Segoe UI";
            color: #000080;
        }
        .style16
        {
            height: 26px;
            font-family: "Segoe UI";
            color: #000080;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; text-decoration: underline; color: #000080">
        Item Purchase Report</p>
    <p class="style14">
        Dear
        <asp:HyperLink ID="UserName" runat="server">[UserName]</asp:HyperLink>
        , please specify the date range over which you want to generate a report: (Note 
        that if no date range is specified, then it is assumed that all dates are to be 
        included)</p>
    <table class="style2">
        <tr>
            <td class="style12">
                <span class="style15">From</td>
            <td class="style10">
                Year</span></td>
            <td class="style6">
                <asp:DropDownList ID="yearFromDropDownList" runat="server">
                </asp:DropDownList>
            </td>
            <td class="style8">
                Month</td>
            <td class="style7">
                <asp:DropDownList ID="monthFromDropDownList" runat="server">
                </asp:DropDownList>
            </td>
            <td class="style16">
                Day</td>
            <td class="style5">
                <asp:DropDownList ID="dayFromDropDownList" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="style13">
                <span class="style15">To</td>
            <td class="style11">
                Year</span></td>
            <td class="style3">
                <asp:DropDownList ID="yearToDropDownList" runat="server">
                </asp:DropDownList>
            </td>
            <td class="style9">
                Month</td>
            <td class="style4">
                <asp:DropDownList ID="monthToDropDownList" runat="server">
                </asp:DropDownList>
            </td>
            <td class="style15">
                Day</td>
            <td>
                <asp:DropDownList ID="dayToDropDownList" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <p>
        <asp:Button ID="GenerateReportButton" runat="server" BackColor="Silver" 
            BorderColor="Silver" BorderStyle="Solid" Height="22px" 
            onclick="GenerateReportButton_Click" Text="Generate Report" Width="150px" />
    </p>
    <p>
    <asp:Label ID="lblResult" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="Red"></asp:Label>
    </p>
    <asp:GridView ID="gvReport" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None" Width="365px">
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
    <asp:SqlDataSource ID="SqlDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        SelectCommand="SELECT * FROM [Address]"></asp:SqlDataSource>
    <p>
        <asp:Button ID="return" runat="server" BackColor="Silver" BorderColor="Silver" 
            BorderStyle="Solid" Height="22px" PostBackUrl="~/Default.aspx" Text="Return" 
            Width="150px" />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following error occurr:" ValidationGroup="itemReport" />
</asp:Content>

