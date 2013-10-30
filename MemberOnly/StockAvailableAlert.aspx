<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="StockAvailableAlert.aspx.cs" Inherits="MemberOnly_StockAvailableAlert" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
    .style2
    {
        width: 100%;
    }
    .style3
    {
        width: 231px;
    }
    .style5
    {
        width: 112px;
    }
        .style6
        {
            width: 134px;
            text-align: right;
        }
        .style7
        {
            width: 231px;
            height: 21px;
        }
        .style8
        {
            width: 134px;
            height: 21px;
        }
        .style9
        {
            height: 21px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080;">
    Request Notification by Email when Item Available
</p>
<table class="style2">
    <tr>
        <td class="style7">
            Request notification for item available:</td>
        <td class="style8">
            <asp:Label ID="itemLabel" runat="server"></asp:Label>
        </td>
        <td class="style9" colspan="2">
            (You are not allowed to change item here.)</td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td class="style6">
            using email:</td>
        <td class="style5">
            <asp:DropDownList ID="email" runat="server" ValidationGroup="requestemail">
            </asp:DropDownList>
            <asp:CustomValidator ID="CustomValidator1" runat="server" 
                ControlToValidate="email" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Please select a email address." ForeColor="Red" 
                onservervalidate="CustomValidator1_ServerValidate" 
                ValidationGroup="requestemail">*</asp:CustomValidator>
        </td>
        <td>
            <asp:Button ID="request" runat="server" Text="Request notification" 
                onclick="request_Click" ValidationGroup="requestemail" />
        </td>
    </tr>
</table>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following error occurred:" ValidationGroup="requestemail" />
<br />
</asp:Content>

