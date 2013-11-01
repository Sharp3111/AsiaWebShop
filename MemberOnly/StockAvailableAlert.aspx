<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="StockAvailableAlert.aspx.cs" Inherits="MemberOnly_StockAvailableAlert" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
    .style2
    {
        width: 100%;
    }
    .style3
    {
        width: 293px;
    }
    .style5
    {
        width: 16px;
    }
        .style6
        {
            width: 98px;
            text-align: right;
        }
        .style7
        {
            width: 293px;
            height: 21px;
        }
        .style8
        {
            width: 98px;
            height: 21px;
        }
        .style9
        {
            height: 21px;
        }
        .style13
        {
            width: 16px;
            height: 21px;
        }
        .style14
        {
            width: 78px;
            height: 21px;
        }
        .style15
        {
            width: 150px;
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
            <asp:TextBox ID="itemBox" runat="server"></asp:TextBox>
        </td>
        <td class="style13">
            <asp:CustomValidator ID="CustomValidator2" runat="server" 
                ControlToValidate="itemBox" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Item doesn't exist!" ForeColor="Red" 
                onservervalidate="CustomValidator2_ServerValidate" 
                ValidationGroup="requestemail">*</asp:CustomValidator>
        </td>
        <td class="style14">
            using email:</td>
        <td class="style15">
            <asp:DropDownList ID="email" runat="server" ValidationGroup="requestemail">
            </asp:DropDownList>
            </td>
        <td class="style9">
            <asp:CustomValidator ID="CustomValidator1" runat="server" 
                ControlToValidate="email" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Please select a email address." ForeColor="Red" 
                onservervalidate="CustomValidator1_ServerValidate" 
                ValidationGroup="requestemail">*</asp:CustomValidator>
        </td>
    </tr>
    <tr>
        <td class="style3">
            &nbsp;</td>
        <td class="style6">
            &nbsp;</td>
        <td class="style5">
            &nbsp;</td>
        <td colspan="3" style="text-align: left">
            <asp:Button ID="request" runat="server" Text="Request notification" 
                onclick="request_Click" ValidationGroup="requestemail" 
                style="text-align: left" />
            <asp:CustomValidator ID="CustomValidator3" runat="server" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Record already exist!" ForeColor="Red" 
                onservervalidate="CustomValidator3_ServerValidate" 
                ValidationGroup="requestemail">*</asp:CustomValidator>
        </td>
    </tr>
</table>
    <br />
    <asp:Label ID="result" runat="server" Font-Bold="True" 
        ForeColor="Red"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following error occurred:" ValidationGroup="requestemail" />
<br />
</asp:Content>

