<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/statistics/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String selectBrowse = ResourcesMessageUtil.getI18nResourceMessage("catalog_common.select_browse");
 %>
<html>
<head>
<title></title><!-- 活动执行时效统计查询 -->
<script language="javascript">
	var action='com.primeton.bps.web.statistics.queryActivityExecutionTime.flow';
	function clearQueryForm(){
		initFormData([
			'processID',
			'process/id',
			'process/type',
			'processName'
		]);
		
		dataCatchPool = [];
	}
	/**
	autoSubmit=false;
	function submitForm(){
		var form=document.forms['queryForm'];
		form.processID.value=form['process/id'].value;
	}
	*/
	
	// js 国际化
	var select_tips = "<b:message key="common_tips.selectProcess"/>";
	function required(form){
		if(!form.processName.value){
			return select_tips;
		}
		form.processID.value=form['process/id'].value;
	}
</script>
<h:script src="/workflow/statistics/js/query-common.js"></h:script>
</head>
<body onLoad="initiFrame()" topmargin="3" bottommargin="0" rightmargin="5" leftmargin="5" style="background:#EAF0F1;overflow: auto;">
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
    <tr height="80px">
      <td valign="top">
		<h:form name="queryForm" action="com.primeton.bps.web.statistics.queryActivityExecutionTime.flow" method="post" target="queryResult">
        <table class="workarea" width="100%">
          <tr>
            <td class="EOS_panel_head" valign="middle"><b:message key="common_words.queryCondition"/></td>
          </tr>
          <tr>
            <td>
              <%-- 分页条件 --%>
              <h:hidden name="pageCond/begin" value="0"/>
              <h:hidden name="pageCond/length" value="10"/>
              <h:hidden name="pageCond/isCount" value="true"/>
              <h:hidden name="processID" value=""/>
              <h:hidden name="locale" property="locale" scope="session"/>
              
              <table width="100%" class="form_table">
                <tr>
                  <td width="10%" class="form_label"><b:message key="activityexecutiontime_query_jsp.processName"/></td><!-- 流程名称 -->
                  <td width="25%" >
                  	
                    <input type="text" class="textbox" name="processName" size="32" readonly="true" value='<b:write property="processName"/>'/>&nbsp;
					
					<wf:selectProcessAndActivity id="selectppanddact" name="select" maxNum="1" output="processName" form="queryForm" isShowActivity="false"  hiddenType="PROCESS" hidden="process" value="<%=selectBrowse %>" styleClass="button" >
					</wf:selectProcessAndActivity>
                  </td>
                  <td nowrap="nowrap" class="form_label"><b:message key="workload_query_jsp.start_end_time"/><b:message key="wsp_punctuation.colon"/></td><!-- 时间段 -->
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
                  <td colspan="7" class="form_bottom">
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