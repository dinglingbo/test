<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="基本信息" name="tab2" visible="true">    
    <fieldset style="border:solid 1px #aaa;padding:3px;">
        <legend >客户信息</legend>
        <div style="padding:5px;">
            <input class="nui-hidden" name="id"/>
            <input class="nui-hidden" name="guestId"/>
            <input class="nui-hidden" id="visitStatus" name="visitStatus"/>
            <input class="nui-hidden" id="status" name="status"/>
            <input id="recorder" name="recorder" style="display:none;" class="nui-textbox width2"/>
            <input id="recordDate" 
                name="recordDate" 
                class="nui-datepicker width2" 
                dateFormat="yyyy-MM-dd HH:mm" 
                style="display:none;" emptyText="请选择日期" alwaysView="true"/>
            <input  id="modifier" name="modifier" style="display:none;" class="nui-textbox width2" value="<b:write property='userName'/>"/>
            <input id="modifyDate" 
                name="modifyDate" 
                class="nui-datepicker width2" 
                dateFormat="yyyy-MM-dd HH:mm" 
                style="display:none;" emptyText="请选择日期" alwaysView="true"/>
            
            <div class="row">
                <span class="title title-width1 required">客户名称：</span>
                <input id="guestName" name="guestName" class="nui-textbox width6" required="true"/>
            </div>  
            <div class="row">
                <span class="title title-width1 required">联系人：</span>
                <input id="contacts" name="contacts" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 ">性别：</span>
                <input name="sex"
                       id="sex"
                       class="nui-combobox width2"
                       textField="text"
                       valueField="value"
                       emptyText="请选择..."
                       data = "const_gender"
                       allowInput="false"
                       showNullItem="false"/>
            </div>
            <div class="row">
                <span class="title title-width1 required">手机号码：</span>
                <input id="mobile" name="mobile" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 required">电话号码：</span>
                <input id="tel" name="tel" class="nui-textbox width2" required="true"/>
            </div>
            <div class="row">
                <span class="title title-width1 ">客户地址：</span>
                <input id="address" name="address" class="nui-textbox width6" />
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
                <input id="carNo" name="carNo" class="nui-textbox width2" required="true"/>
                <span class="title title-width1 ">车辆品牌：</span>
                <input id="carBrandName" name="carBrandName" class="nui-hidden" />
                <input name="carBrandId"
                       id="carBrandId"
                       class="nui-combobox width2"
                       textField="nameCn"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       onValuechanged="getCarModel('carModelId', e)"
                       showNullItem="false"
                       nullItemText="请选择..."/>
            </div>
            <div class="row">
                <span class="title title-width1 required">VIN：</span>
                <input id="vin" name="vin" class="nui-textbox width4" required="true"/>
                <a class="nui-button" iconCls="icon-find" plain="true" onclick="query()" id="query">解析</a>
            </div>
            <div class="row">
                <span class="title title-width1">车型信息：</span>
                <textarea id="carModelInfo" 
                    name="carModelInfo" 
                    class="mini-textarea width6" 
                    onValuechanged=""
                    onKeyup="carModelInfo.doValueChanged()"
                    style="height: 80px;" 
                    emptyText="请输入内容"
                    >
                </textarea>
            </div>
            <div class="row">
                <span class="title title-width1 ">品牌车型：</span>
                <input class="nui-hidden" id="_carModel" name="carModel"/>
                <input name="carModelId"
                       id="carModelId"
                       class="nui-combobox width2"
                       textField="carModel"
                       valueField="carModelId"
                       emptyText="请选择..."
                       onValuechanged="nui.get('_carModel').setValue(this.text)"
                       allowInput="false"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                <span class="title title-width1 ">上牌日期：</span>
                <input id="firstRegDate" 
                            name="firstRegDate" 
                            class="nui-datepicker width2" 
                            dateFormat="yyyy-MM-dd" 
                            enabled="true" emptyText="请选择日期" alwaysView="true"/>
            </div>
        </div>
    </fieldset>
</div>