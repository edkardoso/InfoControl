﻿<%@ Page Language="C#" EnableEventValidation="false" MasterPageFile="~/InfoControl/Default.master"
    AutoEventWireup="true" Inherits="InfoControl_Site_SiteMap" Title="Página do Site"
    CodeBehind="WebPage.aspx.cs" %>

<%@ Register Src="~/App_Shared/ComboTreeBox.ascx" TagName="ComboTreeBox" TagPrefix="uc2" %>
<%@ Register Assembly="InfoControl" Namespace="InfoControl.Web.UI.WebControls" TagPrefix="VFX" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/App_Shared/DateTimeInterval.ascx" TagName="DateTimeInterval"
    TagPrefix="uc4" %>
<%@ Register Src="../../App_Shared/HelpTooltip.ascx" TagName="HelpTooltip" TagPrefix="uc3" %>
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
                <table>
                    <tr>
                        <td>
                            Título:
                            <br />
                            <asp:TextBox ID="txtName" runat="server" Columns="80" MaxLength="1024"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="cErr21" runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;"
                                ID="reqtxtName" ValidationGroup="SaveTask" ControlToValidate="txtName">
                            </asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="Label1" runat="server" AssociatedControlID="cboMasterPage" Text="Página Mestre:"></asp:Label>
                            <br />
                            <asp:DropDownList ID="cboMasterPage" AppendDataBoundItems="true" runat="server" DataSourceID="odsMasterPages">
                                <asp:ListItem Text="" Value="" />
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator CssClass="cErr21" runat="server" ID="reqCboMasterPage"
                                ErrorMessage="&nbsp;&nbsp;&nbsp;" ValidationGroup="SaveTask" ControlToValidate="cboMasterPage"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td valign="top">
                            <table>
                                <tr>
                                    <td>
                                        Pai:<br />
                                        <uc2:ComboTreeBox ID="cboParentPages" runat="server" DataFieldID="WebPageId" DataFieldParentID="ParentPageId"
                                            DataTextField="Name" DataValueField="WebPageId" DataSourceID="odsSiteMap" Width="400px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:CheckBox ID="chkCanComment" Text=" Permite comentário?" runat="server" />
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:CheckBox ID="chkIsPublished" Text=" Publicado?" runat="server" />&nbsp;
                                        <uc3:HelpTooltip ID="HelpTooltip2" runat="server">
                                            <itemtemplate>
                                    Publicado significa que estará disponivel para os usuários, quando desmarcada irá
                                    apresentar apenas para testes com uma marca d'agua RASCUNHO.
                                </itemtemplate>
                                        </uc3:HelpTooltip>
                                        &nbsp;&nbsp;&nbsp;
                                        <asp:CheckBox ID="chkIsInMenu" Text=" No menu?" runat="server" />&nbsp;
                                        <uc3:HelpTooltip ID="HelpTooltip1" runat="server">
                                            <itemtemplate>
                                    Este item só se aplica quando utiliza a tag MENU no arquivo tema
                                </itemtemplate>
                                        </uc3:HelpTooltip>
                                        &nbsp;&nbsp;&nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top">
                            <label>
                                Redirecionar URL:</label>
                            <br />
                            <asp:TextBox ID="txtRedirectUrl" runat="server" MaxLength="1024" Columns="40"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                Descrição:<br />
                <textarea plugin="htmlbox" style="height: 200px; width: 100%;" runat="server" id="txtDescription" />
                <br />
                <label>
                    Tags:</label><br />
                <asp:TextBox ID="txtTags" runat="server" Columns="80" MaxLength="1024"></asp:TextBox>
                <table width="100%">
                    <tr>
                        <td align="right">
                            <asp:Button ID="btnSaveAndNew" runat="server" Text="Salvar Novo" OnClick="btnSave_Click"
                                ValidationGroup="SaveTask" />
                            <asp:Button ID="btnSave" runat="server" Text="Salvar" OnClick="btnSave_Click" ValidationGroup="SaveTask" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancelar" OnClientClick="top.$.LightBoxObject.close();  return false;" />
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
    <VFX:BusinessManagerDataSource ID="odsSiteMap" runat="server" onselecting="odsSiteMap_Selecting"
        SelectMethod="GetChildPagesAsTable" TypeName="Vivina.Erp.BusinessRules.WebSites.SiteManager">
        <selectparameters>
            <asp:Parameter Name="companyId" Type="Int32" />            
        </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsMasterPages" runat="server" OldValuesParameterFormatString="original_{0}"
        onselecting="odsMasterPages_Selecting" SelectMethod="GetMasterPages" TypeName="Vivina.Erp.BusinessRules.WebSites.SiteManager">
        <selectparameters>
            <asp:Parameter Name="Company" />
        </selectparameters>
    </VFX:BusinessManagerDataSource>
</asp:Content>
