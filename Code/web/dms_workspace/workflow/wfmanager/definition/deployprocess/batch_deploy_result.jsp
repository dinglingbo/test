<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title><b:message key="batch_deploy_result_jsp.proc_deploy_result"/></title><!-- 流程部署结果 -->
<script>
		/*点击确定按钮，关闭窗口*/
		function closeAndRefresh() {
   			parent.parent.left.location="<%=request.getContextPath()%>/workflow/wfmanager/main/left.jsp";
   			window.close();
   		}
	</script>
</head>
<body>




<table border="0" class="EOS_panel_body" width="100%" height="100%">
				<%
					int flag = 0;
					String cls = "";
				%>
				<tr>
					<td nowrap="nowrap" class="EOS_panel_head">
						<b:message key="batch_deploy_result_jsp.deploy_result"/><!-- 部署结果 -->
					</td>
				</tr>
				<tr valign="top">
					<td>
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td>
									<table border="0" class="EOS_table" width="100%">

										<tr class="EOS_table_head">
											<th nowrap="nowrap">
												<b:message key="batch_deploy_result_jsp.biz_proc"/><!-- 业务流程 -->
											</th>
											<th nowrap="nowrap">
												<b:message key="batch_deploy_result_jsp.deploy_result"/><!-- 部署结果 -->
											</th>
										</tr>

										<l:present property="deployInfoArr">
											<l:iterate id="list" property="deployInfoArr">
												<%
														if (flag % 2 == 0) {
														cls = "EOS_table_row";
													} else {
														cls = "";
													}
												%>
												<tr class="<%=cls%>"
													onmouseover='this.className="EOS_table_selectRow"'
													onmouseout='this.className="<%=cls%>"'>
													
													<td nowrap="nowrap" width="50%">
														<b:write iterateId="list" property="name" />
													</td>
													<td nowrap="nowrap" width="50%">
														<l:equal iterateId="list" property="deployResult"  targetValue="success">
															<b:message key="batch_deploy_result_jsp.success"/><!-- 成功 -->
														</l:equal>
														<l:equal iterateId="list" property="deployResult"  targetValue="fail">
															<b:message key="batch_deploy_result_jsp.fail"/><!-- 失败 --><b:write iterateId="list" property="failMessage" />
														</l:equal>
													</td>
												</tr>
												<%
												flag++;
												%>
											</l:iterate>
										</l:present>

										<%
												for (; flag < 5; flag++) {
												if (flag % 2 == 0) {
													cls = "EOS_table_row";
												} else {
													cls = "";
												}
										%>
										<tr class="<%=cls%>"
											onmouseover='this.className="EOS_table_selectRow"'
											onmouseout='this.className="<%=cls%>"'>
											<td></td>
											<td></td>
										</tr>
										<%
										}
										%>
									</table>
								</td>
							</tr>
							<tr>
			<td colspan="3" align="center">
				<input type="button" name="" value='<b:message key="defcommon.btn_ok"/>' onclick="closeAndRefresh()">
			</td>
		</tr>
</table>









</body>
</html>