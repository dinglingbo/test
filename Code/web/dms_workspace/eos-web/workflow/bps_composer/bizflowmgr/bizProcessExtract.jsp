<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<%@page import="java.net.URLDecoder"%>
<html>
<!-- 
  - Author(s): bps
  - Date: 2009-07-30 14:47:03
  - Description:
-->
<head>
<title><b:message key="permission_common.biz_proc_extract"/></title>
<%
	String processDefCHName = URLDecoder.decode(request.getParameter("processDefCHName"),"UTF-8");
	request.setAttribute("processDefCHName", processDefCHName);
 %>
</head>
<body>
<div id="ResponseMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<form name="viewlist1" action="com.primeton.bps.web.composer.bizflowmgr.bizProcessCustomDeal.flow" method="post">
<h:hidden property="tempProcessDefID"/>
<h:hidden property="pathName"/>
<h:hidden property="processDefCHName" />
<input type="hidden" name="_eosFlowAction" value="submit"/>
<input type="hidden" name="operateFlag" />
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%" height="370px">
	<tr>
		<td class="workarea_title" valign="middle"><h3><b:message key="permission_common.biz_proc_extract"/></h3></td>
  	</tr>
  	<tr> 
    	<td width="100%" valign="top">
	  <w:layout height="100%" width="100%" type="horizontal">
			<w:layoutPanel height="100%" width="30%">
				<div style="border:1px solid #dddddd;width:100%;height:100%" >
					<b:write property="processDefCHName"/>
				</div>
			</w:layoutPanel>
			<w:layoutPanel height="100%">
               	 <w:layout height="100%" width="100%" type="vertical">
					<w:layoutPanel width="50%">
						<div style="border:1px solid #dddddd;width:100%;height:100%" >
						    <!-- 
						    <h:select id="select1" value="version" multiple="true" style="width:100%;height:100">
						       <h:options property="v" labelField="/" valueField="/"/>
						    </h:select>
						     -->
						    <SELECT id="select1" name="version" MULTIPLE style="width:100%;height:100" onchange="doSelect()">
						       <%int i=0; %>
						       <l:iterate id="id1" property="procList" indexId="index">
						       		       
						       <option processDefID="<b:write iterateId="id1" property="processDefID"/>" versionSign="<b:write iterateId="id1" property="versionSign"/>" operator="<b:write iterateId="id1" property="operator"/>" updatetime="<b:write iterateId="id1" property="updateTime"/>" currentstate="<b:write iterateId="id1" property="currentState"/>" versionDesc="<b:write iterateId="id1" property="versionDesc"/>" 
						       <%if( i==0) out.println("selected");%>>
						       <b:write iterateId="id1" property="versionSign"/>
						       <l:equal iterateId="id1" property="currentState" targetValue="3" compareType="number">（*）</l:equal>
						       <%i++; %>
						       </l:iterate>
						       </option>
						    </SELECT>
						    
						</div>
					</w:layoutPanel>
					<w:layoutPanel width="50%">
						<div style="border:1px solid #dddddd;width:100%;height:100%;valign:top" >
						    <h:hidden property="processDefName"/>
						    <input type="hidden" name="processDefID" value="<b:write property="procList/processDefID"/>">
						    <input type="hidden" name="versionSign" value="<b:write property="procList/versionSign"/>">
						    <table class="EOS_table" width="100%">
								<tr >
									<td class="style1" width="20%"><b:message key="biz_process_extract_jsp.modifier"/></td><!-- 修改人员 -->
									<td><h:text style="width:260px" name="operator" property="procList/operator" disabled="true"/></td>
								</tr>
								<tr>
									<td class="style1"><b:message key="biz_process_extract_jsp.modified_time"/></td><!-- 修改时间 -->
									<b:write property="procList/updateTime" formatPattern="yyyy-MM-dd hh:MM"/>
									<td><input style="width:260px" type="text" disabled="disabled" name="updateTime" value="<b:write property="procList/updateTime" formatPattern="yyyy-MM-dd hh:MM"/>"/></td>
								</tr>
								<tr>
									<td class="style1"><b:message key="biz_process_extract_jsp.version_state"/></td><!-- 版本状态 -->
									<td>
										<input style="width:260px" type="text" name="currentstate" disabled="disabled" value="<l:equal property="procList/currentState" targetValue="3"><b:message key="permission_common.released"/></l:equal><l:equal property="procList/currentState" targetValue="1"><b:message key="permission_common.unreleased"/></l:equal>"/>
									</td>
								</tr>
								<tr>
									<td class="style1"><b:message key="biz_process_extract_jsp.version_desc"/></td><!-- 描述 -->
									<td><h:textarea name="versionDesc" property="procList/versionDesc" disabled="true" style="width:260px" rows="5"/></td>
								</tr>
							</table>
						</div>
					</w:layoutPanel>
			   	 </w:layout>
               
			</w:layoutPanel>
	    </w:layout>
        </td>
        </tr>
        <tr>
          <td class="form_bottom">            
            <input id="btnNextStep" name="btnNextStep" type="button" value='<b:message key="permission_common.btn_next_step"/>' onclick="doModify()" class="button"><!-- 下一步 -->
            <input id="btnDone" name="btnDone" type="button" value='<b:message key="permission_common.btn_done"/>' onclick="doSubmit()" class="button"><!-- 完成 -->
            <input id="btnCancel" name="btnCancel" type="button" value='<b:message key="permission_common.btn_cancel"/>' onclick="cancle()" class="button"><!-- 取消 -->
          </td>
        </tr>
     </table>
</form>
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
    
    function doSelect() {
      var frm = $name("viewlist1");
      var obj = $name("version");
      var childLength = obj.options.length;
	  selectedNum = 0;
	  for(j=0; j<childLength; j++){
		 if(obj.options[j].selected == true)
			selectedNum++;
	  }
	  if(selectedNum == 0){
		showMessage($id("ResponseMessage"),'<b:message key="permission_common.must_choose_tip"/>');//请先选择一个版本
		return false;
	  }
	  if(selectedNum > 1){
		showMessage($id("ResponseMessage"),'<b:message key="permission_common.only_choose_one_tip"/>');//只能选择一个
		return false;
	  }
	  var opt = obj.options[obj.selectedIndex];
	  $name("processDefID").value = opt.getAttribute("processDefID");
	  $name("versionSign").value = opt.getAttribute("versionSign");
	 
	  
	  $name("operator").value = opt.getAttribute("operator");
	  var uptTime = opt.getAttribute("updatetime");
	  var newUptTime = uptTime.substring(0,4)+"-"+uptTime.substring(4,6)+"-"+uptTime.substring(6,8)+" "+uptTime.substring(8,10)+":"+uptTime.substring(10,12)+":"+uptTime.substring(12);
	  $name("updateTime").value = newUptTime;
	  $name("currentstate").value = opt.getAttribute("currentstate");
	  if($name("currentstate").value==3){
	  	$name("currentstate").value='<b:message key="permission_common.released"/>';//发布
	  }else if($name("currentstate").value==1){
	  	$name("currentstate").value='<b:message key="permission_common.unreleased"/>';//未发布
	  }
	  $name("versionDesc").value = opt.getAttribute("versionDesc");
    }
    
    function doModify() {
      var frm = $name("viewlist1");
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