<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" Inherits="Company_VPOS_Budget"
    MasterPageFile="~/InfoControl/Default.master" CodeBehind="Sale.aspx.cs" Title="Ponto de Venda" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="InfoControl" Namespace="InfoControl.Web.UI.WebControls" TagPrefix="VFX" %>
<%@ Register Src="../../App_Shared/ToolTip.ascx" TagName="ToolTip" TagPrefix="uc5" %>
<%@ Register Src="~/InfoControl/Administration/SelectCustomer.ascx" TagName="SelectCustomer"
    TagPrefix="uc6" %>
<%@ Register Src="~/InfoControl/Administration/SelectProduct.ascx" TagName="SelectProduct"
    TagPrefix="uc7" %>
<%@ Register Src="../../App_Shared/CurrencyField.ascx" TagName="CurrencyField" TagPrefix="uc8" %>
<%@ Register Src="~/App_Shared/HelpTooltip.ascx" TagName="HelpTooltip" TagPrefix="vfx" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <table class="cLeafBox21" width="100%">
        <tr class="top">
            <td class="left">
                &nbsp;
            </td>
            <td class="center">
                &nbsp;
            </td>
            <td class="right">
                &nbsp;
            </td>
        </tr>
        <tr class="middle">
            <td class="left">
                &nbsp;
            </td>
            <td class="center">
                <table>
                    <tr>
                        <td>
                            Quant:<br />
                            <uc8:CurrencyField ID="ucCurrFieldQuantityData" Mask="999" Columns="4" ValidationGroup="AddProductToCart"
                                runat="server" />
                            <br />
                            <br />
                        </td>
                        <td style="white-space: nowrap;">
                            <uc7:SelectProduct ID="selProduct" Required="true" ValidationGroup="AddProductToCart"
                                runat="server" />
                        </td>
                        <td valign="bottom">
                            &nbsp;
                        </td>
                        <td valign="bottom">
                            &nbsp;
                        </td>
                        <td>
                            Preço:<br />
                            <uc8:CurrencyField ID="ucTxtUnitPrice" runat="server" />
                            <br />
                            <br />
                        </td>
                        <td valign="bottom">
                            <asp:ImageButton ID="btnAdd" runat="server" ImageUrl="~/App_Shared/themes/glasscyan/Company/shoppingbasket_add.gif"
                                OnClick="btnAdd_Click" ValidationGroup="AddProductToCart" /><br />
                            <br />
                        </td>
                        <td valign="bottom">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        <td valign="bottom">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        <td runat="server" id="saleTypes">
                            <asp:Label ID="lblSaleType" runat="server" Text=" Tipo de venda: "> </asp:Label>&nbsp;<VFX:HelpTooltip
                                ID="helpToolTip1" runat="server">
                                <ItemTemplate>
                                    <h2>
                                        Ajuda:</h2>
                                    Indica a forma pela qual o produto será vendido. Como exemplo podemos citar as seguintes
                                    formas de venda: promoção, oferta, promoçao de verão,etc. Essas formas de venda
                                    são estipuladas na seção "Vendas" que fica no menu "Administração" => "Configurações".
                                </ItemTemplate>
                            </VFX:HelpTooltip>
                            <br />
                            <asp:DropDownList ID="cboUnitPriceName" runat="server" AutoPostBack="True" OnTextChanged="cboUnitPriceName_TextChanged"
                                AppendDataBoundItems="true">
                                <asp:ListItem Text="" Value=""></asp:ListItem>
                            </asp:DropDownList>
                            <br />
                            <br />
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="grdSaleItens" BorderStyle="Solid" runat="server" Width="100%" AutoGenerateColumns="False"
                    OnRowDataBound="grdSaleItens_RowDataBound" OnRowDeleting="grdSaleItens_RowDeleting"
                    RowSelectable="false" DataKeyNames="ProductId" OnRowDeleted="grdSaleItens_RowDeleted">
                    <Columns>
                        <asp:TemplateField HeaderText="Código">
                            <ItemStyle Width="70px" />
                            <ItemTemplate>
                                <%#Eval("ProductCode")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Qtd.">
                            <ItemTemplate>
                                <center>
                                    <%#Eval("Quantity")%></center>
                            </ItemTemplate>
                            <ItemStyle Width="32px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="V. Unitário">
                            <ItemTemplate>
                                <center>
                                    <%#Convert.ToDouble(Eval("UnitPrice")).ToString("##,###,###,##0.00")%></center>
                            </ItemTemplate>
                            <ItemStyle Width="70px" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Nome">
                            <ItemTemplate>
                                &nbsp;&nbsp;&nbsp;<%#Eval("ProductName")%>
                                <asp:Image ID="imgProduct_warning" ImageUrl="~/App_Shared/themes/glasscyan/Company/Product_warning.gif"
                                    AlternateText="Este produto não se encontra cadastrado!" runat="server" Visible='<%# Eval("ProductCode")=="0" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Série">
                            <ItemTemplate>
                                <center>
                                    <asp:DropDownList ID="cboSerialNumber" AutoPostBack="true" runat="server" DataValueField="InventorySerialId"
                                        AppendDataBoundItems="true" DataTextField="Serial" OnTextChanged="cboSerialNumber_TextChanged">
                                    </asp:DropDownList>
                                    <%--                                            <asp:TextBox ID="SerialNumber" runat="server" Text='<%#Eval("SerialNumber")%>' MaxLength="20"
                                                Width="100px"></asp:TextBox>--%>
                                </center>
                            </ItemTemplate>
                            <ItemStyle Width="114px" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Preço Total">
                            <ItemTemplate>
                                <p class="cTxt42b" style="text-align: right; margin-right: 10px;">
                                    <%#(Convert.ToDouble(Eval("ProfitPrice"))).ToString("##,###,###,##0.00")%></p>
                            </ItemTemplate>
                            <ItemStyle Width="150px" HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:CommandField DeleteText="&lt;div class=&quot;delete&quot;title=&quot;excluir&quot;&lt;/div&gt;"
                            ShowDeleteButton="True">
                            <ItemStyle Width="20px" />
                        </asp:CommandField>
                    </Columns>
                    <EmptyDataTemplate>
                        Selecione um produto.
                    </EmptyDataTemplate>
                    <HeaderStyle HorizontalAlign="Center" />
                </asp:GridView>
                <br />
                <table style="width: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="padding-right: 5px; border-right: 1px solid #1A6E6A;" valign="top" nowrap="nowrap"
                            class="style1">
                            <asp:MultiView ID="WizardCustomer" runat="server" ActiveViewIndex="0">
                                <asp:View ID="Select" runat="server">
                                    <table>
                                        <tr>
                                            <td valign="top">
                                                <uc6:SelectCustomer ID="sel_customer" runat="server" OnSelectedCustomer="SelCustomer_SelectedCustomer" />
                                            </td>
                                            <td valign="top">
                                                <b>
                                                    <asp:Label ID="lblBudget" runat="server" Visible="False" Text="Orçamentos"> </asp:Label>
                                                </b>&nbsp;<VFX:HelpTooltip ID="helpToolTipBudget" Visible="false" runat="server">
                                                    <ItemTemplate>
                                                        <h2>
                                                            Ajuda:</h2>
                                                        São as propostas de compras que o cliente selecionado já recebeu anteriormente.
                                                        Clicando em uma das propostas, você importa todos os produtos que esta proposta
                                                        tem para esta venda.
                                                    </ItemTemplate>
                                                </VFX:HelpTooltip>
                                                <br />
                                                <asp:DataList ID="lstBudget" runat="server" OnSelectedIndexChanged="lstBudget_SelectedIndexChanged"
                                                    DataKeyField="BudgetId">
                                                    <ItemTemplate>
                                                        <table>
                                                            <tr>
                                                                <td valign="top">
                                                                    <asp:LinkButton ID="link" runat="server" Text='<%# Eval("BudgetCode") + " - " + Convert.ToDateTime(Eval("ModifiedDate")).ToShortDateString()%>'
                                                                        CommandName="Select" ToolTip='<%# Eval("BudgetCode") %>' />
                                                                    -
                                                                </td>
                                                                <td valign="top">
                                                                    <asp:LinkButton ID="LinkButton1" CssClass="delete" runat="server" CommandArgument='<%# Eval("BudgetId") %>'
                                                                        CommandName="Delete" OnCommand="btnDeleteBudget_Command" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:View>
                            </asp:MultiView>
                        </td>
                        <td style="padding-left: 15px;" valign="top">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td>
                                        <img src="../../App_Shared/themes/glasscyan/Company/subtotal.gif" alt="Subtotal" />
                                    </td>
                                    <td style="text-align: right; padding-right: 32px;">
                                        <asp:Label ID="lblSubtotal" runat="server" Text="00.000,00" CssClass="cTxt42b"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <img src="../../App_Shared/themes/glasscyan/Company/desconto.gif" alt="Desconto" />
                                    </td>
                                    <td nowrap="nowrap" style="text-align: right; padding-right: 22px;">
                                        <asp:TextBox ID="txtDiscount" CssClass="cDat21" runat="server" Font-Size="16pt" Font-Bold="true"
                                            ForeColor="#1A6E6A" Columns="7" MaxLength="9" Text="00.000,00"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:ImageButton ID="btnPayment" AlternateText="Efetuar venda" runat="server" ImageUrl="../../App_Shared/themes/glasscyan/Company/bt_concluir_venda.gif" />
                                    </td>
                                    <td nowrap="nowrap" valign="bottom" style="vertical-align: middle; text-align: right;
                                        padding-right: 32px;">
                                        <asp:Label ID="lblTotal" runat="server" Text="00.000,00" CssClass="cTxt44b"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
            <td class="right">
                &nbsp;
            </td>
        </tr>
        <tr class="bottom">
            <td class="left">
                &nbsp;
            </td>
            <td class="center">
                &nbsp;
            </td>
            <td class="right">
                &nbsp;
            </td>
        </tr>
    </table>
    
    <uc5:ToolTip ID="tipSale" runat="server" Message="Incentive sempre, para que o máximo de campos sejam preenchidos, mesmo durante o corre-corre das vendas, ou qualquer outra situação. D� sempre atenção especial ao 'Cliente' (e todas as informações que dizem respeito a ele). O InfoControl traz ferramentas que facilitam a fidelização dos seus clientes."
        Title="Dica:" Indication="left" Top="0px" Left="180px" />
    <VFX:BusinessManagerDataSource ID="odsBudgets" runat="server" OnSelecting="odsBudgets_Selecting"
        SelectMethod="GetBudgetByCustomerExcludingSales" TypeName="Vivina.Erp.BusinessRules.SaleManager">
        <selectparameters>
            <asp:Parameter Name="CustomerId" Type="Int32" />
            <asp:Parameter Name="CompanyId" Type="Int32" />
        </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsInventorySerial" runat="server" onselecting="odsInventorySerial_Selecting"
        SelectMethod="GetInventorySerials" TypeName="Vivina.Erp.BusinessRules.InventoryManager"
        ConflictDetection="CompareAllValues" SortParameterName="sortExpression" DataObjectTypeName="Vivina.Erp.DataClasses.InventorySerial">
        <selectparameters>
            <asp:Parameter Name="depositId" Type="Int32" />
            <asp:Parameter Name="productId" Type="Int32" />
            <asp:Parameter Name="companyId" Type="Int32" />
            <asp:Parameter Name="sortExpression" Type="String" />
            <asp:Parameter Name="startRowIndex" Type="Int32" />
            <asp:Parameter Name="maximumRows" Type="Int32" />
        </selectparameters>
    </VFX:BusinessManagerDataSource>
</asp:Content>
