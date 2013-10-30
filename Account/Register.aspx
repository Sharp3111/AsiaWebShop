<%@ Page Title="Register" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style2
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: large;
            color: #000080;
            text-transform: uppercase;
            text-decoration: underline;
            font-weight: normal;
        }
        .style3
        {
            font-family: "Segoe UI";
            color: #000080;
        }
        .style4
        {
            font-family: "Segoe UI";
        }
        .style5
        {
            color: #800000;
        }
        .style6
        {
            color: #000080;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:CreateUserWizard ID="RegisterUser" runat="server" 
        OnCreatedUser="RegisterUser_CreatedUser">
        <LayoutTemplate>
            <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                <ContentTemplate>
                    <h2 class="style2">
                        REGISTRATION PAGE</h2>
                    <p>
                        <span class="style3">Use the form below to create a new account. </span>
                    </p>
                    </span><span class="style4">
                    <p class="style5">
                        <span class="style6">Passwords are required to be a minimum of
                        <%= Membership.MinRequiredPasswordLength %>characters in length.</span>
                    </p>
                    </span>
                    </p>
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterUserValidationGroup" Width="908px"/>
                    <div class="accountInfo">
                    <p class="style3">
        <strong>Member Information</strong></p>
<table class="style3">
    <tr>
        <td class="style32">
            User Name:</td>
        <td class="style5">
            <asp:TextBox ID="UserName" runat="server" Height="22px" Width="200px" 
                MaxLength="10"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUserName" runat="server" 
                ControlToValidate="UserName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="User Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revUserName" runat="server" 
                ControlToValidate="UserName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="User Name must be alphanumeric and at least 6 characters." 
                ForeColor="Red" ValidationExpression="^[A-Za-z\d]{6,10}$" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
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
            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                ControlToValidate="Email" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Email address has to have the form: example@samplemail.com" 
                ForeColor="Red" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RegularExpressionValidator>
        </td>
    </tr>
    <tr>
        <td class="style48">
            Password:</td>
        <td class="style49">
            <asp:TextBox ID="Password" runat="server" TextMode="Password" Height="22px" 
                Width="200px" MaxLength="15"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                ControlToValidate="Password" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Password is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style50">
            &nbsp;Confirm Password:</td>
        <td class="style51">
            <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" 
                Height="22px" Width="200px" MaxLength="15"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                ControlToValidate="ConfirmPassword" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Confirm Password is required." 
                ForeColor="Red" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvConfirmPassword" runat="server" 
                ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                CultureInvariantValues="True" Display="Dynamic" 
                ErrorMessage="Password and Confirm Password must be the same." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup" EnableClientScript="False">*</asp:CompareValidator>
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
        <td class="style54">
            Street:</td>
        <td class="style55">
            <asp:TextBox ID="Street" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                ControlToValidate="Street" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Street is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style56">
            District:</td>
        <td class="style57">
            <asp:DropDownList ID="DistrictDropDownList" runat="server" 
                Height="22px" style="margin-left: 0px" Width="205px">
                <asp:ListItem Value="0">-- Select district --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                ControlToValidate="DistrictDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a district." 
                ForeColor="Red" InitialValue="0" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
    </tr>
</table>
<p class="style3">
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
                Width="250px" Height="22px">
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
                            Height="22px" Width="110px">
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
                            <asp:ListItem Value="0">Year</asp:ListItem>
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
                        <p class="submitButton">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Create User" 
                                 ValidationGroup="RegisterUserValidationGroup" BackColor="Silver" 
                                BorderColor="Silver" Height="30px" 
                                style="font-size: medium; font-family: 'Maiandra GD'" Width="120px"/>
                        </p>
                    </div>
                </ContentTemplate>
                <CustomNavigationTemplate>
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
<asp:CompleteWizardStep runat="server"></asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>