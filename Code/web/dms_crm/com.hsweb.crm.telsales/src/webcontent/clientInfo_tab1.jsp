<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="车辆信息" name="tab1" visible="true">    
    <!--
    -->
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend >基本信息</legend>
        <div style="padding:5px;">
            <input class="nui-hidden" name="id"/>
            <div class="row">
                <span class="title title-width1 required">车牌号：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 required">车辆品牌：</span>
                <input name="typeId"
                       id="typeId"
                       required="true"
                       class="nui-combobox width2"
                       textField="NAME"
                       valueField="CUSTOMID"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       valueFromSelect="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
            </div>
            <div class="row">
                <span class="title title-width1 required">VIN：</span>
                <input id="charCount" name="charCount" class="nui-textbox width4" required="true"/>
                <a class="nui-button" iconCls="icon-find" plain="true" onclick="query()" id="query">解析</a>
            </div>
            <div class="row">
                <span class="title title-width1 required">车型信息：</span>
                <textarea id="content" 
                    name="content" 
                    class="mini-textarea width6" 
                    onValuechanged="setCharCount()"
                    onKeyup="content.doValueChanged()"
                    style="height: 120px;" 
                    emptyText="请输入短信内容"
                    required="true">
                </textarea>
            </div>
            <div class="row">
                <span class="title title-width1 required">车型：</span>
                <input name="typeId"
                       id="typeId"
                       required="true"
                       class="nui-combobox width2"
                       textField="NAME"
                       valueField="CUSTOMID"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       valueFromSelect="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                <span class="title title-width1 required">上牌日期：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
            </div>
        </div>
    </fieldset>
    
    <fieldset style="border:solid 1px #aaa;padding:3px;">
    <legend >其他信息</legend>
        <div style="padding:5px;">
            <div class="row">
                <span class="title title-width1 required">保险公司：</span>
                <input name="typeId"
                       id="typeId"
                       required="true"
                       class="nui-combobox width5"
                       textField="NAME"
                       valueField="CUSTOMID"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       valueFromSelect="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
            </div>
            <div class="row">
                <span class="title title-width1 required">交强险到期：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">商业险到期：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width2 required">发动机号：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">保养到期：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width2 required">生产到期：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">颜色：</span>
                <input name="typeId"
                       id="typeId"
                       required="true"
                       class="nui-combobox width2"
                       textField="NAME"
                       valueField="CUSTOMID"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       valueFromSelect="true"
                       showNullItem="false"
                       nullItemText="请选择..."/>
            </div>
            <div class="row">
                <span class="title title-width2 required">年审到期：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
                <span class="title title-width2 required">驾审到期：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
            </div>
        </div>
    </fieldset>
</div>