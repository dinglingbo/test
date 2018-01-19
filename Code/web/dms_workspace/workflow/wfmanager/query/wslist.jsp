<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<!-- 
  - Author(s): tys
  - Date: 2010-12-02 17:27:25
  - Description:
-->
<head>
<title><b:message key="wslist_jsp.webservice_list"/></title><%-- Web服务列表 --%>
</head>
<body  style="width:100%;background:white;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">

			<table border="0" cellpadding="1" cellspacing="0" class="workarea" width="100%">
				<tr>
					<td nowrap="nowrap" class="EOS_panel_head">
						<b:message key="wslist_jsp.webservice_list"/><%-- Web服务列表 --%>
					</td>
				</tr>
				<tr valign="top">
					<td>
						
									<table border="0" class="EOS_table" width="100%">
										<tr class="EOS_table_head">
<!--											<th nowrap="nowrap">
												<input type="checkbox" name="operation"	onclick="checkAll();">选择
											</th>-->
											<th nowrap="nowrap" width="10%">
												<b:message key="wslist_jsp.webservice_id"/><%-- 序号 --%>
											</th>
											<th nowrap="nowrap"  width="50%">
												<b:message key="wslist_jsp.webservice_url"/><%-- Web服务地址 --%>
											</th>
											<th nowrap="nowrap"  width="40%">
												<b:message key="wslist_jsp.webservice_desc"/><%-- 描述 --%>
											</th>

									
										</tr>
										
										<l:present property="list">
											<% int i=0;%>
											<l:iterate id="list" property="list">
												<tr id="processInstRow" name="processInstRow" class="EOS_table_row" onclick="">

													<td nowrap="nowrap" style="text-align:center">
													<%=++i%>
													</td>
													<td nowrap="nowrap">
														<a href='<b:write iterateId="list" property="url" />' target="_blank"><b:write iterateId="list" property="url" /></a>
													</td>
													<td nowrap="nowrap">
														<l:equal iterateId="list" property="wsType" targetValue="0">
															<b:write iterateId="list" property="wsName" />
														</l:equal>
														<l:equal iterateId="list" property="wsType" targetValue="1">
															<b:write iterateId="list" property="wsName" />&nbsp;<b:message key="wslist_jsp.webservice_process"/><%-- 流程 --%>
														</l:equal>
														<l:equal iterateId="list" property="wsType" targetValue="2">
															<b:message key="wslist_jsp.webservice_custom"/><%-- 自定义Web服务 --%>
														</l:equal>
													</td>										
													
												</tr>
											</l:iterate>
										</l:present>
									</table>

					</td>
				</tr>
			</table>

	</body>
</html>
