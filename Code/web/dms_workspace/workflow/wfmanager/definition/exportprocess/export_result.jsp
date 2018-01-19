<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title><b:message key="export_result_jsp.export_result_down"/></title>
<script>
	var hasBizComposer ='<b:write property="hasBizComposer"/>';
	
	function backStep() {
		history.back();
	}
	
</script>
</head>
<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<table border="0" cellpadding="1" cellspacing="0" class="workarea" width="100%" height="100%">
<tr>
	<td class="workarea_title" valign="middle"><h3><b:message key="export_result_jsp.export_result"/></h3></td>
</tr>
<l:present property="fileName" >
<tr>
<td>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="EOS_panel_head" valign="middle"><b:message key="export_result_jsp.export_sum"/></td>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%" height="100%" valign="top">
					<table border="0" class="EOS_table" width="100%">
						<tr>
							<th width="40%" nowrap><b:message key="export_result_jsp.item"/></th>
							<th width="60%" nowrap><b:message key="export_result_jsp.amount"/></th>
						</tr>
						<!-- 无法正确统计导出的业务目录数，暂时不显示。
						<tr class="EOS_table_row">
							<td><b:message key="defcommon.biz_catalog"/></td>
							<td><b:write property="catCount"/></td>
						</tr>
						 -->
						<tr class="EOS_table_row">
							<td><b:message key="defcommon.biz_proc"/></td>
							<td><b:write property="proCount"/></td>
						</tr>
						<l:equal property="hasBizComposer" targetValue="true">
						<tr class="EOS_table_row">
							<td><b:message key="defcommon.biz_res"/></td>
							<td><b:write property="resCount"/></td>
						</tr>
						</l:equal>
					</table>
            	</td>
			</tr>
		</table>
</td></tr>
</table>
</td>
</tr>
</l:present>
<tr>
<td>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="EOS_panel_head" valign="middle"><b:message key="export_result_jsp.export_result_down"/></td>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
				<td width="100%" height="100%" valign="top">
					<table border="0" class="EOS_table" width="100%">
						<tr class="EOS_table_row">
							<td class="form_label" width="150"><b:message key="defcommon.success"/></td>
							<l:present property="fileName" >
							<td><b:message key="defcommon.yes"/></td>
							</l:present>
							<l:notPresent property="fileName">
							<td><b:message key="defcommon.no"/></td>
							</l:notPresent>
						</tr>
						<l:present property="fileName" >
						<tr>
							<td class="EOS_table_row" width="150"><b:message key="export_result_jsp.download_link"/></td>
							<td><a href="<%=request.getContextPath() %>/workflow/wfmanager/definition/exportprocess/downloadFile.jsp?dirName=/temp/&fileName=<b:write property="fileName"/>" style="color: #FF9900"><b:message key="export_result_jsp.click_download"/></a></td>
						</tr>
						</l:present>
					</table>
				  	<br>		
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
					  <tr>
					    <td>&nbsp;</td>
					  </tr>
                      <tr>
                        <td>
                        	<!--<input type="button" value='<b:message key="defcommon.btn_back"/>' class=button onclick="backStep();">-->
                   		</td>
                      </tr>
                    </table>
            	</td>
			</tr>
		</table>
</td></tr>
</table>
</td></tr>
</table>
</body>
</html>