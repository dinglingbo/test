<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="客户信息" name="tab2" visible="true">    
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend >基本信息</legend>
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
                <input id="source" name="source" class="nui-textbox width6" required="true"/>
            </div>  
            <div class="row">
                <span class="title title-width1 required">联系人：</span>
                <input id="source" name="source" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 required">性别：</span>
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
                <span class="title title-width1 required">手机号码：</span>
                <input id="source" name="source" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 required">电话号码：</span>
                <input id="source" name="source" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width1 required">地址：</span>
                <input id="source" name="source" class="nui-textbox width6" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width1 required">备注：</span>
                <input id="source" name="source" class="nui-textbox width6" required="true"/>
            </div>
        </div>
    </fieldset>
    
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend>其他信息</legend>
        <div style="padding:5px;">
            <div class="row"> 
                <span class="title title-width2 required">来源：</span>
                <input name="typeId"
                           id="typeId"
                           required="true"
                           class="nui-combobox width6"
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
                <span class="title title-width2 required">身份：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" />
                <span class="title title-width1 required">特别关注：</span>
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
                <span class="title title-width2">生日：</span>
                <input id="charCount" name="charCount" class="nui-textbox width2" />
                <span class="title title-width1">生日类型：</span>
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
                <span class="title title-width2">身份证号：</span>
                <input id="charCount" name="charCount" class="nui-textbox width6" />
            </div>
            <div class="row">
                <span class="title title-width2">身份证地址：</span>
                <input id="charCount" name="charCount" class="nui-textbox width6" />
            </div>
        </div>   
    </fieldset>   
</div>