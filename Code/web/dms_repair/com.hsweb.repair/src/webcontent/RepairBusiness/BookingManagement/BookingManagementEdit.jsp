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
		                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
		                     
		                    
		               
		    			</td>
		            </tr>
		        </table>
		    </div>
		</div>
        <div showCollapseButton="false" style="border:0; ">
         
                    <div class="form" id="basicInfoForm" >
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="guestId" id="guestId"/>
                        <input class="nui-hidden" name="contactorId" id="contactorId"/>
                        <table>
                            <tr>
                            <td class="form_label">
                             <label  >服务顾问：</label>
                             </td>
		                     <td>	
		                     <input class="nui-combobox" id="defaultStore" name="defaultStore" value=""   width="70px"  textField="name" valueField="id"/>
                           	 </td>
                                <td class="form_label">
                                    <label>车牌号：</label>
                                </td>
                                <td>
                                    <input class="nui-buttonedit" name="carId"
                                           onclick="selectCar"
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
                                    <input class="nui-textbox" name="tel" id="tel"/>
                                </td>
                                <td class="form_label">
                                    <label>业务类型：</label>
                                </td>
                                <td>
                                    <input class="nui-combobox" id="prebookItem"
                                           name="prebookItem"
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
                                           nullValue="null" format="yyyy-MM-dd" showOkButton="true"
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
									<a class="nui-button" onclick="pay" style="width: 60px;">确定(O)</a>
									<a class="nui-button" onclick="onCancel" style="width: 60px;">取消(C)</a>
				</div>
             
        </div>
    </div>


<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:180px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="form_label">预计来厂 从:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           class="nui-datepicker"/>
                </td>
                <td class="form_label">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">品牌:</td>
                <td colspan="1">
                    <input class="nui-combobox" name="carBrandId"
                           valueField="id" textField="nameCn"
                           id="carBrandId-ad"/>
                </td>
                <td class="form_label">车牌号:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="carNo"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">预约类型:</td>
                <td colspan="1">
                    <input class="nui-combobox" name="prebookItem"
                           valueField="customid" textField="name"
                           id="prebookItem-ad"/>
                </td>
                <td class="form_label">车牌号:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="carNo"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchClear" style="width:60px;margin-right:20px;">清除</a>
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>
</html>