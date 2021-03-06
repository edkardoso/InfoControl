<%@ Page EnableEventValidation="false" Language="C#" MasterPageFile="~/InfoControl/Default.master"
    AutoEventWireup="True" CodeBehind="Employee.aspx.cs" Inherits="Company_RH_Employee"
    Title="Funcionário" %>

<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="Header">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder" runat="Server">
    <div class="tabs cTabs11" style="padding-left: 10px;">
        <ul class="tabNavigation">
            <li><a href="Employee_PersonalData.aspx?eid=<%=Request["EmployeeId"] %>" target="tabContent">
                Informações Pessoais</a></li>
            <li><a href="Employee_ProfessionalData.aspx?eid=<%=Request["EmployeeId"] %>" target="tabContent">
                Informações Profissionais</a></li>
            <li><a href="Dependants.aspx?eid=<%=Request["EmployeeId"] %>" target="tabContent">Dependentes</a></li>
            <li><a href="Employee_History.aspx?eid=<%=Request["EmployeeId"] %>" target="tabContent">
                Histórico Profissional</a></li>
            <li><a href="Employee_Competency.aspx?eid=<%=Request["EmployeeId"] %>" target="tabContent">
                Competências</a> </li>
        </ul>
        <iframe id="tabContent" name="tabContent" src="Employee_PersonalData.aspx?eid=<%=Request["EmployeeId"] %>"
            style="width: 100%; height: 500"></iframe>
    </div>
</asp:Content>
