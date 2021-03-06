<%@ Page Language="C#" EnableEventValidation="false" MasterPageFile="~/InfoControl/Default.master"
    AutoEventWireup="true" Inherits="InfoControl_Task" Title="Tarefa/Compromisso"
    CodeBehind="Task.aspx.cs" %>

<%@ Register Src="~/App_Shared/ComboTreeBox.ascx" TagName="ComboTreeBox" TagPrefix="uc2" %>
<%@ Register Assembly="InfoControl" Namespace="InfoControl.Web.UI.WebControls" TagPrefix="VFX" %>
<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register Src="~/App_Shared/modules/AccessControl/SelectUser.ascx" TagName="SelectUser"
    TagPrefix="uc1" %>
<%@ Register Src="../App_Shared/Comments.ascx" TagName="Comments" TagPrefix="uc3" %>
<%@ Register Src="../App_Shared/Date.ascx" TagName="Date" TagPrefix="uc5" %>
<%@ Register Src="../App_Shared/CurrencyField.ascx" TagName="CurrencyField" TagPrefix="uc6" %>
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
                            Nome:<br />
                            <asp:TextBox ID="txtName" runat="server" Columns="80" MaxLength="128"></asp:TextBox>
                            <asp:RequiredFieldValidator CssClass="cErr21" ID="reqtxtName" runat="server" ControlToValidate="txtName"
                                ErrorMessage="&amp;nbsp;&amp;nbsp;&amp;nbsp;" ValidationGroup="SaveTask"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            Prioridade:<br />
                            <ajaxToolkit:Rating ID="rtnRanking" runat="server" MaxRating="5" StarCssClass="ratingStar"
                                WaitingStarCssClass="savedRatingStar" FilledStarCssClass="filledRatingStar" EmptyStarCssClass="emptyRatingStar"
                                ToolTip="Classificação">
                            </ajaxToolkit:Rating>
                            <br />
                        </td>
                        <td>
                            Status:<br />
                            <asp:DropDownList ID="cboTaskStatus" AppendDataBoundItems="true" runat="server" DataSourceID="odsTaskStatus"
                                DataTextField="Name" DataValueField="TaskStatusId">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator CssClass="cErr21" ID="reqcboTaskStatus" Enabled="false"
                                runat="server" ErrorMessage="&nbsp;&nbsp;&nbsp;" ControlToValidate="cboTaskStatus"
                                ValidationGroup="SaveTask">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
                <fieldset>
                    <legend>Informações Adicionais:</legend>
                    <table>
                        <tr>
                            <td>
                                Pai:<br />
                                <uc2:ComboTreeBox ID="cboParentTasks" runat="server" DataFieldID="TaskId" DataFieldParentID="ParentTaskId"
                                    DataTextField="Name" DataValueField="TaskId" DataSourceID="odsTask" Width="400px" />
                            </td>
                            <td>
                                <%--<uc4:DateTimeInterval ID="ucDateInterval" ValidationGroup="SaveTask" runat="server" />--%>
                                Início:<br />
                                <uc5:Date ID="ucBeginDate" runat="server" ShowTime="true"></uc5:Date>
                            </td>
                            <td>
                                Término:<br />
                                <uc5:Date ID="ucEndDate" runat="server" ShowTime="true"></uc5:Date>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;
                            </td>
                            <td>
                                Lembrete(min):<br />
                                <asp:DropDownList runat="server" ID="cboAlertMinutesBefore">
                                    <asp:ListItem Text="" Value="" />
                                    <asp:ListItem Text="10" Value="10" />
                                    <asp:ListItem Text="15" Value="15" />
                                    <asp:ListItem Text="20" Value="20" />
                                    <asp:ListItem Text="25" Value="25" />
                                    <asp:ListItem Text="30" Value="30" />
                                    <asp:ListItem Text="35" Value="35" />
                                    <asp:ListItem Text="40" Value="40" />
                                    <asp:ListItem Text="45" Value="45" />
                                </asp:DropDownList>
                            </td>
                            <td>
                                &nbsp;&nbsp;&nbsp;
                            </td>
                            <td>
                                Custo:<br />
                                <uc6:CurrencyField ID="ucCurrFieldCost" runat="server" />
                            </td>
                            <td>
                                DeadLine:<br />
                                <uc5:Date ID="ucDeadLineDate" runat="server" />
                            </td>
                        </tr>
                    </table>
                    Descrição:<br />
                    <textarea plugin="htmlbox" runat="server" id="txtDescription" style="width: 100%;
                        height: 200px" />
                </fieldset>
                <fieldset>
                    <legend>Participantes:</legend>
                    <table id="TaskUser">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="upTechnicalEmployee" runat="server">
                                    <ContentTemplate>
                                        <uc1:SelectUser ID="SelUser" OnSelectedUser="selUser_SelectedUser" runat="server" />
                                        <asp:DataList ID="lstUsers" runat="server" DataKeyField="UserId" OnDeleteCommand="lstUsers_DeleteCommand">
                                            <ItemTemplate>
                                                <table>
                                                    <tr>
                                                        <td valign="top" style="width: 310px;">
                                                            <%# Eval("Profile.AbreviatedName")%>
                                                        </td>
                                                        <td valign="top">
                                                            <asp:LinkButton ID="LinkButton1" CssClass="delete" runat="server" ValidationGroup="Delete"
                                                                CommandArgument='<%# Eval("UserId") %>' CommandName="Delete" Visible='<%#OriginalTask.CreatorUserId == User.Identity.UserId && !Eval("UserId").Equals(User.Identity.UserId) %>' />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <uc3:Comments ID="ucComments" runat="server" />
                <br />
                <table width="100%">
                    <tr>
                        <td align="right">
                            <asp:Button ID="btnSaveAndNew" runat="server" Text="Salvar Novo" ValidationGroup="SaveTask"
                                OnClick="btnSave_Click" />
                            <asp:Button ID="btnSave" runat="server" Text="Salvar" ValidationGroup="SaveTask"
                                OnClick="btnSave_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancelar" UseSubmitBehavior="false"
                                OnClientClick="location='tasks.aspx'; return false;" />
                        </td>
                    </tr>
                </table>
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
        </td>
    </table>
    <VFX:BusinessManagerDataSource ID="odsTask" runat="server" SelectMethod="GetTasksByUserAsDataTable"
        TypeName="Vivina.Erp.BusinessRules.TaskManager" OnSelecting="odsTask_Selecting"
        OldValuesParameterFormatString="original_{0}">
        <selectparameters>
            <asp:Parameter Name="userId" Type="Int32" />
            <asp:Parameter Name="sortExpression" Type="String" />
            <asp:Parameter Name="status" Type="Object" />
    </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsTaskUser" runat="server" SelectMethod="GetUsersByCompany"
        TypeName="Vivina.Erp.BusinessRules.CompanyManager" onselecting="odsSelect_Selecting">
        <selectparameters>
        </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsTaskType" runat="server" SelectMethod="GetTaskType"
        TypeName="Vivina.Erp.BusinessRules.TaskManager" onselecting="odsSelect_Selecting">
        <selectparameters>
        </selectparameters>
    </VFX:BusinessManagerDataSource>
    <VFX:BusinessManagerDataSource ID="odsTaskStatus" runat="server" SelectMethod="GetTaskStatus"
        TypeName="Vivina.Erp.BusinessRules.TaskManager">
    </VFX:BusinessManagerDataSource>
</asp:Content>
