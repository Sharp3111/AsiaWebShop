<%@ Page Title="Register" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="Register.aspx.cs" Inherits="Account_Register" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:CreateUserWizard ID="RegisterUser" runat="server" 
        OnCreatedUser="RegisterUser_CreatedUser" style="margin-bottom: 0px">
        <LayoutTemplate>
            <asp:PlaceHolder ID="wizardStepPlaceholder" runat="server"></asp:PlaceHolder>
            <asp:PlaceHolder ID="navigationPlaceholder" runat="server"></asp:PlaceHolder>
        </LayoutTemplate>
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                <ContentTemplate>
                    <h2 style="font-family: Arial, Helvetica, sans-serif; font-size: large; color: NAVY">
                        REGISTRATION PAGE
                    </h2>
                    <p>
                        Use the form below to create a new account.
                    </p>
                    <p>
                        Passwords are required to be a minimum of <%= Membership.MinRequiredPasswordLength %> characters in length.
                    </p>
                    <span class="failureNotification">
                        <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                    </span>
                    <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" CssClass="failureNotification" 
                         ValidationGroup="RegisterUserValidationGroup"/>
                    <div class="accountInfo">
                       <p class="style4">
        Member Information</p>
    <table class="style5">
        <tr>
            <td class="style6">
                User Name:</td>
            <td class="style7">
                <asp:TextBox ID="UserName" runat="server" MaxLength="10"></asp:TextBox>
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
            <td class="style14">
                Email Address:</td>
            <td colspan="5">
                <asp:TextBox ID="Email" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ControlToValidate="Email" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Email Address is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style6">
                Password:</td>
            <td class="style7">
                <asp:TextBox ID="Password" runat="server" TextMode="Password" MaxLength="15"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="Password" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Password is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style14">
                Confirm Password:</td>
            <td colspan="5">
                <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" 
                    MaxLength="15" Width="128px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" 
                    ControlToValidate="ConfirmPassword" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Confirm Password is required." 
                    ForeColor="Red" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                <asp:CompareValidator ID="cvConfirmPassword" runat="server" 
                    ControlToCompare="Password" ControlToValidate="ConfirmPassword" 
                    Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Password and Confirm Password must be the same." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
            </td>
        </tr>
        <tr>
            <td class="style6">
                First Name:</td>
            <td class="style7">
                <asp:TextBox ID="FirstName" runat="server" MaxLength="20"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                    ControlToValidate="FirstName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="First Name is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style14">
                Last Name:</td>
            <td colspan="5">
                <asp:TextBox ID="LastName" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                    ControlToValidate="LastName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Last Name is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style10">
                Phone Number:</td>
            <td class="style11">
                <asp:TextBox ID="PhoneNumber" runat="server" MaxLength="8"></asp:TextBox>
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
            <td class="style15">
            </td>
            <td class="style13" colspan="5">
            </td>
        </tr>
        <tr>
            <td class="style10">
                Building:</td>
            <td class="style11">
                <asp:TextBox ID="Building" runat="server" MaxLength="20"></asp:TextBox>
            </td>
            <td class="style15">
                Floor:</td>
            <td class="style9">
                <asp:TextBox ID="Floor" runat="server" Width="83px" MaxLength="3"></asp:TextBox>
            </td>
            <td class="style16">
                Flat/Suite:</td>
            <td class="style17">
                <asp:TextBox ID="FlatSuite" runat="server" MaxLength="5"></asp:TextBox>
            </td>
            <td class="style18">
                Block/Tower:</td>
            <td class="style13">
                <asp:TextBox ID="BlockTower" runat="server" MaxLength="2"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style25">
                Street:</td>
            <td class="style26">
                <asp:TextBox ID="Street" runat="server" MaxLength="30"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                    ControlToValidate="Street" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Street is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style27">
                District:</td>
            <td colspan="5" class="style28">
                <asp:DropDownList ID="DistrictDropDownList" runat="server">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                    ControlToValidate="DistrictDropDownList" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a district." 
                    ForeColor="Red" InitialValue="-- Select district --" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
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
                <asp:TextBox ID="CardHolderName" runat="server" MaxLength="50" Width="117px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                    ControlToValidate="CardHolderName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Cardholder Name is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style21">
                Card Type:</td>
            <td colspan="2">
                <asp:DropDownList ID="CardTypeDropDownList" runat="server">
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
            <td class="style22">
                Card Number:</td>
            <td class="style23">
                <asp:TextBox ID="CardNumber" runat="server" MaxLength="16"></asp:TextBox>
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
            <td class="style24">
                Expiry Date:</td>
            <td class="style10">
                <asp:DropDownList ID="MonthDropDownList" runat="server">
                    <asp:ListItem Value="Month"></asp:ListItem>
                    <asp:ListItem>01</asp:ListItem>
                    <asp:ListItem>02</asp:ListItem>
                    <asp:ListItem>03</asp:ListItem>
                    <asp:ListItem>04</asp:ListItem>
                    <asp:ListItem>05</asp:ListItem>
                    <asp:ListItem>06</asp:ListItem>
                    <asp:ListItem>07</asp:ListItem>
                    <asp:ListItem>08</asp:ListItem>
                    <asp:ListItem>09</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>11</asp:ListItem>
                    <asp:ListItem>12</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvMonth" runat="server" 
                    ControlToValidate="MonthDropDownList" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a month." 
                    ForeColor="Red" InitialValue="Month" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style13">
                <asp:DropDownList ID="YearDropDownList" runat="server">
                    <asp:ListItem Value="0">Year</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                    ControlToValidate="YearDropDownList" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a year." ForeColor="Red" 
                    InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
                        <p class="submitButton">
                            <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="Create User" 
                                 ValidationGroup="RegisterUserValidationGroup"/>
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