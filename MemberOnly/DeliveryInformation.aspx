<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="DeliveryInformation.aspx.cs" Inherits="MemberOnly_DeliveryInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: large;
            color: #000080;
            text-transform: uppercase;
            text-decoration: underline;
        }
        .style3
    {
        width: 97%;
            height: 28px;
            color: #000080;
            font-family: "Segoe UI";
        }
        .style32
        {
            width: 170px;
        }
        .style5
    {
        }
        .style46
        {
            width: 143px;
        }
        .style48
        {
            width: 268435488px;
        }
        .style49
        {
            width: 195px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong>SPECIFY Delivery Information</strong></p>
<table class="style3">
    <tr>
        <td class="style32">
            User Name:</td>
        <td class="style5">
            <asp:Label ID="UserName" runat="server"></asp:Label>
        </td>
        <td class="style46" colspan="2">
            &nbsp;Email Adress:</td>
        <td class="style48">
            <asp:TextBox ID="Email" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                ControlToValidate="Email" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Email Address is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="Email" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Email address has to have the form: example@sampleemail.com" 
                ForeColor="Red" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="style32">
            First Name:</td>
        <td class="style5">
            <asp:TextBox ID="FirstName" runat="server" Height="22px" Width="200px" 
                MaxLength="20"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                ControlToValidate="FirstName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="First Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style46" colspan="2">
            &nbsp;Last Name:</td>
        <td class="style48">
            <asp:TextBox ID="LastName" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                ControlToValidate="LastName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Last Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style32">
            Phone Number:</td>
        <td class="style5">
            <asp:TextBox ID="PhoneNumber" runat="server" Height="22px" Width="200px" 
                MaxLength="8"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPhoneNumber" runat="server" 
                ControlToValidate="PhoneNumber" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Phone Number is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revPhoneNumber" runat="server" 
                ControlToValidate="PhoneNumber" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Phone Number must be numeric and exactly 8 digits." 
                ForeColor="Red" ValidationExpression="^\d{8}$" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
        </td>
        <td class="style46" colspan="2">
            &nbsp;</td>
        <td class="style48">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style32">
            Delivery Address:</td>
        <td class="style49" colspan="2">
            <asp:DropDownList ID="AddressDropDownList" runat="server">
                <asp:ListItem Value="0">-- Select an Address --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvAddressDropDownList" runat="server" 
                ControlToValidate="AddressDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select an address." 
                ForeColor="Red" InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style5" colspan="2">
            Desired address not listed? Click
            <asp:HyperLink ID="ChangeAddressLink" runat="server" 
                NavigateUrl="~/MemberOnly/EditAddressList.aspx">here</asp:HyperLink>
&nbsp;to add another and check out later!</td>
    </tr>
    <tr>
        <td class="style32">
            Delivery Date:</td>
        <td class="style5">
            <asp:DropDownList ID="DeliveryDateDropDownList" runat="server">
                <asp:ListItem Value="0">-- Select a Date --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDeliveryDate" runat="server" 
                ControlToValidate="DeliveryDateDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a delivery date." 
                ForeColor="Red" InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style46" colspan="2">
            Delivery Time:</td>
        <td class="style48">
            <asp:DropDownList ID="DeliveryTimeDropDownList" runat="server">
                <asp:ListItem Value="0">-- Select a Time Slot --</asp:ListItem>
                <asp:ListItem Value="9">09:00-12:00</asp:ListItem>
                <asp:ListItem Value="12">12:00-15:00</asp:ListItem>
                <asp:ListItem Value="15">15:00-18:00</asp:ListItem>
                <asp:ListItem Value="18">18:00-21:00</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDeliveryTime" runat="server" 
                ControlToValidate="DeliveryTimeDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a delivery time slot." 
                ForeColor="Red" InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            <asp:CustomValidator ID="cvDeliveryTime" runat="server" 
                ControlToValidate="DeliveryTimeDropDownList" Display="Dynamic" 
                EnableClientScript="False" 
                ErrorMessage="The earliest delivery time-slot should be at least 24 hours after the purchase time." 
                ForeColor="Red" onservervalidate="cvDeliveryTime_ServerValidate" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:CustomValidator>
        </td>
    </tr>
    </table>
    <p>
        <asp:Button ID="ContinueButton" runat="server" onclick="ContinueButton_Click" 
            Text="Next: Specify Payment Information" 
            ValidationGroup="RegisterUserValidationGroup" />
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following error(s) occurred:" 
        ValidationGroup="RegisterUserValidationGroup" />
    <p>
    </p>
</asp:Content>

