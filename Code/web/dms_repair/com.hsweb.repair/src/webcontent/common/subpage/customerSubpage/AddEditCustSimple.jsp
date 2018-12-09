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
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CustomerProfile/AddEditCustSimple.js?v=1.0.0"></script>
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
         borderStyle="border:1;"
         style="width:100%;height:80%;">
        <div class="form" id="basicInfoForm">
            <input class="nui-hidden" name="id"/>
            <table class="nui-form-table" style="width:99%">
                <tr>
                    <td class="form_label required">
                        <label>客户名称：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="fullName" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label required">
                        <label>车牌号：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="carNo" id="carNo" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>手机号码：</label>
                    </td>
                    <td>
                        <input class="nui-textbox" name="mobile" width="100%"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label required">
                        <label>车架号(VIN)：</label>
                    </td>
                    <td colspan="2">
                        <input class="nui-textbox" id="underpanNo" name="underpanNo" width="100%"/>
                    </td>
                    <td>
                        <a class="nui-button" onclick="onParseUnderpanNo()">解析</a>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>车型信息：</label>
                    </td>
                    <td colspan="3">
                        <textarea class="nui-textarea" id="carModelInfo" name="carModelInfo" width="100%"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="form_label">
                        <label>品牌车型：</label>
                    </td>
                    <td colspan="3">
                        <input class="nui-buttonedit" name="carModelId" id="carModelId" onclick="selectCarModel('carModelId','carBrandId')" width="100%"/>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div style="text-align:center;padding:10px;">
        <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">保存</a>
        <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>
    </div>
</body>
</html>