<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="ViewMemberInformation.aspx.cs" Inherits="MemberOnly_ViewMemberInformation" %>

<script runat="server">

</script>
<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style2
        {
            text-decoration: underline;
            font-size: large;
            color: #000000;
        }
        .style4
        {
            text-decoration: underline;
            font-size: medium;
            color: #000000;
        }
        .style5
        {
            width: 100%;
        }
        .style6
        {
            width: 107px;
        }
        .style7
        {
            width: 141px;
        }
        .style14
        {
            width: 115px;
        }
        .style15
        {
            width: 115px;
            height: 4px;
        }
        .style19
        {
            width: 120px;
        }
        .style20
        {
            width: 144px;
        }
        .style21
        {
            width: 128px;
        }
        .style31
    {
        width: 107px;
        height: 5px;
    }
    .style32
    {
        height: 5px;
    }
    .style33
    {
        width: 107px;
        height: 4px;
    }
    .style34
    {
        height: 4px;
    }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <p class="style2">
        REGISTRATION PAGE</p>
    <p class="style4">
        Member Information</p>
    <table class="style5">
        <tr>
            <td class="style6">
                User Name:</td>
            <td class="style7">
                <asp:Label ID="UserName" runat="server"></asp:Label>
            </td>
            <td class="style14">
                Email Address:</td>
            <td>
                <asp:Label ID="Email" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style6">
                First Name:</td>
            <td class="style7">
                <asp:Label ID="FirstName" runat="server"></asp:Label>
            </td>
            <td class="style14">
                Last Name:</td>
            <td>
                <asp:Label ID="LastName" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style33">
                Phone Number:</td>
            <td class="style34">
                <asp:Label ID="PhoneNumber" runat="server"></asp:Label>
            </td>
            <td class="style15">
            </td>
            <td class="style34">
            </td>
        </tr>
        <tr>
            <td class="style31">
                Address:</td>
            <td class="style32" colspan="3">
                <asp:Label ID="Address" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Street:</td>
            <td>
                <asp:Label ID="Street" runat="server"></asp:Label>
            </td>
            <td class="style14">
                District:</td>
            <td>
                <asp:Label ID="District" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Renewal Date:</td>
            <td colspan="3">
                <asp:Label ID="RenewalDate" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <span class="style4">Credit Card Information<br />
    </span>
    <table class="style5">
        <tr>
            <td class="style19">
                Cardholder Name:</td>
            <td class="style20">
                <asp:Label ID="CardHolderName" runat="server"></asp:Label>
            </td>
            <td class="style21">
                Card Type:</td>
            <td>
                <asp:Label ID="CardType" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td class="style19">
                Card Number:</td>
            <td class="style20">
                <asp:Label ID="CardNumber" runat="server"></asp:Label>
            </td>
            <td class="style21">
                Expiry Date:</td>
            <td>
                <asp:Label ID="Month" runat="server"></asp:Label>
                /<asp:Label ID="Year" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:Button ID="Edit" runat="server" onclick="Edit_Click" style="height: 26px" 
        Text="Edit" />
    <br />
</asp:Content>
