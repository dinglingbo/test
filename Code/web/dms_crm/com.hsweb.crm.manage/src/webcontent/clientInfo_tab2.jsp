<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<div title="保险保养信息" name="tab1" visible="true">
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend >信息</legend>
        <div style="padding:5px;"> 

<table>
    <tr>
                <td><span class="title title-width2 ">保险公司：</span></td>
                <td colspan="3"><input name="insureCompCode"
                 		dataField="list"
                       id="insureCompCode"
                       class="nui-combobox "
                       textField="fullName" 
                       valueField="code"
                       emptyText="请选择..."
                       allowInput="false"
                       showNullItem="false"
                       style="width:100%;" 
                       nullItemText="请选择..."/></td>
    </tr>

    <tr>
                <td><span class="title title-width2 ">商业险到期：</span></td>
                <td><input id="annualInspectionDate"
                            name="annualInspectionDate"
                            class="nui-datepicker width2"
                            dateFormat="yyyy-MM-dd"
                            enabled="true" emptyText="请选择日期" alwaysView="true"/></td>
                <td><span class="title title-width2 ">交强险到期：</span></td>
                <td><input id="insureDueDate"
                            name="insureDueDate"
                            class="nui-datepicker width2"
                            dateFormat="yyyy-MM-dd"
                            enabled="true" emptyText="请选择日期" alwaysView="true"/></td>
    </tr>
    <tr>
                <td><span class="title title-width2 ">发动机号：</span></td>
                <td><input id="engineNo" name="engineNo" class="nui-textbox width2" /></td>
                <td><span class="title title-width2 ">保养到期：</span></td>
                <td><input id="careDueDate"
                            name="careDueDate"
                            class="nui-datepicker width2"
                            dateFormat="yyyy-MM-dd"
                            enabled="true" emptyText="请选择日期" alwaysView="true"/></td>
    </tr>

    <tr>
                <td><span class="title title-width2 ">颜色：</span></td>
                <td><input name="color"
                       id="color"
                       class="nui-combobox width2"
                       textField="name"
                       valueField="customid"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       showNullItem="false"
                       nullItemText="请选择..."/></td>
                <td><span class="title title-width2">生产日期：</span></td>
                <td><input id="produceDate"
                            name="produceDate"
                            class="nui-datepicker width2"
                            dateFormat="yyyy-MM-dd"
                            enabled="true" emptyText="请选择日期" alwaysView="true"/></td>
    </tr>
    <tr>
                <td><span class="title title-width2">车辆年检：</span></td>
                <td><input id="annualVerificationDueDate"
                            name="annualVerificationDueDate"
                            class="nui-datepicker width2"
                            dateFormat="yyyy-MM-dd"
                            enabled="true" emptyText="请选择日期" alwaysView="true"/></td>
                <td><span class="title title-width2">驾照年审：</span></td>
                <td><input id="drivingLicenceDueDate"
                            name="drivingLicenceDueDate"
                            class="nui-datepicker width2"
                            dateFormat="yyyy-MM-dd"
                            enabled="true" emptyText="请选择日期" alwaysView="true"/></td>
    </tr>
    <tr>
                <td><span class="title title-width2">备注：</span></td>
                <td colspan="3"><input id="remark" name="remark" class="nui-textbox "style="width:100%;" /></td>
    </tr>
</table>


        </div>
    </fieldset>
</div>