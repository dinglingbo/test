<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
</head>
<body bgcolor="#D8EAEC">
<table border="0" width="100%" >
  <%--<tr>
    <td class="EOS_panel_head">流程实例详细信息</td>
  </tr>--%>
  <tr>
    <td width="100%" >
    	<table width="100%" border="0"  class="EOS_table">
	        <tr>
	          <td width="25%" class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.proc_inst_id"/></td><%-- 流程实例ID --%>
	          <td width="25%"  nowrap="nowrap"><b:write property="processInst/processInstID"/></td>
	          <td width="25%" class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.is_out_time"/> </td><%-- 是否超时 --%>
	          <td width="25%" nowrap="nowrap"><d:write property="processInst/isTimeOut" dictTypeId="WFDICT_YN"/></td>
          </tr>
	        <tr>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.proc_inst_name"/></td><%-- 流程实例名称 --%>
	          <td><b:write property="processInst/processInstName"/></td>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.out_time_num"/></td><%-- 超时数 --%>
	          <td nowrap="nowrap"><b:write property="processInst/timeOutNumDesc"/></td>
	        </tr>
	        <tr>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.creator"/></td><%-- 创建者 --%>
	          <td nowrap="nowrap"><b:write property="processInst/creator"/></td>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.proc_def_id"/></td><%-- 流程定义ID --%>
	          <td nowrap="nowrap"><b:write property="processInst/processDefID"/></td>
	        </tr>
	        <tr>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.current_state"/></td><%-- 当前状态 --%>
	          <td nowrap="nowrap"><d:write property="processInst/currentState" dictTypeId="WFDICT_ProcessState"/></td>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.parent_proc_id"/></td><%-- 父流程ID --%>
	          <td nowrap="nowrap">
	           <l:greaterThan property="processInst/parentProcID" targetValue="0" >
	                 <b:write property="processInst/parentProcID"/>
	          </l:greaterThan>
	          </td>
	        </tr>
	        <tr>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.create_time"/></td><%-- 创建时间 --%>
	          <td nowrap="nowrap"><b:write property="processInst/createTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.start_time"/></td><%-- 启动时间 --%>
	          <td nowrap="nowrap"><b:write property="processInst/startTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
	        </tr>
	        <tr>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.proc_def_name"/></td><%-- 流程定义名称 --%>
	          <td><b:write property="processInst/processDefName"/></td>
	          <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.time_limit_num"/></td><%-- 时间限制数 --%>
	          <td nowrap="nowrap"><b:write property="processInst/limitNumDesc"/></td>
	        </tr>
	        <tr>
			  <td class="EOS_table_row" nowrap="nowrap"><b:message key="processinst_detail_jsp.end_time"/></td><%-- 结束时间 --%>
	          <td nowrap="nowrap" colspan="3"><b:write property="processInst/endTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/></td>
	        </tr>
	      </table>
    </td>
  </tr>  
</table>
</body>
</html>
