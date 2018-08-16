<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/common.jsp"%>
	<%@include file="/common/commonRepair.jsp"%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-15 17:18:09
  - Description:
-->
<head>
<title>会员卡充值</title>
<%--     <script src="<%=webPath + repairDomain%>/repair/js/RepairBusiness/BookingManagement/BookingManagementEdit.js?v=1.3"></script> --%>
    
</head>
<body>


    <div style=" width: 100%;  ">
        <div showCollapseButton="false" style="border:0; ">
            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                
            </div>
            <div class="nui-form" id="basicInfoForm">

                <table style="border-collapse:separate; border-spacing:0px 10px;">
                    <tr>

                        <td class="form_label">
                            <label>客户姓名：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="" name="" visible="true"  allowInput="true"/>
                        </td>
                        <td class="form_label">
                            <label>客户电话：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="" name="" allowInput="true" valueField=""  />
                        </td>
                        <td class="form_label">
                            <label>客户生日：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="" name="" allowInput="true" textField="" valueField="" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>客户性别：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="" name="" required="true"/>
                        </td>
                        <td class="form_label">
                            <label>会员等级：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" name="" id="" required="true"/>
                        </td>
                        <td class="form_label">
                            <label>会员卡余额：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="" name="" textField="" valueField="" required="true"/>

                        </td>
                    </tr>
                    
                    <tr>
                        <td  class="form_label">
                            <label>预计来厂：</label>
                        </td>
                        <td>
                            <!-- <input id="predictComeDate"  name="predictComeDate" width="150px" class="nui-datepicker" format="yyyy-MM-dd H:mm" timeFormat="H:mm" showTime="true" 
                                allowInput="false" showTodayButton="false" ondrawdate="onDrawDate" viewDate="new Date()" nullValue="null" showOkButton="true"
                                showClearButton="false" required="true"/> -->
                            <input class="nui-combobox" id="timeStart" name="timeStart" textField="name"  ondrawdate="onDrawDate"
                                valueField="id" allowInput="false"  onValuechanged="setTimeChange" >
                        </td>
                    </tr>
                    <tr>
                        <td  class="form_label">
                        </td>
                        <td colspan="5">
                            <div class="addyytime">
                            </div>
                        </td>
                    </tr>

                    <tr>
                        <td class="form_label">
                            <label>客户描述：</label>
                        </td>
                        <td colspan="5">
                            <textarea class="nui-textarea" width="100%" height="180px" id="faultDesc" name="faultDesc"></textarea>
                        </td>
                    </tr>
                </table>
            </div>

        </div>
    </div>


    </div>
</body>
</html>