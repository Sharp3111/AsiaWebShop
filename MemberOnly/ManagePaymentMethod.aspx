﻿<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ManagePaymentMethod.aspx.cs" Inherits="MemberOnly_PaymentMethodManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: x-large;
            text-transform: uppercase;
            font-family: "Times New Roman", Times, serif;
        }
        .style3
        {
            font-size: medium;
            color: #0000FF;
        }
        .style4
        {
            font-size: medium;
            color: #000080;
        }
        .style5
        {
            color: #000080;
        }
        .style6
        {
            font-size: small;
            color: #008080;
            font-family: "Segoe UI";
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong style="font-weight: 700; " class="style5">Manage Payment Information</strong></p>
    <p class="style4">
        Dear
        <asp:Label ID="UserName" runat="server"></asp:Label>
        , your credit card information is as follows:</p>
    <p class="style6">
        To add a new credit card, select any arbitary card below and then click &quot;New&quot; at the 
        bottom.</p>
    <p class="style3">
        <asp:GridView ID="gvCreditCard" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" DataKeyNames = "number,userName"
            GridLines="None" Width="915px" onselectedindexchanged="gvCreditCard_SelectedIndexChanged" 
            >
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    SortExpression="userName" Visible="False" ReadOnly="True" />
                <asp:TemplateField HeaderText="Card Number" SortExpression="number">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("number") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="cardNumber" runat="server" Text='<%# Bind("number") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Card Type" SortExpression="type">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("type") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="cardType" runat="server" Text='<%# Bind("type") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cardholder Name" SortExpression="cardHolderName">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("cardHolderName") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="cardHolderName" runat="server" 
                            Text='<%# Bind("cardHolderName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Expiry Month" SortExpression="expiryMonth">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("expiryMonth") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="expiryMonth" runat="server" Text='<%# Bind("expiryMonth") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Expiry Year" SortExpression="expiryYear">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("expiryYear") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="expiryYear" runat="server" Text='<%# Bind("expiryYear") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Default" SortExpression="creditCardDefault">
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="default" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="RemoveButton" runat="server" onclick="RemoveButton_Click" 
                            Text="Remove" Height="30px" 
                            style="font-family: 'Times New Roman', Times, serif; font-size: medium" 
                            Width="100px" />
                    </ItemTemplate>
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
        <asp:DetailsView ID="dvCreditCard" runat="server" AutoGenerateRows="False" 
            CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" 
            GridLines="None" Height="50px" Width="696px" 
            oniteminserted="dvCreditCard_ItemInserted1" 
            oniteminserting="dvCreditCard_ItemInserting" 
            onitemupdated="dvCreditCard_ItemUpdated" 
            onitemupdating="dvCreditCard_ItemUpdating" onload="dvCreditCard_Load" 
            ondatabound="dvCreditCard_DataBound">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:TemplateField HeaderText="User Name" SortExpression="userName">
                    <EditItemTemplate>
                        <asp:Label ID="EditUserName" runat="server" Text='<%# Bind("userName") %>' onload="InsertUserName_Load"></asp:Label>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:Label ID="InsertUserName" runat="server" Text='<%# Bind("userName") %>' onload="InsertUserName_Load"></asp:Label>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("userName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Card Number" SortExpression="number">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditCardNumber" runat="server" MaxLength="16" 
                            Text='<%# Bind("number") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                            ControlToValidate="EditCardNumber" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Card Number is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                            ControlToValidate="EditCardNumber" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Card Number must be numeric and between 14 and 16 digits." 
                            ForeColor="Red" ValidationExpression="^\d{14,16}$">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvEditCardNumber" runat="server" 
                            ControlToValidate="EditCardNumber" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="This card has existed in your credit card list. Please try another one." 
                            ForeColor="Red" onservervalidate="cvEditCardNumber_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertCardNumber" runat="server" MaxLength="16" 
                            Text='<%# Bind("number") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                            ControlToValidate="InsertCardNumber" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Card Number is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                            ControlToValidate="InsertCardNumber" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Card Number must be numeric and between 14 and 16 digits." 
                            ForeColor="Red" ValidationExpression="^\d{14,16}$">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvInsertCardNumber" runat="server" 
                            ControlToValidate="InsertCardNumber" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="This card has existed in your credit card list. Please try another one." 
                            ForeColor="Red" onservervalidate="cvInsertCardNumber_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="LabelCardNumber" runat="server" Text='<%# Bind("number") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Card Type" SortExpression="type">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditCardType" runat="server" Text='<%# Bind("type") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditCardType" runat="server" 
                            ControlToValidate="EditCardType" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Credit card type is required. You can choose from the following: American Express, Diners Club, Discover, MasterCard, Visa." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditCardType" runat="server" 
                            ControlToValidate="EditCardType" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="You have to choose from the following: American Express, Diners Club, Discover, MasterCard, Visa." 
                            ForeColor="Red" onservervalidate="cvEditCardType_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertCardType" runat="server" Text='<%# Bind("type") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditCardType" runat="server" 
                            ControlToValidate="InsertCardType" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="The credit card is required. You can choose from the following: American Express, Diners Club, Discover, MasterCard, Visa." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertCardType" runat="server" 
                            ControlToValidate="InsertCardType" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="You have to choose from the following: American Express, Diners Club, Discover, MasterCard, Visa." 
                            ForeColor="Red" onservervalidate="cvInsertCardType_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("type") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cardholder Name" SortExpression="cardHolderName">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditCardholderName" runat="server" MaxLength="50" 
                            Text='<%# Bind("cardHolderName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                            ControlToValidate="EditCardholderName" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Cardholder Name is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEditCardholderName" runat="server" 
                            ControlToValidate="EditCardholderName" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Cardholder name can only contain alphabet and spaces." 
                            ForeColor="Red" ValidationExpression="^[a-zA-Z\s]+$">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertCardholderName" runat="server" MaxLength="50" 
                            Text='<%# Bind("cardHolderName") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                            ControlToValidate="InsertCardholderName" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Cardholder Name is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertCardholderName" runat="server" 
                            ControlToValidate="InsertCardholderName" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Cardholder name can only contain alphabet and spaces." 
                            ForeColor="Red" ValidationExpression="^[a-zA-Z\s]+$">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("cardHolderName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Expiry Month" SortExpression="expiryMonth">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditExpiryMonth" runat="server" MaxLength="2" 
                            Text='<%# Bind("expiryMonth") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditExpiryMonth" runat="server" 
                            ControlToValidate="EditExpiryMonth" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Expiry Month is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvEditExpiryMonth" runat="server" 
                            ControlToValidate="EditExpiryMonth" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="You can only choose from the following: 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12" 
                            ForeColor="Red" onservervalidate="cvEditExpiryMonth_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertExpiryMonth" runat="server" MaxLength="2" 
                            Text='<%# Bind("expiryMonth") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditExpiryMonth" runat="server" 
                            ControlToValidate="InsertExpiryMonth" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Expiry Month is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvInsertExpiryMonth" runat="server" 
                            ControlToValidate="InsertExpiryMonth" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="You can only choose from the following: 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12" 
                            ForeColor="Red" onservervalidate="cvInsertExpiryMonth_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("expiryMonth") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Expiry Year" SortExpression="expiryYear">
                    <EditItemTemplate>
                        <asp:TextBox ID="EditExpiryYear" runat="server" MaxLength="4" 
                            Text='<%# Bind("expiryYear") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditExpiryYear" runat="server" 
                            ControlToValidate="EditExpiryYear" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Expiry year is required." ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revEditExpiryYear" runat="server" 
                            ControlToValidate="EditExpiryYear" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Year should have the form yyyy. For example, 1999." 
                            ForeColor="Red" ValidationExpression="^\d{4}$">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvEditExpiryYear" runat="server" 
                            ControlToValidate="EditExpiryYear" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Your credit card is expired. Please try another one." 
                            ForeColor="Red" onservervalidate="cvEditExpiryYear_ServerValidate">*</asp:CustomValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="InsertExpiryYear" runat="server" MaxLength="4" 
                            Text='<%# Bind("expiryYear") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvInsertExpiryYear" runat="server" 
                            ControlToValidate="InsertExpiryYear" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Expiry year is required." 
                            ForeColor="Red">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revInsertExpiryYear" runat="server" 
                            ControlToValidate="InsertExpiryYear" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Year should have the form yyyy. For example, 1999." 
                            ForeColor="Red" ValidationExpression="^\d{4}$">*</asp:RegularExpressionValidator>
                        <asp:CustomValidator ID="cvInsertExpiryYear" runat="server" 
                            ControlToValidate="InsertExpiryYear" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Your credit card is expired. Please try another one." 
                            ForeColor="Red" onservervalidate="cvInsertExpiryYear_ServerValidate">*</asp:CustomValidator>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("expiryYear") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Credit Card Default" 
                    SortExpression="creditCardDefault" Visible="False">
                    <EditItemTemplate>
                        <asp:CheckBox ID="EditCreditCardDefault" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' 
                            oncheckedchanged="EditCreditCardDefault_CheckedChanged" />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="InsertCreditCardDefault" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' AutoPostBack="True" 
                            oncheckedchanged="InsertCreditCardDefault_CheckedChanged" />
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' Enabled="false" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ShowEditButton="True" 
                    ShowInsertButton="True" />
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" />
    <p>
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </p>
    <p>
        <asp:Button ID="Return" runat="server" BackColor="Silver" BorderColor="Silver" 
            BorderStyle="Solid" Height="30px" 
            PostBackUrl="~/MemberOnly/EditMemberInformation.aspx" 
            Text="Return to Manage Member Information" Width="300px" />
    </p>
    <p>
        &nbsp;</p>
    <p class="style3">
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT * FROM [CreditCard] WHERE ([userName] = @userName) ORDER BY [number]">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style3">
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT * FROM [CreditCard] WHERE ([userName] = @userName AND [number] = @number)" 
            DeleteCommand="DELETE FROM [CreditCard] WHERE ([number] = @number)" 
            InsertCommand="INSERT INTO [CreditCard] ([userName], [cardHolderName], [type], [number], [expiryMonth], [expiryYear]) VALUES (@userName, @cardHolderName, @type, @number, @expiryMonth, @expiryYear)" 
            
            
            
            
            
            UpdateCommand="UPDATE CreditCard SET cardHolderName = @cardHolderName, type = @type, number = @number, expiryMonth = @expiryMonth, expiryYear = @expiryYear WHERE (userName = @userName) AND (isSelected = 'true')">
            <DeleteParameters>
                <asp:Parameter Name="number" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userName" />
                <asp:Parameter Name="cardHolderName" />
                <asp:Parameter Name="type" />
                <asp:Parameter Name="number" />
                <asp:Parameter Name="expiryMonth" />
                <asp:Parameter Name="expiryYear" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" 
                    PropertyName="Text" />
                <asp:ControlParameter ControlID="gvCreditCard" Name="number" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="cardHolderName" />
                <asp:Parameter Name="type" />
                <asp:Parameter Name="number" />
                <asp:Parameter Name="expiryMonth" />
                <asp:Parameter Name="expiryYear" />
                <asp:Parameter Name="userName" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style3">
        &nbsp;</p>
</asp:Content>

