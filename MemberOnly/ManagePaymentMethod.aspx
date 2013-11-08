<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ManagePaymentMethod.aspx.cs" Inherits="MemberOnly_PaymentMethodManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: large;
            text-decoration: underline;
            text-transform: uppercase;
        }
        .style3
        {
            font-size: medium;
            color: #0000FF;
        }
        .style4
        {
            font-size: medium;
            text-decoration: underline;
            color: #000080;
        }
        .style5
        {
            color: #000080;
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
    <p class="style3">
        <asp:GridView ID="gvCreditCard" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" DataKeyNames = "number, userName"
            GridLines="None" Width="915px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    SortExpression="userName" Visible="False" />
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
            GridLines="None" Height="50px" Width="914px">
            <AlternatingRowStyle BackColor="White" />
            <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
            <EditRowStyle BackColor="#2461BF" />
            <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
            <Fields>
                <asp:BoundField DataField="userName" HeaderText="userName" 
                    SortExpression="userName" Visible="False" />
                <asp:TemplateField HeaderText="Card Number" SortExpression="number">
                    <ItemTemplate>
                        <asp:Label ID="cardNumber" runat="server" Text='<%# Bind("number") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="editCardNumber" runat="server" MaxLength="16" 
                            Text='<%# Bind("number") %>' ValidationGroup="CreditCardValidationGroup"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                            ControlToValidate="editCardNumber" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Card Number is required." ForeColor="Red" 
                            ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                            ControlToValidate="editCardNumber" Display="Dynamic" EnableClientScript="False" 
                            ErrorMessage="Card Number must be numeric and between 14 and 16 digits." 
                            ForeColor="Red" ValidationExpression="^\d{14,16}$" 
                            ValidationGroup="CreditCardValidationGroup">*</asp:RegularExpressionValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="insertCreditCard" runat="server" MaxLength="16" 
                            Text='<%# Bind("number") %>' ValidationGroup="CreditCardValidationGroup"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                            ControlToValidate="insertCreditCard" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Card Number is required." 
                            ForeColor="Red" ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="revCardNumber" runat="server" 
                            ControlToValidate="insertCreditCard" Display="Dynamic" 
                            EnableClientScript="False" 
                            ErrorMessage="Card Number must be numeric and between 14 and 16 digits." 
                            ForeColor="Red" ValidationExpression="^\d{14,16}$" 
                            ValidationGroup="CreditCardValidationGroup">*</asp:RegularExpressionValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Card Type" SortExpression="type">
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("type") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="editCardTypeDropDownList" runat="server" Height="22px" 
                            ValidationGroup="CreditCardValidationGroup" Width="250px">
                            <asp:ListItem>-- Select credit card --</asp:ListItem>
                            <asp:ListItem>American Express</asp:ListItem>
                            <asp:ListItem>Diners Club</asp:ListItem>
                            <asp:ListItem>Discover</asp:ListItem>
                            <asp:ListItem>MasterCard</asp:ListItem>
                            <asp:ListItem>Visa</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCardTypeDropDownList" runat="server" 
                            ControlToValidate="editCardTypeDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a credit card." 
                            ForeColor="Red" InitialValue="-- Select credit card --" 
                            ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="insertCardTypeDropDownList" runat="server" Height="22px" 
                            ValidationGroup="CreditCardValidationGroup" Width="250px">
                            <asp:ListItem>-- Select credit card --</asp:ListItem>
                            <asp:ListItem>American Express</asp:ListItem>
                            <asp:ListItem>Diners Club</asp:ListItem>
                            <asp:ListItem>Discover</asp:ListItem>
                            <asp:ListItem>MasterCard</asp:ListItem>
                            <asp:ListItem>Visa</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvCardTypeDropDownList" runat="server" 
                            ControlToValidate="insertCardTypeDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a credit card." 
                            ForeColor="Red" InitialValue="-- Select credit card --" 
                            ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Cardholder Name" SortExpression="cardHolderName">
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("cardHolderName") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="editCardHolderName" runat="server" MaxLength="50" 
                            Text='<%# Bind("cardHolderName") %>' 
                            ValidationGroup="CreditCardValidationGroup"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                            ControlToValidate="editCardHolderName" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Cardholder Name is required." 
                            ForeColor="Red" ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:TextBox ID="insertCardHolderName" runat="server" MaxLength="50" 
                            Text='<%# Bind("cardHolderName") %>' 
                            ValidationGroup="CreditCardValidationGroup"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvCardHolderName" runat="server" 
                            ControlToValidate="insertCardHolderName" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Cardholder Name is required." 
                            ForeColor="Red" ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Expiry Month" SortExpression="expiryMonth">
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("expiryMonth") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="editMonthDropDownList" runat="server" Height="22px" 
                            ValidationGroup="CreditCardValidationGroup" Width="110px">
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
                            ControlToValidate="editMonthDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a month." 
                            ForeColor="Red" InitialValue="00" ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="insertMonthDropDownList" runat="server" Height="22px" 
                            ValidationGroup="CreditCardValidationGroup" Width="110px">
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
                            ControlToValidate="insertMonthDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a month." 
                            ForeColor="Red" InitialValue="00" ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Expiry Year" SortExpression="expiryYear">
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("expiryYear") %>'></asp:Label>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="editYearDropDownList" runat="server" Height="22px" 
                            ValidationGroup="CreditCardValidationGroup" Width="110px">
                            <asp:ListItem Value="0">Year</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                            ControlToValidate="editYearDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a year." ForeColor="Red" 
                            InitialValue="0" ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:DropDownList ID="insertYearDropDownList" runat="server" Height="22px" 
                            ValidationGroup="CreditCardValidationGroup" Width="110px">
                            <asp:ListItem Value="0">Year</asp:ListItem>
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="rfvYear" runat="server" 
                            ControlToValidate="insertYearDropDownList" Display="Dynamic" 
                            EnableClientScript="False" ErrorMessage="Please select a year." ForeColor="Red" 
                            InitialValue="0" ValidationGroup="CreditCardValidationGroup">*</asp:RequiredFieldValidator>
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Credit Card Default" 
                    SortExpression="creditCardDefault">
                    <ItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' Enabled="false" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' />
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" 
                            Checked='<%# Bind("creditCardDefault") %>' />
                    </InsertItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="EditLink" runat="server" CausesValidation="False" 
                            CommandName="Edit"  Text="Edit" onclick="EditLink_Click"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="NewLink" runat="server" CausesValidation="False" 
                            CommandName="New" onclick="NewLink_Click" Text="New"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="DeleteLink" runat="server" CausesValidation="False" 
                            CommandName="Delete" Text="Delete"></asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                            CommandName="Update" Text="Update"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                            CommandName="Insert" Text="Insert"></asp:LinkButton>
                        &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                            CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                    </InsertItemTemplate>
                </asp:TemplateField>
            </Fields>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
        </asp:DetailsView>
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" 
        ValidationGroup="CreditCardValidationGroup" />
    <p>
    </p>
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
            
            SelectCommand="SELECT * FROM [CreditCard] WHERE (([userName] = @userName) AND ([number] = @number))" 
            DeleteCommand="DELETE FROM [CreditCard] WHERE ([userName] = @userName AND [number] = @number)" 
            InsertCommand="INSERT INTO [CreditCard] ([userName], [cardHolderName], [type], [number], [expiryMonth], [expiryYear], [creditCardDefault]) VALUES (@userName, @cardHolderName, @type, @number, @expiryMonth, @expiryYear, @creditCardDefault)" 
            UpdateCommand="UPDATE [CreditCard] SET [cardHolderName] = @carHolderName, [type] = @type, [number] = @number, [expiryMonth] = @expiryMonth, [expiryYear] = @expiryYear, [creditCardDefault] = @creditCardDefault WHERE ([userName] = @userName AND [number] = @number)">
            <DeleteParameters>
                <asp:Parameter Name="userName" />
                <asp:Parameter Name="number" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="userName" />
                <asp:Parameter Name="cardHolderName" />
                <asp:Parameter Name="type" />
                <asp:Parameter Name="number" />
                <asp:Parameter Name="expiryMonth" />
                <asp:Parameter Name="expiryYear" />
                <asp:Parameter Name="creditCardDefault" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
                <asp:ControlParameter ControlID="gvCreditCard" Name="number" 
                    PropertyName="SelectedValue" Type="String" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="carHolderName" />
                <asp:Parameter Name="type" />
                <asp:Parameter Name="number" />
                <asp:Parameter Name="expiryMonth" />
                <asp:Parameter Name="expiryYear" />
                <asp:Parameter Name="creditCardDefault" />
                <asp:Parameter Name="userName" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </p>
    <p class="style3">
        &nbsp;</p>
</asp:Content>

