<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@page import="com.primeton.bps.workspace.frame.common.WSServiceClientFacade"%>

<%
	String processInstID = request.getParameter("processInstID");

	String relativeDataXml = WSServiceClientFacade.getBPSWSManager().getRelaDataString(Long.parseLong(processInstID));
	relativeDataXml = relativeDataXml.replaceFirst("<__root", "<root");
	relativeDataXml = relativeDataXml.replaceFirst("</__root>", "</root>");
			
%>

<html>
<head>
<%@ include file="/workflow/wfmanager/common/common.jsp"%>
<title><b:message key="relative_data_set_jsp.relate_data_set"/></title><%-- 相关数据设置 --%>
<script type="text/javascript">
	function doCheck() {			
		var keyPath = document.forms['saveRelativeData'].keyPath.value;
		var keyValue = document.forms['saveRelativeData'].keyValue.value;	
		document.forms['saveRelativeData'].action='com.primeton.workflow.manager.instance.saveRelativeData.flow?_eosFlowAction=saveRelativeData';
		$name('saveRelativeData').submit();				
	}
	
	function validate(){
		var processInstID = document.forms['saveRelativeData'].processInstID.value;		
		var hs = new HideSubmit('com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz');
		hs.addParam('processInstID',processInstID);
		hs.submit();
		var currentState = hs.getProperty('currentState');
		
		/*流程实例只有处于“运行状态”或“未启动状态”时才可以设置相关数据*/
		if(currentState == 1||currentState == 2){
			if(trim(document.forms['saveRelativeData'].keyPath.value).length == 0){
					alert('<b:message key="relative_data_set_jsp.input_modify_path"/>');//请输入修改路径
					return false;
			}
			return true;
		}else{			
			alert('<b:message key="relative_data_set_jsp.set_condition"/>');//流程实例只有处于“运行状态”或“未启动状态”时才可以设置相关数据
			return false;
		}
	}
	
	
	/*提交执行动作*/
	function doSubmit(){	
		if(validate()){
		 doCheck();
		}
		else{			
			return false;
		}
	}
	
	function doLoad(){
		var flag = '<b:write property="errorFlag"/>';
		if(flag == 'true')
			alert("<b:message key="relative_data_set_jsp.xpath"/>");//请使用正确的xpath语法进行相关数据的设置!
	}
</script>
</head>
<body onLoad="doLoad();" bgcolor="#D8EAEC" leftmargin="0" rightmargin="0" bottommargin="0"
	marginheight="0" marginwidth="0" topmargin="0"  >
<h:errorMessage  />
<form name="saveRelativeData" method="post"	 action="" >
<h:hidden name="processInstID"	property="processInstID" />		
<table width="100%"  border="0" cellpadding="0"
	cellspacing="0" align="center" >
	<!--	<tr>
		<td height="19" colspan="4" class="EOS_panel_head">相关数据显示区</td>
	</tr>-->
	<tr valign="top">
		<%--<td colspan="4">&nbsp;</td> --%>
	<script type="text/javascript">
	var xmlStr = '<%=relativeDataXml %>';
	var xslFileStr ='<%=request.getContextPath() %>/workflow/wfmanager/instance/style.xsl';
	 if (window.ActiveXObject) { // 支持IE浏览器  
		  //装载数据
		  var source = new ActiveXObject("Msxml2.DOMDocument");
		  source.async = false; 
		  source.loadXML(xmlStr);
		
		  // 装载样式单
		  var stylesheet = new ActiveXObject("Msxml2.DOMDocument");
		  stylesheet.async = false;
		  stylesheet.resolveExternals = false;
		  stylesheet.load(xslFileStr);
		 
		  // 创建结果对象
		  var result = new ActiveXObject("Msxml2.DOMDocument");
		  result.async = false;
		
		  // 把解析结果放到结果对象中方法1
		  source.transformNodeToObject(stylesheet, result);
		  //alert(result.xml)
		  
		  // 把解析结果放到结果对象中方法2
		  result2 = "";
		  result2 = source.transformNode(stylesheet);
		  source.loadXML(result2);
		  document.write("<textarea name=\"textfield\" rows=\"14\" cols=\"80\" style=\"overflow:auto;background-color:white;\"  readonly>");
		  document.write("    " + source.xml);
		  document.write("</textarea>");
	}else if(document.implementation && document.implementation.createDocument) { // 支持Mozilla浏览器  		
		  var xmlDoc = document.implementation.createDocument("", "", null);   
		  //var xslDoc = document.implementation.createDocument("", "", null);  
		  
		  var dp = new DOMParser();  
		  var xmlDOM = dp.parseFromString(xmlStr, "text/xml");  
		  //xslDoc.async = false; 
		  //xslDoc.load(xslFileStr);
		  // Modified by yangzhou at 2013.6.28 使用XMLHttpRequest代替xslDoc.load()，以兼容Chrome
		  var xmlhttp = new window.XMLHttpRequest();
		  xmlhttp.open("GET",xslFileStr,false);
		  xmlhttp.send(null);
		  var xslDoc = xmlhttp.responseXML.documentElement;
		  
		  // 定义XSLTProcessor对象
		  var xsltProcessor = new XSLTProcessor(); 
		  xsltProcessor.importStylesheet(xslDoc);  
		  // transformToDocument方式  
		  var result = xsltProcessor.transformToDocument(xmlDOM);  
		  var oXmlSerializer = new XMLSerializer();  
		
		  document.write("<textarea name=\"textfield\" rows=\"12\" cols=\"80\" style=\"overflow:auto;background-color:white;\"  readonly>");
		  document.write("    " + oXmlSerializer.serializeToString(result));
		  document.write("</textarea>");
	
	}
	</script><%--</td>--%>
	</tr>
	<tr valign="top">
	  <td>&nbsp;<b:message key="relative_data_set_jsp.modify_path"/><%-- 修改路径: --%>
      <input name="keyPath" class="textbox" value="" type="text" >	 
	  &nbsp;<b:message key="relative_data_set_jsp.modify_value"/><%-- 修改值: --%>
      <input type="text" name="keyValue" value="" class="textbox">
      &nbsp;<input type="button" name="btSave" value="<b:message key="relative_data_set_jsp.submit_save"/>" class="button"  onClick="doSubmit()"><%-- 提交保存 --%>
      </td>
	</tr>
</table>
</form>
</body>
</html>
