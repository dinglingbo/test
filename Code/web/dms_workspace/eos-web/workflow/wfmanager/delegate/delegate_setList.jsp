<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<body style="background:#EAF0F1;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:scroll; overflow-y:hidden; overflow-x: auto;">
<table class="workarea" width="100%">
		<tr>
  			<td class="EOS_panel_head" valign="middle"><b:message key="delegate_set_list_jsp.task_list"/></td><%-- 任务列表 --%>
		</tr>
		<tr>
  			<td valign="top">
  			<form action="#" name="form1" method="post" target="_self">      
    			<table border="0" cellpadding="0" cellspacing="0" width="100%">
      				<tr>
       	 				<td colspan="2">
          				<input type="hidden" name="delegType">
          				<h:hidden property="fromName"/>
          				<h:hidden property="from"/>
          					<table border="0" class="EOS_table" width="100%">
            					<tr class="EOS_table_head" align="center">
			                       <th height="25" width="5%" nowrap="nowrap">
			                       <input type="checkbox"  name="operation"	value="checkbox" onClick="selectAll();">&nbsp;<b:message key="delegate_set_list_jsp.select"/>
			                       </th><%-- 选择 --%>
			                       <th height="25" width="15%" nowrap="nowrap"><b:message key="delegate_set_list_jsp.item_name"/></th><%-- 工作项名称 --%>
			                       <th height="25" width="20%" nowrap="nowrap"><b:message key="delegate_set_list_jsp.biz_process_name"/></th><%-- 业务流程名称 --%>
			                       <th height="25" width="15%" nowrap="nowrap"><b:message key="delegate_set_list_jsp.process_inst_name"/></th><%-- 流程实例名称 --%>
			                       <th height="25" width="15%" nowrap="nowrap"><b:message key="delegate_set_list_jsp.current_state"/></th><%-- 当前状态 --%>
			                       <th height="25" width="15%" nowrap="nowrap"><b:message key="delegate_set_list_jsp.start_time"/></th><%-- 启动时间 --%>
			                       <th height="25" width="15%" nowrap="nowrap"><b:message key="delegate_set_list_jsp.time_limit"/></th><%-- 时间限制 --%>
			                    </tr>
	                    <l:present property="workitems">
	                    <l:iterate id="workitem" property="workitems">
	                    <tr id="workItemRow" name="workItemRow" class="EOS_table_row" onclick="doSelectRow(this);">
	                      <td nowrap><h:checkbox iterateId="workitem" name="workitemID" onclick="doSelect(this);" property="workItemID"/></td>
	                      <td><b:write property="workItemName" iterateId="workitem"/></td>
	                      <td><b:write property="processDefName" iterateId="workitem"/></td>
	                      <td><b:write property="processInstName" iterateId="workitem" maxLength="50"/></td>
	                      <td><d:write dictTypeId="WFDICT_WorkItemState" property="currentState" iterateId="workitem"/></td>
	                      <td><b:write property="createTime" iterateId="workitem" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyy-MM-dd hh:MM.0"/></td>
	                      <td><b:write property="limitNumDesc" iterateId="workitem"/></td>
	                    </tr>
	                    </l:iterate>
	                    </l:present>
						<!--<tr class="EOS_table_row"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>-->
			                  </table>
		                
		               	</td>
		           	</tr>
	              	<tr>
		                <td colspan="1" class="result_bottom" align="left">
		                  <INPUT type="button" id="delegateBtn" name="deleg" value='<b:message key="delegate_set_list_jsp.delegate"/>' class="button" onclick="delegateWI();"><%-- 代办 --%>
		                </td>
		                <td colspan="1" class="result_bottom" align="right">
							<b:set name="action" value="com.primeton.workflow.manager.delegate.setDelegate.flow?_eosFlowAction=action4"/>
							<b:set name="target" value="_self"/>
  							<%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
        				</td>
	              	</tr>
	          	</table>
	          	</form>
          	</td>
        </tr>
  	</table>
