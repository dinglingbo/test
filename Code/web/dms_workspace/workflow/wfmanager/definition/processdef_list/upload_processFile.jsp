<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<html>
<head>
	<title></title>
	<script>
	    function upload () {
			if(!validate()){
			 	return false;
			}	
   			document.forms['uploadProcess'].action='com.primeton.workflow.manager.def.deploy_signleFile.flow?_eosFlowAction=action0&processDefName=<%=request.getParameter("processDefName")%>' ;
   			submitForm('uploadProcess');
   		}
   		
   		function validate(){
		   sFilePath =  document.all.processFile.value;
		   if(sFilePath ==""){
		     alert("<b:message key="upload_process_file_jsp.select_process_file"/>"); //请选择流程文件
		     uploadProcess.processFile.focus() ;
		     return false;
		   }
		   
		   var reg = /([^.]+)$/.exec(sFilePath); 
		   var fileType = RegExp.$1 ;
		   if(fileType.toLowerCase() == "workflow" ||
		       fileType.toLowerCase() == "workflowx" ) {
		   		return true;
		   } else {
			   	alert("<b:message key="upload_process_file_jsp.file_format_incorrect"/>") ;//该文件不是workflow或workflowx格式
		   		return false ;
		   }
		   
		}
 
   		function cancelUpload() {
   			window.returnValue = false ;
   			window.close() ;
   		}
	</script>
</head>
<body>
<form name="uploadProcess" method="post" enctype="multipart/form-data">
	<h:hidden name="catalogUUID" property="catalogUUID" />
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tr>
			<td>
				<div style="padding-top:10px">
					<fieldset style="height:100px">
						<legend><b:message key="upload_process_file_jsp.upload_process_file"/></legend><%-- 上传流程文件 --%>
						<div>
							<h:file name="processFile"/>
						</div>
						<div style="text-align: center;">
							<br>
							<input type="button" id="btnOk" name="btnOk" value="<b:message key="upload_process_file_jsp.ok"/>" class="button" onclick="upload()"><%-- 确定 --%>
							<input type="button" id="btnCancel" name="btnCancel" value="<b:message key="upload_process_file_jsp.cancel"/>" class="button" onclick="cancelUpload()"><%-- 取消 --%>
						</div>
						<div style="padding-top:5px">
							<l:present property="processNotEqual">
								<label><font color="red"><b:message key="upload_process_file_jsp.error"/></font></label><%-- 错误:上传的流程文件与当前流程不一致,请确认上传流程文件的流程名称(processId属性)与当前流程名称一致! --%>
							</l:present>
						</div>
					</fieldset>
				</div>
			</td>
		</tr>
	</table>
</form>
</body>