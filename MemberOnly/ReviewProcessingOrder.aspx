<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ReviewProcessingOrder.aspx.cs" Inherits="MemberOnly_ReviewProcessingOrder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: x-large;
            color: #000080;
            text-transform: capitalize;
            font-weight: bold;
            font-family: "Times New Roman", Times, serif;
        }
        .style3
        {
            font-size: medium;
            color: #000080;
            }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        Review processing orders</p>
    <p class="style3">
        Dear
        <asp:Label ID="UserName" runat="server"></asp:Label>
        , your processing order information is as follows:</p>
    <p class="style3">
        <asp:GridView ID="gvDeliveryTime" runat="server" CellPadding="4" 
            ForeColor="#333333" GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="cbOrderRecord" runat="server" AutoPostBack="True" 
                            oncheckedchanged="cbOrderRecord_CheckedChanged" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
    </p>
    <p class="style3">
        <asp:Button ID="btnNext" runat="server" onclick="btnNext_Click" Text="Edit" 
            Height="30px" 
            style="font-family: 'Times New Roman', Times, serif; font-size: medium" 
            Width="80px" />
    </p>
    <p class="style3">
        <asp:Label ID="Label1" runat="server" Font-Underline="False" ForeColor="Red"></asp:Label>
    </p>
</asp:Content>

