<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="PaymentInformation.aspx.cs" Inherits="MemberOnly_PaymentInformation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: large;
            text-decoration: underline;
            color: #0000FF;
        }
        .style3
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: medium;
            color: #0000FF;
        }
        .style4
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: medium;
            color: #0000FF;
            text-decoration: underline;
            text-transform: uppercase;
        }
        .style5
        {
            font-family: Arial, Helvetica, sans-serif;
            font-size: small;
            color: #0000FF;
        }
        .style6
        {
            width: 100%;
        }
        .style7
        {
            text-decoration: underline;
            color: #0000FF;
            font-size: medium;
            text-transform: uppercase;
        }
        .style8
        {
            color: #0000FF;
        }
        .style9
        {
            width: 469px;
        }
        .style10
        {
            font-family: "Segoe UI";
            color: #000080;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <h1 class="style2">
        <strong style="font-weight: 700; color: #0000CC">Specify Payment Information</strong></h1>
    <p class="style3">
        Dear
        <asp:Label ID="UserName" runat="server"></asp:Label>
        , Asia Web Shop only accept major credit cards:</p>
    <p class="style4">
        Add a card</p>
    <p class="style5">
        Enter your card information:</p>
    <table class="style6">
        <tr>
            <td class="style9">
                <span class="style10">Cardholder Name:&nbsp; </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="CardHolderName" runat="server" 
                    ValidationGroup="RegisterUserValidationGroup" MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                ControlToValidate="CardholderName" Display="Dynamic" EnableClientScript="False" 
                ErrorMessage="Cardholder Name is required." ForeColor="Red" 
                ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
            </td>
            <td>
                <span class="style10">Card Type:
            </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:DropDownList ID="CardTypeDropDownList" runat="server" 
                Width="250px" Height="22px" ValidationGroup="RegisterUserValidationGroup">
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
            <td class="style9">
                <span class="style10">Card Number:&nbsp;&nbsp;&nbsp; </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:TextBox ID="CardNumber" runat="server" 
                    ValidationGroup="RegisterUserValidationGroup" MaxLength="16"></asp:TextBox>
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
            <td>
                <span class="style10">Expiry Date:&nbsp; </span>&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="MonthDropDownList" runat="server" 
                            Height="22px" Width="110px" CausesValidation="True" 
                            ValidationGroup="RegisterUserValidationGroup">
                            <asp:ListItem Value="00">Month</asp:ListItem>
                            <asp:ListItem>01</asp:ListItem>
                            <asp:ListItem>02</asp:ListItem>
                            <asp:ListItem>03</asp:ListItem>
                            <asp:ListItem Value="04"></asp:ListItem>
                            <asp:ListItem Value="05"></asp:ListItem>
                            <asp:ListItem Value="06"></asp:ListItem>
                            <asp:ListItem Value="07"></asp:ListItem>
                            <asp:ListItem Value="08"></asp:ListItem>
                            <asp:ListItem Value="09"></asp:ListItem>
                            <asp:ListItem Value="10"></asp:ListItem>
                            <asp:ListItem Value="11"></asp:ListItem>
                            <asp:ListItem Value="12"></asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvMonth" runat="server" 
                            ControlToValidate="MonthDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a month." 
                            ForeColor="Red" InitialValue="00" 
                            ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                    &nbsp;<span class="style10">/</span> 
                        <asp:DropDownList ID="YearDropDownList" runat="server" 
                            Height="22px" Width="110px" 
                    ValidationGroup="RegisterUserValidationGroup">
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                            ControlToValidate="YearDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a year." ForeColor="Red" 
                            InitialValue="0" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="cvExpiryDate" runat="server" 
                            ControlToValidate="MonthDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Credit card is expired." 
                            ForeColor="Red" onservervalidate="cvExpiryDate_ServerValidate" 
                            ValidationGroup="RegisterUserValidationGroup">*</asp:CustomValidator>
                    </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center">
                <br />
        <asp:Button ID="btAddYourCard" runat="server" onclick="btAddYourCard_Click" 
            Text="Add Your Card" ValidationGroup="RegisterUserValidationGroup" 
                    BackColor="Silver" BorderColor="Silver" BorderStyle="Solid" />
                    </td>
        </tr>
    </table>
    <p class="style7">
        Or Select a card from your credit card List
    </p>
    <p>
        <asp:GridView ID="gvCreditCard" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" 
            ForeColor="#333333" GridLines="None" Width="918px"> 
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            oncheckedchanged="CheckBox1_CheckedChanged1" Text=" " />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="cardHolderName" HeaderText="Cardholder Name" 
                    SortExpression="cardHolderName" />
                <asp:BoundField DataField="type" HeaderText="Type" SortExpression="type" />
                <asp:BoundField DataField="number" HeaderText="Number" 
                    SortExpression="number" />
                <asp:BoundField DataField="expiryMonth" HeaderText="Expiry Month" 
                    SortExpression="expiryMonth" />
                <asp:BoundField DataField="expiryYear" HeaderText="Expiry Year" 
                    SortExpression="expiryYear" />
                <asp:CheckBoxField DataField="creditCardDefault" HeaderText="Default" 
                    SortExpression="creditCardDefault" />
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
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT [cardHolderName], [type], [number], [expiryMonth], [expiryYear], [creditCardDefault] FROM [CreditCard] WHERE ([userName] = @userName)">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
    <p>
        <asp:Label ID="SelectOneCardOnlyMessage" runat="server" ForeColor="Red"></asp:Label>
&nbsp;</p>
    <p>
        <asp:Label ID="SelectCardMessage" runat="server" ForeColor="Red"></asp:Label>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" HeaderText="The following errors:" 
        ValidationGroup="RegisterUserValidationGroup" />
    <p>
    </p>
    <p class="style8">
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="btSelectThisCard" runat="server" onclick="btContinue_Click" 
            Text="Select This Card" CausesValidation="False" BackColor="Silver" 
            BorderColor="Silver" BorderStyle="Solid" />
    &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btNextStep" runat="server" onclick="btContinue_Click" 
            Text="Next: Final Confirmation" CausesValidation="False" 
            PostBackUrl="~/MemberOnly/FinalConfirmation.aspx" BackColor="Silver" 
            BorderColor="Silver" BorderStyle="Solid" />
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </p>
</asp:Content>

