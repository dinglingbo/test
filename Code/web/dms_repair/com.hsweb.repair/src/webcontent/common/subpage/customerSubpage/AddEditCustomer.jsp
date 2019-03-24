<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-31 16:54:43
  - Description:
-->
<head>
<title>新增/修改客户档案</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/AddEditCustomer.js?v=1.3.28"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 100px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>

        <div class="nui-panel" showToolbar="false" title="客户信息" showFooter="false"
             borderStyle="border:0;"
             style="width:100%;">
              <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                            </td>
                        </tr>
                    </table>
                </div>
            <div class="form" id="basicInfoForm">
                <input class="nui-hidden" name="id"/>
                <table class="nui-form-table" style="width:99%">
                     <tr>
                        <td class="form_label required">
                            <label>客户名称：</label>
                        </td>
                        <td >
                         <input class="nui-hidden" name="id" id="guestId"/>
                         <input class="nui-textbox" id="fullName" name="fullName" width="100%" onvaluechanged="onChanged(this.id)"/>
                        </td>
                        <td class="form_label required">
                            <label>手机号码：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="mobile" name="mobile"  width="100%" onvaluechanged="onChanged(this.id)"  
                            emptyText="请输入手机号查询" onenter="onChanged(this.id)"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>性别：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" data="[{value:'0',text:'男',},{value:'1',text:'女'},]"
						textField="text" valueField="value" name="sex"
						value="0"  width="100%" />
                        </td>
                        <td class="form_label ">
                            <label>客户简称：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="shortName" name="shortName" onValuechanged="processMobile(this.value)" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                      <!--   <td class="form_label">
                            <label>生日类型：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" data="[{value:'0',text:'农历',},{value:'1',text:'阳历'},]"
						textField="text" valueField="value" name="birthdayType"
						value="0"  width="100%"/>
                        </td>
                        <td class="form_label ">
                            <label>生日日期：</label>
                        </td>
                        <td>
                            <input name="birthday" allowInput="false" class="nui-datepicker" width="100%"/>
                        </td> -->
                        <td class="form_label">
                                <label>客户级别：</label>
                            </td>
                            <td colspan="3">
                                <input name="guestTypeId"
                                   id="guestTypeId"
                                   class="nui-combobox "
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="40%" 
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>地址：</label>
                        </td>
                        <td colspan="3">
                            <input name="provinceId"
                               id="provice"
                               valueField="code"
                               textField="name"
                               emptyText = "省"
                               url=""
                               onValuechanged="initCityByParent('cityId', e.value || -1)"
                               class="nui-combobox" width="32%"/>
                            
                            <input name="cityId"
                               id="cityId"
                               valueField="code"
                               textField="name"
                               emptyText = "市/县"
                               onValuechanged="initCityByParent('areaId', e.value || -1)"
                               class="nui-combobox" width="33%"/>
                               
                            <input name="areaId"
                               id="areaId"
                               valueField="code"
                               textField="name"
                               emptyText = "乡/镇"
                               class="nui-combobox" width="33%"/>
                            
                            <input class="nui-textbox" name="addr" width="100%"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>备注：</label>
                        </td>
                        <td colspan="3">
                            <input class="nui-textbox" name="remark" width="100%"/>
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="nui-fit">
            <div class="nui-tabs" activeIndex="0" id="tabs"
                 style="width:100%;">
                <div title="车辆信息" showCloseButton="false">
                    <div class="form" id="carInfoFrom">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId"/>
                        <input class="nui-hidden" name="carBrandId" id="carBrandId"/>
                        <input class="nui-hidden" name="carModelId" id="carModelId"/>
                        <input class="nui-hidden" name="carModelIdLy" id="carModelIdLy"/>
                        <input class="nui-hidden" name="insureCompName" id="insureCompName"/>
                        <table class="nui-form-table" style="width:100%;">
                            <tr>
                                <td class="form_label required">
                                    <label>车牌号：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-textbox" name="carNo" id="carNo"/>
                                     
                                        <a class="nui-button" iconCls="" id="preCarBtn" onclick="preCar()" style="margin-right:10px;" tooltip="上一个" plain="true"><span class="fa fa-chevron-left fa-lg"></span></a>
                                        <a class="nui-button" iconCls="" id="nextCarBtn" onclick="nextCar()" style="margin-right:10px;" tooltip="下一个" plain="true"><span class="fa fa-chevron-right fa-lg"></span></a>
                                        <a class="nui-button" iconCls="" onclick="addCar()" tooltip="新增" plain="true"><span class="fa fa-plus fa-lg"></span></a>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label ">
                                    <label>车架号(VIN)：</label>
                                </td>
                                <td colspan="2">
                                    <input class="nui-textbox" id="vin" name="vin" width="100%"/>
                                </td>
                                <td>
                                    <a class="nui-button" onclick="onParseUnderpanNo()">解析车型</a>
                                    <a class="nui-button" onclick="getCarModel(setCarModel)">选择车型</a>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>车型信息：</label>
                                </td>
                                <td colspan="3">
                                    <textarea class="nui-textarea" id="carModel" name="carModelFullName" width="100%"></textarea>
                                </td>
                            </tr>
                            <!--
                            <tr>
                                <td class="form_label">
                                    <label>品牌车型：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-buttonedit" name="carModelId" id="carModelId" onclick="selectCarModel('carModelId','carBrandId')" width="100%"/>
                                </td>
                            </tr>
                            -->
                            <tr>
                                <td class="form_label">
                                    <label>发动机号：</label>
                                </td>
                                <td>
                                    <input name="engineNo" class="nui-textbox" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>年审到期：</label>
                                </td>
                                <td>
                                    <input name="annualVerificationDueDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>

                            <tr>
                                <td class="form_label">
                                    <label>商业险单号：</label>
                                </td>
                                <td>
                                    <input name="annualInspectionNo" class="nui-textbox" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>商业险到期：</label>
                                </td>
                                <td>
                                    <input name="annualInspectionDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
			                <tr>
			                    <td class="form_label">
			                        <label>商业险投保公司：</label>
			                    </td>
			                    <td colspan="3">
			                        <input class="nui-combobox" name="annualInspectionCompCode" id="annualInspectionCompCode" valueField="id" textField="fullName" width="100%" onvaluechanged="onannualInsureChange"
			                        />
			                    </td>
			                </tr>
                            <tr>
                                <td class="form_label">
                                    <label>交强险单号：</label>
                                </td>
                                <td>
                                    <input name="insureNo" class="nui-textbox" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>交强险到期：</label>
                                </td>
                                <td>
                                    <input name="insureDueDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
			               <tr>
			                    <td class="form_label">
			                        <label>交强险投保公司：</label>
			                    </td>
			                    <td colspan="3">
			                        <input class="nui-combobox" name="insureCompCode" id="insureCompCode" valueField="id" textField="fullName" width="100%" onvaluechanged="onInsureChange"
			                        />
			                    </td>
			                </tr>
                            <tr>
                                <td class="form_label">
                                    <label>生产日期：</label>
                                </td>
                                <td>
                                    <input name="produceDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>上牌日期：</label>
                                </td>
                                <td>
                                    <input name="firstRegDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                
                                <td class="form_label">
                                    <label>发证日期：</label>
                                </td>
                                <td>
                                    <input id="issuingDate" name="issuingDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>是否禁用：</label>
                                </td>
                                <td>
                                    <input type="checkbox" id="isDisabled" class="mini-checkbox" naem="isDisabled"  trueValue="1" falseValue="0" >
                                </td>
                              <!--   <td class="form_label" >
                                    <label>公司内部车：</label>
                                </td>
                                <td>
                                    <input name="isCompanyInside"
                                           data="[{id:1,text:'是'},{id:0,text:'否'}]"
                                           class="nui-combobox" width="100%"/>
                                </td> -->
                                
                            </tr>
                             <tr>
				                <td class="form_label">
				                    <label>备注：</label>
				                </td>
				                <td colspan="3">
				                    <input class="nui-textbox" name="remark" width="100%" />
				                </td>
				            </tr>
                        </table>
                    </div>
                </div>
                <div title="联系人信息" showCloseButton="false">
                    <div class="form" id="contactInfoForm">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId"/>
                    
					<table class="nui-form-table" style="width:100%;">
                <tr>
                    <td class="form_label required">
                        <label>姓名：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-textbox" id="name2" name="name" width="160px" />
                        <a class="nui-button" iconCls="" id="preContactBtn" onclick="preContact()" style="margin-right:10px;" tooltip="上一个" plain="true"><span class="fa fa-chevron-left fa-lg"></span></a>
                        <a class="nui-button" iconCls="" id="nextContactBtn" onclick="nextContact()" style="margin-right:10px;" tooltip="下一个" plain="true"><span class="fa fa-chevron-right fa-lg"></span></a>
                        <a class="nui-button" iconCls="" onclick="addContact()" tooltip="新增" plain="true"><span class="fa fa-plus fa-lg"></span></a>
                    </td>
                </tr>
                <tr>
                    <td class="form_label required">
                        <label>手机：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" id="mobile2" name="mobile" width="100%" />
                    </td>
                    <td class="form_label required">
                        <label>身份：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" name="identity" id="identity" valueField="customid" textField="name" width="100%" value="060301" />
                    </td>
                </tr>
                <tr>
                     <td class="form_label">
                        <label>性别：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" id="sex" name="sex" data="[{id:0,text:'男'},{id:1,text:'女'},{id:2,text:'未知'}]" width="100%" value="0"
                        />
                    </td>
                    <td class="form_label required">
                        <label>来源：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" name="source" id="source" valueField="customid" textField="name" width="100%" value="060110" />
                    </td>
                </tr>
                 <tr>
                    <td class="form_label">
                        <label>驾驶证号：</label>
                    </td>
                    <td>
                 	   <input class="nui-textbox" name="licenseNo" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>准备车型(A1)：</label>
                    </td>
                    <td>
                    	<input class="nui-textbox" name="licenseType" width="100%" />
                    </td>
                </tr>
                 <tr>
                    <td class="form_label">
                        <label>初次领证时间：</label>
                    </td>
                    <td>
                        <input name="licenseRecordDate" allowInput="true" class="nui-datepicker" width="100%" />
                    </td>
                    <td class="form_label">
                        <label>驾照到期日期：</label>
                    </td>
                    <td>
                        <input name="licenseOverDate" allowInput="true" class="nui-datepicker" width="100%" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>生日类型：</label>
                    </td>
                    <td>
                        <input class="nui-combobox" name="birthdayType" data="[{id:0,text:'农历'},{id:1,text:'阳历'}]" width="100%" value="0" />
                    </td>
                    <td class="form_label">
                        <label>生日：</label>
                    </td>
                    <td>
                        <input name="birthday" allowInput="true" class="nui-datepicker" width="100%" />
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>身份证号码：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-textbox" name="idNo" width="100%" />
                    </td>
                </tr>
                
                <tr>
                    <td class="form_label">
                        <label>备注：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-textbox" name="remark" width="100%" />
                    </td>
                </tr>
            </table>
                        
                    </div>
                </div>
            </div>
<!--             <div id="btnGroup" style="text-align:center;padding:10px;"> -->
<!--                 <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a> -->
<!--                 <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a> -->
<!--             </div> -->
        </div>

</body>
</html>