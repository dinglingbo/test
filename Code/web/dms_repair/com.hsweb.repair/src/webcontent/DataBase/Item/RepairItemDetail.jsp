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
<title>新增和编辑</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script
	src="<%= request.getContextPath() %>/repair/js/DataBase/Item/RepairItemDetail.js"  type="text/javascript"></script>
    
    
</head>
<body style="margin:0;padding:0;">
		<input name="pageType" class="nui-hidden"/>
		<div id="dataform1" class="nui-form" >
		<div  class="nui-panel" showToolbar="false" title="基本信息" showFooter="false" style="width:430px;height:200px;margin:9px 9px">
			<div style="padding-top:5px;" >
				<table style="table-layout:fixed;" class="nui-form-table">
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="color:#FF0000;margin-left:10px;" >项目编码：</span>
						</td>
						<td>
							<input class="nui-textbox" name="code" width="120px"/>
						</td>
						<td class="form_label" width="50px"> 
							<span style="color:#FF0000;margin-left:10px;">工种：</span>
						</td>
						<td>
							<input class="nui-combobox" name="type" width="122px"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label"width="80px" > 
							<span style="color:#FF0000;margin-left:10px;">项目名称：</span>
						</td>
						<td>
							<input class="nui-textbox" name="name" width="300px"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="color:#FF0000;margin-left:10px;">项目类型：</span>
						</td>
						<td>
							<input class="nui-combobox" name="itemKind" width="300px"/>
						</td>
					</tr>
					<tr style=" display:block;margin:5px 0">
						<td class="form_label" width="80px"> 
							<span style="color:#FF0000;margin-left:10px;">品牌：</span>
						</td>
						<td>
							<input class="nui-combobox" name="carBrandId" width="120px"/>
						</td>
						<td class="form_label" width="50px"> 
							<span style="color:#FF0000;margin-left:10px;">车型：</span>
						</td>
						<td>
							<input class="nui-combobox" name="carModel" width="122px"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		
		
		<div  class="nui-panel" showToolbar="false" title="工时价格信息" showFooter="false" style="width:430px;height:200px;margin:9px 9px">
			<table style="table-layout:fixed;" class="nui-form-table">
				<tr style=" display:block;margin:5px 0">
					<td class="form_label" width="80px"> 
						<span style="margin-left:20px;">标准工时：</span>
					</td>
					<td colspan="1">
						<input class="nui-spinner" name="itemTime" format="0.00" value="0" maxValue="1000000000"
										changeOnMousewheel="true" showButton="false" width="300px" inputStyle="text-align:right;"/>
				</tr>
				<tr style=" display:block;margin:5px 0">
					<td class="form_label" width="80px"> 
						<span style="margin-left:20px;">工时单价：</span>
					</td>
					<td colspan="1">
						<input class="nui-spinner" name="unitPrice" format="0.00" value="0" maxValue="1000000000"
										changeOnMousewheel="true" showButton="false" width="300px" inputStyle="text-align:right;"/>
					</td>
				</tr>
				<tr style=" display:block;margin:5px 0">
					<td class="form_label" width="80px"> 
						<span style="margin-left:20px;">工时金额：</span>
					</td>
					<td colspan="1">
						<input class="nui-spinner" name="amt" format="0.00" value="0" maxValue="1000000000"
										changeOnMousewheel="true" showButton="false" width="300px" inputStyle="text-align:right;"/>
					</td>
				</tr>
				<tr style=" display:block;margin:5px 0">
					<td class="form_label" width="80px"> 
						<span style="margin-left:20px;">提成金额：</span>
							</td>
							<td colspan="1">
								<input class="nui-spinner" name="unitPriceFours" format="0.00" value=" " maxValue="1000000000"
										changeOnMousewheel="true" showButton="false" width="300px" inputStyle="text-align:right;"/>
							</td>
						</tr>
					</table>
				</div>
			</div>


				
			
			<div style="text-align:center;padding:10px;">               
        <a class="nui-button" onclick="onOk" style="width:60px;margin-right:20px;">确定</a>       
        <a class="nui-button" onclick="onCancel" style="width:60px;">取消</a>       
    </div>
		
	
</body>
</html>