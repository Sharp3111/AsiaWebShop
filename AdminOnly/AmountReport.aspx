<%@ Page Title="" Language="C#" MasterPageFile="~/AsiaWebShopAdmin.master" AutoEventWireup="true" CodeFile="AmountReport.aspx.cs" Inherits="AdminOnly_AmountReport" %>

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
            width: 91px;
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
            width: 91px;
            height: 24px;
        }
        .style24
        {
            height: 24px;
            text-align: left;
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
        .style30
        {
            width: 129px;
            height: 21px;
            text-align: right;
        }
        .style31
        {
            width: 91px;
            height: 21px;
        }
        .style35
        {
            width: 3px;
            height: 21px;
        }
        .style36
        {
            width: 33px;
            height: 21px;
        }
        .style37
        {
            width: 22px;
            height: 21px;
        }
        .style38
        {
            width: 17px;
            height: 21px;
        }
        .style39
        {
            height: 21px;
        }
        .style50
        {
            width: 129px;
            height: 16px;
        }
        .style51
        {
            width: 91px;
            height: 16px;
        }
        .style54
        {
            width: 3px;
            height: 16px;
        }
        .style55
        {
            width: 33px;
            height: 16px;
        }
        .style56
        {
            width: 22px;
            height: 16px;
        }
        .style57
        {
            width: 17px;
            height: 16px;
        }
        .style58
        {
            height: 16px;
        }
        .style68
        {
            height: 16px;
            width: 16px;
        }
        .style69
        {
            height: 21px;
            width: 16px;
        }
        .style70
        {
            width: 16px;
        }
        .style71
        {
            width: 54px;
        }
        .style72
        {
            width: 54px;
            height: 16px;
        }
        .style73
        {
            width: 54px;
            height: 21px;
        }
        .style74
        {
            width: 24px;
        }
        .style75
        {
            width: 24px;
            height: 16px;
        }
        .style76
        {
            width: 24px;
            height: 21px;
        }
        .style79
        {
            text-align: left;
        }
        .style80
        {
            width: 37px;
        }
        .style81
        {
            width: 88px;
            text-align: left;
        }
        .style82
        {
            width: 143px;
        }
        .style83
        {
            width: 143px;
            height: 16px;
        }
        .style84
        {
            width: 143px;
            height: 21px;
            text-align: right;
        }
        .style85
        {
            width: 143px;
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" Runat="Server">
    <p class="style2" 
        style="font-family: Arial, Helvetica, sans-serif; font-size: large; font-weight: bold; color: #000080">
        Purchase Amount Report</p>
    <table class="style3">
        <tr>
            <td class="style82">
                Purcahse done by user:</td>
            <td class="style5">
                <asp:TextBox ID="userName" runat="server"></asp:TextBox>
            </td>
            <td class="style6">
                (empty for all)</td>
            <td class="style80" rowspan="3" colspan="2">
                <asp:RadioButtonList ID="date" runat="server" Width="111px" Height="71px" 
                    style="text-align: center; margin-top: 12px; margin-right: 0px;" 
                    RepeatLayout="Flow" ValidationGroup="purchaseAmount">
                    <asp:ListItem Value="certain">in certain date <br><br></asp:ListItem>
                    
                    <asp:ListItem Value="any">at any time&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      </asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="style74">
                from</td>
            <td class="style70">
                Year:</td>
            <td class="style71">
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
            <td class="style83">
                </td>
            <td class="style50">
                </td>
            <td class="style51">
                </td>
            <td class="style75">
                to</td>
            <td class="style68">
                Year</td>
            <td class="style72">
                <asp:DropDownList ID="yearTo" runat="server" AutoPostBack="True"
                    onselectedindexchanged="yearTo_SelectedIndexChanged" 
                    ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td class="style54">
                &nbsp;Month:</td>
            <td class="style55">
                <asp:DropDownList ID="monthTo" runat="server" AutoPostBack="True"
                    onselectedindexchanged="monthTo_SelectedIndexChanged" 
                    ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td class="style56">
                Day:</td>
            <td class="style57">
                <asp:DropDownList ID="dayTo" runat="server" ValidationGroup="purchaseAmount">
                </asp:DropDownList>
            </td>
            <td class="style58">
                <asp:CustomValidator ID="CustomValidator1" runat="server" Display="Dynamic" 
                    EnableClientScript="False" ErrorMessage="Invalid range selection." 
                    ForeColor="Red" onservervalidate="CustomValidator1_ServerValidate" 
                    ValidationGroup="purchaseAmount">*</asp:CustomValidator>
            </td>
        </tr>
        <tr>
            <td class="style84">
                </td>
            <td class="style30">
                </td>
            <td class="style31">
                </td>
            <td class="style76">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="date" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="You need to select a time range." ForeColor="Red" 
                    ValidationGroup="purchaseAmount">*</asp:RequiredFieldValidator>
                </td>
            <td class="style69">
                </td>
            <td class="style73">
            </td>
            <td class="style35">
                </td>
            <td class="style36">
            </td>
            <td class="style37">
                </td>
            <td class="style38">
            </td>
            <td class="style39">
            </td>
        </tr>
        <tr>
            <td class="style85">
            </td>
            <td class="style22">
            </td>
            <td class="style23">
            </td>
            <td class="style81" rowspan="2">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; order by&nbsp; </td>
            <td class="style79" colspan="4" rowspan="2">
                <asp:RadioButtonList ID="orderBy" runat="server" Width="128px" 
                    ValidationGroup="purchaseAmount" 
                    style="text-align: left; margin-left: 0px; margin-right: 0px">
                    <asp:ListItem Value="name">Last name</asp:ListItem>
                    <asp:ListItem Value="amount">Purchase amount</asp:ListItem>
                </asp:RadioButtonList>
            </td>
            <td class="style24" colspan="3">
                <asp:CheckBox ID="groupDistrict" runat="server" Text="Group by District" />
            </td>
            <td class="style24">
            </td>
        </tr>
        <tr>
            <td class="style82">
                &nbsp;</td>
            <td class="style5">
                &nbsp;</td>
            <td class="style6">
                &nbsp;</td>
            <td class="style19">
                <asp:RequiredFieldValidator ID="orderRequire" runat="server" 
                    ControlToValidate="orderBy" Display="Dynamic" EnableClientScript="False" 
                    ErrorMessage="You need to select one order way." ForeColor="Red" 
                    ValidationGroup="purchaseAmount">*</asp:RequiredFieldValidator>
            </td>
            <td class="style20" colspan="2">
                <asp:Button ID="Button1" runat="server" Text="General Report" 
                    ValidationGroup="purchaseAmount" Width="97px" onclick="Button1_Click" />
            </td>
            <td>
                &nbsp;</td>
        </tr>
    </table>
    <asp:Label ID="result" runat="server" Font-Bold="True" Font-Size="Medium" 
        ForeColor="Red"></asp:Label>
    <br />
    <asp:GridView ID="report" runat="server" CellPadding="4" 
        DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" 
        AutoGenerateColumns="False" DataKeyNames="userName">
        <AlternatingRowStyle BackColor="White" />
        <Columns>
            <asp:BoundField DataField="userName" HeaderText="Username" ReadOnly="True" 
                SortExpression="userName" />
            <asp:BoundField DataField="firstName" HeaderText="First Name" 
                SortExpression="firstName" />
            <asp:BoundField DataField="lastName" HeaderText="Last Name" 
                SortExpression="lastName" />
            <asp:BoundField DataField="orderDateTime" HeaderText="Purchase Date" 
                SortExpression="orderDateTime" />
            <asp:BoundField DataField="Expr1" HeaderText="Total Purchase amount" 
                ReadOnly="True" SortExpression="Expr1" />
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
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:AsiaWebShopDBConnectionString %>" 
        
        SelectCommand="SELECT Member.userName, Member.firstName, Member.lastName,OrderRecord.orderDateTime, SUM(OrderRecord.quantity * OrderRecord.unitPrice) AS Expr1 FROM OrderRecord INNER JOIN Member ON OrderRecord.userName = Member.userName GROUP BY OrderRecord.confirmationNumber, Member.userName, Member.firstName, Member.lastName,OrderRecord.orderDateTime"></asp:SqlDataSource>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
        EnableClientScript="False" ForeColor="Red" 
        HeaderText="Following error occurred:" ValidationGroup="purchaseAmount" />
    <br />
</asp:Content>

