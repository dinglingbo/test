<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
	<title>投诉管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
	<%@include file="/common/sysCommon.jsp" %>
	<script src="<%=webPath + contextPath%>/manage/js/complainDetail.js?v=1.0.7"></script>
	<link href="<%=webPath + contextPath%>/manage/css/complainDetail.css" rel='stylesheet' type='text/css' />
</head>

<body>
<div class="nui-toolbar" style="padding:0px;border-bottom:0;">
            <table style="width:80%;">
                <tr>
                    <td style="width:80%;">
                        <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                        <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                    </td>
                </tr>
            </table>
        </div>
	<div id="complainFrom" class="nui-fit">
		<div style="width:100%;height:220px;">
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
		<div class="nui-fit" style="width:100%">

			<div class="nui-panel" title="登记人的填写" style="width:100%;height:100%;">


				<table  style="border-collapse:separate; border-spacing:10px;">
					<tr>
						<td >
							<span>客户陈述:</span>
						</td>
						<td style="width:520px;">
							<input class="nui-textarea" id="complaintReason" id="complaintReason" style="height:70px;width:100%" />
						</td>
					</tr>
					<tr>
						<td>
							<span>登记人备注:</span>
						</td>
						<td>
							<input class="nui-textarea" id="complaintReamrk" id="complaintReamrk" style="height:70px;width:100%" />
						</td>
					</tr>
				</table>
			</div>
		</div>
<!-- 		<div style="padding:2px;border-bottom:0;"> -->
<!-- 			<table align="center"> -->
<!-- 				<tr> -->
<!-- 					<td> -->
<!-- 						<a class="nui-button"  plain="true" id="ok" name = "ok" onclick="onOk()"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a> -->
<!-- 						<a class="nui-button"  plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a> -->
<!-- 					</td> -->
<!-- 				</tr> -->
<!-- 			</table> -->
<!-- 		</div> -->
	</div>

</body>

</html>