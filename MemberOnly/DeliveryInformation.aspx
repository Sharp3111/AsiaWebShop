﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="DeliveryInformation.aspx.cs" Inherits="MemberOnly_DeliveryInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: x-large;
            color: #000080;
            text-transform: uppercase;
            font-family: "Times New Roman", Times, serif;
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
        .style57
        {
            width: 295px;
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
        .style72
        {
            height: 74px;
        }
        .style75
        {
            width: 302px;
            height: 29px;
        }
        .style76
        {
            width: 245px;
            height: 29px;
        }
        .style77
        {
        }
        .style78
        {
            width: 916px;
            height: 28px;
            color: #000080;
            font-family: "Segoe UI";
        }
        .style79
        {
            width: 245px;
        }
        .style81
        {
            width: 302px;
        }
        .style82
        {
            width: 347px;
        }
        .style83
        {
            width: 347px;
            height: 29px;
        }
        .style84
        {
            height: 29px;
            width: 178px;
        }
        .style85
        {
            width: 178px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong>SPECIFY Delivery Information</strong></p>
<table class="style78">
    <tr>
        <td class="style84">
            User Name:</td>
        <td class="style83">
            <asp:Label ID="UserName" runat="server"></asp:Label>
        </td>
        <td class="style75" colspan="2">
            &nbsp;Email Address:</td>
        <td class="style76">
            <asp:Label ID="email" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style85">
            First Name:</td>
        <td class="style82">
            <asp:TextBox ID="FirstName" runat="server" Height="22px" Width="200px" 
                MaxLength="20"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                ControlToValidate="FirstName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="First Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style81" colspan="2">
            &nbsp;Last Name:</td>
        <td class="style79">
            <asp:TextBox ID="LastName" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                ControlToValidate="LastName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Last Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style85">
            Phone Number:</td>
        <td class="style82">
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
        <td class="style81" colspan="2">
            &nbsp;</td>
        <td class="style79">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style66" colspan="5">
            <br />
            <asp:Label ID="lblAddAddress" runat="server" 
                style="text-transform: uppercase; text-decoration: underline; font-size: medium; font-family: Arial, Helvetica, sans-serif" 
                Text="Add an Address"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style64" colspan="5">
            <asp:Label ID="lblEnterAddrInfo" runat="server" 
                Text="Please enter your delivery address information:"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style85">
            <asp:Label ID="lblBuilding" runat="server" Text="Building:"></asp:Label>
        </td>
        <td class="style82">
            <asp:TextBox ID="Building" runat="server" Height="22px" Width="200px" 
                MaxLength="20"></asp:TextBox>
        </td>
        <td class="style81" colspan="2">
            <table class="style3" __designer:mapid="51d">
                <tr __designer:mapid="51e">
                    <td class="style7" __designer:mapid="51f">
                        <asp:Label ID="lblFloor" runat="server" Text="&nbsp;Floor: "></asp:Label>
                    </td>
                    <td __designer:mapid="520">
                        <asp:TextBox ID="Floor" runat="server" Width="40px" Height="22px" MaxLength="3"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
        <td class="style79">
            <table class="style3" __designer:mapid="523">
                <tr __designer:mapid="524">
                    <td class="style8" __designer:mapid="525">
                        <asp:Label ID="lblFlatSuite" runat="server" Text="Flat/Suite:"></asp:Label>
                    </td>
                    <td class="style29" __designer:mapid="526">
                        <asp:TextBox ID="FlatSuite" runat="server" Width="40px" Height="22px" 
                            MaxLength="5"></asp:TextBox>
                    </td>
                    <td class="style10" __designer:mapid="528">
                        <asp:Label ID="lblBlockTower" runat="server" Text="Block/Tower:"></asp:Label>
                    </td>
                    <td __designer:mapid="529">
                        <asp:TextBox ID="BlockTower" runat="server" Width="40px" Height="22px" 
                            MaxLength="2"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td class="style85">
            <asp:Label ID="lblStreet" runat="server" Text="Street:"></asp:Label>
        </td>
        <td class="style82">
            <asp:TextBox ID="Street" runat="server" Height="22px" Width="200px" 
                MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvStreet" runat="server" 
                ControlToValidate="Street" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Street is required." ForeColor="Red" 
                ValidationGroup="AddAddressValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style81" colspan="2">
            <asp:Label ID="lblDistrict" runat="server" Text="District:"></asp:Label>
        </td>
        <td class="style79">
            <asp:DropDownList ID="DistrictDropDownList" runat="server" 
                Height="22px" style="margin-left: 0px" Width="200px" 
                onselectedindexchanged="DistrictDropDownList0_SelectedIndexChanged">
                <asp:ListItem Value="0">-- Select district --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDistrict" runat="server" 
                ControlToValidate="DistrictDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a district." 
                ForeColor="Red" InitialValue="0" 
                ValidationGroup="AddAddressValidationGroup">*</asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td class="style84">
            <asp:Label ID="lblNickname" runat="server" Text="Nickname:"></asp:Label>
        </td>
        <td class="style83">
            <asp:TextBox ID="Nickname" runat="server" MaxLength="10" 
                            Text='<%# Bind("nickname") %>' Height="22px" Width="160px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvNickname" runat="server" 
                            ControlToValidate="Nickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname is required." ForeColor="Red" 
                ValidationGroup="AddAddressValidationGroup">*</asp:RequiredFieldValidator>
            <asp:CustomValidator ID="cvNickname" runat="server" 
                            ControlToValidate="Nickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname already exists." ForeColor="Red" 
                            onservervalidate="cvInsertNickname_ServerValidate" 
                ValidationGroup="AddAddressValidationGroup">*</asp:CustomValidator>
            <asp:RegularExpressionValidator ID="revNickname" runat="server" 
                            ControlToValidate="Nickname" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Nickname must be alphanumeric only." ForeColor="Red" 
                            ValidationExpression="^[a-zA-Z0-9]+$" 
                ValidationGroup="AddAddressValidationGroup">*</asp:RegularExpressionValidator>
        </td>
        <td class="style75" colspan="2">
            </td>
        <td class="style76">
        </td>
    </tr>
    <tr>
        <td class="style64" colspan="5">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnAddYourAddress" runat="server" onclick="btnAddYourAddress_Click" 
            Text="Add Your Address" ValidationGroup="AddAddressValidationGroup" 
                Height="30px" 
                style="font-size: medium; font-family: 'Times New Roman', Times, serif" 
                Width="200px" />
                    </td>
    </tr>
    <tr>
        <td class="style64" colspan="5">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                    </td>
    </tr>
    <tr>
        <td class="style65" colspan="2">
            <br />
            <asp:Label ID="lblSelectAddress" runat="server" 
                Text="OR Select a delivery address"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style85">
            <asp:Label ID="lblDeliveryAddress" runat="server" Text="Delivery Address:"></asp:Label>
        </td>
        <td class="style57" colspan="2">
            <asp:DropDownList ID="AddressDropDownList" runat="server" 
                onselectedindexchanged="AddressDropDownList_SelectedIndexChanged" 
                Height="22px">
                <asp:ListItem Value="0">-- Select an Address --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvAddressDropDownList" runat="server" 
                ControlToValidate="AddressDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select an address." 
                ForeColor="Red" InitialValue="0" 
                ValidationGroup="ChooseAddressValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style5" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style85">
            &nbsp;</td>
        <td class="style57" colspan="2">
            &nbsp;</td>
        <td class="style5" colspan="2">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style64" colspan="5">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnChooseAddress" runat="server" onclick="btnChooseAddress_Click" 
                Text="Choose Your Address" ValidationGroup="ChooseAddressValidationGroup" 
                Height="30px" 
                style="font-family: 'Times New Roman', Times, serif; font-size: medium" 
                Width="200px" />
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
    </tr>
    <tr>
        <td class="style64" colspan="5">
            &nbsp;</td>
    </tr>
    <tr>
        <td class="style85">
            <asp:Label ID="lblFinalAddress" runat="server" 
                Text="Now your delivery address is: " Visible="False"></asp:Label>
        </td>
        <td class="style64" colspan="4">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="Address" runat="server" Visible="False"></asp:Label>
        </td>
    </tr>
    <tr>
        <td class="style77" colspan="5">
        <asp:Label ID="lblMessage0" runat="server" ForeColor="Red"></asp:Label>
                    </td>
    </tr>
    <tr>
        <td class="style72" colspan="5">
            <br />
            <br />
            <span class="style67">Specify Delivery Time</span></td>
    </tr>
    <tr>
        <td class="style85">
            Delivery Date:</td>
        <td class="style82">
            <asp:DropDownList ID="DeliveryDateDropDownList" runat="server" Height="22px" 
                Width="160px">
                <asp:ListItem Value="0">-- Select a Date --</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="rfvDeliveryDate" runat="server" 
                ControlToValidate="DeliveryDateDropDownList" Display="Dynamic" 
                EnableClientScript="False" ErrorMessage="Please select a delivery date." 
                ForeColor="Red" InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
        </td>
        <td class="style81" colspan="2">
            Delivery Time:</td>
        <td class="style79">
            <asp:DropDownList ID="DeliveryTimeDropDownList" runat="server" Height="22px" 
                Width="160px">
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
            ValidationGroup="RegisterUserValidationGroup" Height="30px" 
            style="font-family: 'Times New Roman', Times, serif; font-size: medium" 
            Width="300px" />
    </p>
            <asp:Label ID="lblMessage1" runat="server" ForeColor="Red"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary3" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following error(s) occurred:" 
        ValidationGroup="AddAddressValidationGroup" />
    <p>
    </p>
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following error(s) occurred:" 
        ValidationGroup="ChooseAddressValidationGroup" />
    <p>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="The following error(s) occurred:" 
        ValidationGroup="RegisterUserValidationGroup" />
    <p>
    </p>
</asp:Content>

