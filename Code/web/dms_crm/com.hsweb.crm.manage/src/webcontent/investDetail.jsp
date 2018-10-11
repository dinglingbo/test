<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>业绩详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/sysCommon.jsp" %>
    <script src="manage/js/investDetail.js" type="text/javascript"></script>
</head>
<body>
	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table>
            <tr>
                <td>
                    <a class="nui-button" iconCls="icon-save" plain="true" onclick="">保存</a>
                    <a class="nui-button" iconCls="icon-close" plain="true" onclick="onCancel()">关闭</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
    	<table>
    		<tr>
                <td style="width:70px;text-align:right;" class="title-tab"><span>车牌号:</span></td>
				<td ><input style="width:100%;" class="nui-textbox"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>业务单号:</span></td>
				<td><input style="width:100%;" class="nui-combobox" allowInput="false"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>维修顾问:</span></td>
				<td><input style="width:100%;" class="nui-textbox"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>车辆厂牌:</span></td>
				<td><input style="width:100%;" class="nui-textbox"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>营销员:</span></td>
				<td><input style="width:100%;" class="nui-combobox" allowInput="false"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>业绩门店:</span></td>
				<td><input style="width:100%;" class="nui-combobox" allowInput="false"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>业绩来源:</span></td>
				<td><input style="width:100%;" class="nui-combobox" allowInput="false"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>来厂类型:</span></td>
				<td><input style="width:100%;" class="nui-combobox" allowInput="false"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>备注:</span></td>
				<td><input style="width:100%;" class="nui-textarea"/></td>
            </tr>
    	</table>
    </div>
</body>
</html>