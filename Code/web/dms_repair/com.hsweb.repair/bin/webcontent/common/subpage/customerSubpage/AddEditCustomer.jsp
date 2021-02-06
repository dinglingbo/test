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
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/AddEditCustomer.js?v=1.6.2"></script>
      	<script src="<%=webPath + contextPath%>/common/js/qiniu.min.js" type="text/javascript"></script>
  	    <script src="https://cdn.staticfile.org/jquery/2.2.1/jquery.min.js"></script>
 	<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
 	<script src="<%= request.getContextPath() %>/common/qiniu/qiniu1.0.14.js" type="text/javascript"></script>
  	<script src="https://cdn.staticfile.org/plupload/2.1.9/moxie.js"></script>
 	<script src="https://cdn.staticfile.org/plupload/2.1.9/plupload.dev.js"></script>  
<style type="text/css">
 	.max_img{
		display: none;
		position: absolute;
		bottom: 0;
		left: 0; 
		width:550px;
		height:500px;
		z-index:999;
		margin:0 auto;
	}
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
a{
cursor: pointer;
}
            .print_btn  {
            text-align: center;
                width: 230px;
                height: 37px;
                display: inline-block;
                background: #ff6600b3;
                line-height: 35px;
                border-radius: 5px;
                color: #fff;
                font-size: 15px;
                text-decoration: none;
                margin: 0 100px;
            }

            a:hover {
                color: #fff;
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
                                <a class="nui-button" iconCls="" plain="true" onclick="delet()" id="deletBtn"><span class="fa fa-trash-o fa-lg"></span>&nbsp;清空</a>
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
						textField="text" valueField="value" name="sex" id="guestSex"
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
                                   width="46%" 
                                   valueFromSelect="true"
                                   nullItemText="请选择..."/>
                    </tr>
                        <tr>
                        	 <td class="form_label ">
		                        <label>客户属性：</label>
		                    </td>
		                    <td>
		                        <input class="nui-combobox" name="guestProperty" id="guestProperty" valueField="customid" textField="name" width="200px" value="013902" />
		                    </td> 
		                    <td class="form_label ">
		                        <label>客户属性特点：</label>
		                    </td>
		                    <td>
		                        <input class="nui-textbox" name="propertyFeatures" id="propertyFeatures"  width="100%"  />
		                    </td> 
                        </tr>                    
						<tr>
                            <td class="form_label">
                                <label>地址：</label>
                            </td>
                            <td colspan="3">
                                <input name="provinceId" id="provice" valueField="code" textField="name" emptyText="省" url="" onvaluechanged="onProvinceChange"
                                    class="nui-combobox" width="32%" />

                                <input name="cityId" id="cityId" valueField="code" textField="name" emptyText="市/县" onvaluechanged="onCityChange"
                                    class="nui-combobox" width="33%" />

                                <input name="areaId" id="areaId" valueField="code" textField="name" emptyText="乡/镇" class="nui-combobox" width="33%" onvaluechanged="onCountyChange"/>
                            </td>
                        </tr>
                        <tr>
			                <td class="form_label"><label>详细地址:</label></td>
			                <td colspan="3"><input class="nui-textbox tabwidth" name="streetAddress" id="streetAddress" onvaluechanged="onStreetChange" width="66%"/></td>			
			            </tr>
			            <tr>
			                <td class="form_label"><label>组合地址:</label></td>
			                <td colspan="3"><input class="nui-textbox tabwidth" enabled="true" name="addr" id="addr" width="66%"/></td>			
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
                 style="width:100%;height: 100%">
                <div title="车辆信息" showCloseButton="false" >
                    <div class="form" id="carInfoFrom">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId"/>
                        <input class="nui-hidden" name="carBrandId" id="carBrandId"/>
                        <input class="nui-hidden" name="carModelId" id="carModelId"/>
                        <input class="nui-hidden" name="carModelIdLy" id="carModelIdLy"/>
                        <input class="nui-hidden" name="insureCompName" id="insureCompName"/>
                        <table class="nui-form-table" style="width:100%;">
                             <tr>
                                <td colspan="4">
                                     <a class="print_btn" href="#" id="faker4">上传行驶证识别车辆信息</a>
									
                                </td>
                            </tr>                       	
                            <tr>
                                <td class="form_label required">
                                    <label>车牌号：</label>
                                </td>
                                <td colspan="3">
                                    <input class="nui-textbox" name="carNo" id="carNo"/>
                                      	<a class="nui-button" onclick="parsingCarNo()">获取车架号(VIN)</a>
                                        <a class="nui-button" iconCls="" id="preCarBtn" onclick="preCar()" style="margin-right:10px;" tooltip="上一个" plain="true"><span class="fa fa-chevron-left fa-lg"></span></a>
                                        <a class="nui-button" iconCls="" id="nextCarBtn" onclick="nextCar()" style="margin-right:10px;" tooltip="下一个" plain="true"><span class="fa fa-chevron-right fa-lg"></span></a>
                                        <a class="nui-button" iconCls="" onclick="addCar()" tooltip="新增" plain="true"><span class="fa fa-plus fa-lg"></span></a>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
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
                                    <input name="engineNo" id="engineNo" class="nui-textbox" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>生产日期：</label>
                                </td>
                                <td>
                                    <input name="produceDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>注册日期：</label>
                                </td>
                                <td>
                                    <input name="firstRegDate" id="firstRegDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>年审到期：</label>
                                </td>
                                <td>
                                    <input name="annualVerificationDueDate" id="annualVerificationDueDate" allowInput="true" class="nui-datepicker" width="100%"/>
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
                                    <label>发证日期：</label>
                                </td>
                                <td>
                                    <input id="issuingDate" name="issuingDate" allowInput="true" class="nui-datepicker" width="100%"/>
                                </td>
                                <td class="form_label">
                                    <label>是否禁用：</label>
                                </td>
                                <td>
                                    <input type="checkbox" id="isDisabled" class="mini-checkbox" name="isDisabled"  trueValue="1" falseValue="0" >
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
							  <tr>
			                	<td class="form_label" colspan="1">
			                        <label>行驶证正本照：<br><a  href="#" id="faker2">点击上传</a></label>
			                    </td>
			                    <td >
					                <div class="page-header" id="btn-uploader" style="position: unset;">
									            <img id="xmTanImg2" style="width: 100px;height: 100px" onclick="changeShow(this.src);" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
			
								    </div>
					
					
											 <input  class="nui-textbox" id="driveLicensePicOne" name="driveLicensePicOne"  style="display:none" >
			                    </td>
			                    <td class="form_label" colspan="1">
			                       <label>行驶证副本照：<br><a  href="#" id="faker3">点击上传</a></label>
			                    </td>
			                    <td>
				                    <div class="page-header" id="btn-uploader" style="position: unset;">
					                	
								            <img id="xmTanImg3" style="width: 100px;height: 100px" onclick="changeShow(this.src);" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
								        
							        </div>
			
			
									 <input  class="nui-textbox" id="driveLicensePicTwo" name="driveLicensePicTwo"  style="display:none" >
			                    </td>
			                </tr>
                        </table>
                    </div>
                </div>
                <div title="联系人信息" showCloseButton="false">
                    <div class="form" id="contactInfoForm">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId"/>
                    
					<table class="nui-form-table" style="width:100%;height: 100%">
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
                        <input class="nui-combobox" id="sex" name="sex"  data="[{id:0,text:'男'},{id:1,text:'女'},{id:2,text:'未知'}]" width="100%" value="0"
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
                        <label>准驾车型(A1)：</label>
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
                <tr>
               		 <td class="form_label">
                        <label>驾驶证正本照：<br><a  href="#" id="faker">点击上传</a></label>
                    </td>
                    <td nowrap="nowrap">
		                <div class="page-header" id="btn-uploader">
						            <img id="xmTanImg" style="width: 100px;height: 100px" onclick="changeShow(this.src)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>
					    </div>
		
		
								 <input  class="nui-textbox" id="licensePicOne" name="licensePicOne"  style="display:none" >
                    </td>
                    <td class="form_label" colspan="1">
                       <label>驾驶证副本照：<br><a  href="#" id="faker1">点击上传</a></label>
                    </td>
                    <td>
	                    <div class="page-header" id="btn-uploader">
					            <img id="xmTanImg1" style="width: 100px;height: 100px" onclick="changeShow(this.src)" src="<%= request.getContextPath() %>/common/images/logo.jpg"/>

				        </div>


						 <input  class="nui-textbox" id="licensePicTwo" name="licensePicTwo"  style="display:none" >
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
	   <div class="max_img" style=" margin:0 auto">
			<img src="" id="maxImgShow" onclick="changeHide();" width="100%" height="100%" />
	   </div>
</body>
</html>