<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String pojo = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_list_jsp.busi_op_type_pojo");
String service = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_list_jsp.busi_op_type_service");
String logicFlow = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_list_jsp.busi_op_type_logic_flow");
String bizlet = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_list_jsp.busi_op_type_bizlet");
String nullStr = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.null");

String type = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.type");
String name = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.name");
String dataType = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.data_type");
String paraType = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.para_type");
String desc = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.desc");
String inputPara = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.input_para");
String returnValue = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.return_value");
String simpleType = ResourcesMessageUtil.getI18nResourceMessage("global_bizopt_info_jsp.simple_type");
%>
<h:script src="/workflow/bps_composer/bizresouce/i18n/message.js" i18n="true"/>
<h:script src="/workflow/bps_composer/bizresouce/check.js"></h:script>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-27 16:00:32
  - Description:
-->
<head>
<title><b:message key="global_bizopt_info_jsp.busi_op_main"/></title><!-- 业务操作维护界面 -->
<script>
	function doSave(){
	  var frm = $name("dataform1");
	  
	  var datacell =$id("datacell");
      if(!datacell.validateAll()) return false;
      if(!checkReturnParam()) return false;
      if(!checkSameNameParam()) return false;
	  
	  if(!checkForm($name(frm))) {
		return false;
	  }
  	  
	  buildScope();
      if($name("bizoptviewobj/mdfState").value!="9"){
		$name("bizoptviewobj/mdfState").value="1";
	  }
	 
      f_alert_hidden_all_message();
	  datacell.submitAllByHidden();
      frm.submit();
	}
	
	function buildScope(){
		var scope="";
		if($name("scope1").checked){
			scope+="1";
		}else{
			scope+="0";
		}
		if($name("scope2").checked){
			scope+="1";
		}else{
			scope+="0";
		}
		if($name("scope3").checked){
			scope+="1";
		}else{
			scope+="0";
		}
		if($name("scope4").checked){
			scope+="1";
		}else{
			scope+="0";
		}
		$name("bizoptviewobj/busioptScope").value=scope+"0000";
	}
	
	function init(){
		var	scope = $name("bizoptviewobj/busioptScope").value;
		toShowDesc(scope);
	}
	
	function toShowDesc(scope){
		if(scope!=""){
			for(i=0;i<4;i++){
				var tmp = scope.substr(i,1);
				if(tmp=="1"){
					dictScope(i+1);					
				}
			}
		}
	}
	
	function dictScope(v){
		if(v==1){
			$name("scope1").checked=true;
		}
		if(v==2){
			$name("scope2").checked=true;
		}
		if(v==3){
			$name("scope3").checked=true;
		}
		if(v==4){
			$name("scope4").checked=true;
		}
	}
	
	function go2List(){
	  var frm = $name("dataform1");
	  frm.elements["_eosFlowAction"].value = "pageQuery";
      frm.submit();
	}
	
	function checkReturnParam(){
			var trs = $id("datacell").getAllRows(true) ;
			var returnSize = 0;
			
			for(var i=0;i<trs.length;i++){
				var str = $id("datacell").getCellValue($id("datacell").getCell(i,0));
				if (str=="result")
					returnSize++;
					if (returnSize==2){
						f_alert($id("datacell").getCell(i,0),'<b:message key="global_bizopt_info_jsp.return_value_tip"/>');//返回值不能有多个！
						return false;
					}
			}
			f_alert_hidden_all_message();
			return true;
	}
	
	function checkSameNameParam(){
			var trs = $id("datacell").getAllRows(true) ;
			var arr = new Array();
			
			for(var i=0;i<trs.length;i++){
				var str = $id("datacell").getCellValue($id("datacell").getCell(i,1));
				if ($contains(arr, str)){
					f_alert($id("datacell").getCell(i,1),'<b:message key="global_bizopt_info_jsp.para_value_same_tip"/>');//参数不能同名！
					return false;
				}
				else{
					arr.push(str);
				}
			}
			f_alert_hidden_all_message();
			return true;
	}
</script>
</head>
<body onload="init();">
<form name="dataform1" action="com.primeton.bps.web.composer.bizresouce.GlobalBizOptMgr.flow" target="_self" method="post">
	<input type="hidden" name="_eosFlowAction" value="save" />
	<h:hiddendata property="page" />
	<h:hiddendata property="queryViewObject" />
	<h:hidden property="bizoptviewobj/busioptUUID" />
	<h:hidden property="bizoptviewobj/catalogUUID" value="0" />
	<h:hidden property="bizoptviewobj/mdfState" value="9"/>
	<h:hidden property="bizoptviewobj/busioptScope" value="00000000" />
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
</l:present>	

