<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
 
<div title="客户资料" name="tab2" visible="true">  
	    <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="saveClientInfo()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                    </td>
                </tr>
            </table>
        </div>  
    <form id="form2" method="post">
        <div id="basicInfoForm" class="form">
            <fieldset style="border:solid 1px #aaa;padding:3px;">
                <legend >客户信息</legend>
                <div style="padding:5px;">
                    <input class="nui-hidden" name="id"/>
                    
                    <div class="row">            
                        <span class="title title-width1 required">客户：</span>
                        <input id="guestName" name="guestName" class="nui-textbox width2" required="true"/>   
                        <span class="title title-width2 required">联系人：</span>
                        <input id="contacts" name="contacts" class="nui-textbox width2" required="true"/>                        
                    </div>
                    <div class="row">            
                        <span class="title title-width1 required">手机：</span>
                        <input id="mobile" name="mobile" class="nui-textbox width2" required="true"/>
                        <span class="title title-width2">电话：</span>
                        <input id="tel" name="tel" class="nui-textbox width2" />         
                    </div>
                    <div class="row">            
                        <span class="title title-width1 ">性别：</span>
                        <input name="sex"
                            id="sex"
                            class="nui-combobox width2"
                            textField="text"
                            valueField="value"
                            emptyText="请选择..."
                            data = "const_gender"
                            allowInput="false"
                            showNullItem="false"
                            nullItemText="请选择..."/>
                        <span class="title title-width2">是否黑名单：</span>
                        <input name="isBlack"
                               id="isBlack"
                               required="true"
                               class="nui-combobox width2"
                               textField="text"
                               valueField="value"
                               emptyText="请选择..."
                               data="const_is"
                               allowInput="false"
                               valueFromSelect="true"
                               showNullItem="false"
                               nullItemText="请选择..."/>
                    </div>
                    <div class="row">            
                        <span class="title title-width1">地址：</span>
                        <input id="address" name="address" class="nui-textbox width6" />
                    </div>
                </div>    
            </fieldset>
            <fieldset style="border:solid 1px #aaa;padding:3px;">
                <legend >车辆信息</legend>
                <div style="padding:5px;">
                    <input class="nui-hidden" name="id"/>
                    <div class="row">            
                        <span class="title title-width1 required">车牌：</span>
                        <input id="carNo" name="carNo" class="nui-textbox width2" required="true"/>          
                        <span class="title title-width1 ">品牌：</span>
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
                        <span class="title title-width1 ">车型：</span>
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
                        <span class="title title-width1">上牌日期：</span>
                        <input id="firstRegDate" 
                                name="firstRegDate" 
                                class="nui-datepicker width2" 
                                dateFormat="yyyy-MM-dd hh:MM" 
                                emptyText="请选择日期" alwaysView="true"/>          
                    </div>
                    <div class="row">            
                        <span class="title title-width1">VIN：</span>
                        <input id="vin" name="vin" class="nui-textbox width2" required="true"/>
                        <span class="title title-width1">投保公司：</span>
                        <input name="insureCompCode"
                               id="insureCompCode"
                               class="nui-combobox width2"
                               textField="fullName"
                               valueField="code"
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
<!--         <div style="text-align:center;padding:10px;display:none;" class="saveGroup"> -->
<!--             <a id="save" class="mini-button" onclick="saveClientInfo" style="width:60px;margin-right:20px;">保存</a> -->
<!--         </div> -->
    </form>
</div>