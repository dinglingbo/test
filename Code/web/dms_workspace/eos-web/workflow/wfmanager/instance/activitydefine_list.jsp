<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<%@include file="/workflow/wfmanager/common/common.jsp"%>
<script type="text/javascript" language="javascript">
	/*检查是否选择的一条记录*/
	function validate(){
		var length = 0;		
		if(document.forms['activityDefForm'].elements['activityDefID'] != null)
			length = document.forms['activityDefForm'].elements['activityDefID'].length;
		
		for(i = 0; i < length; i++){
			if(document.forms['activityDefForm'].elements['activityDefID'][i].checked)
				return document.forms['activityDefForm'].elements['activityDefID'][i].value;
		}
		
		alert('<b:message key="activity_define_list_jsp.select_act_def_record"/>');//请先选择一条活动定义记录
		return false;
	}
	
	function doSubmit(){
		var flag = validate()
		if(flag !=false){
		window.returnValue = validate();
		window.close(); 
		}  
	}
</script>
</head>
<body  leftmargin="0" rightmargin="0" bottommargin="0" marginheight="0" marginwidth="0" topmargin="0" style="background:#EAF0F1;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:hidden; overflow-x: auto;">
<form name="activityDefForm" action="" method="post">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
   	<tr>
		<td class="EOS_panel_head" valign="middle"><b:message key="activity_define_list_jsp.act_inst_list"/></td><%-- 活动实例列表 --%>
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%">
			 <tr>
			   <td width="100%"  height="440"  valign="top">
			      <table border="0" class="EOS_table" width="100%">
				    <tr class="EOS_table_head">
				      <th width="6%" align="center"><b:message key="activity_define_list_jsp.operation"/></th><%-- 操作 --%>
				      <th width="16%" align="center"><b:message key="activity_define_list_jsp.act_def_id"/></th><%-- 活动定义ID --%>
				      <th width="11%"><b:message key="activity_define_list_jsp.act_def_name"/></th><%-- 活动定义名称 --%>
				      <th width="11%"><b:message key="activity_define_list_jsp.act_type"/></th><%-- 活动类型 --%>
				    </tr>
				    <l:iterate id="list" property="activityDefList">
				    <tr class="EOS_table_selectRow">
					  <td><h:radio iterateId="list" name="activityDefID" property="id"/></td>
					  <td><b:write iterateId="list" property="id"/></td>
					  <td><b:write iterateId="list" property="name"/></td>
					  <td>
					 <!-- <b:write iterateId="list" property="type"/>-->
					  <d:write iterateId="list" property="type" dictTypeId="WFDICT_ActivityType"/>
					  </td>
					</tr>
					</l:iterate>
				    <tr class="EOS_table_selectRow">
				      <td colspan="4">
					  <input type="button" name="btChoiced" value="<b:message key="activity_define_list_jsp.select"/>" class="button" onClick="doSubmit('btChoiced')"/><%-- 选择 --%>
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