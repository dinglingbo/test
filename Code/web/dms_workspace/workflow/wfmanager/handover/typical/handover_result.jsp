<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<title><b:message key="handover_result_jsp.simple_handover_result"/></title><%-- 简单交接结果 --%>
</head>

<body style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:hidden; overflow-y:auto; overflow-x: auto;">
   <form name="queryForm" action="" method="post">
      <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	     <tr>
		     <td class="workarea_title" valign="middle"><b:message key="handover_result_jsp.handover_work"/></td><%-- 工作交接 --%>
	     </tr>
	     <tr>
		     <td width="100%" valign="top">
		         <table cellpadding="0" width="100%" cellspacing="0" border="0">
			        <tr>
				        <td>
				           <table border="0" class="EOS_panel_body" width="100%">
					          <tr>
						          <td class="EOS_panel_head"><b:message key="handover_result_jsp.handover_result_list"/></td><%-- 交接结果列表 --%>
					          </tr>
					          <tr>
						          <td>
						              <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
						                  <tr>
						                      <td class="EOS_table_row" align="left" width="15%"><b:message key="handover_select_person_jsp.giver"/></td><%-- 移交人: --%>
						                      <td><b:write property="ret/handoverPerson"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_select_person_jsp.receiver"/></td><%-- 接管人: --%>
						                      <td><b:write property="ret/takeoverPerson"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_worklist_jsp1.to_be_exec_workitem"/></td><%-- 待执行的工作项: --%>
						                      <td><b:write property="ret/executeWICount"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_worklist_jsp1.delegate_other_item"/></td><%-- 代办他人的工作项: --%>
						                      <td><b:write property="ret/delegateWICount"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_worklist_jsp1.delegate_to_other_item"/></td><%-- 委托他人代办的工作项: --%>
						                      <td><b:write property="ret/enturstWICount"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_result_jsp.handover_receive_item"/></td><%-- 需要交接待领取的工作项: --%>
						                      <td><b:write property="ret/publicWICount"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_result_jsp.modify_process_define"/></td><%-- 需要修改的流程定义: --%>
						                      <td><b:write property="ret/proDefCount"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_result_jsp.deleted_agent_relation"/></td><%-- 删除的代理关系: --%>
						                      <td><b:write property="ret/agentCount"/></td>
						                  </tr>
						                  <tr>
						                      <td class="EOS_table_row" align="left"><b:message key="handover_result_jsp.total"/></td><%-- 总计: --%>
						                      <td><b:write property="ret/total"/></td>
						                  </tr>
						              </table>
						          </td>
						       </tr>
					       </table>
				        </td>
				    </tr>
				 </table>    
		     </td>
		 </tr>
	  </table>
   </form>
</body>
</html>