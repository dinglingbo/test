<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/sysCommon.jsp" %>
		<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>

		<head>
			<title>投诉管理</title>
			<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
			<script src="<%=webPath + contextPath%>/manage/js/complainDetail.js?v=1.0.3"></script>
			<link href="<%=webPath + contextPath%>/manage/css/complainDetail.css" rel='stylesheet' type='text/css' />
		</head>

		<body>
			<div id="complainFrom" class="nui-fit">
				<div style="width:calc(100% - 20px);height:45%;padding:10px;">
					<div class="nui-panel" title="客户信息" style="width:100%;height:100%;">
						<table  style="border-collapse:separate; border-spacing:10px;">
							<tr>
								<td>
									<font color="red">车牌号:</font>
								</td>
								<td>
									<input class="nui-hidden" name="id" name="id"/>
									<input class="nui-hidden" name="carId" name="carId"/>
									<input class="nui-hidden" name="serviceId" name="serviceId"/>
									<input class="nui-hidden" name="complaintOrgid" name="complaintOrgid"/>
									<input class="nui-hidden" name="guestId" name="guestId"/>
									<input class="nui-textbox" id="carNo" name="carNo" onvaluechanged="carNoChange(this.value)"/>
								</td>
							</tr>
							<tr >

								<td>
									客户电话:
								</td>
								<td>
									<input class="nui-textbox" id="mobile" name="mobile"  />
								</td>
								<td>
									客户姓名:
								</td>
								<td>
									<input class="nui-textbox" id="fullName" name="guestName"  />
								</td>
								<td>
									工单号:
								</td>
								<td>
									<input class="nui-textbox" id="serviceCode" />
								</td>
							</tr>
							<tr>
								<td>
									<span>投诉类型:</span>
								</td>
								<td>
									<input class="nui-combobox" id="complaintType" name="complaintType"  />
								</td>
								<td>
									<span>投诉级别:</span>
								</td>
								<td>
									<input class="nui-combobox" id="complaintLevel" name="complaintLevel"  />
								</td>
								<td>
									<span>投诉日期:</span>
								</td>
								<td>
									<input class="nui-datepicker" id="complaintDate" name="complaintDate"   />
								</td>

							</tr>
							<tr>
								<td>
									<span>维修顾问:</span>
								</td>
								<td>
									<input class="nui-textbox" id="mtAdvisor"  />
								</td>
								<td>
								<span>责任部门:</span>
								</td>
								<td>
									<input class="nui-textbox" id="dutyDept" name="dutyDept"  />
								</td>
								<td>
								<span>责任人:</span>
								</td>
								<td>
									<input class="nui-textbox" id="dutyMan" name="dutyMan"  />
								</td>
							</tr>
							<tr>
								<td>
									<span>处罚方式:</span>
								</td>
								<td>
									<input class="nui-textbox" id="punishType" name="punishType" />
								</td>
								<td>
									<span>处罚金额:</span>
								</td>
								<td>
									<input class="mini-spinner" id="punishAmt" name="punishAmt"   minValue="0" changeOnMousewheel="false" showButton="false"/>
								</td>
								<td>
									<span>预防措施:</span>
								</td>
								<td>
									<input class="nui-textbox" id="preventReamrk" name="preventReamrk"  />
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="nui-fit" style="width:calc(100% - 20px);padding:10px;">
					<div class="nui-panel" title="客户投诉的陈述" style="width:100%;height:100%;">
						<div class="nui-panel" title="登记人的填写" style="width:100%;height:100%;">
							<div style="width:100%;height:30%;">
								<div>客户陈述:</div>
								<input class="nui-textarea" id="complaintReason" id="complaintReason" style="height:70%;width:100%" />
							</div>
							<div style="width:100%;height:30%;">
								<div>登记人备注:</div>
								<input class="nui-textarea" id="complaintReamrk" id="complaintReamrk" style="height:70%;width:100%" />
							</div>
						</div>
					</div>
				</div>
				    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="left: 320px;">
            <tr>
                <td>
                    <a class="nui-button" iconCls="icon-save" plain="true" id="ok" name = "ok" onclick="onOk()">保存</a>
                    <a class="nui-button" iconCls="icon-close" plain="true" onclick="onCancel()">关闭</a>
                </td>
            </tr>
        </table>
    </div>
			</div>

		</body>

		</html>