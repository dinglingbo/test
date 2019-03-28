<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:26:10
  - Description:
-->
<head>
<title>车牌车主变更</title>
<script src="<%= request.getContextPath() %>/repair/js/RepairBusiness/CustomerProfile/carChange.js?v=1.1.1"></script>
<style type="text/css">

.dtable{
	table-layout: fixed;
	font-size: 12px;
	height: 100%;
	width: 100%;
}

.form_label {
	width: 80px;
	text-align: right;
}

.d_label {
	width: 80px;
	text-align: center;
}

/* .mini-panel {
	margin-top: 10px;
	margin-left: 10px;
	margin-right: 10px;
	 width: calc(100% - 20px) !important; 
} */

.required {
	color: red;
}
</style>
</head>
<body>

<div class="nui-fit">
	            <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                            <a class="nui-button" onclick="onClose()" plain="true"  style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
                        </td>
                    </tr>
                </table>
            </div>
				<div  class="form">
					<input name="id" class="nui-hidden"/>
					<input name="orgid" class="nui-hidden"/>
					<div class="nui-panel" showToolbar="false" title="变更信息" showFooter="false"
						style="width:100%;">
						<table class="nui-form-table" border=0>
							<tr>
								<td class="form_label required">
									<label>变更类型：</label>
								</td>
								<td colspan="1">
									<input class="nui-combobox"
										data="[{value:'0',text:'变更车牌',},{value:'1',text:'变更车主'},{value:'2',text:'变更车架号(VIN)'}]"
										textField="text" valueField="value" name="changeType"
										value="0" onvalidation="updateType()" id="changeType" width="200px" />
								</td>
							</tr>
							<tr>
								<td class="form_label required">
									<label>变更原因：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="remark" id="remark" width="200px" />
								</td>
							</tr>
						</table>
					</div>
					<div>
					<div id="yCar" class="form">
					<div class="nui-panel"  showToolbar="false" title="原车辆信息" showFooter="false"
							style="width:49.5%;float:left">
					<table class="nui-form-table" border=0>
							<tr>
								<td class="form_label">
									<label>车牌号：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="carNo" id="carNo" width="140px"/>
									<input name="id" class="nui-hidden"/>
								</td>
							</tr> 
							<tr>
								<td class="form_label">
									<label>车架号(VIN)：</label>
								</td>
								<td colspan="1">
										<input class="nui-textbox" name="vin" id="vin" width="140px"/>
								</td>
							</tr>            
							<tr>
								<td class="form_label">
									<label>客户名称：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="guestFullName" id="guestFullName" width="140px"/>
								</td>
							</tr> 
							<tr>
								<td class="form_label">
									<label>电话号码：</label>
								</td>
								<td colspan="1">
										<input class="nui-textbox" name="mobile" id="mobile" width="140px"/>
								</td>
							</tr> 
						</table> 
				</div>
			</div>
				<div id="xCar" class="form">
								<div class="nui-panel" showToolbar="false" title="现车辆信息" showFooter="false"
							style="width:49.5%;float:right">
 											<table class="nui-form-table" border=0>
							<tr>
								<td class="form_label">
									<label>车牌号：</label>
								</td>
								<td colspan="1">
									<input class="nui-textbox" name="carNo" id="xcarNo" width="140px"/>
									<input name="id" class="nui-hidden"/>
									<input name="xGuestId" id="xGuestId" class="nui-hidden"/>
								</td>
							</tr> 
							<tr>
								<td class="form_label">
									<label>车架号(VIN)：</label>
								</td>
								<td colspan="1">
										<input class="nui-textbox" name="vin" id="xvin" width="140px"/>
								</td>
							</tr>            
							<tr>
								<td class="form_label">
									<label>客户名称：</label>
								</td>
								<td colspan="1">
									<!-- <input class="nui-textbox" name="guestFullName" id="xguestFullName" width="140px"/> -->
									<input id="xguestFullName" name="guestFullName"  class="mini-buttonedit" allowInput="false" width="140px" onbuttonclick="onButtonEdit" selectOnFocus="true" />
								</td>
							</tr> 
							<tr>
								<td class="form_label">
									<label>电话号码：</label>
								</td>
								<td colspan="1">
										<input class="nui-textbox" name="mobile" id="xmobile" width="140px"/>
								</td>
							</tr> 
						</table> 
					</div>
			</div>
			<div style="clear:both"></div>
</div>
	</div>
</div>

	
</body>
</html>