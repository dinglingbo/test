<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/statistics/common/common.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String selectBrowse = ResourcesMessageUtil.getI18nResourceMessage("catalog_common.select_browse");
 %>
<html>
<head>
<title></title>
<script language="javascript">	
	var action='com.primeton.bps.web.statistics.queryTimeout.flow';
	function clearQueryForm(){
		initFormData([
		    'cataID',
			'cataName',
			'startTime',
			'endTime'
		]);
		dataCatchPool = [];
	}
	
	// js 国际化
	var select_tips = "<b:message key="common_tips.selectCatalog"/>";
	var alert_tips = "<b:message key="common_tips.catalogRequired"/>";
	function required(form){
	    if(!form.cataName.value){
			return select_tips;
		}
		var el=form['cataID'];
		if(el){
			var val=el.value;
			if(val==1){
				return alert_tips;
			}
			form.processID.value=val;
		}
	}
	
</script>

<h:script src="/workflow/statistics/js/query-common.js"></h:script>
</head>
<body onLoad="initiFrame()" topmargin="3" bottommargin="0" rightmargin="5" leftmargin="5" style="background:#EAF0F1;overflow: auto;">
  <table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
    <tr height="80px">
      <td valign="top">
		<h:form name="queryForm" action="com.primeton.bps.web.statistics.queryTimeout.flow" method="post" target="queryResult">
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
              <h:hidden name="locale" property="locale" scope="session"/>
              <table width="100%" class="form_table">
                <tr>
                  <td width="15%" class="form_label"><b:message key="timeout_query_jsp.catalogName"/></td><!-- 业务目录 -->
                  <td width="35%" >
					<input type="text" name="cataName" value="" readonly="true" size="32">&nbsp;
                  	 <wf:selectBizCatalog name="select" value="<%=selectBrowse %>" maxNum="1" hiddenType="ID" hidden="cataID" form="queryForm" output="cataName" styleClass="button"/>
                  	 <span style="color:#ff0000"><b:message key="common_tips.catalogRequired"/></span> <!-- 不能直接选择领域业务目录！ -->
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