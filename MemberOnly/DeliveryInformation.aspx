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
        .style5
    {
        }
        .style51
        {
            width: 289px;
        }
        .style53
        {
            width: 268435136px;
        }
        .style56
        {
            width: 206px;
        }
        .style57
        {
            width: 199px;
        }
        .style64
        {
        }
        .style65
        {
            height: 54px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: medium;
            text-transform: uppercase;
            text-decoration: underline;
        }
        .style66
        {
            height: 66px;
        }
        .style67
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: medium;
            text-transform: uppercase;
            text-decoration: underline;
            border-left-color: #A0A0A0;
            border-right-color: #C0C0C0;
            border-top-color: #A0A0A0;
            border-bottom-color: #C0C0C0;
            padding: 1px;
        }
        .style69
        {
            width: 289px;
            height: 74px;
        }
        .style70
        {
            width: 206px;
            height: 74px;
        }
        .style71
        {
            width: 268435136px;
            height: 74px;
        }
        .style72
        {
            height: 74px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong>SPECIFY Delivery Information</strong></p>
<table class="style3">
    <tr>
        <td class="style64">
            User Name:</td>
        <td class="style51">
            <asp:Label ID="UserName" runat="server"></asp:Label>
        </td>
        <td class="style56" colspan="2">
            &nbsp;Email Address:</td>
        <td class="style53">
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
        <td class="style64">
            First Name:</td>
        <td class="style51">
            <asp:TextBox ID="FirstName" runat="server" Height="22px" Width="200px" 
                MaxLength="20"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                ControlToValidate="FirstName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="First Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style56" colspan="2">
            &nbsp;Last Name:</td>
        <td class="style53">
            <asp:TextBox ID="LastName" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                ControlToValidate="LastName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Last Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style64">
            Phone Number:</td>
        <td class="style51">
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
        <td class="style56" colspan="2">
            &nbsp;</td>
        <td class="style53">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style66" colspan="5">
            <br />
            <span class="style67">Add an Address</span></td>
    </tr>
    <tr>
        <td class="style64" colspan="5">
            Please enter your delivery address information:</td>
    </tr>
    <tr>
        <td class="style64">
            Building:</td>
        <td class="style51">
            <asp:TextBox ID="Building" runat="server" Height="22px" Width="200px" 
                MaxLength="20"></asp:TextBox>
        </td>
        <td class="style56" colspan="2">
            <table class="style3" __designer:mapid="51d">
                <tr __designer:mapid="51e">
                    <td class="style7" __designer:mapid="51f">
                        &nbsp;Floor</td>
                    <td __designer:mapid="520">
                        <asp:TextBox ID="Floor" runat="server" Width="40px" Height="22px" MaxLength="3"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td class="style53">
            <table class="style3" __designer:mapid="523">
                <tr __designer:mapid="524">
                    <td class="style8" __designer:mapid="525">
                        Flat/Suite:</td>
                    <td class="style29" __designer:mapid="526">
                        <asp:TextBox ID="FlatSuite" runat="server" Width="40px" Height="22px" 
                            MaxLength="5"></asp:TextBox>
                    </td>
                    <td class="style10" __designer:mapid="528">
                        Block/Tower:</td>
                    <td __designer:mapid="529">
                        <asp:TextBox ID="BlockTower" runat="server" Width="40px" Height="22px" 
                            MaxLength="2"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="style64">
            Street:</td>
        <td class="style51">
            <asp:TextBox ID="Street" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                ControlToValidate="Street" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Street is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style56" colspan="2">
            District:</td>
        <td class="style53">
            <asp:DropDownList ID="DistrictDropDownList" runat="server" 
                Height="22px" style="margin-left: 0px" Width="205px" 
                onselectedindexchanged="DistrictDropDownList0_SelectedIndexChanged">
                <asp:ListItem Value="0">-- Select district --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                ControlToValidate="DistrictDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a district." 
                ForeColor="Red" InitialValue="0" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style64" colspan="5">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btAddYourAddress" runat="server" onclick="btAddYourCard_Click" 
            Text="Add Your Address" ValidationGroup="RegisterUserValidationGroup" 
                    BackColor="Silver" BorderColor="Silver" BorderStyle="Solid" />
                    </td>
    </tr>
    <tr>
        <td class="style65" colspan="2">
            <br />
            OR Select a delivery address</td>
    </tr>
    <tr>
        <td class="style64">
            Delivery Address:</td>
        <td class="style57" colspan="2">
            <asp:DropDownList ID="AddressDropDownList" runat="server" AutoPostBack="True" 
                onselectedindexchanged="AddressDropDownList_SelectedIndexChanged">
                <asp:ListItem Value="0">-- Select an Address --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvAddressDropDownList" runat="server" 
                ControlToValidate="AddressDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select an address." 
                ForeColor="Red" InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style5" colspan="2">
            <asp:Label ID="Address" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style72">
            </td>
        <td class="style69">
        </td>
        <td class="style70" colspan="2">
            </td>
        <td class="style71">
        </td>
    </tr>
    <tr>
        <td class="style64">
            Delivery Date:</td>
        <td class="style51">
            <asp:DropDownList ID="DeliveryDateDropDownList" runat="server">
                <asp:ListItem Value="0">-- Select a Date --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDeliveryDate" runat="server" 
                ControlToValidate="DeliveryDateDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a delivery date." 
                ForeColor="Red" InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style56" colspan="2">
            Delivery Time:</td>
        <td class="style53">
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
        &nbsp;</p>
    <p>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="ContinueButton" runat="server" onclick="ContinueButton_Click" 
            Text="Next: Specify Payment Information" 
            ValidationGroup="RegisterUserValidationGroup" BackColor="Silver" 
            BorderColor="Silver" BorderStyle="Solid" />
    </p>
    <p>
        &nbsp;</p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following error(s) occurred:" 
        ValidationGroup="RegisterUserValidationGroup" />
    <p>
    </p>
</asp:Content>

