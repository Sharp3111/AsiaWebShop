<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopSite.master" AutoEventWireup="true" CodeFile="ItemReview.aspx.cs" Inherits="MemberOnly_ItemReview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
    <style type="text/css">
        .style2
        {
            font-size: x-large;
            font-family: "Times New Roman", Times, serif;
            color: #000080;
        }
        .style3
        {
            color: #000080;
        }
        .style4
        {
            text-decoration: underline;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2">
        <strong>Item Review</strong></p>
    <p class="style3">
        Dear
        <asp:Label ID="UserName" runat="server" Text="UserName"></asp:Label>
        , this is the item review page.</p>
    <p>
        <span class="style3">The following list shows items you purchased. Please specify 
        an item you want to review:</span>
        &nbsp;</p>
    <p>
        <asp:Label ID="lblMessage" runat="server"></asp:Label>
    </p>
    <p>
        <asp:GridView ID="gvItemReview" runat="server" AutoGenerateColumns="False" 
            CellPadding="4" DataSourceID="SqlDataSource1" ForeColor="#333333" 
            GridLines="None" Width="356px">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:CheckBox ID="selected" runat="server" AutoPostBack="True" 
                            oncheckedchanged="selected_CheckedChanged" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Item Name" SortExpression="name">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("name") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="ItemName" runat="server" Text='<%# Bind("name") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="UPC" SortExpression="upc">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("upc") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="ItemUPC" runat="server" Text='<%# Bind("upc") %>'></asp:Label>
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
    <p>
        &nbsp;</p>
    <p>
        <span class="style3">Please rate the following aspects of the item from 1 to 5 (required):</span></p>
    <span class="style3">
    <p>
        <span class="style4">Quality</span>:
        <asp:RequiredFieldValidator ID="rfvQuality" runat="server" 
            ControlToValidate="qualityRadioButtonList" Display="Dynamic" 
            EnableClientScript="False" ErrorMessage="Please rate the item's quality." 
            ForeColor="Red" ValidationGroup="reviewValidationGroup">*</asp:RequiredFieldValidator>
    </p>
    <asp:RadioButtonList ID="qualityRadioButtonList" runat="server" 
        CausesValidation="True" Height="25px" RepeatDirection="Horizontal" 
        Width="400px">
        <asp:ListItem Value="1"></asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>3</asp:ListItem>
        <asp:ListItem>4</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
    </asp:RadioButtonList>
    <p>
        <span class="style4">Features</span>:<asp:RequiredFieldValidator 
            ID="rfvFeatures" runat="server" ControlToValidate="featuresRadioButtonList" 
            Display="Dynamic" EnableClientScript="False" 
            ErrorMessage="Please rate the item's features." ForeColor="Red" 
            ValidationGroup="reviewValidationGroup">*</asp:RequiredFieldValidator>
    </p>
    <p>
        <asp:RadioButtonList ID="featuresRadioButtonList" runat="server" 
            CausesValidation="True" Height="25px" RepeatDirection="Horizontal" 
            Width="400px">
            <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
        </asp:RadioButtonList>
    </p>
    <p>
        <span class="style4">Performance</span>:
        <asp:RequiredFieldValidator ID="rfvPerformance" runat="server" 
            ControlToValidate="featuresRadioButtonList" Display="Dynamic" 
            EnableClientScript="False" ErrorMessage="Please rate the item's performance." 
            ForeColor="Red" ValidationGroup="reviewValidationGroup">*</asp:RequiredFieldValidator>
    </p>
    <asp:RadioButtonList ID="performanceRadioButtonList" runat="server" 
        CausesValidation="True" Height="25px" RepeatDirection="Horizontal" 
        Width="400px">
        <asp:ListItem>1</asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>3</asp:ListItem>
        <asp:ListItem>4</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
    </asp:RadioButtonList>
    <p>
        <span class="style4">Appearance</span>:
        <asp:RequiredFieldValidator ID="rfvAppearance" runat="server" 
            ControlToValidate="appearanceRadioButtonList" Display="Dynamic" 
            EnableClientScript="False" ErrorMessage="Please rate the item's appearance." 
            ForeColor="Red" ValidationGroup="reviewValidationGroup">*</asp:RequiredFieldValidator>
    </p>
    <asp:RadioButtonList ID="appearanceRadioButtonList" runat="server" 
        CausesValidation="True" Height="25px" RepeatDirection="Horizontal" 
        Width="400px">
        <asp:ListItem>1</asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>3</asp:ListItem>
        <asp:ListItem>4</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
    </asp:RadioButtonList>
    <p>
        <span class="style4">Durability</span>:
        <asp:RequiredFieldValidator ID="rfvDurability" runat="server" 
            ControlToValidate="durabilityRadioButtonList" Display="Dynamic" 
            EnableClientScript="False" ErrorMessage="Please rate the item's durability." 
            ForeColor="Red" ValidationGroup="reviewValidationGroup">*</asp:RequiredFieldValidator>
    </p>
    <asp:RadioButtonList ID="durabilityRadioButtonList" runat="server" 
        CausesValidation="True" Height="25px" RepeatDirection="Horizontal" 
        Width="400px">
        <asp:ListItem>1</asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>3</asp:ListItem>
        <asp:ListItem>4</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
    </asp:RadioButtonList>
    <p>
        &nbsp;</p>
    <p>
        Please write a comment for the item you are reviewing (optional; maximum: 140 
        characters):</span></p>
    <p>
        <asp:TextBox ID="comment" runat="server" Height="191px" TextMode="MultiLine" 
            Width="522px" MaxLength="140"></asp:TextBox>
    </p>
    <p>
        <asp:Label ID="indicator" runat="server"></asp:Label>
    </p>
    <p>
        If you want your review to be anonymous, please check here
        <asp:CheckBox ID="checkAnonymous" runat="server" />
    </p>
    <p>
        <asp:Button ID="submit" runat="server" Text="Submit" Height="30px" 
            ValidationGroup="reviewValidationGroup" Width="120px" 
            onclick="submit_Click" />
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" 
        ValidationGroup="reviewValidationGroup" />
    <p>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            
            SelectCommand="SELECT [name], [upc] FROM [OrderRecord] WHERE (([userName] = @userName) AND ([isConfirmed] = @isConfirmed))">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
                <asp:Parameter DefaultValue="True" Name="isConfirmed" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

