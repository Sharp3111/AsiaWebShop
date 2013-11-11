<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="EditMemberInformation.aspx.cs" Inherits="MemberOnly_EditMemberInformation" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style3
    {
        width: 91%;
            height: 28px;
            color: #000080;
            font-family: "Segoe UI";
        }
    .style5
    {
            width: 298px;
        }
    .style7
    {
        width: 45px;
    }
    .style8
    {
        width: 60px;
    }
    .style10
    {
        width: 90px;
    }
    .style15
    {
        width: 333px;
            height: 43px;
        }
    .style21
    {
        width: 185px;
        height: 21px;
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
        .style29
        {
            width: 74px;
        }
        .style32
        {
            width: 170px;
        }
        .style37
        {
            width: 114px;
            height: 43px;
        }
        .style41
        {
            width: 311px;
            height: 21px;
        }
        .style44
        {
            width: 311px;
            height: 43px;
        }
        .style46
        {
            width: 175px;
        }
        .style47
        {
            width: 185px;
            height: 43px;
        }
        .style52
        {
            height: 43px;
        }
        .style53
        {
            width: 126px;
            height: 43px;
        }
        .style54
        {
            color: #000080;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
<p class="style26">
        <strong>Member Information</strong></p>
<table class="style3">
    <tr>
        <td class="style32">
            User Name:</td>
        <td class="style5">
            <asp:Label ID="UserName" runat="server"></asp:Label>
        </td>
        <td class="style46">
            &nbsp;Email Adress:</td>
        <td>
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
        <td class="style46">
            &nbsp;Last Name:</td>
        <td>
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
        <td class="style46">
            &nbsp;</td>
        <td>
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style32">
            Building:</td>
        <td class="style5">
            <asp:Label ID="Building" runat="server"></asp:Label>
        </td>
        <td class="style46">
            <table class="style3">
                <tr>
                    <td class="style7">
                        &nbsp;Floor</td>
                    <td>
                        <asp:Label ID="Floor" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
        <td>
            <table class="style3">
                <tr>
                    <td class="style8">
                        Flat/Suite:</td>
                    <td class="style29">
                        <asp:Label ID="FlatSuite" runat="server"></asp:Label>
                    </td>
                    <td class="style10">
                        Block/Tower:</td>
                    <td>
                        <asp:Label ID="BlockTower" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="style32">
            Street:</td>
        <td class="style5">
            <asp:Label ID="Street" runat="server"></asp:Label>
        </td>
        <td class="style46">
            &nbsp;
            District:</td>
        <td>
            <asp:Label ID="District" runat="server"></asp:Label>
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
        <td class="style47">
            Card Number:</td>
        <td class="style44">
            <asp:Label ID="CardNumber" runat="server"></asp:Label>
        </td>
        <td class="style37">
            Expiry Date:</td>
        <td class="style15">
            <table class="style3">
                <tr>
                    <td class="style53">
                        <asp:Label ID="Month" runat="server"></asp:Label>
                    </td>
                    <td class="style52">
                        / 
                        <asp:Label ID="Year" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
    <p>
        <asp:Button ID="Update" runat="server" Text="Update" Height="30px" 
            style="font-family: 'Maiandra GD'; font-size: medium; color: #000000; text-align: center; background-color: #C0C0C0; " 
            Width="100px" onclick="Update_Click" 
            ValidationGroup="RegisterUserValidationGroup" BackColor="Silver" 
            BorderColor="Silver" />
    </p>
    <p>
        <span class="style54">If you want to edit delivery addresses, please click</span>
        <asp:HyperLink ID="ManageDeliveryAddressLink" runat="server" 
            NavigateUrl="~/MemberOnly/ManageDeliveryAddress.aspx" 
            style="text-decoration: underline; color: #9900FF">Manage Delivery Address List</asp:HyperLink>
    </p>
    <p>
        <span class="style54">If you want to edit credit card information, please click</span>
        <asp:HyperLink ID="ManageCreditCardLink" runat="server" 
            NavigateUrl="~/MemberOnly/ManagePaymentMethod.aspx" 
            style="text-decoration: underline; color: #9900FF">Manage Payment Methods</asp:HyperLink>
    </p>
    <p>
        <span class="style54">If you want to change your password, please click</span>
        <asp:HyperLink ID="HyperLinkToChangePassword" runat="server" ForeColor="#9900FF" 
            NavigateUrl="~/Account/ChangePassword.aspx">Change Password</asp:HyperLink>
    </p>
    <p>
        </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following errors occurred." 
        ValidationGroup="RegisterUserValidationGroup" />
</asp:Content>
