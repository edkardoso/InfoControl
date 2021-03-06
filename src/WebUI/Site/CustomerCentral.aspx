<%@ Page Language="C#" MasterPageFile="~/InfoControl/Default.master" 
    AutoEventWireup="true" Inherits="Site_CustomerCentral" Title="Central do Cliente"
    CodeBehind="CustomerCentral.aspx.cs" %>

<%@ Register Assembly="InfoControl" Namespace="InfoControl.Web.UI.WebControls" TagPrefix="VFX" %>
<asp:Content ID="Content" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">

    <table class="cLeafBox21" width="100%">
        <tr class="top">
            <td class="left">&nbsp;</td>
            <td class="center">&nbsp;</td>
            <td class="right">&nbsp;</td>
        </tr>
        <tr class="middle">
            <td class="left">&nbsp;</td>
            <td class="center" controller="../controller/site/">
                <div id="compras">
                    <h2>Compras</h2>
                    <table command="load" action="GetServiceOrdersByCustomer" target="#compras .template"
                        template="#compras .template" emptytemplate="#compras .empty" emptytarget="#compras table">
                        <thead>
                            <tr>
                                <td>Data</td>
                                <td>Total</td>
                                <td>Status</td>
                            </tr>
                        </thead>
                        <tbody class="template">
                            <tr>
                                <td>Data</td>
                                <td>Total</td>
                                <td>Status</td>
                            </tr>
                        </tbody>
                        <tbody class="empty" style="display: none">
                            <tr>
                                <td colspan="99">Nenhuma compra realizada até hoje!</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <h2>Ordens de Serviço:</h2>
                <asp:GridView Width="100%" ID="grdServiceOrders" DataSourceID="odsServiceOrders"
                    runat="server" AutoGenerateColumns="False" AllowPaging="True" DataKeyNames="ServiceOrderStatusId,ServiceOrderId"
                    AllowSorting="True" OnRowDataBound="grdServiceOrders_RowDataBound" rowselectable="false">
                    <Columns>
                        <asp:BoundField DataField="ServiceOrderNumber" HeaderText="Número" SortExpression="ServiceOrderNumber" />
                        <asp:BoundField DataField="OpenedDate" HeaderText="Data de Abertura" SortExpression="OpenedDate" />
                        <asp:BoundField DataField="serviceOrderStatusName" HeaderText="Status" SortExpression="serviceOrderStatusName" />
                    </Columns>
                    <EmptyDataTemplate>
                        Nenhuma Ordem de Serviço.
                    </EmptyDataTemplate>
                </asp:GridView>
                <h2>Chamados:</h2>
                <asp:GridView ID="grdCustomerCalls" DataSourceID="odsCustomerCalls" runat="server"
                    AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="CustomerCallId"
                    RowSelectable="false" OnRowDataBound="grdCustomerCalls_RowDataBound" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="Subject" HeaderText="Descrição" SortExpression="Subject" />
                        <asp:BoundField DataField="customerCallStatusName" HeaderText="Status" SortExpression="customerCallStatusName" />
                        <asp:BoundField DataField="CallNumber" HeaderText="Número" SortExpression="CallNumber" />
                        <asp:BoundField DataField="OpenedDate" HeaderText="Data de Abertura" SortExpression="OpenedDate" />
                        <asp:BoundField DataField="ClosedDate" HeaderText="Data de Fechamento" SortExpression="ClosedDate" />
                        <asp:BoundField DataField="UserName" HeaderText="Gerado pelo usuário" SortExpression="UserName" />
                    </Columns>
                    <EmptyDataTemplate>
                        Nenhum Chamado.
                    </EmptyDataTemplate>
                </asp:GridView>
                <h2>Notas Fiscais:</h2>
                <asp:GridView ID="grdReceipts" DataSourceID="odsReceipts" runat="server" AutoGenerateColumns="False"
                    AllowPaging="True" AllowSorting="True" DataKeyNames="ReceiptId" rowselectable="false"
                    OnRowDataBound="grdReceipts_RowDataBound" Width="100%">
                    <Columns>
                        <asp:BoundField DataField="ReceiptNumber" HeaderText="Número" SortExpression="ReceiptNumber" />
                        <asp:BoundField DataField="IssueDate" HeaderText="Data de Emissão" SortExpression="IssueDate" />
                        <asp:BoundField DataField="ReceiptValue" HeaderText="Valor da Nota" SortExpression="ReceiptValue" />
                    </Columns>
                    <EmptyDataTemplate>
                        Nenhuma Nota Fiscal.
                    </EmptyDataTemplate>
                </asp:GridView>
            </td>
            <td class="right">&nbsp;</td>
        </tr>
        <tr class="bottom">
            <td class="left">&nbsp;</td>
            <td class="center">&nbsp;</td>
            <td class="right">&nbsp;</td>
        </tr>
    </table>
    <VFX:businessmanagerdatasource id="odsServiceOrders" runat="server" onselecting="odsServiceOrders_Selecting"
        SelectMethod="GetServiceOrdersByCustomer" TypeName="Vivina.Erp.BusinessRules.Services.ServicesManager"
        EnablePaging="True" SelectCountMethod="GetServiceOrdersByCustomerCount" SortParameterName="sortExpression">
        <selectparameters>
            <asp:Parameter Name="customerID" Type="Int32" />
            <asp:Parameter Name="sortExpression" Type="String" />
            <asp:Parameter Name="startRowIndex" Type="Int32" />
            <asp:Parameter Name="maximumRows" Type="Int32" />
      </selectparameters>
    </VFX:businessmanagerdatasource>
    <VFX:businessmanagerdatasource id="odsCustomerCalls" runat="server" onselecting="odsCustomerCalls_Selecting"
        SelectMethod="GetCustomerCallsByCustomer" TypeName="Vivina.Erp.BusinessRules.CustomerManager"
        EnablePaging="True" SelectCountMethod="GetCustomerCallsByCustomerCount" SortParameterName="sortExpression">
        <selectparameters>
            <asp:Parameter Name="companyId" Type="Int32" />
            <asp:Parameter Name="customerId" Type="Int32" />
            <asp:Parameter Name="customerCallStatusId" Type="Int32" />
            <asp:Parameter Name="customerCallType" Type="Int32" />
            <asp:Parameter Name="technicalEmployeeId" Type="Int32" />
            <asp:Parameter Name="dateTimeInterval" Type="Object" />
            <asp:Parameter Name="sortExpression" Type="String" />
            <asp:Parameter Name="startRowIndex" Type="Int32" />
            <asp:Parameter Name="maximumRows" Type="Int32" />
      </selectparameters>
    </VFX:businessmanagerdatasource>
    <VFX:businessmanagerdatasource id="odsReceipts" runat="server" onselecting="odsReceipts_Selecting"
        SelectMethod="GetReceiptsByCustomer" TypeName="Vivina.Erp.BusinessRules.ReceiptManager"
        EnablePaging="True" SelectCountMethod="GetReceiptsByCustomerCount" SortParameterName="sortExpression">
        <selectparameters>
            <asp:Parameter Name="customerID" Type="Int32" />
            <asp:Parameter Name="sortExpression" Type="String" />
            <asp:Parameter Name="startRowIndex" Type="Int32" />
            <asp:Parameter Name="maximumRows" Type="Int32" />
      </selectparameters>
    </VFX:businessmanagerdatasource>
    <VFX:businessmanagerdatasource id="odsSales" runat="server" SelectMethod="GetSalesByCustomer"
        TypeName="Vivina.Erp.BusinessRules.SaleManager" onselecting="odsSales_Selecting"
        SelectCountMethod="GetSalesByCustomerCount" SortParameterName="sortExpression"
        EnablePaging="True" OldValuesParameterFormatString="original_{0}">
        <selectparameters>
            <asp:Parameter Name="customerID" Type="Int32" />
            <asp:Parameter Name="sortExpression" Type="String" />
            <asp:Parameter Name="startRowIndex" Type="Int32" />
            <asp:Parameter Name="maximumRows" Type="Int32" />
      </selectparameters>
    </VFX:businessmanagerdatasource>
</asp:Content>
