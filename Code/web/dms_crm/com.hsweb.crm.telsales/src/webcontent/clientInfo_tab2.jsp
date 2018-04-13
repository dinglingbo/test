<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="保险保养信息" name="tab1" visible="true">    
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend ></legend>
        <div style="padding:5px;">
            <div class="row">
                <span class="title title-width2 required">保险公司：</span>
                <input name="insureCompCode"
                       id="insureCompCode"
                       required="true"
                       class="nui-combobox width6"
                       textField="fullName"
                       valueField="code"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       valueFromSelect="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
            </div>
            <div class="row">
                <span class="title title-width2 required">商业险到期：</span>
                <input id="annualInspectionDate" name="annualInspectionDate" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">交强险到期：</span>
                <input id="insureDueDate" name="insureDueDate" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width2 required">发动机号：</span>
                <input id="engineNo" name="engineNo" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">保养到期：</span>
                <input id="careDueDate" name="careDueDate" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width2 required">生产日期：</span>
                <input id="produceDate" name="produceDate" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">颜色：</span>
                <input name="color"
                       id="color"
                       required="true"
                       class="nui-combobox width2"
                       textField="name"
                       valueField="customid"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       valueFromSelect="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
            </div>
            <div class="row">
                <span class="title title-width2 required">年审到期：</span>
                <input id="annualVerificationDueDate" name="annualVerificationDueDate" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">驾审到期：</span>
                <input id="drivingLicenceDueDate" name="drivingLicenceDueDate" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width2 required">备注：</span>
                <input id="remark" name="remark" class="nui-textbox width6" required="true"/>
            </div>
        </div>
    </fieldset>
</div>