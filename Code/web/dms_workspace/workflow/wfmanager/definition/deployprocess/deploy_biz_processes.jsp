<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
	    function upload () {
	    	if(validate()){
	    		// 导入PAR功能会覆盖相同的业务目录、业务流程、业务资源信息，是否继续？
		    	if(confirm('<b:message key="deploy_biz_processes_jsp.upload_tip1"/>')){
		    		document.getElementById("btnOk").disabled=true;
		    		//document.getElementById("btnCancel").disabled=true;
		   			document.forms['uploadProcess'].action='com.primeton.workflow.manager.def.deployContribution.flow?_eosFlowAction=uploadEcd';
		   			document.forms['uploadProcess'].submit();
		   			//parent.left.refreshTreeRoot();
	   			} else {
	   				return false;
	   			}
	    	} else {
	    		return false;
	    	}	
   		}
   		
   		function validate(){
		   var sFilePath =  document.all.ecdPath.value;
	       var reg=/([^.]+)$/.exec(sFilePath);   
		   var regex=/(par|PAR)$/ig;
		   if(sFilePath ==""||(!regex.test(sFilePath))){
		   	 //请选择流程par文件！
		     alert('<b:message key="deploy_biz_processes_jsp.upload_tip2"/>'); 
		     document.all.ecdPath.focus() ;
		     return false;
		   }
		   if(document.all.description.value.length>128){
		   	 alert('<b:message key="deploy_biz_processes_jsp.upload_tip3"/>');
		   	 return false;
		   }
		   else return true;
		   
		}
		
   		function cancelUpload() {
   			document.forms['uploadProcess'].action='com.primeton.workflow.manager.def.getProcessPackages.flow' ;
   			document.forms['uploadProcess'].submit();
   		}
   		
   		//返回
		function closeWin() {
			parent.frames["middle"].window.location.href = 'com.primeton.workflow.manager.def.getProcessByCatalogID.flow?catalogUUID='+$id("catalogUUID").value;
		}
	</script>
</head>

<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
<form id="uploadProcess" name="uploadProcess" method="post" enctype="multipart/form-data">
<h:hidden id="catalogUUID" property="catalogUUID" />
   <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="deploy_biz_processes_jsp.batch_import"/></h3></td><!-- 批量导入业务流程 -->
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
			   <td width="100%" height="100%" valign="top">
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                        	<fieldset>
								<legend><b:message key="deploy_biz_processes_jsp.upload_proc_file"/></legend>
								<h:file name="ecdPath" onkeydown="return false;"/>
								<table border="0" cellpadding="0" cellspacing="0" width="50%" name="optionEditor" id="optionEditor" style="display:">
								<tr>
									<td>
										<div>
											<fieldset style="border: 0px">
												<br/>
												<legend><b:message key="deploy_biz_processes_jsp.rel_info"/></legend>
												<div>
													<input type="radio" id="option/mode" name="option/mode"  value="default" checked="checked"  >
													<label for="deployType_default"><b:message key="deploy_biz_processes_jsp.submit_default"/></label>
													<div style="padding-left:13px"> 
														(<b:message key="deploy_biz_processes_jsp.note"/>)
													</div>
												</div>
												<div>
													<input type="radio" id="option/mode" name="option/mode" value="new-version"  >
													<label for="deployType_new"><b:message key="deploy_biz_processes_jsp.create_new_version"/></label>
												</div>
												<div>
													<div style="display:inline;padding-left:3px">
														<label for="isRelease"><b:message key="deploy_biz_processes_jsp.release_now"/></label>
													</div>
													<input type="checkbox" id="isRelease" name="isRelease"  checked="checked"  >
												</div>
												<div>
													<div style="display:inline;padding-left:3px">
														<label for="description"><b:message key="deploy_biz_processes_jsp.desc"/></label>
													</div>
													<div style="display:inline;padding-left:29px">
														<textarea id="description" name="option/versionDesc" rows="4"  cols="40" ></textarea>
													</div>
												</div>
											</fieldset>
										</div>
									</td>
								</tr> 
							</table>
							<br>
								<input id="btnOk" name="btnOk" type="button" value='<b:message key="defcommon.btn_ok"/>' class="button" onclick="upload()">
								<!--&nbsp;&nbsp;
								<input id="btnCancel" name="btnBack" type="button" value='<b:message key="defcommon.btn_cancel"/>' class="button" onclick="closeWin()">-->
							<br>
							<br>
							</fieldset>
                        </td>
                      </tr>
                    </table></td>
			</tr>
		</table>
</td></tr>
</table> 

<!--批量提交使用隐藏层-->
    
</form>
</body>
