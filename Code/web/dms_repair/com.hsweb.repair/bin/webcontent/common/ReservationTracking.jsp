<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-07 10:46:46
  - Description:
-->
<head>
<title>预约跟踪</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/BookingManagement/ReservationTracking.js?v=1.0.2"></script>
<style type="text/css">
table {
	font-size: 12px;
}

.form_label {
	width: 72px;
	text-align: right;
}

.form_label_1 {
	width: 84px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<div class="nui-panel" showToolbar="false" title="客户预约信息" showFooter="false"
     style="width:100%;">
    <div class="form" id="bookInfoForm">
        <table>
            <tr>
                <td class="form_label">
                    <label>车牌号：</label>
                </td>
                <td>
                    <input name="carNo" enabled="false" class="nui-textbox"/>
                </td>
                <td class="form_label">
                    <label>品牌：</label>
                </td>
                <td>
                    <input name="carBrandName" enabled="false" class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>车系：</label>
                </td>
                <td colspan="3">
                    <input class="nui-textbox" enabled="false" name="carSeriesName" style="width:100%;"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>联系人：</label>
                </td>
                <td>
                    <input name="contactorName" enabled="false" class="nui-textbox"/>
                </td>
                <td class="form_label">
                    <label>联系人电话：</label>
                </td>
                <td>
                    <input name="tel" enabled="false" class="nui-textbox"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">
                    <label>客户描述：</label>
                </td>
                <td colspan="3">
                    <textarea name="faultDesc" enabled="false" class="nui-textarea" style="width:100%;"></textarea>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%;"
         plain="false" onactivechanged="">
        <div title="预约跟踪">
            <div id="basicInfoForm" class="form">
            	<input class="nui-hidden" name="serviceId"/>
                <table>
                    <tr>
                        <td class="form_label_1">
                            <label>跟踪方式：</label>
                        </td>
                        <td>
                            <input name="scoutMode" id="scoutMode" class="nui-combobox"
                                   textField="name" valueField="customid"/>
                        </td>
                        <td class="form_label_1">
                            <label>跟踪人：</label>
                        </td>
                        <td>
                            <input name="scoutMan" class="nui-textbox" enabled="false"/>
                        </td>
                        <td class="form_label_1">
                            <label>跟踪日期：</label>
                        </td>
                        <td>
                            <input name="scoutDate" class="nui-datepicker"  enabled="false"/>
                        </td>
                    </tr>
                    <tr>
                        <td class="form_label_1">
                            <label>跟踪结果：</label>
                        </td>
                        <td>
                            <input name="isUsabled" class="nui-combobox"
                                   id="isUsabled"
                                   textField="name" valueField="customid"/>
                        </td>
                        <td class="form_label_1">
                            <label>下次跟踪日期：</label>
                        </td>
                        <td>
                            <input name="nextScoutDate" class="nui-datepicker"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <label>跟踪内容（Enter换行，描述不能超过500字）：</label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <textarea name="scoutContent" class="nui-textarea" style="width:100%;height:150px;"></textarea>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div style="text-align:right;padding:5px 5px;margin-top:0">
        <a class="nui-button" onclick="onOk" style="margin-right:10px;width:60px">保存(S)</a>
        <a class="nui-button" onclick="onCancel">取消(C)</a>
    </div>
</div>

</body>
</html>