﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="AmountReport.aspx.cs" Inherits="AdminOnly_AmountReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            text-decoration: underline;
        }
        .style3
        {
            width: 100%;
        }
        .style5
        {
            width: 129px;
        }
        .style6
        {
            width: 88px;
        }
        .style7
        {
        }
        .style14
        {
            width: 32px;
        }
        .style15
        {
            width: 19px;
        }
        .style16
        {
        }
        .style19
        {
            width: 33px;
        }
        .style20
        {
        }
        .style22
        {
            width: 129px;
            height: 24px;
        }
        .style23
        {
            width: 88px;
            height: 24px;
        }
        .style24
        {
            height: 24px;
        }
        .style25
        {
            width: 3px;
        }
        .style26
        {
            width: 22px;
        }
        .style27
        {
            width: 17px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2" 
        style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080">
        Purchase Amount Report</p>
    <table class="style3">
        <tr>
            <td class="style5">
                Item bought by user:</td>
            <td class="style5">
                <asp:TextBox ID="userName" runat="server"></asp:TextBox>
            </td>
            <td class="style6">
                (empty for all)</td>
            <td class="style14">
                from</td>
            <td class="style15">
                Year:</td>
            <td class="style15">
                <asp:DropDownList ID="yearFrom" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="yearFrom_SelectedIndexChanged" 
                    ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td class="style25">
                &nbsp;Month:</td>
            <td class="style19">
                <asp:DropDownList ID="monthFrom" runat="server" AutoPostBack="True" 
                    onselectedindexchanged="monthFrom_SelectedIndexChanged" 
                    ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td class="style26">
                Day:</td>
            <td class="style27">
                <asp:DropDownList ID="dayFrom" runat="server" ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style5">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style14">
                to</td>
            <td class="style15">
                Year</td>
            <td class="style15">
                <asp:DropDownList ID="yearTo" runat="server" AutoPostBack="True"
                    onselectedindexchanged="yearTo_SelectedIndexChanged" 
                    ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td class="style25">
                &nbsp;Month:</td>
            <td class="style19">
                <asp:DropDownList ID="monthTo" runat="server" AutoPostBack="True"
                    onselectedindexchanged="monthTo_SelectedIndexChanged" 
                    ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td class="style26">
                Day:</td>
            <td class="style27">
                <asp:DropDownList ID="dayTo" runat="server" ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td>
                <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Invalid range selection." 
                    ForeColor="Red" onservervalidate="CustomValidator1_ServerValidate" 
                    ValidationGroup="purchaseAmount">*</asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td class="style22">
            </td>
            <td class="style22">
            </td>
            <td class="style23">
            </td>
            <td class="style24" colspan="2">
                order by</td>
            <td class="style16" colspan="2" rowspan="2">
                <asp:RadioButtonList ID="orderBy" runat="server" Width="132px" 
                    ValidationGroup="purchaseAmount">
                    <asp:ListItem Value="lastName">Last name</asp:ListItem>
                    <asp:ListItem Value="purchaseAmount">Purchase amount</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="style24" colspan="3">
                <asp:CheckBox ID="groupDistrict" runat="server" Text="Group by District" />
            </td>
            <td class="style24">
            </td>
        </tr>
        <tr>
            <td class="style5">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style7" colspan="2">
                &nbsp;</td>
            <td class="style19">
                <asp:RequiredFieldValidator ID="orderRequire" runat="server" 
                    ControlToValidate="orderBy" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="You need to select one order way." ForeColor="Red" 
                    ValidationGroup="purchaseAmount">*</asp:RequiredFieldValidator>
            </td>
            <td class="style20" colspan="2">
                <asp:Button ID="Button1" runat="server" Text="General Report" 
                    ValidationGroup="purchaseAmount" Width="97px" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <br />
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following error occured:" ValidationGroup="purchaseAmount" />
    <br />
</asp:Content>

