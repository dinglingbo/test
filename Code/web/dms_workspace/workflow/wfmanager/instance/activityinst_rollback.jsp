<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<script language="javascript">

function showAactivityDefineList(selectObj){
	if(selectObj.value == 'one_step' || selectObj.value == 'recent_manual')
		t1.style.display="none";
	else if(selectObj.value == 'time' || selectObj.value == 'path' || selectObj.value == 'simple')
		t1.style.display="block";	
}

function validate(formObj){
	if(document.forms['rollbackActivityForm'].activityDefID.length == undefined){
		if(document.forms['rollbackActivityForm'].activityDefID.checked)
			return document.forms['rollbackActivityForm'].activityDefID.value
	}else{
		for(i = 0;i<document.forms['rollbackActivityForm'].activityDefID.length;i++)
		  	if(document.forms['rollbackActivityForm'].activityDefID[i].checked)
		  		return document.forms['rollbackActivityForm'].activityDefID[i].value;
	}
	alert('<b:message key="activity_inst_rollback_jsp.select_act_record"/>');//请先选中一条活动定义记录
	return false;
}
	
function doSubmit(){
	var formObj = document.forms['rollbackActivityForm'];
	var strategy = formObj.strategy.value;
	var activityDefID = null;
	if(strategy == 'time' || strategy == 'path' || strategy == 'simple'){
		activityDefID = validate(formObj);
		if(!activityDefID)
			return;	
	}
	
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ActivityInstanceManager.rollbackActivityInst.biz');
	
	hs.addParam('currentActInstID',formObj.activityInstID.value);
	hs.addParam('rollBackStrategy',formObj.strategy.value);
	hs.addParam('destActDefID',activityDefID);
	hs.submit();
	if(ajaxIsSuccess==false){
		//alert('操作失败');
		return;
	}
	alert('<b:message key="activity_inst_rollback_jsp.rollback_success"/>');//回退成功
	returnValue = true;
	window.close();
}

</script>
</head>
<body onLoad="showAactivityDefineList(document.forms['rollbackActivityForm'].strategy)" bgcolor="#D8EAEC" leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0">
<form name="rollbackActivityForm" method="post" action="">
<h:hidden name="activityInstID" property="activityInstID"/>
<table border="0" width="100%">  
  <tr>
    <td width="100%">      
        <table border="0" cellpadding="0" cellspacing="0" align="center" width="98%">
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td width="30%"><b:message key="activity_inst_rollback_jsp.select_rollback_policy"/></td><%-- 请选择回退策略: --%>
            <td>
            <select name="strategy" onChange="showAactivityDefineList(this)">
              <option value="one_step"><b:message key="activity_inst_rollback_jsp.step_rollback"/></option><%-- 单步回退 --%>
              <option value="simple"><b:message key="activity_inst_rollback_jsp.simple_rollback"/></option><%-- 简单回退 --%>
              <option value="time"><b:message key="activity_inst_rollback_jsp.based_node_time"/></option><%-- 基于两个节点之间的时间 --%>
              <option value="recent_manual"><b:message key="activity_inst_rollback_jsp.rollback_latest"/></option><%-- 回退到最近的人工活动 --%>
              <option value="path"><b:message key="activity_inst_rollback_jsp.based_node_path"/></option><%-- 基于两个节点之间的路径 --%>
            </select>
            </td>
          </tr>
          <tr>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr>
            <td colspan="2">			
                <table id="t1" border="0" class="EOS_table" width="100% style="display:none">
                  <tr class="EOS_table_head">
                    <th width="10%" align="center"><b:message key="activity_inst_rollback_jsp.operation"/></th><%-- 操作 --%>
                    <th width="45%" align="center"><b:message key="activity_inst_rollback_jsp.act_def_name"/></th><%-- 活动定义名称 --%>
                    <th width="45%"><b:message key="activity_inst_rollback_jsp.act_type"/></th><%-- 活动类型 --%>
                  </tr>
                  <l:present property="activityDefList">
                  <l:iterate id="list" property="activityDefList">
                  <l:notEqual iterateId="list" property="id" targetProperty="activityInst/activityDefID">
                  <tr>
                    <td width="10%" align="center"><h:radio name="activityDefID" iterateId="list" property="id"/></td>
                    <td width="45%" align="center"><b:write iterateId="list" property="name"/></td>
                    <td width="45%" align="center"><d:write iterateId="list" property="type" dictTypeId="WFDICT_ActivityType"/></td>
                  </tr>
                  </l:notEqual>
                  </l:iterate>
                  
                  </l:present>
                </table>
                           
			</td>
          </tr>
          <tr>
            <td colspan="6" align="center" class="query_bottom">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td height="30" align="center">
				    <input type="button" name="btok" value="<b:message key="activity_inst_rollback_jsp.execute_rollback"/>" class="button" onclick="doSubmit()"><%-- 执行回退 --%>
				    &nbsp;
			  	  <input type="button" name="btok" value="<b:message key="activity_inst_rollback_jsp.cancel"/>" class="button" onclick="window.close();">&nbsp;&nbsp;</td><%-- 取消 --%>
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
