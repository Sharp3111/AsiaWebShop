<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="FinalConfirmation.aspx.cs" Inherits="MemberOnly_FinalConfirmationPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 53%;
        }
        .style3
        {
            width: 263px;
        }
        .style4
        {
            width: 96px;
        }
        .style5
        {
            width: 29px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; color: #000080; font-weight: bold;">
        Final Order Confirmation</p>
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: medium; color: #000080;">
        Dear
        <asp:Label ID="userName" runat="server"></asp:Label>
        , following is the detail of your order, please confirm or change the incorret 
        information:</p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        The item you purchased:</p>
    <p>
        <asp:GridView ID="itemPurchase" runat="server" CellPadding="4" 
            ForeColor="#333333" GridLines="None">
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
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        Your deliver address:</p>
    <p>
        <asp:GridView ID="deliverAddress" runat="server" CellPadding="4" 
            ForeColor="#333333" GridLines="None">
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
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        Your payment method:</p>
    <p>
&nbsp;<asp:GridView ID="paymentMethod" runat="server" CellPadding="4" 
            ForeColor="#333333" GridLines="None">
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
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
&nbsp;<table class="style2">
            <tr>
                <td class="style3">
                    Choose an email address to receive receipt:</td>
                <td class="style4">
                    <asp:DropDownList ID="emailAddress" runat="server">
                    </asp:DropDownList>
                </td>
                <td class="style5">
                    and</td>
                <td>
                    <asp:Button ID="confirm" runat="server" Text="Confirm" />
                </td>
            </tr>
        </table>
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; color: #000080">
        <asp:SqlDataSource ID="AsiaWebDataSource" runat="server"></asp:SqlDataSource>
    </p>
</asp:Content>

