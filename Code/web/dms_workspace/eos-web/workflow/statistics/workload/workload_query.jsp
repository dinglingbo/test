<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/statistics/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String selectBrowse = ResourcesMessageUtil.getI18nResourceMessage("catalog_common.select_browse");
 %>
<html>
<head>
<title><b:message key="workload_frame_jsp.workload_query"/></title>
<script language="javascript">	
	var action='com.primeton.bps.web.statistics.queryWorkload.flow';
	function clearQueryForm(){
		initFormData([
			'orgID',
			'orgName',
			'startTime',
			'endTime'
		]);
		dataCatchPool = [];
	}
	
	function required(form){
		if(form.orgName.value){
			form.orgID.value=form['org/id'].value;
			form.typeCode.value=form['org/typeCode'].value;
		}
	}
</script>

<h:script src="/workflow/statistics/js/query-common.js"></h:script>
</head>
<body onLoad="initiFrame()" topmargin="3" bottommargin="0" rightmargin="5" leftmargin="5" style="background:#EAF0F1;overflow: auto;">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr height="80px">
      <td valign="top">
		<h:form name="queryForm" action="com.primeton.bps.web.statistics.queryWorkload.flow" method="post" target="queryResult">
        <table class="workarea" width="100%">
          <tr>
            <td class="EOS_panel_head" valign="middle"><b:message key="workload_query_jsp.query_cond"/></td><%-- 查询条件 --%>
          </tr>
          <tr>
            <td>
              <%-- 分页条件 --%>
              <h:hidden name="pageCond/begin" value="0"/>
              <h:hidden name="pageCond/length" value="10"/>
              <h:hidden name="pageCond/isCount" value="true"/>
              <h:hidden name="locale" property="locale" scope="session"/>              
              <h:hidden name="orgID" value=""/>
              <h:hidden name="typeCode" value=""/>
              
              <table width="100%" class="form_table">
                <tr>
                  <td width="15%" class="form_label"><b:message key="workload_query_jsp.org"/><b:message key="wsp_punctuation.colon"/></td><%-- 组织机构 --%>
                  <td width="35%" >
                    <input type="text" class="textbox" id="orgName" name="orgName" size="32" readonly="true" value='<b:write property="orgName"/>'/>&nbsp;
					<wf:selectParticipant form="queryForm" selectTypes="" styleClass="button" maxNum="1" output="orgName" root="" value="<%=selectBrowse %>" hidden="org" hiddenType="PARTICIPANT"><%-- 选择... --%>
					</wf:selectParticipant>
                  </td>
                  <td nowrap="nowrap" class="form_label"><b:message key="workload_query_jsp.start_end_time"/><b:message key="wsp_punctuation.colon"/></td><%-- 时间段 --%>
                  <td nowrap="nowrap">
                  	<table border="0" cellpadding="0" cellspacing="0" style='border:0px;background-color:transparent'>
                  		<tr style='border:0px;background-color:transparent'>
                  			<td style='border:0px;background-color:transparent'>
                  				<select name="startTime" id="startTime">
                  				</select>
                  			</td>
                  			<td style='border:0px;background-color:transparent'>&nbsp;-&nbsp;</td>
                  			<td style='border:0px;background-color:transparent'>
                  				<select name="endTime" id="endTime">
                  				</select>
                  			</td>
						</tr>
					</table>
				  </td>
                </tr>
                
				<tr>
                  <td colspan="5" class="form_bottom">
                    <input type="submit" id="queryBtn" name="query" value="<b:message key="manager_common.query"/>" class="button" onclick="return setSubmitItem()"><%-- 查询 --%>
                    <input type="button" id="resetBtn" name="reset" value="<b:message key="manager_common.clear"/>" class="button" onclick="clearQueryForm();"><%-- 清空 --%>
                  </td>
         		</tr>
              </table>
            </td>
          </tr>
        </table>
        </h:form>
      </td>
    </tr>
    <tr>
      <td valign="top" align="center" style="padding-top:10px">
      <iframe id="queryResult"  width="100%" height="100%" marginHeight="0" scrolling="auto" frameBorder="0" marginWidth="0" name="queryResult" src=""></iframe>      
      </td>
    </tr>
  </table>
</body>
</html>