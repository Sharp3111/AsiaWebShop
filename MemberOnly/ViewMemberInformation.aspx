<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="ViewMemberInformation.aspx.cs" Inherits="MemberOnly_ViewMemberInformation" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style3
    {
        width: 89%;
            height: 0px;
            color: #000080;
            font-family: "Segoe UI";
        }
    .style5
    {
        }
    .style21
    {
        width: 185px;
        height: 21px;
            text-align: left;
        }
    .style23
    {
        width: 114px;
        height: 21px;
    }
    .style24
    {
        width: 333px;
        height: 21px;
    }
    .style26
    {
        text-decoration: underline;
        font-family: "Segoe UI";
        color: #000080;
    }
        .style32
        {
            width: 170px;
            text-align: left;
        }
        .style41
        {
            width: 311px;
            height: 21px;
        }
        .style46
        {
            width: 175px;
            text-align: right;
        }
        .style53
        {
            height: 43px;
        }
        .style54
        {
            width: 175px;
            text-align: left;
        }
        .style55
        {
        }
        .style56
        {
            text-decoration: underline;
            font-family: "Segoe UI";
            color: #000080;
            font-weight: bold;
        }
        .style57
        {
            width: 175px;
            text-align: left;
        }
        .style58
        {
            width: 185px;
            text-align: left;
        }
        .style59
        {
            width: 311px;
        }
        .style60
        {
            width: 114px;
        }
        .style61
        {
            width: 333px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<p class="style56">
        Member Information</p>
<table class="style3">
    <tr>
        <td class="style32">
            User Name:</td>
        <td class="style55">
            <asp:Label ID="UserName" runat="server"></asp:Label>
        </td>
        <td class="style57">
            &nbsp;Email Adress:</td>
        <td>
            <asp:Label ID="Email" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style32">
            First Name:</td>
        <td class="style55">
            <asp:Label ID="FirstName" runat="server"></asp:Label>
        </td>
        <td class="style54">
            &nbsp;Last Name:</td>
        <td>
            <asp:Label ID="LastName" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style32">
            Phone Number:</td>
        <td class="style55">
            <asp:Label ID="PhoneNumber" runat="server"></asp:Label>
        </td>
        <td class="style46">
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style32">
            Address:</td>
        <td class="style5" colspan="3">
            <asp:Label ID="Address" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style32">
            Street:</td>
        <td class="style55">
            <asp:Label ID="Street" runat="server"></asp:Label>
        </td>
        <td class="style54">
            District:</td>
        <td>
            <asp:Label ID="District" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style32">
            Renewal Date:</td>
        <td class="style55" colspan="3">
            <asp:Label ID="RenewalDate" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<p class="style26">
        <strong>Credit Card Information</strong></p>
<table class="style3">
    <tr>
        <td class="style21">
            Cardholder Name:</td>
        <td class="style41">
            <asp:Label ID="CardHolderName" runat="server"></asp:Label>
        </td>
        <td class="style23">
            Card Type:</td>
        <td class="style24">
            <asp:Label ID="CardType" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style58">
            Card Number:</td>
        <td class="style59">
            <asp:Label ID="CardNumber" runat="server"></asp:Label>
        </td>
        <td class="style60">
            Expiry Date:</td>
        <td class="style61">
                        <asp:Label ID="Month" runat="server"></asp:Label>
                    &nbsp;/ 
                        <asp:Label ID="Year" runat="server"></asp:Label>
        </td>
    </tr>
</table>
    <br />
    <br />
    <asp:Button ID="Edit" runat="server" CausesValidation="False" 
        PostBackUrl="~/MemberOnly/EditMemberInformation.aspx" Text="Edit" 
        Width="100px" Height="30px" 
        style="font-size: medium; font-family: 'Times New Roman', Times, serif" />
    </asp:Content>