<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle">
		<l:empty property="bizoptviewobj/busioptUUID"><h3><b:message key="global_bizopt_info_jsp.add_busi_op"/></h3></l:empty><!-- 新增业务操作 -->
		<l:notEmpty property="bizoptviewobj/busioptUUID"><h3><b:message key="global_bizopt_info_jsp.edit_busi_op"/></h3></l:notEmpty><!-- 修改业务操作 -->
    	</td>
  	</tr>
  	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">	
			<tr>
				<td class="form_label" width="20%"><b:message key="global_bizopt_list_jsp.busi_op_name"/></td><!-- 业务操作名称 -->
				<td>
					<h:text property="bizoptviewobj/busioptName" style="width:50%" onblur="checkInput(this)" validateAttr="allowNull=false;maxLength=20;type=bpscommname"/>
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizopt_list_jsp.busi_op_type"/></td><!-- 业务操作类型 -->
				<td>
					<l:equal property="productInfo/productName" targetValue="Primeton Platform" scope="session">
						<h:select name="bizoptviewobj/busioptType" style="width:50%" property="bizoptviewobj/busioptType">
							<h:option label="<%=pojo%>" value="pojo"/>
							<h:option label="<%=service%>" value="service-component"/>
							<h:option label="<%=logicFlow%>" value="logic-flow"/>
							<h:option label="<%=bizlet%>" value="bizlet"/>
						</h:select>
					</l:equal>
					<l:notEqual property="productInfo/productName" targetValue="Primeton Platform" scope="session">
						<h:select name="bizoptviewobj/busioptType" style="width:50%" property="bizoptviewobj/busioptType">
							<h:option label="<%=pojo%>" value="pojo"/>
						</h:select>
					</l:notEqual>
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizopt_list_jsp.busi_op_impl"/></td><!-- 业务操作实现 -->
				<td><h:text property="bizoptviewobj/busioptImpl" style="width:50%" onblur="checkInput(this)" validateAttr="maxLength=128;type=bpscommimpl" value="<%=nullStr%>"/>
				</td>
			</tr>

			<tr> 
    			<td colspan="2" class="form_label"><b:message key="global_bizopt_info_jsp.para_cfg_list"/></td><!-- 参数配置表 -->
    		</tr>
			</table>
		</td>
	</tr>
	<tr> 
    	<td style="padding:7px">
    			    			<r:datacell width="100%" height="190" id="datacell"  pageSize="100"
	            xpath="params" submitXpath="params">
	                <r:toolbar tools="edit:add del"></r:toolbar>
				<r:field fieldName="paramMode" label="<%=type%>"  defaultValue="parameter"  sortAt="none"><!-- 类型 -->
				<h:select validateAttr="allowNull=false;">
					<h:option label="<%=inputPara%>" value="parameter"/><!-- 输入参数 -->
					<h:option label="<%=returnValue%>" value="result"/><!-- 返回值 -->
				</h:select>
	            </r:field>
	            <r:field fieldName="paramName" label="<%=name%>" width="120" defaultValue="" sortAt="none"><!-- 名称 -->
	            	<h:text validateAttr="allowNull=false;minLength=1;maxLength=30;type=LetterAhead_NumLettMidDown"/>
	            </r:field>
	            <r:field fieldName="typeClass" label="<%=dataType%>" width="80" defaultValue="primitive" sortAt="none"><!-- 名称 -->
	            	<h:select validateAttr="allowNull=false;">
						<h:option label="<%=simpleType%>" value="primitive"/><!-- 简单 -->
					</h:select>
	            </r:field>
	            <r:field fieldName="typeValue" label="<%=paraType%>" width="100" sortAt="none"  defaultValue="java.lang.String" ><!-- 简单 -->
	            	<h:select validateAttr="allowNull=false;">
						<h:option label="String" value="java.lang.String"/>
						<h:option label="int" value="int"/>
						<h:option label="boolean" value="boolean"/>
						<h:option label="double" value="double"/>
						<h:option label="long" value="long"/>
						<h:option label="char" value="char"/>
						<h:option label="short" value="short"/>
						<h:option label="float" value="float"/>
						<h:option label="byte" value="byte"/>
					</h:select>
	            </r:field>
	            
	            <r:field fieldName="description" label="<%=desc%>" width="180" defaultValue="" sortAt="none"><!-- 描述 -->
	            	<h:text validateAttr="allowNull=true;maxLength=8"/>
	            </r:field>
	            </r:datacell>
    	</td>
	</tr>
	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">	
			<tr>
				<td class="form_label" width="20%"><b:message key="global_bizopt_list_jsp.desc"/></td><!-- 说明 -->
				<td><h:textarea property="bizoptviewobj/mark" style="width:50%" rows="5" validateAttr="maxLength=170" onblur="checkInput(this)"/></td>
			</tr>

			<tr>
				<td class="form_label"><b:message key="global_bizopt_info_jsp.available_scope"/></td><!-- 可用范围 -->
				<td>
					<input type="checkbox" name="scope1" value="1"><b:message key="global_bizopt_list_jsp.busi_op_scope_v1"/><!-- 自动活动实现 -->
					<input type="checkbox" name="scope2" value="2"><b:message key="global_bizopt_list_jsp.busi_op_scope_v2"/><!-- 触发事件 -->
					<input type="checkbox" name="scope3" value="3"><b:message key="global_bizopt_list_jsp.busi_op_scope_v3"/><!-- 分支规则 -->
					<input type="checkbox" name="scope4" value="4"><b:message key="global_bizopt_list_jsp.busi_op_scope_v4"/><!-- 参与者规则 -->
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<input id="btnSave" name="btnSave" type="button" value='<b:message key="permission_common.btn_save"/>' class="button" onclick="doSave()">
				<input id="btnBack" name="btnBack" type="button" value='<b:message key="permission_common.btn_back"/>' onclick="go2List();" class="button">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</form>
</body>
</html>
