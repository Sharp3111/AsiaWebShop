<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="RecommendationManagement.aspx.cs" Inherits="AdminOnly_RecommendationManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-family: "Times New Roman", Times, serif;
            font-size: x-large;
            color: #000080;
        }
        .style3
        {
            color: #000080;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong>Recommendation Management</strong></p>
    <p class="style3">
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
    </p>
    <p class="style3">
        <strong>Part I</strong>. Please indicate the recommendation table you want to 
        update.</p>
    <asp:RadioButtonList ID="rangeRadioButtonList" runat="server"         
        style="color: #000080; font-family: 'Segoe UI'" 
        
        RepeatDirection="Horizontal" Width="938px">
        <asp:ListItem Selected="True" Value="0">Daily Recommnendation</asp:ListItem>
        <asp:ListItem Value="1">Weekly Recommendation</asp:ListItem>
        <asp:ListItem Value="2">Monthly Recommendation</asp:ListItem>
        <asp:ListItem Value="3">Yearly Recommendation</asp:ListItem>
    </asp:RadioButtonList>
    <p>
        <span class="style3"><strong>Part II</strong>. Please specify the UPC of the 
        item that you want to add to the ranking table specified in <strong>Part I</strong>. 
        A list of the items put on sale with their UPC is appended.</p>
    <p>
        UPC of the item you want to add: </span>
    </p>
    <p>
        <asp:TextBox ID="txtUPC" runat="server" Width="150px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="rfvUPC" runat="server" 
                            ControlToValidate="txtUPC" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="UPC is required." ForeColor="Red" 
            ValidationGroup="recommendationManagementValidationGroup">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="revUPC" runat="server" 
                            ControlToValidate="txtUPC" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="UPC must be exactly 12 digits." ForeColor="Red" 
                            ValidationExpression="^\d{12}$" 
            ValidationGroup="recommendationManagementValidationGroup">*</asp:RegularExpressionValidator>
        <asp:CustomValidator ID="cvUPC" runat="server" Display="Dynamic" 
                            EnableClientScript="False" 
            ErrorMessage="The item with this UPC has zero quantity available." ForeColor="Red" 
                            
            ControlToValidate="txtUPC" 
            ValidationGroup="recommendationManagementValidationGroup">*</asp:CustomValidator>
        <asp:CustomValidator ID="cvUPC2" runat="server" Display="Dynamic" 
            EnableClientScript="False" 
            ErrorMessage="The item with this UPC has existed in the specified recommendation table." 
            ForeColor="Red" ValidationGroup="recommendationManagementValidationGroup">*</asp:CustomValidator>
    </p>
    <p class="style3">
        A list of the items put on sale:</p>
    <p>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataKeyNames="upc" DataSourceID="SqlDataSource" 
            ForeColor="#333333" GridLines="None" Width="392px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:BoundField DataField="upc" HeaderText="upc" ReadOnly="True" 
                    SortExpression="upc" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="discountPrice" HeaderText="discountPrice" 
                    SortExpression="discountPrice" />
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
        <strong>Part III</strong>. Please indicate the ranking in the recommendation 
        table:</p>
    <p>
        <asp:RadioButtonList ID="rankingRadioButtonList" runat="server" 
            RepeatDirection="Horizontal" style="color: #000080" Width="599px">
            <asp:ListItem Selected="True">1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
        </asp:RadioButtonList>
    </p>
    <p>
        <asp:Button ID="submitButton" runat="server" Height="30px" 
            onclick="submitButton_Click" 
            style="font-size: medium; font-family: 'Times New Roman', Times, serif" 
            Text="Submit" ValidationGroup="recommendationManagementValidationGroup" 
            Width="150px" />
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="Return" runat="server" Height="30px" 
            style="font-size: medium; font-family: 'Times New Roman', Times, serif" 
            Text="Return To Admin Management Page" Width="300px" 
            PostBackUrl="~/AdminOnly/AdminManagement.aspx" />
    </p>
    <asp:ValidationSummary ID="ValidationSummary" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" 
        ValidationGroup="recommendationManagementValidationGroup" />
    <p>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT [upc], [name], [discountPrice] FROM [Item] WHERE ([visible] = 'True') ORDER BY [upc]">
        </asp:SqlDataSource>
    </p>
</asp:Content>

