<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>


<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>应收账款管理</title>
<%@include file="/common/sysCommon.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
	<script src="<%=webPath + contextPath%>/frm/js/arap/receive_sk.js?v=1.5"
	type="text/javascript"></script>
</head>
<body>
	<div class="nui-fit">
		<form id="form1" method="post">
		<input class="nui-textbox" name="guestId" id="guestId" visible="false"/>
			<fieldset style="border: solid 1px #aaa; padding: 3px;">
				<legend>基本信息</legend>
				<div style="padding: 5px;">
					<input class="nui-hidden" name="id">
					<table>
						<tr>
							<td class="title" style="width: 100px;">客户名称:</td>
							<td colspan="3"><input class="nui-textbox" enabled="false"
								name="guestFullName" style="width: 440px;" /></td>
						</tr>


						<tr>
							<td class="title" style="width: 100px;">单位备注:</td>
							<td colspan="3"><input class="nui-textbox" enabled="false"
								 style="width: 440px;" /></td>
						</tr>
						<tr>
							<td class="title" style="width: 100px;">工单号:</td>
							<td colspan="3"><input class="nui-textbox" enabled="false"
								name="serviceCode" style="width: 440px;" /></td>
						</tr>
						<tr>
							<td class="title">本单结转人:</td>
							<td><input class="nui-textbox" enabled="false"
								name="recorder" /></td>
							<td class="title">本单结转日期:</td>
							<td><input class="nui-datepicker width2M" enabled="false"
								name="recordDate" format="yyyy-MM-dd HH:mm" /></td>

						</tr>

					</table>
				</div>
			</fieldset>
			<fieldset style="border: solid 1px #aaa; padding: 3px;" id="fiebillAmt" name="fiebillAmt">
				<legend>是否开发票: 是</legend>
				<div style="padding: 5px;">
					<table>
						<tr>
							<td class="title" style="width: 110px;">发票号:</td>
							<td><input class="nui-textbox" 
								style="width: 400px;" /></td>
							<td class="title">应开发票金额:</td>
							<td><input class="nui-textbox" enabled="false"
								name="billAmt" /></td>
							<td class="title">实开发票金额:</td>
							<td><input class="nui-textbox"/></td>
						</tr>

					</table>
				</div>
			</fieldset>
			<div class="nui-fit">
				<div class="nui-splitter" id="splitter" allowResize="false"
					handlerSize="6" style="width: 100%; height: 75%;">
					<div size="85%" showCollapseButton="false" style="border: 0;">
						<div title="请选择单据" class="nui-panel"
							style="width: 100%; height: 100%">
							<fieldset style="border: solid 1px #aaa; padding: 3px;">
								<legend>请选择单据</legend>
								<div style="padding: 5px;">
									<div id="dgGrid" class="nui-datagrid"
										style="width: 100%; height: 80%;" showPager="true"
										pageSize="10" sizeList="[10,20,50]" allowAlternating="true"
										multiSelect="true" showSummaryRow="true"
										url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" 
										 dataField="data" 
										idField="id" treeColumn="name" parentField="parentId">
										<div property="columns" width="10">
											<div type="indexcolumn">序号</div>
											<div field="id" allowSort="true" headerAlign="center"
												visible="false" width="120"></div>
											<div field="rpCode" name="rpCode" allowSort="true" headerAlign="center"
											width="120"  >订单号</div>
											<div field="serviceTypeId" allowSort="true" headerAlign="center"
												width="120">业务类型</div>
											<div field="serviceCode" allowSort="true" headerAlign="center" summaryType="count" align=center width="120">工单号</div>
											<div field="rpAmt" allowSort="true" headerAlign="center"  summaryType="sum"  
												width="120">应收金额</div>
											<div field="rpAmtYes" allowSort="true" summaryType="sum"  headerAlign="center"
												width="120">已收金额</div>
											<div field="rpAmtNo" allowSort="true" headerAlign="center"
												width="120">未收金额</div>
											<div field="billAmt" allowSort="true" headerAlign="center"
												width="120">发票金额</div>
										</div>
									</div>

								</div>
							</fieldset>
						</div>
					</div>
					<div size="30%" showCollapseButton="false" style="border: 0;">

						<div title="结算信息" class="nui-panel"
							style="width: 100%; height: 100%">
							<table>
								<tr>
									<td class="title"
										style="width: 100px; color: red; text-align: left;">支付方式：</td>
								<td><input name="payment" textField="name" 
                                valueField="customid" id="payment" class="nui-combobox" /></td>
								</tr>
								<tr>
									<td class="title" style="text-align: left;">冲预收款：</td>
									<td><input class="nui-textbox width2M" enabled="false"
										 /></td>
								</tr>
								<tr>
									<td colspan="2"><a class="nui-button"
										style="width: 260px;">冲减预收款</a></td>
								</tr>
								<tr>
									<td class="title"
										style="width: 100px; color: red; text-align: left;">实收金额：</td>
									<td><input class="nui-textbox width2M" onKeyup=""  onValuechanged="setCharCount()" name="recive" id="recive"
									/></td>
								</tr>
								<tr>
									<td class="title" style="text-align: left;">应收金额：</td>
									<td><input class="nui-textbox width2M" enabled="false"
										name="rpAmt" /></td>
								</tr>
								<tr>
									<td class="title" style="text-align: left;">欠收金额：</td>
									<td><input class="nui-textbox width2M" enabled="false"
										name="rpAmtNo" /></td>
								</tr>
								<tr style="display: none">
									<td class="title" style="text-align: left;">积分：</td>
								</tr>
								<tr  style="display: none">
									<td colspan="2" ><input class="nui-textbox width2M" value="0"/></td>
								</tr>
								<tr>
									<td class="title" style="text-align: left;">收款备注：</td>
								</tr>
								<tr>
									<td colspan="2"><input class="nui-textarea" name=remark
										required="true"style=" width: 240px;" />
								</tr>
								
							</table>
							
						</div>
					
					</div>
						
				</div>
				<div style="text-align: center; padding: 1px;">
									<a class="nui-button" onclick="pay" style="width: 60px;">确定(O)</a>
									<a class="nui-button" onclick="onCancel" style="width: 60px;">取消(C)</a>
				</div>
			</div>


		</form>

	</div>

</body>
</html>