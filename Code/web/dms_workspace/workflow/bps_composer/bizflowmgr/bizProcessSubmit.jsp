<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="java.net.URLDecoder"%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-08-04 10:45:47
  - Description:
-->
<head>
<title><b:message key="permission_common.biz_proc_submit"/></title>
<%
	String processDefCHName = URLDecoder.decode(request.getParameter("processDefCHName"),"UTF-8");
	String versionDesc = URLDecoder.decode(request.getParameter("versionDesc"),"UTF-8");
	request.setAttribute("processDefCHName", processDefCHName);
	request.setAttribute("versionDesc", versionDesc);
 %>
</head>
<body onload="initForm()">
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<h:form name="viewlist1" action="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomSubmit.flow" method="post">
<h:hidden property="tempProcessDefID"/>
<h:hidden property="processDefName"/>
<h:hidden property="processDefCHName"/>
<h:hidden property="pathName"/>
<input type="hidden" name="_eosFlowAction" value="submit"/>
<input type="hidden" name="operateFlag" />
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="permission_common.biz_proc_submit"/></h3></td>
  	</tr>
  	<tr> 
    	<td width="100%">
	  <w:layout height="100%" width="98%" type="horizontal">
			<w:layoutPanel style="height:50%;vertical-align:top" width="30%">
				<div style="border:1px solid #dddddd;width:100%;height:100%" >
				    <b:write property="processDefCHName"/>
				</div>
			</w:layoutPanel>
			<w:layoutPanel height="50%">
               	 <w:layout height="100%" width="100%" type="vertical">
					<w:layoutPanel width="50%" >
						<div style="border:1px solid #dddddd;width:100%;height:100%" >
						    
						    <table class="EOS_table" width="100%">
								<tr>
									<td class="style1" width="20%"><h:radio name="submitType" value="1" checked="true" onclick=""/>
									   <b:message key="biz_process_submit_jsp.submit_default"/><br/>
									    <span style="width:100%;" >
									    <b:message key="biz_process_submit_jsp.note"/>
									    </span>
									</td>
								</tr>
								<tr>
									<td class="style1"><h:radio id="rd1" name="submitType" value="2" onclick="clickOverVer()"/><b:message key="biz_process_submit_jsp.overwrite_exist"/>
									    <br>
									     <SELECT id="select1" name="versionSign" onchange="doChange()" MULTIPLE style="width:100%;height:100">
									       
									       <l:iterate id="id1" property="procList" indexId="index">
									       <option value="<b:write iterateId="id1" property="versionSign"/>" >
									       version--(<b:write iterateId="id1" property="versionSign"/>)
									       <l:equal property="currentState" targetValue="3" iterateId="id1">*</l:equal>
									       </option>
									       </l:iterate>
									    </SELECT>
									   
									</td>
								</tr>
								
								<tr>
									<td class="style1"><h:radio name="submitType" value="3" onclick=""/><b:message key="biz_process_submit_jsp.create_new_version"/>
									 <br>
									 <h:checkbox value="1" property="deploy" checked="true"/><b:message key="biz_process_submit_jsp.release_now"/>
									
									</td>
								</tr>
								<tr>
									<td class="style1"><b:message key="biz_process_submit_jsp.version_desc"/>
									 	<br>
									  	<h:textarea property="versionDesc" style="width:100%;height:85;word-break:break-all;" validateAttr="allowNull=true;maxLength=200;"/>									
									</td>
								</tr>
							</table>
						    
						</div>
					</w:layoutPanel>
			   	 </w:layout>
			</w:layoutPanel>
	    </w:layout>
        </td>
        </tr>
        <tr class="form_bottom">
          <td colspan="2">            
            <input id="btnNextStep" name="btnNextStep" type="button" value='<b:message key="permission_common.btn_next_step"/>' onclick="doResource()" class="button">
            <input id="btnSubmit" name="btnSubmit" type="button" value='<b:message key="permission_common.btn_done"/>' onclick="doSubmit()" class="button">
            <input id="btnCancel" name="btnCancel" type="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancle()" class="button">
          </td>
        </tr>
        </table>
</h:form>
       
</body>
</html>
<script>
	var ret = new Array(2);
    function cancle() {
		ret[0]="N";
		// 定义窗口关闭时的返回值
        window['returnValue'] = ret;
        window.close();
    }
    
    function initForm(){
    	var frm = $name("viewlist1");
    	var obj = $name("versionSign");
      	var childLength = obj.options.length;
      	if(childLength==0){
      		$id("rd1").disabled=true;
      	}
    }
    
    function clickOverVer(){
	    var frm = $name("viewlist1");
    	var obj = $name("versionSign");
      	var childLength = obj.options.length;
      	for(j=0; j<childLength; j++){
		 	if(obj.options[j].selected == true)
				return;
	  	}
    	if(childLength>0){
    		obj.options[0].selected = true;
    	}
    }
    
    function doChange() {
      var frm = $name("viewlist1");
      var obj = $name("versionSign");
      var childLength = obj.options.length;
	  selectedNum = 0;
	  for(j=0; j<childLength; j++){
		 if(obj.options[j].selected == true)
			selectedNum++;
	  }	  
	  if(selectedNum > 1){
		showMessage($id("ResponseMessage"),'<b:message key="permission_common.only_choose_one_tip"/>');
		return false;
	  }
	  if(selectedNum == 1){
	    $id("rd1").checked=true;
	  }
    }
    
    function doSelect() {
      var frm = $name("viewlist1");
      var obj = $name("versionSign");
      var childLength = obj.options.length;
	  selectedNum = 0;
	  for(j=0; j<childLength; j++){
		 if(obj.options[j].selected == true)
			selectedNum++;
	  }
	  if(selectedNum == 0){
		showMessage($id("ResponseMessage"),'<b:message key="permission_common.must_choose_tip"/>');
		return false;
	  }
	  if(selectedNum > 1){
		showMessage($id("ResponseMessage"),'<b:message key="permission_common.only_choose_one_tip"/>');
		return false;
	  }
	  $name("processDefID").value = obj.options[obj.selectedIndex].processDefID;
	  $name("versionSign").value = obj.options[obj.selectedIndex].versionSign;
	  
	  $name("operator").value = obj.options[obj.selectedIndex].operator;
	  $name("updatetime").value = obj.options[obj.selectedIndex].updatetime;
	  $name("currentstate").value = obj.options[obj.selectedIndex].currentstate;
	  $name("versionDesc").value = obj.options[obj.selectedIndex].versionDesc;
    }
    
    function doResource() {
		if($id("rd1").checked){
			if($id("select1").value==""){
				showMessage($id("ResponseMessage"),'<b:message key="permission_common.must_choose_tip"/>');
				return ;
			}
		}
		
      var frm = $name("viewlist1");
      var obj = $name("versionSign");
      var childLength = obj.options.length;
	  selectedNum = 0;
	  if(!$id("rd1").checked) {
		  for(j=0; j<childLength; j++){
			 if(obj.options[j].selected == true)
				obj.options[j].selected == false;
		  }	
	  }
      frm.elements["_eosFlowAction"].value = "next";
      frm.submit();
    }
    
    function doSubmit() {
      var frm = $name("viewlist1");
      frm.elements["operateFlag"].value = "1";
      frm.elements["_eosFlowAction"].value = "next";
      frm.submit();
    }
</script>