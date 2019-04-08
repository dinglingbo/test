<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/commonRepair.jsp"%>
<html>
<!--
- Author(s): steven
- Date: 2018-01-26 11:24:15
- Description:
-->

<head>
    <title>预约跟进</title>
    <script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/BookingManagement/BookingScout.js?v=1.3.8"></script>
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
    
    <div style=" width: 100%;  ">
        <div showCollapseButton="false" style="border:0; ">
        	 <div class="nui-toolbar" style="padding:0px;border-bottom:0;white-space: nowrap;">
	            <table style="width:80%;">
	                <tr>
	                    <td style="width:80%;">
	                        <a class="nui-button" iconCls="" plain="true" onclick="onOk()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                        <a class="nui-button" iconCls="" plain="true" onclick="onClose"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
	                        <span class="separator"></span>
	                        <a id="btn_mobile"class="nui-button" plain="true" iconCls="" plain="false" onclick="telVisit()"><span class="fa fa-phone fa-lg"></span>&nbsp;电话回访</a>
                            <a id="btn_info"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendInfo()"><span class="fa fa-envelope-o fa-lg"></span>&nbsp;发送短信</a>
                            <!--<a id="btn_model"class="nui-button" plain="true" iconCls="" plain="false" onclick=""><span class="fa fa-weixin fa-lg"></span>&nbsp;发送微信</a>-->
                            <a id="btn_coupon"class="nui-button" plain="true" iconCls="" plain="false" onclick="sendWcCoupon()"><span class="fa fa-credit-card fa-lg"></span>&nbsp;发送卡券</a>
	                    </td>
	                </tr>
	            </table>
	        </div>
            <div class="nui-form" id="basicInfoForm">     
                <input id="id" class="nui-textbox" visible="false" />           
                <input id="serviceId" class="nui-textbox" visible="false" />
                <input id="scoutModeList" class="nui-combobox" visible="false" />
                <input id="scoutReustList" class="nui-combobox" visible="false" />
                <table style="border-collapse:separate; border-spacing:0px 10px;">
                    <tr>
                        <td class="form_label">
                            <label>车牌号：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="carNo" name="carNo" enabled="false" />
                        </td>
                        <td class="form_label">
                            <label>客户名称：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" id="contactorName" name="contactorName" enabled="false"/>
                        </td>
                        <td class="form_label">
                            <label>联系电话：</label>
                        </td>
                        <td>
                            <input class="nui-textbox" name="contactorTel" id="contactorTel" enabled="false" />
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label">
                            <label>跟进方式：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" id="scoutMode" name="scoutMode" textField="name" valueField="customid" required="true"/>

                        </td>
                        <td class="form_label">
                            <label>跟进结果：</label>
                        </td>
                        <td>
                            <input class="nui-combobox" id="isUsabled" name="isUsabled" textField="name" valueField="customid" required="true"/>

                        </td>
                        <td  class="form_label">
                            <label>下次跟进：</label>
                        </td>
                        <td>
                            <input id="nextScoutDate"  name="nextScoutDate" width="150px" class="nui-datepicker" format="  yyyy-MM-dd HH:mm" timeFormat="H:mm" showTime="true" 
                                allowInput="false" showTodayButton="false" ondrawdate="onDrawDate" viewDate="new Date()" nullValue="null" showOkButton="true"
                                showClearButton="false" required="true"/>
                        </td>                        
                    </tr>               
                    <tr>
                        <td class="form_label">
                            <label>跟进内容：</label>
                        </td>
                        <td colspan="5">
                            <textarea  id="scoutContent" name="scoutContent" class="nui-textarea" width="100%" height="180px"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
<!--             <div style="text-align: center; padding: 1px;"> -->
<!--                 <a class="nui-button" onclick="onOk" style="width: 60px;">保存(S)</a> -->
<!--                 <a class="nui-button" onclick="onClose" style="width: 60px;">关闭(C)</a> -->
<!--             </div> -->

        </div>
    </div>


    </div>
</body>

</html>