﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ChangeDeliveryInformationDisplay.aspx.cs" Inherits="MemberOnly_ChangeDeliveryInformationDisplay" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: medium; color: #FF0000">
&nbsp;Your delivery information has changed successfully.
    </p>
    <p style="font-family: Arial, Helvetica, sans-serif; font-size: medium; color: #FF0000">
&nbsp;The notification has been sent to both old email address and new email address of 
        your delivery information.</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Button1" runat="server" PostBackUrl="~/Default.aspx" 
            Text="Back to Homepage" />
    </p>
</asp:Content>

