<%@ Page EnableEventValidation="false" Language="C#" MasterPageFile="~/InfoControl/Default.master"
    AutoEventWireup="true" Inherits="Company_Inventory" CodeBehind="Inventories.aspx.cs"
    Title="Inventário" %>

<%@ Register Assembly="InfoControl" Namespace="InfoControl.Web.UI.WebControls" TagPrefix="VFX" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="InfoControl" Namespace="InfoControl.Web.UI.WebControls" TagPrefix="VFX" %>
<%@ Register Src="~/InfoControl/Administration/SelectProduct.ascx" TagName="SelectProduct" TagPrefix="uc3" %>
<%@ Register Src="~/App_Shared/ComboTreeBox.ascx" TagName="ComboTreeBox" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
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
                <table width="100%">
                    <tr>
                        <td>
                            <fieldset id="filter" class="closed" onmouseouts='$("#filter .body").toggle(); $("#filter").attr({className:"closed"})'>
                                <legend onmouseover='$("#filter .body").show("slow"); $("#filter").attr({className:"open"})'>
                                    Escolha o filtro desejado: </legend><div class="body">
                                        <table>
                                            <tr>
                                                <td class="style2">
                                                    Nome:
                                                    <br />
                                                    <asp:TextBox ID="txtProductName" runat="server"></asp:TextBox>
                                                </td>
                                                &nbsp;&nbsp;
                                                <td class="style1">
                                                    Descrição:
                                                    <br />
                                                    <asp:TextBox ID="txtDescription" runat="server"></asp:TextBox>
                                                </td>
                                                &nbsp;&nbsp;
                                                <td class="style3">
                                                    Fabricante:
                                                    <br />
                                                    <asp:DropDownList DataSourceID="odsManufacturer" ID="cboManufacturer" runat="server"
                                                        DataTextField="Name" DataValueField="ManufacturerId" AppendDataBoundItems="True"
                                                        Width="200">
                                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    Estoque Físico:<br />
                                                    <asp:DropDownList ID="cboDeposit" runat="server" DataSourceID="odsDeposit" DataTextField="Name"
                                                        DataValueField="DepositId" Width="200">
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    Categoria:<br />
                                                    <uc1:ComboTreeBox ID="cboTreeCategories" DataFieldID="CategoryId" DataFieldParentID="ParentId"
                                                        DataTextField="Name" DataSourceID="odsCategories" DataValueField="CategoryId"
                                                        runat="server" />
                                                </td>
                                                <td>
                                                    Exibir:<br />
                                                    <asp:DropDownList ID="cboPageSize" runat="server">
                                                        <asp:ListItem Value="20" Text="20"></asp:ListItem>
                                                        <asp:ListItem Value="50" Text="50"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <br />
                                        <br />
                                        <br />
                                        <asp:Button ID="btnSearch" runat="server" Text="Pesquisar" OnClick="btnSearch_Click" />
                                    </div><span class="closeButton" onmouseover='$("#filter .body").hide(500, function(){$("#filter").attr({className:"closed"})})'>
                                        &nbsp;</span>
                                <br />
                                <br />
                            </fieldset>
                            <br />
                            <br />
                            <br />
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="grdProducts" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" DataKeyNames="ProductId,InventoryId" Width="100%"
                                DataSourceID="odsInventory" OnRowDataBound="grdProducts_RowDataBound" RowSelectable="false"
                                PageSize="20">
                                <Columns>
                                    <asp:TemplateField HeaderText="Código" SortExpression="ProductCode">
                                        <ItemTemplate>
                                            <%# Eval("ProductCode")%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Nome" SortExpression="Name">
                                        <ItemTemplate>
                                            <b>
                                                <%# Eval("Name")%></b>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Quantity" HeaderText="Quantidade" SortExpression="Quantity">
                                    </asp:BoundField>                                   
                                    <asp:BoundField DataField="UnitPrice" HeaderText="Preão" SortExpression="UnitPrice"
                                        DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Left">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>                                    
                                </Columns>
                                <EmptyDataTemplate>
                                    <p align="center">
                                        Não há dados a serem exibidos...
                                    </p>
                                </EmptyDataTemplate>
                            </asp:GridView>
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
    <VFX:BusinessManagerDataSource ID="odsInventory" runat="server" SelectMethod="GetProductsByDeposit"
        TypeName="Vivina.Erp.BusinessRules.InventoryManager" OnSelecting="odsInventory_Selecting"
        OldValuesParameterFormatString="original_{0}" EnablePaging="True" EnableViewState="False"
        SelectCountMethod="GetProductsByDepositCount" SortParameterName="sortExpression">
        <selectparameters>            
            <asp:Parameter Name="categoryId" Type="Int32" />
            <asp:Parameter Name="companyId" Type="Int32" />
            <asp:Parameter Name="manufacturerId" Type="Int32" />
            <asp:Parameter Name="description" Type="String" />
            <asp:Parameter Name="name" Type="String" />
            <asp:parameter Name="depositId" Type="Int32" />
            <asp:Parameter Name="sortExpression" Type="String" />
            <asp:Parameter Name="startRowIndex" Type="Int32" />
            <asp:Parameter Name="maximumRows" Type="Int32" />
        </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsDeposit" runat="server" OnSelecting="odsDeposit_Selecting"
        SelectMethod="GetDepositByCompanyAsDataTable" TypeName="Vivina.Erp.BusinessRules.DepositManager">
        <selectparameters>
            <asp:parameter Name="companyId" Type="Int32" />
        </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsManufacturer" runat="server" onselecting="odsDeposit_Selecting"
        SelectMethod="GetManufacturerByCompany" TypeName="Vivina.Erp.BusinessRules.ManufacturerManager">
        <selectparameters>
            <asp:parameter Name="companyId" Type="Int32"></asp:parameter>
        </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsCategories" runat="server" onselecting="odsDeposit_Selecting"
        SelectMethod="GetCategoriesByCompanyAsDataTable" TypeName="Vivina.Erp.BusinessRules.CategoryManager">
        <selectparameters>
            <asp:parameter Name="companyId" Type="Int32"></asp:parameter>
        </selectparameters>
    </VFX:BusinessManagerDataSource>
</asp:Content>
