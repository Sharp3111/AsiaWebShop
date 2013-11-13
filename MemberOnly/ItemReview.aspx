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
        <span class="style3">Please specify the item you want to review:</span>
        <asp:RequiredFieldValidator ID="rfvItem" runat="server" 
            ControlToValidate="ItemRadioButtonList" Display="Dynamic" 
            EnableClientScript="False" ErrorMessage="Please choose an item to review." 
            ForeColor="Red" ValidationGroup="reviewValidationGroup">*</asp:RequiredFieldValidator>
        <asp:CustomValidator ID="cvItem" runat="server" ErrorMessage="CustomValidator"></asp:CustomValidator>
    </p>
    <p>
        <asp:RadioButtonList ID="ItemRadioButtonList" runat="server" 
            DataSourceID="SqlDataSource1" style="color: #000080" Width="246px">
        </asp:RadioButtonList>
    </p>
    <p>
        <span class="style3">Please rate the following aspects of the item from 1 to 5 (required):</span></p>
    <p>
        <span class="style3"></p>
    <p>
        <span class="style4">Quality</span>:
        <asp:RequiredFieldValidator ID="rfvQuality" runat="server" 
            ControlToValidate="ItemRadioButtonList" Display="Dynamic" 
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
            ID="rfvFeatures" runat="server" ControlToValidate="ItemRadioButtonList" 
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
            ControlToValidate="ItemRadioButtonList" Display="Dynamic" 
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
            ControlToValidate="ItemRadioButtonList" Display="Dynamic" 
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
            ControlToValidate="ItemRadioButtonList" Display="Dynamic" 
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
        <asp:TextBox ID="TextBox1" runat="server" Height="191px" TextMode="MultiLine" 
            Width="498px" MaxLength="140"></asp:TextBox>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="submit" runat="server" Text="Submit" Height="30px" 
            ValidationGroup="reviewValidationGroup" Width="120px" />
    </p>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" 
        HeaderText="The following errors occur:" 
        ValidationGroup="reviewValidationGroup" />
    <p>
    </p>
    <p>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
            SelectCommand="SELECT [name] FROM [OrderRecord] WHERE (([userName] = @userName) AND ([isConfirmed] = @isConfirmed))">
            <SelectParameters>
                <asp:ControlParameter ControlID="UserName" Name="userName" PropertyName="Text" 
                    Type="String" />
                <asp:Parameter DefaultValue="True" Name="isConfirmed" Type="Boolean" />
            </SelectParameters>
        </asp:SqlDataSource>
    </p>
</asp:Content>

