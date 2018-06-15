<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@ include file="/common/sysCommon.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 11:24:15
  - Description:
-->
<head>
<title>预约管理</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/BookingManagement/BookingManagementEdit.js?v=1.0.36"></script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	width: 84px;
	text-align: right;
}

.required {
	color: red;
}
</style>

</head>
<body>
<input id="scoutMode" class="nui-combobox" visible="false"/>
<input id="isUsabled" class="nui-combobox" visible="false"/>
<input id="bookStatus" class="nui-combobox" visible="false"/>



<div style=" width: 100%;  ">
		 <div class="nui-toolbar" style="border-bottom:0;width: 99%;">
		    <div class="nui-form1" id="queryForm" style="width: 100%;" >
		        <table style="width: 100%;" id="table1">
		            <tr>
		                <td>
		                   
		                    <label>车牌号：</label>
		                    <input class="nui-textbox" name="carNo"/>
		                    <span class="separator"></span>
		                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="search()">查询</a>
		                     
		                    
		               
		    			</td>
		            </tr>
		        </table>
		    </div>
		</div>
        <div showCollapseButton="false" style="border:0; ">
         
                    <div class="nui-form" id="basicInfoForm" >
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId" id="guestId"/>
                        <input class="nui-hidden" name="contactorId" id="contactorId"/>
                        <table style="border-collapse:separate; border-spacing:0px 10px;">
                            <tr>
                            <td class="form_label">
                             <label  >服务顾问：</label>
                             </td>
		                     <td>	
		                     <input class="nui-combobox" id="mtAdvisor" name="mtAdvisor" value=""    textField="name" valueField="id"/>
                           	 </td>
                                <td class="form_label">
                                    <label>车牌号：</label>
                                </td>
                                <td>
                                    <input class="nui-buttonedit" name="carId"
                                           onclick="addCarBrand"
                                           ebabled="false"
                                           id="carId"/>
                                </td>
                                <td class="form_label">
                                    <label>品牌：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="carBrandId" id="carBrandId"
                                           textField="nameCn"
                                           valueField="id"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label">
                                    <label>车型：</label>
                                </td>
                                <td colspan="5">
                                    <input class="nui-combobox"
                                           width="100%"
                                           textField="carModel"
                                           valueField="carModelId"
                                           id="carSeriesId"
                                           name="carSeriesId"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>联系人：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox"
                                           id="contactorName"
                                           name="contactorName"/>
                                </td>
                                <td class="form_label required">
                                    <label>联系电话：</label>
                                </td>
                                <td>
                                    <input class="nui-textbox" name="contactorTel" id="contactorTel"/>
                                </td>
                                <td class="form_label">
                                    <label>业务类型：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" id="serviceTypeId"
                                           name="serviceTypeId"
                                           textField="name"
                                           valueField="customid"/>
                                </td>
                            </tr>
                            <tr>
                                <td class="form_label required">
                                    <label>预计来厂：</label>
                                </td>
                                <td>
                                    <input name="predictComeDate" class="nui-datepicker" viewDate="new Date()"
                                           nullValue="null" format="yyyy-MM-dd" showOkButton="true" id="predictComeDate" name="predictComeDate"
                                           showClearButton="false"/>
                                </td>
                                
                                <td class="form_label">
                                    <label>预约类型：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" name="prebookCategory"
                                           id="prebookCategory"
                                           textField="name"
                                           valueField="customid"/>
                                </td>
                                <td class="form_label">
                                    
                                </td>
                                <td>
                                    <input class="nui-textbox" name="id"
                                           id="id"  visible="false"
                                           />
                                </td>
                            </tr>
                           
                            <tr>
                                <td class="form_label">
                                    <label>客户描述：</label>
                                </td>
                                <td colspan="5">
                                    <textarea class="nui-textarea"
                                              width="100%"
                                              name="faultDesc"></textarea>
                                </td>
                            </tr>
                        </table>
                    </div>
               <div style="text-align: center; padding: 1px;">
									<a class="nui-button" onclick="onOk" style="width: 60px;">确定(O)</a>
									<a class="nui-button" onclick="onCancel" style="width: 60px;">取消(C)</a>
				</div>
             
        </div>
    </div>


</div>
</body>
</html>