<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="基本信息" name="tab2" visible="true">    
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend >客户信息</legend>
        <div style="padding:5px;">
            <input class="nui-hidden" name="id"/>
            <input class="nui-hidden" name="guestId"/>
            <input id="recorder" name="recorder" style="display:none;" class="nui-textbox width2"/>
            <input id="recordDate" 
                name="recordDate" 
                class="nui-datepicker width2" 
                dateFormat="yyyy-MM-dd HH:mm:ss" 
                style="display:none;" emptyText="请选择日期" alwaysView="true"/>
            <input  id="modifier" name="modifier" style="display:none;" class="nui-textbox width2" value="<b:write property='userName'/>"/>
            <input id="modifyDate" 
                name="modifyDate" 
                class="nui-datepicker width2" 
                dateFormat="yyyy-MM-dd HH:mm:ss" 
                style="display:none;" emptyText="请选择日期" alwaysView="true"/>
            
            <div class="row">
                <span class="title title-width1 required">客户名称：</span>
                <input id="guestName" name="guestName" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 required">来源：</span>
                <input name="source"
                           id="source"
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
                <span class="title title-width1 required">联系人：</span>
                <input id="contacts" name="contacts" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 required">性别：</span>
                <input name="sex"
                       id="sex"
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
                <span class="title title-width1 required">手机号码：</span>
                <input id="mobile" name="mobile" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 required">电话号码：</span>
                <input id="tel" name="tel" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width1 required">客户地址：</span>
                <input id="address" name="address" class="nui-textbox width6" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width1">身份证号：</span>
                <input id="idcard" name="idcard" class="nui-textbox width6" />
            </div>
        </div>
    </fieldset>
    
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend >车辆信息</legend>
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
                    style="height: 80px;" 
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
</div>