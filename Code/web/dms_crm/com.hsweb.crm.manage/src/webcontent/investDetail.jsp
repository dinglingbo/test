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
    <div class="nui-fit">
    	<table id="investForm">
    		<tr>
    		
                <td style="width:70px;text-align:right;" class="title-tab"><span>车牌号:</span></td>
				<td>
					<input id="id" name="id" style="width:300px;" class="nui-hidden"/>
					<input id="carId" name="carId" style="width:300px;" class="nui-hidden"/>
					<input id="guestId" name="guestId" style="width:300px;" class="nui-hidden"/>
					<input id="carNo" name="carNo" style="width:300px;" class="nui-textbox" onvaluechanged="carNoChange" required="true">
					
				</td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>工单号:</span></td>
				<td>
					<input id="serviceCode" name="serviceCode" style="width:300px;" class="nui-textbox"/>
					<input id="serviceId" name="serviceId" style="width:300px;" class="nui-hidden"/>
				</td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>营销员:</span></td>
				<td>
					<input id="visitId" name="visitId" style="width:300px;" textField="empName" valueField="empId"  
					emptyText="请选择..." class="nui-combobox" allowInput="false" onvaluechanged="visitChange" required="true"/>
					<input id="visitMan" name="visitMan" class="nui-hidden"/>
				</td>
            </tr>      
            <tr>
                <td style="width:70px;text-align:right;"><span>来厂类型:</span></td>
				<td><input id="carType" name="carType" style="width:300px;" class="nui-combobox"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>备注:</span></td>
				<td><input id="remark" name="remark" style="width:300px;height:100px" class="nui-textarea"/></td>
            </tr>
    	</table>
    </div>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="left: 160px;">
            <tr>
                <td>
                    <a class="nui-button" iconCls="icon-save" plain="true" onclick="save()">保存</a>
                    <a class="nui-button" iconCls="icon-close" plain="true" onclick="onCancel()">关闭</a>
                </td>
            </tr>
        </table>
    </div>
</body>
</html>