<script type="text/javascript">
	function doSelect(chkObj){
		if (chkObj.checked){
			chkObj.checked=false;
		} else {
			chkObj.checked=true;
		}
	}
	
	function doSelectRow(rowObj) {
		var chkObj;
		chkObj = rowObj.cells[0].getElementsByTagName("input")[0];
		//chkObj.click();
		
		var chkAll = $name("operation");
	 	if(chkObj.checked && chkAll.checked){
	        chkAll.checked=false;
	        chkObj.checked=false;
		}else{
			if(!chkObj.checked){
				  chkObj.checked=true;
				  rowObj.className = "EOS_table_selectRow";
			}else{
				  chkObj.checked=false;
				  rowObj.className = "EOS_table_row";
			}
			var el = document.getElementsByName('workitemID');
	      	var len = el.length;
	       	var temp=0;
	        for(var i=0; i<len; i++){  
	          if(el[i].checked == true){
	             temp=temp+1;
	          }
	        }
	        if(temp==len)
	        	chkAll.checked=true;
		}
	}

function selectAll(){
	var form1= $name('form1');
	if(form1.workitemID != null){
		var isChecked = form1.operation.checked;
		if (isChecked) {
			styleName = "EOS_table_selectRow";
		}
		else {
			styleName = "EOS_table_row";
		}
		if(form1.workitemID.length == undefined) {
			form1.workitemID.checked = isChecked;				
		}
		else {
			for(i = 0;i<form1.workitemID.length;i++) {
				form1.workitemID[i].checked = isChecked;
				if (isFF) {
					$names("workItemRow")[i].setAttribute("class", styleName);//for FF
				}
				else {
					$names("workItemRow")[i].setAttribute("className", styleName);//for IE
				}
			}
		}
	}
}

function delegateWI(){
	var form1= $name('form1');
	if(form1.workitemID == null){
		alert("<b:message key="delegate_set_list_jsp.select_item"/>");//请选择工作项！
		return;
	}
	if(form1.workitemID.length == undefined){
		if(!form1.workitemID.checked)
			return;
	}else{
		for(var i = 0; i<form1.workitemID.length;i++){
			if(form1.workitemID[i].checked)
				break;
			if(i==form1.workitemID.length-1){
				alert("<b:message key="delegate_set_list_jsp.select_item"/>");//请选择工作项！
				return;
			}
		}
	}	
    var argument="";
	showModalCenter("<%=request.getContextPath()%>/workflow/wfmanager/delegate/delegate_workitem.jsp",argument,callBack,'500','300','<b:message key="delegate_set_list_jsp.delegate_task"/>') ;//代办任务
}

function callBack (arg) {
	if(!arg) return ;
	var formName = 'form1';
	var form1= $name(formName);
	form1.action="com.primeton.workflow.manager.delegate.setDelegate.flow?_eosFlowAction=action2";
	form1.delegType.value=arg[0];
	var wfps = arg[2];
	//FIXME:INPUT HIDDEN
	/*var o = form1.appendChild(document.createElement("<INPUT TYPE='HIDDEN'>")) ;
	o.id= 'reason';			
	o.name= 'reason';
	o.value = arg[1] ;
	form1.appendChild(o);
	*/
	appendHiddenChild(formName,'reason',arg[1]);
	for(var i = 0;i<wfps.length;i++){
	    var wfp = wfps[i];
	    
		if(wfps.length == 3 && wfp.value=='<b:write property="from"/>'){
			alert("<b:message key="delegate_set_list_jsp.operation_fail"/>");//操作失败:不能代办(协办)给自己！
			return;
		}
		/*var o1 = form1.appendChild(document.createElement("<INPUT TYPE='HIDDEN'>")) ;
		o1.id= wfp.name;			
		o1.name= wfp.name;
		o1.value = wfp.value ;
		form1.appendChild(o1);
		*/
		appendHiddenChild(formName,wfp.name,wfp.value);			
	}
	form1.submit();
}



window.onload =  function (){
	var cnt = 0;
	<l:present property="workitems">
	 cnt = <b:size property="workitems"/>
	</l:present>
	if (cnt==0)
		$name("deleg").disabled=true;
}  
</script>  	
</body>
</html>