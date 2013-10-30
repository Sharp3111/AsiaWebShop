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
            <asp:TextBox ID="Building" runat="server" Height="22px" Width="200px" 
                MaxLength="20"></asp:TextBox>
        </td>
        <td class="style46">
            <table class="style3">
                <tr>
                    <td class="style7">
                        &nbsp;Floor</td>
                    <td>
                        <asp:TextBox ID="Floor" runat="server" Width="40px" Height="22px" MaxLength="3"></asp:TextBox>
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
                        <asp:TextBox ID="FlatSuite" runat="server" Width="40px" Height="22px" 
                            MaxLength="5"></asp:TextBox>
                    </td>
                    <td class="style10">
                        Block/Tower:</td>
                    <td>
                        <asp:TextBox ID="BlockTower" runat="server" Width="40px" Height="22px" 
                            MaxLength="2"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="style32">
            Street:</td>
        <td class="style5">
            <asp:TextBox ID="Street" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                ControlToValidate="Street" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Street is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style46">
            &nbsp;
            District:</td>
        <td>
            <asp:DropDownList ID="DistrictDropDownList" runat="server" 
                Height="22px" style="margin-left: 0px" Width="205px">
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                ControlToValidate="DistrictDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a district." 
                ForeColor="Red" InitialValue="-- Select district --" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
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
            <asp:TextBox ID="CardHolderName" runat="server" Height="22px" 
                style="margin-left: 0px" Width="200px" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                ControlToValidate="CardHolderName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Cardholder Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style23">
            Card Type:</td>
        <td class="style24">
            <asp:DropDownList ID="CardTypeDropDownList" runat="server" 
                Width="250px" Height="22px" ValidationGroup="RegisterUserValidationGroup">
                <asp:ListItem>-- Select credit card --</asp:ListItem>
                <asp:ListItem>American Express</asp:ListItem>
                <asp:ListItem>Diners Club</asp:ListItem>
                <asp:ListItem>Discover</asp:ListItem>
                <asp:ListItem>MasterCard</asp:ListItem>
                <asp:ListItem>Visa</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvCardTypeDropDownList" runat="server" 
                ControlToValidate="CardTypeDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a credit card." 
                ForeColor="Red" InitialValue="-- Select credit card --" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style47">
            Card Number:</td>
        <td class="style44">
            <asp:TextBox ID="CardNumber" runat="server" Height="22px" Width="200px" 
                MaxLength="16"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                ControlToValidate="CardNumber" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Card Number is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                ControlToValidate="CardNumber" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Card Number must be numeric and between 14 and 16 digits." 
                ForeColor="Red" ValidationExpression="^\d{14,16}$" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
        </td>
        <td class="style37">
            Expiry Date:</td>
        <td class="style15">
            <table class="style3">
                <tr>
                    <td class="style53">
                        <asp:DropDownList ID="MonthDropDownList" runat="server" 
                            Height="22px" Width="110px" CausesValidation="True" 
                            ValidationGroup="RegisterUserValidationGroup">
                            <asp:ListItem Value="00">Month</asp:ListItem>
                            <asp:ListItem>01</asp:ListItem>
                            <asp:ListItem>02</asp:ListItem>
                            <asp:ListItem>03</asp:ListItem>
                            <asp:ListItem Value="04"></asp:ListItem>
                            <asp:ListItem Value="05"></asp:ListItem>
                            <asp:ListItem Value="06"></asp:ListItem>
                            <asp:ListItem Value="07"></asp:ListItem>
                            <asp:ListItem Value="08"></asp:ListItem>
                            <asp:ListItem Value="09"></asp:ListItem>
                            <asp:ListItem Value="10"></asp:ListItem>
                            <asp:ListItem Value="11"></asp:ListItem>
                            <asp:ListItem Value="12"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvMonth" runat="server" 
                            ControlToValidate="MonthDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a month." 
                            ForeColor="Red" InitialValue="00" 
                            ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                    </td>
                    <td class="style52">
                        / 
                        <asp:DropDownList ID="YearDropDownList" runat="server" 
                            Height="22px" Width="110px">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                            ControlToValidate="YearDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a year." ForeColor="Red" 
                            InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvExpiryDate" runat="server" 
                            ControlToValidate="MonthDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Credit card is expired." 
                            ForeColor="Red" onservervalidate="cvExpiryDate_ServerValidate" 
                            ValidationGroup="RegisterUserValidationGroup">*</asp:CustomValidator>
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
        If you want to change your password, please click
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
