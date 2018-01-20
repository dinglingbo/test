<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
	
	    function upload () {
	    	if(validate()){
	    		document.getElementById("btnOk").disabled=true;
	    		document.getElementById("btnCancel").disabled=true;
	   			document.forms['uploadProcess'].action='com.primeton.workflow.manager.def.deployContribution.flow?_eosFlowAction=uploadEcd' ;
	   			document.forms['uploadProcess'].submit();
   			}
   		}
   		
   		function validate(){
		   var sFilePath =  document.all.ecdPath.value;
	       var reg=/([^.]+)$/.exec(sFilePath);   
		   var regex=/(ecd|ECD)$/ig;
		   if(sFilePath ==""||(!regex.test(sFilePath))){
		     alert("<b:message key="upload_ecd_processFile_jsp.selectECD"/>"); //请选择流程ecd文件！
		     document.all.ecdPath.focus() ;
		     return false;
		   }
		   if(document.all.description.value.length>128){
		   	 alert("<b:message key="upload_ecd_processFile_jsp.processVersionDescValidate"/>");//业务流程版本描述长度不能超过128个字符！
		   	 return false;
		   }
		   else return true;
		   
		}
   		function cancelUpload() {
   			document.forms['uploadProcess'].action='com.primeton.workflow.manager.def.getProcessPackages.flow' ;
   			document.forms['uploadProcess'].submit();
   		}
	</script>
</head>

<body style="background:#FFFFFF;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;overflow:auto;">
	<form name="uploadProcess" method="post" enctype="multipart/form-data">
   <table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="100%">
   	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="upload_ecd_processFile_jsp.workarea_title"/></h3></td><!-- 批量部署业务流程 -->
	</tr>
	<tr>
	  <td>
		<table border="0" class="EOS_panel_body" width="100%" height="100%">
			 <tr> 
			   <td width="100%" height="100%" valign="top">
				    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td>
                        	<fieldset style="height:270px">
								<legend><b:message key="upload_ecd_processFile_jsp.uploadProcessFiles"/></legend><!-- 上传流程文件 -->
								<h:file name="ecdPath"/> 
								<table border="0" cellpadding="0" cellspacing="0" width="50%" name="optionEditor" id="optionEditor" style="display:">
								<tr>
									<td>
										<div>
											<fieldset style="border: 0px">
												<legend><b:message key="upload_ecd_processFile_jsp.bizVersionInfo"/></legend><!-- 业务版本相关信息 -->
												<div>
													<input type="radio" id="option/mode" name="option/mode"  value="default" checked="checked"  >
													<label for="deployType_default"><b:message key="deploy_process_jsp.deployType_default"/></label><!-- 按照默认方式提交 -->
													<div style="padding-left:13px"> 
														<b:message key="deploy_process_jsp.note"/>					
													</div><!-- (注: 当已经存在流程定义时覆盖最新版本,不存在流程定义时则创建新版本)  -->
												</div>
												<div>
													<input type="radio" id="option/mode" name="option/mode" value="new-version"  >
													<label for="deployType_new"><b:message key="deploy_multiprocesses_jsp.create_new"/></label><!-- 创建新版本 -->
												</div>
												<div>
													<div style="display:inline;padding-left:3px">
														<label for="isRelease"><b:message key="deploy_multiprocesses_jsp.release_now"/></label><!-- 立即发布 -->
													</div>
													<input type="checkbox" id="isRelease" name="isRelease"  checked="checked"  >
												</div>
												<div>
													<div style="display:inline;padding-left:3px">
														<label for="description"><b:message key="edit_autoact_info_jsp.desc"/></label><!-- 描述 -->
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
								<input type="button"  id="btnOk" name="btnOk" value="<b:message key="edit_autoact_info_jsp.ok"/>" class="button" onclick="upload()"><!-- 确定 -->
								&nbsp;&nbsp;<input type="button" id="btnCancel" name="btnCancel" value="<b:message key="edit_autoact_info_jsp.cancel"/>" class="button" onclick="cancelUpload()"><!-- 返回 -->
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
