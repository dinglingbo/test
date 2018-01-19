<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
	<head>
	</head>
	<script type="text/javascript"> 
	function checkAll(){
		if(document.forms['resultForm'].procInstID != null){
			var isChecked = document.forms['resultForm'].operation.checked;
			if (isChecked) {
				styleName = "EOS_table_selectRow";
			}
			else {
				styleName = "EOS_table_row";
			}
			if(document.forms['resultForm'].procInstID.length == undefined){
				document.forms['resultForm'].procInstID.checked = isChecked;				
			}
			else {
				for(i = 0;i<document.forms['resultForm'].procInstID.length;i++) {
					document.forms['resultForm'].procInstID[i].checked = isChecked;
					if (isFF) {
						$names("processInstRow")[i].setAttribute("class", styleName);//for FF
					}
					else {
						$names("processInstRow")[i].setAttribute("className", styleName);//for IE
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
			var el = document.getElementsByName('procInstID');
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
	
	function validate(actionName){
		//alert(actionName);
		
		if(document.resultForm.procInstID == undefined)
			return false; 
			
		if(document.resultForm.procInstID.length == undefined){
			if(document.resultForm.procInstID.checked){
				var values = new Array();
				values[0] = document.resultForm.procInstID.value;
				return isAllowDone(actionName,values);
			}
		}else{
			var values = new Array(document.resultForm.procInstID.length);
			var isChecked = false;
			for(i = 0;i<document.resultForm.procInstID.length;i++){
			  	if(document.resultForm.procInstID[i].checked){
					values[i] = document.resultForm.procInstID.value;
					isChecked = true;
				}
		  	}
		  	if(isChecked)
	  			return isAllowDone(actionName,values);
		}
		alert('<b:message key="procInst_result_jsp.select_pro_ins_record"/>');//请先选中一条流程实例记录
		return false;
	}
	
	//判断状态
	function isAllowDone(actionName,values){
		//alert('isAllowDone');
		
		if(document.resultForm.procInstID== undefined){
			return false;
		}
		var chks=document.resultForm.procInstID;
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
		
		if(actionName == 'suspend'){
			for(i=0;i<state.length;i++){
				if(state[i]!=undefined)
				if(state[i]!=2){
					alert('<b:message key="procInst_result_jsp.suspend_condition"/>');//只有状态为“运行”的流程实例才能挂起。
					return false;
				}
			}
		}
		else if(actionName == 'resume'){
			for(i=0;i<state.length;i++){
				if(state[i]!=undefined)
				if(state[i]!=3){
					alert('<b:message key="procInst_result_jsp.resume_condition"/>');//只有状态为“挂起”的流程实例才能回复。
					return false;
				}
			}
		}
		else if(actionName == 'terminate'){
			for(i=0;i<state.length;i++){
				if(state[i]!=undefined)
				if(state[i]!=1&&state[i]!=2&&state[i]!=3){
					alert('<b:message key="procInst_result_jsp.terminate_condition"/>');//只有状态为“未启动”、“挂起”、“运行”的流程实例才能终止。
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
				if(action=="terminate"){
					terminateProcInsts();
				}
				else if(action=="delete"){
					deletProcInsts();
				}
				else if(action=="suspend"){
					suspendProcInsts();
				}
				else if(action=="resume"){
					resumeProcInsts(); 
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
					return "<b:message key="procInst_result_jsp.resume"/>"; //恢复
				}  				 
				  
	}
	
	function doDetail(processInstID,processDefID){
		if(confirm("<b:message key="procInst_result_jsp.sure_into_mgr_page"/>")){//您确实要进入该流程的管理页面吗?
		    document.resultForm.action = 'com.primeton.workflow.manager.instance.navigation.flow?sourceFlag=advance_query&_eosFlowAction=diagramAction&processInstID='+processInstID+'&processDefID='+processDefID;
			document.resultForm.target= "mainframe";
			document.resultForm.submit();
			
		}else{
	   		//没有进入该流程的管理页面
	    }
		
	}
	
	function resumeProcInsts(){
		document.resultForm.action="com.primeton.workflow.manager.query.handleProcInst.flow?_eosFlowAction=resumeProcInsts";
		document.resultForm.Submit3.disabled="disabled";
		document.resultForm.submit();
	} 
	
	function terminateProcInsts(){
		document.resultForm.action="com.primeton.workflow.manager.query.handleProcInst.flow?_eosFlowAction=terminateProcInsts";
		document.resultForm.Submit2.disabled="disabled";
		document.resultForm.submit();
	}
	   
	function suspendProcInsts(){
		document.resultForm.action="com.primeton.workflow.manager.query.handleProcInst.flow?_eosFlowAction=suspendProcInsts";
		document.resultForm.Submit1.disabled="disabled";
		document.resultForm.submit();
	}
	
	function deletProcInsts(){
		document.resultForm.action="com.primeton.workflow.manager.query.handleProcInst.flow?_eosFlowAction=deleteProcInsts";
		document.resultForm.Submit4.disabled="disabled";
		document.resultForm.submit();
	}
	
	window.onload = function (){
	
		 var listSize = '<b:write property="procInstList"/>';
		 listSize = listSize=='[]'?0:listSize;
		 if(listSize==0){
			 $name("Submit1").disabled=true;
			 $name("Submit2").disabled=true;
			 $name("Submit3").disabled=true;
			 $name("Submit4").disabled=true;
		 }
	}
	
	function initiFrame(){
		var height = frameElement.parentNode.offsetHeight;
		if (isFF) {
			height += 20;
		}
		else {
			height -= 20;
		}
		frameElement.height = height;
	}
</script>
	<body onLoad="initiFrame()" style="width:100%;background:white;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px; margin-right: 0px;margin: auto;overflow:auto; overflow-y:auto; overflow-x: auto;">
	<table border="0" cellpadding="1" cellspacing="0" width="100%">
		<tr><td>
		<form name="resultForm" action="" method="post">
		<l:present property="queryCondition">
			<h:hiddendata property="queryCondition" />
			<h:hidden property="isIncludeSubCatalog" />
			<h:hidden property="catalogUUID" />
		</l:present>
			<table border="0" cellpadding="1" cellspacing="0" class="workarea" width="100%">
				<tr>
					<td nowrap="nowrap" class="EOS_panel_head">
						<b:message key="procInst_result_jsp.process_inst_info"/>
					</td><%-- 流程实例信息 --%>
				</tr>
				<tr valign="top">
					<td>
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td>
									<table border="0" class="EOS_table" width="100%">
										<tr class="EOS_table_head">
											<th nowrap="nowrap">
												<input type="checkbox" name="operation"	onclick="checkAll();"><b:message key="procInst_result_jsp.select"/>
											</th><%-- 选择 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.biz_catalog"/>
											</th><%-- 业务目录 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.pro_inst_id"/>
											</th><%-- 流程实例ID --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.pro_inst_name"/>
											</th><%-- 流程实例名称 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.pro_def_name"/>
											</th><%-- 流程定义名称 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.creator"/>
											</th><%-- 创建者 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.cur_state"/>
											</th><%-- 当前状态 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.start_time"/>
											</th><%-- 启动时间 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.end_time"/>
											</th><%-- 结束时间 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.is_time_out"/>
											</th><%-- 是否超时 --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.pro_def_id"/>
											</th><%-- 流程定义ID --%>
											<th nowrap="nowrap">
												<b:message key="procInst_result_jsp.operation"/>
											</th><%-- 操作 --%>
										</tr>
										<l:present property="procInstList">
											<l:iterate id="list" property="procInstList">
												<tr id="processInstRow" name="processInstRow" class="EOS_table_row" onclick="doSelectRow(this);">
													<td nowrap="nowrap" width="5%">
														<input type="checkbox" name="procInstID" onclick="doSelect(this);"
															value='<b:write iterateId="list" property="processInstID" />'>
													</td>
													<td nowrap="nowrap">
														<l:present iterateId="list" property="catalogName" >
															<b:write iterateId="list" property="catalogName" />
														</l:present>
														<l:notPresent iterateId="list" property="catalogName" >
															<b:message key="procInst_result_jsp.default_catalog"/>
														</l:notPresent><%-- 默认业务目录 --%>
													</td>
													<td nowrap="nowrap">
														<b:write iterateId="list" property="processInstID" />
													</td>
													<td nowrap="nowrap">
														<span title='<b:write iterateId="list" property="processInstName" />'><b:write iterateId="list" property="processInstName" maxLength="15"/></span>
													</td>
													<td nowrap="nowrap">
														<b:write iterateId="list" property="processDefName" />
													</td>
													<td nowrap="nowrap">
														<b:write iterateId="list" property="creator" />
													</td>
													<td nowrap="nowrap">
														<d:write iterateId="list" property="currentState" dictTypeId="WFDICT_ProcessState" />
														<input type="hidden" name='currentState<b:write iterateId="list" property="processInstID" />' value='<b:write iterateId="list" property="currentState" />' />
													</td>
													<td nowrap="nowrap">
														<b:write iterateId="list" property="startTime"
															formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyyMMddHHmmss"/>
													</td>
													<td nowrap="nowrap">
														<b:write iterateId="list" property="endTime"
															formatPattern="yyyy-MM-dd HH:mm:ss" srcFormatPattern="yyyyMMddHHmmss"/>
													</td>
													<td nowrap="nowrap">
														<!--	<b:write iterateId="list"
									property="isTimeOut" />-->
														<d:write iterateId="list" property="isTimeOut"
															dictTypeId="WFDICT_YN" />
													</td>
													<td nowrap="nowrap">
														<b:write iterateId="list" property="processDefID" />
													</td>
													<td nowrap="nowrap">
														<A href="javascript:void(doDetail(<b:write iterateId="list" property="processInstID" />,<b:write iterateId="list" property="processDefID" />))" ><b:message key="procInst_result_jsp.into_mgr"/></A><%-- 进入管理 --%>
													</td>
												</tr>
											</l:iterate>
										</l:present>
									</table>
									<table width="100%" border="0" cellspacing="0" cellpadding="0" style="background-color: #e7f5fe;" >
										<tr>
											<td colspan="10" class="command_sort_area">
												<input type="button" id="suspendBtn" name="Submit1" value="<b:message key="procInst_result_jsp.btn_suspend"/>" class="button"
													onclick="doSubmit('suspend')"><%-- 挂起 --%>
												<input type="button" id="terminateBtn" name="Submit2" value="<b:message key="procInst_result_jsp.btn_terminate"/>" class="button"
													onclick="doSubmit('terminate')"><%-- 终止 --%>
												<input type="button" id="resumeBtn" name="Submit3" value="<b:message key="procInst_result_jsp.btn_resume"/>" class="button"
													onclick="doSubmit('resume')"><%-- 恢复 --%>
												<input type="button" id="deleteBtn" name="Submit4" value="<b:message key="procInst_result_jsp.btn_delete"/>" class="button"
													onclick="doSubmit('delete')"><%-- 删除 --%>
											</td>
											<td align="right" nowrap="nowrap">
												<b:set name="action" value='com.primeton.workflow.manager.query.queryProcessInstance.flow?_eosFlowAction=queryWithPage' />
												<b:set name="target" value="_self" />
												<%@ include	file="/workflow/wfcomponent/web/common/pagination.jsp"%>
											</td>
										</tr>
									</table>
									<br>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		</td></tr>
	</table>
	</body>
</html>
