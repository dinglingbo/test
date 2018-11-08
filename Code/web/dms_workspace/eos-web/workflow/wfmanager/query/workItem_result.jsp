<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
<script type="text/javascript">
	function checkAll(){
		if(document.resultForm.workItemID != null){
			var isChecked = document.resultForm.operation.checked;
			var isChecked = document.forms['resultForm'].operation.checked;
			if (isChecked) {
				styleName = "EOS_table_selectRow";
			}
			else {
				styleName = "EOS_table_row";
			}
			if(document.resultForm.workItemID.length == undefined){
				document.resultForm.workItemID.checked = isChecked;				
			}
			else {
				for(i = 0;i<document.resultForm.workItemID.length;i++) {
					document.resultForm.workItemID[i].checked = isChecked;
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
	        rowObj.className = "EOS_table_row";
		}else{
			if(!chkObj.checked){
				  chkObj.checked=true;
				  rowObj.className = "EOS_table_selectRow";
			}else{
				  chkObj.checked=false;
				  rowObj.className = "EOS_table_row";
			}
			var el = document.getElementsByName('workItemID');
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
	  
	function editWorkItem(workItemID){
		var action = 'com.primeton.workflow.manager.instance.findWorkItemByID.flow?_eosFlowAction=findWorkItemByIDForAllWorkItem&workItemID='+workItemID;
			showModalCenter(action,null,function(returnValue){			
			doQuery(returnValue);
		},'550','330','<b:message key="workItem_result_jsp.item_details"/>');//工作项信息
	}
	
	function doQuery(returnValue){
		document.forms['resultForm'].submit();
	}
	
	function validate(actionName){
		//alert(actionName);
		
		if(document.resultForm.workItemID == undefined)
			return false; 
			
		if(document.resultForm.workItemID.length == undefined){
			if(document.resultForm.workItemID.checked){
				var values = new Array();
				values[0] = document.resultForm.workItemID.value;
				return isAllowDone(actionName,values);
			}
		}else{
			var values = new Array(document.resultForm.workItemID.length);
			var isChecked = false;
			for(i = 0;i<document.resultForm.workItemID.length;i++){
			  	if(document.resultForm.workItemID[i].checked){
					values[i] = document.resultForm.workItemID.value;
					isChecked = true;
				}
		  	}
		  	if(isChecked)
	  			return isAllowDone(actionName,values);
		}
		alert('<b:message key="workItem_result_jsp.select_item_record"/>');//请先选中一条工作项记录
		return false;
	}
	
	//判断状态
	function isAllowDone(actionName,values){
		if(document.resultForm.workItemID== undefined){
			return false;
		}
		var chks=document.resultForm.workItemID;
		var state = new Array();
		if(chks.length == undefined){
			if(chks.checked){
				//alert("checked : "+chks.checked);				
				//alert("value : "+chks.value);
				state = new Array(1);
				state[0]=document.resultForm.elements["currentState"+chks.value].value;
			}
		}
		else{
			for(i=0;i<chks.length;i++){
				if(chks[i].checked){	
					//alert("checked[i] : "+chks[i].checked);					
					//alert("value[i] : "+chks[i].value);
					state[i]=document.resultForm.elements["currentState"+chks[i].value].value;
				}
			}
		}
		
		//alert("states length " +state.length);
		
		if(actionName == 'suspend'){
			for(i=0;i<state.length;i++){
				if(state[i]!=undefined)
				if(state[i]!=10&&state[i]!=4){
					alert('<b:message key="workItem_result_jsp.suspend_condition"/>');//只有状态为“运行”或“待领取”的工作项才能挂起。
					return false;
				}
			}
		}
		else if(actionName == 'resume'){
			for(i=0;i<state.length;i++){
				if(state[i]!=undefined)
				if(state[i]!=8){
					alert('<b:message key="workItem_result_jsp.resume_condition"/>');//只有状态为“挂起”的工作项才能恢复。
					return false;
				}
			}
		}
		else if(actionName == 'terminate'){
			for(i=0;i<state.length;i++){
				if(state[i]!=undefined)
				if(state[i]!=10&&state[i]!=4&&state[i]!=8){
					alert('<b:message key="workItem_result_jsp.terminate_condition"/>');//只有状态为“运行”、“待领取”、“挂起”的工作项才能终止。
					return false;
				}
			}
		}
		return true; 
		
			
	}
	function doSubmit(action){
		//alert(action);
		if(validate(action)){
			var a = "<b:message key="procInst_result_jsp.sure_op"/>";
			parm1 = getActionName(action);
			a = a.replace("{0}",parm1);
			if(confirm(a)){//您确认要"+getActionName(action)+"吗?
				if(action=="delete"){
					deletWorkItems();
				} 
				if(action=="terminate"){
					terminateWorkItems();
				}
			}
		}
	}
	
	function getActionName(action){			
		if(action=="terminate"){
			return "<b:message key="procInst_result_jsp.terminate"/>";//终止
		}
		else if(action=="delete"){
			return "<b:message key="procInst_result_jsp.delete"/>";//删除
		}
		else if(action=="suspend"){
			return "<b:message key="procInst_result_jsp.suspend"/>";//挂起
		}
		else if(action=="resume"){
			return "<b:message key="procInst_result_jsp.resume"/>";//恢复
		}  								
	}
	
	function deletWorkItems(){
		document.resultForm.action="com.primeton.workflow.manager.query.handleWorkItem.flow?_eosFlowAction=deletWorkItems";
		document.resultForm.Submit2.disabled = "disabled";
		document.resultForm.submit();
	}
	
	function terminateWorkItems(){
		document.resultForm.action="com.primeton.workflow.manager.query.handleWorkItem.flow?_eosFlowAction=terminateWorkItems";
		document.resultForm.Submit1.disabled = "disabled";
		document.resultForm.submit();
	}
	
	window.onload =  function (){
		var cnt = 0;
		<l:present property="workItemList">
		 cnt = <b:size property="workItemList"/>
		</l:present>
		if (cnt==0){
			$name("Submit1").disabled=true;
			$name("Submit2").disabled=true;
			}
	}
	
	function initiFrame(){
		var height = frameElement.parentNode.offsetHeight;
		if (isFF) {
			height += 35;
		}
		else {
			height -= 20;
		}
		frameElement.height = height;
	}
</script>
</head>
<body onLoad="initiFrame()" style="width:100%;height:100%;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
<table border="0" cellpadding="1" cellspacing="0" width="100%">
<tr><td>
<h:form name="resultForm" action="" method="post" >
<l:present property="queryCondition">
	<h:hiddendata property="queryCondition" />
	<h:hidden property="isIncludeSubCatalog" />
	<h:hidden property="catalogUUID" />
</l:present>
<table border="0" cellpadding="1" cellspacing="0" class="workarea" width="100%" height="100%">
	<tr>
		<td class="EOS_panel_head"><b:message key="workItem_result_jsp.item_details"/></td><%-- 工作项信息 --%>
	</tr>
	<tr valign="top">
		<td>
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tr>
				<td>
				<table border="0" class="EOS_table" width="100%">
					<tr class="EOS_table_head">
						<th nowrap="nowrap"><input type="checkbox" name="operation" onClick="checkAll();"><b:message key="keyString"/></th><%-- 选择 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.biz_catalog"/></th><%-- 业务目录 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.item_id"/></th><%-- 工作项ID --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.item_name"/></th><%-- 工作项名称 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.current_state"/></th><%-- 当前状态 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.biz_state"/></th><%-- 业务状态 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.process_inst_name"/></th><%-- 流程实例名称 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.process_def_name"/></th><%-- 流程定义名称 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.is_outtime"/></th><%-- 是否超时 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.parter_id"/></th><%-- 参与者ID --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.parter_name"/></th><%-- 参与者名称 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.create_time"/></th><%-- 创建时间 --%>
						<th nowrap="nowrap"><b:message key="workItem_result_jsp.end_time"/></th><%-- 结束时间 --%>
					</tr>
					<l:present  property="workItemList">  
					<l:iterate id="list" property="workItemList">
						<tr id="workItemRow" name="workItemRow" class="EOS_table_row" onclick="doSelectRow(this);">
							<td nowrap="nowrap">
								<input type="checkbox" name="workItemID" onclick="doSelect(this);" value='<b:write iterateId="list" property="workItemID" />'></td>
							<td nowrap="nowrap">
								<l:present iterateId="list" property="catalogName" >
									<b:write iterateId="list" property="catalogName" />
								</l:present>
								<l:notPresent iterateId="list" property="catalogName" >
									<b:message key="workItem_result_jsp.default_catalog"/>
								</l:notPresent><%-- 默认业务目录 --%>
							<td nowrap="nowrap">
								<b:write iterateId="list" property="workItemID" /></td>
							<td nowrap="nowrap">
								<a href="javascript:void(editWorkItem(<b:write iterateId="list" property="workItemID" />))" ><b:write iterateId="list"
									property="workItemName" /></a>	
							</td>
							<td nowrap="nowrap">
								<d:write iterateId="list" property='currentState' dictTypeId="WFDICT_WorkItemState"/>			 							
								<input type="hidden" name='currentState<b:write iterateId="list" property="workItemID" />' value='<b:write iterateId="list" property="currentState" />'/>
							</td>
							<td nowrap="nowrap">
								<d:write iterateId="list" property='bizState' dictTypeId="WFDICT_WorkItemBizState"/>	
							</td>
							<td nowrap="nowrap">
								<span title='<b:write iterateId="list" property="processInstName" />'><b:write iterateId="list" property="processInstName" maxLength="15"/></span>
							</td>
							<td nowrap="nowrap">
								<b:write iterateId="list" property="processDefName" />
							</td>
							<td nowrap="nowrap">				
								<d:write iterateId="list" property="isTimeOut" dictTypeId="WFDICT_YN"/>
							</td>
							<td nowrap="nowrap">
								<b:write iterateId="list" property="participant" />
							</td>
							<td nowrap="nowrap">
								<b:write iterateId="list" property="partiName" />
							</td>
							<td nowrap="nowrap">
								<b:write iterateId="list" property="createTime" formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/>
							</td>
							<td nowrap="nowrap">
								<b:write iterateId="list" property="endTime"  formatPattern="yyyy-MM-dd hh:MM" srcFormatPattern="yyyyMMddHHmmss"/>
							</td> 
						</tr>  
					</l:iterate></l:present>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color: #e7f5fe;" >
					<tr>
						<td colspan="10" class="command_sort_area">
							<input type="button" id="terminateBtn" name="Submit1" value="<b:message key="workItem_result_jsp.terminate"/>" class="button" onClick="doSubmit('terminate')"><%-- 终止 --%>
							<input type="button" id="deleteBtn" name="Submit2" value="<b:message key="workItem_result_jsp.delete"/>" class="button" onClick="doSubmit('delete')"><%-- 删除 --%>
						</td>
						<td align="right" nowrap="nowrap">
							<b:set name="action" value="com.primeton.workflow.manager.query.queryWorkItemList.flow?_eosFlowAction=queryWithPage"/>
							<b:set name="target" value="_self"/>
				      		<%@ include file="/workflow/wfcomponent/web/common/pagination.jsp"%>
						</td>
					</tr>
				</table>
				<br>
				</td>
			</tr> 
		</table>	
</h:form> 
</td></tr>
</table>
</body>
</html>