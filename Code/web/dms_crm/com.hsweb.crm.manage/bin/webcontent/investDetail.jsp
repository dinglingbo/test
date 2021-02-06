<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>业绩详情</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    	<%@include file="/common/sysCommon.jsp" %>
    <script src="<%=request.getContextPath()%>/manage/js/investDetail.js?v=1.0.5"></script>
</head>
<body>
    <div class="nui-fit">
    	<div class="nui-toolbar" style="padding:2px;">
	        <table >
	            <tr>
	                <td>
	                    <a class="nui-button" iconCls="" plain="true" id="ok" name = "ok" onclick="save()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
	                    <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
	                </td>
	            </tr>
	        </table>
	    </div>
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
					<input id="visitId" name="visitId" style="width:300px;" textField="empName" valueField="empId"   popupHeight="100%"
					emptyText="请选择..." class="nui-combobox" allowInput="false" onvaluechanged="visitChange" required="true"/>
					<input id="visitMan" name="visitMan" class="nui-hidden"/>
				</td>
            </tr>      
            <tr>
                <td style="width:70px;text-align:right;"><span>来厂类型:</span></td>
				<td><input id="carType" name="carType" style="width:300px;" class="nui-combobox" data="hash" valueField="id" textField="text"/></td>
            </tr>
            <tr>
                <td style="width:70px;text-align:right;"><span>备注:</span></td>
				<td><input id="remark" name="remark" style="width:300px;height:100px" class="nui-textarea"/></td>
            </tr>
    	</table>
    </div>

</body>
</html>