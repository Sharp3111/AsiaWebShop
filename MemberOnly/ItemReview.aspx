<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemReview.aspx.cs" Inherits="MemberOnly_ItemReview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p>
        Item Review</p>
    <p>
        Please specify the item you want to review:
        <asp:TextBox ID="itemName" runat="server" Height="22px" Width="240px"></asp:TextBox>
    </p>
    <p>
        Please rate the following aspects of the item from 1 to 5 (required):</p>
    <p>
        Quality:
    </p>
    <p>
        Features:</p>
    <p>
        Performance:
    </p>
    <p>
        Appearance:
    </p>
    <p>
        Durability:
    </p>
    <p>
        &nbsp;</p>
    <p>
        Please write a comment for the item you are reviewing (optional):</p>
</asp:Content>

