<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="客户资料" name="tab2" visible="true">    
    <form id="form2" method="post">
        <div id="basicInfoForm" class="form">
            <fieldset style="border:solid 1px #aaa;padding:3px;">
                <legend >客户信息</legend>
                <div style="padding:5px;">
                    <input class="nui-hidden" name="id"/>
                    <div class="row">            
                        <span class="title title-width1 required">客户名称：</span>
                        <input id="guestName" name="guestName" class="nui-textbox width2" required="true"/>          
                        <span class="title title-width1 required">手机：</span>
                        <input id="mobile" name="mobile" class="nui-textbox width2" required="true"/>
                    </div>
                    <div class="row">            
                        <span class="title title-width1">电话：</span>
                        <input id="tel" name="tel" class="nui-textbox width2" />         
                        <span class="title title-width1">地址：</span>
                        <input id="address" name="address" class="nui-textbox width2" />
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
                        <span class="title title-width1 required">厂牌：</span>
                        <input id="carBrandId" name="carBrandId" class="nui-textbox width2" required="true"/>
                    </div>
                    <div class="row">            
                        <span class="title title-width1 required">车型：</span>
                        <input id="carModel" name="carModel" class="nui-textbox width2" required="true"/>          
                        <span class="title title-width1">上牌日期：</span>
                        <input id="firstRegDate" 
                                name="firstRegDate" 
                                class="nui-datepicker width2" 
                                dateFormat="yyyy-MM-dd HH:mm:ss" 
                                emptyText="请选择日期" alwaysView="true"/>          
                    </div>
                    <div class="row">            
                        <span class="title title-width1">VIN：</span>
                        <input id="underpanNo" name="underpanNo" class="nui-textbox width2" required="true"/>
                        <span class="title title-width1">投保公司：</span>
                        <input name="insureCompCode"
                               id="insureCompCode"
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
                </div>    
            </fieldset>
            <fieldset style="border:solid 1px #aaa;padding:3px;">
                <legend >联系人信息</legend>
                <div style="padding:5px;">
                    <input class="nui-hidden" name="id"/>
                    <div class="row">            
                        <span class="title title-width1 required">姓名：</span>
                        <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>         
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
                        <span class="title title-width1 required">联系人：</span>
                        <input id="contacts" name="contacts" class="nui-textbox width2" required="true"/>
                        <span class="title title-width1 required">手机：</span>
                        <input id="charCount" name="charCount" class="nui-textbox width2" required="true"/>
                    </div>
                    <div class="row">            
                        <span class="title title-width1">电话：</span>
                        <input id="tel" name="tel" class="nui-textbox width2" />
                        <span class="title title-width1">是否黑名单：</span>
                        <input name="isBlack"
                               id="isBlack"
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
                </div>    
            </fieldset>
        </div>
        <div style="text-align:center;padding:10px;">
            <a id="save" class="mini-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
        </div>
    </form>
</div>