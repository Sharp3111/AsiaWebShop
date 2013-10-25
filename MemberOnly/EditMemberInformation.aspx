<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true"
    CodeFile="EditMemberInformation.aspx.cs" Inherits="MemberOnly_EditMemberInformation" %>

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
            margin-bottom: 0px;
        }
        .style10
        {
            width: 95px;
            height: 26px;
        }
        .style13
        {
            height: 26px;
        }
        .style19
        {
            width: 120px;
        }
        .style20
        {
            width: 169px;
        }
        .style21
        {
            width: 128px;
        }
        .style22
        {
            width: 120px;
            height: 26px;
        }
        .style23
        {
            width: 169px;
            height: 26px;
        }
        .style24
        {
            width: 128px;
            height: 26px;
        }
        .style26
        {
            width: 177px;
            }
        .style29
        {
            width: 95px;
            height: 29px;
        }
        .style30
        {
            width: 177px;
            height: 29px;
        }
        .style32
        {
            height: 29px;
        }
        .style41
        {
            width: 177px;
            height: 6px;
        }
        .style43
        {
            width: 95px;
            height: 6px;
        }
        .style44
        {
            height: 6px;
        }
        .style45
        {
            width: 95px;
            height: 12px;
        }
        .style46
        {
            width: 177px;
            height: 12px;
        }
        .style48
        {
            height: 12px;
        }
        .style49
        {
            width: 93px;
            height: 29px;
        }
        .style50
        {
            width: 93px;
            height: 12px;
        }
        .style51
        {
            width: 93px;
            height: 6px;
        }
        .style53
        {
            width: 93px;
        }
        .style54
        {
            width: 95px;
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
            <td class="style29" height="25">
                User Name:</td>
            <td class="style30" height="25">
                <asp:Label ID="UserName" runat="server"></asp:Label>
            </td>
            <td class="style49" height="25">
                Email Address:</td>
            <td class="style32" height="25">
                <asp:TextBox ID="Email" runat="server" MaxLength="30" Height="15px" 
                    Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                    ControlToValidate="Email" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Email Address is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style45">
                First Name:</td>
            <td class="style46">
                <asp:TextBox ID="FirstName" runat="server" MaxLength="20" Height="15px" 
                    Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                    ControlToValidate="FirstName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="First Name is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style50">
                Last Name:</td>
            <td class="style48">
                <asp:TextBox ID="LastName" runat="server" MaxLength="30" Height="15px" 
                    Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                    ControlToValidate="LastName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Last Name is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style43">
                Phone Number:</td>
            <td class="style41">
                <asp:TextBox ID="PhoneNumber" runat="server" MaxLength="8" Height="15px" 
                    Width="150px"></asp:TextBox>
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
            <td class="style51">
                BuildingAddress:</td>
            <td class="style44">
                <asp:TextBox ID="Building" runat="server" MaxLength="20" Height="15px" 
                    Width="150px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style54">
                Street:</td>
            <td class="style26">
                <asp:TextBox ID="Street" runat="server" MaxLength="30" Height="15px" 
                    Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                    ControlToValidate="Street" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Street is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style53">
                District:</td>
            <td>
                <asp:DropDownList ID="DistrictDropDownList" runat="server" Height="20px">
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
                <asp:TextBox ID="CardHolderName" runat="server" MaxLength="50" Width="150px" 
                    Height="15px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                    ControlToValidate="CardHolderName" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="Cardholder Name is required." ForeColor="Red" 
                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td class="style21">
                Card Type:</td>
            <td colspan="2">
                <asp:DropDownList ID="CardTypeDropDownList" runat="server" Height="20px">
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
                <asp:TextBox ID="CardNumber" runat="server" MaxLength="16" Height="15px" 
                    Width="150px"></asp:TextBox>
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
                <asp:DropDownList ID="MonthDropDownList" runat="server" Height="20px">
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
                <asp:DropDownList ID="YearDropDownList" runat="server" Height="20px" 
                    >
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                    ControlToValidate="YearDropDownList" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Please select a year." ForeColor="Red" 
                    InitialValue="Year" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following errors occurred:" 
    ValidationGroup="RegisterUserValidationGroup" />
    <asp:Button ID="Edit" runat="server" Text="Update" onclick="Edit_Click" />
    <br />
</asp:Content>
