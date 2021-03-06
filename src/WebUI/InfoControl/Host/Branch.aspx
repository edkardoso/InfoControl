<%@ Page EnableEventValidation="false" Language="C#" MasterPageFile="~/infocontrol/Default.master"
    AutoEventWireup="true" Inherits="Generico_Cadastro"
     Codebehind="Branch.aspx.cs"  %>

<%@ Register Assembly="InfoControl" Namespace="InfoControl.Web.UI.WebControls"
    TagPrefix="VFX" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    
    <table class="cLeafBox21" width="100%">
        <tr class="top">
            <td class="left">
                &nbsp;
            </td>
            <td class="center">
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
                <br />
                <asp:GridView ID="grid" runat="server" AutoGenerateColumns="False" EditIndex="0"
                    HorizontalAlign="Center" OnRowDeleting="grid_RowDeleting" OnRowEditing="grid_RowEditing"
                    OnRowUpdating="grid_RowUpdating" Width="100%" OnRowCancelingEdit="grid_RowCancelingEdit"
                    GridLines="None" OnRowDataBound="grid_RowDataBound" OnRowCommand="grid_RowCommand"
                    OnSorting="grid_Sorting" AllowSorting="true">
                    <Columns>
                        <asp:TemplateField HeaderText="Nome">
                            <ItemStyle Wrap="True" />
                            <EditItemTemplate>
                                <asp:TextBox ID="txtNome" CssClass="cDat11" runat="server" Width="96%" MaxLength="100"
                                    Text='<%# Bind("Name") %>'>
                                </asp:TextBox>
                                <asp:RequiredFieldValidator CssClass="cErr21" ID="RequiredFieldValidator5" runat="server" ControlToValidate="txtNome"
                                    ErrorMessage="&nbsp;&nbsp;&nbsp;" ValidationGroup="Salvar">*</asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField DeleteText="&lt;img src=&quot;../../App_Shared/themes/glasscyan/Controls/GridView/img/Pixel_bg.gif&quot; alt=&quot;Apagar&quot; class=&quot;delete&quot; border=0&gt;"
                            ShowDeleteButton="True">
                            <ItemStyle Width="1%" />
                        </asp:CommandField>
                        <asp:CommandField CancelText="&lt;img src='../../App_Shared/themes/glasscyan/Controls/GridView/img/Cancel.gif' border='0' /&gt;"
                            EditText="" ShowEditButton="True" UpdateText="&lt;img src='../../App_Shared/themes/glasscyan/Controls/GridView/img/Save.gif' border='0' /&gt;"
                            ValidationGroup="Salvar">
                            <ItemStyle Width="1%" Wrap="True" HorizontalAlign="Center" />
                        </asp:CommandField>
                    </Columns>
                </asp:GridView>
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
</asp:Content>
