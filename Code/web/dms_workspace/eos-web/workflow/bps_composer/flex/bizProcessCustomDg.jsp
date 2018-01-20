<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String busiProcCust = ResourcesMessageUtil.getI18nResourceMessage("catalog_process_custom_tree_jsp.busi_proc_cust");
String busiProccfg = ResourcesMessageUtil.getI18nResourceMessage("catalog_process_config_tree_jsp.busi_proc_cfg");
String needInstallFlash10 = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_dg_jsp.need_install_flash10");
String noSaveClose = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_dg_jsp.no_save_close");
String getFlash = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_dg_jsp.get_flash");
String loginTip = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_dg_jsp.login_tip");
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="swfobject.js"></script>
<script type="text/javascript" src="AC_OETags.js"></script>
<script type="text/javascript" src="shortcut.js"></script>
<script type="text/javascript">
		
		// Major version of Flash required
		var requiredMajorVersion = 10;
		// Minor version of Flash required
		var requiredMinorVersion = 0;
		// Minor version of Flash required
		var requiredRevision = 0;

		var LocString=String(window.document.location.href);  
       
     	function getQueryStr(str){  
     		var rs = new RegExp("(^|)"+str+"=([^\&]*)(\&|$)","gi").exec(LocString), tmp;  
       			
	 		if(tmp=rs){  
	    	    return tmp[2];  
	        }  
       			
         	// parameter cannot be found  
        	return "";  
	    }  
	    
	    function getServerStr(){
	    	var index1 = LocString.indexOf("//");
	    	var index2 = LocString.indexOf("/",index1+2);
	    	
	    	return LocString.substring(index1+2,index2)
	    }
		
		var flashvars = {};
		flashvars.hasForm = getQueryStr("hasForm");
		flashvars.locale = getQueryStr("locale");
		flashvars.processDefID = getQueryStr("processDefID");
		flashvars.catalogID = getQueryStr("catalogUUID");
		flashvars.editType = getQueryStr("editType");//业务流程配置config;业务流程定制custom
		flashvars.author = getQueryStr("author");
		flashvars.processDefName = getQueryStr("processDefName");
		flashvars.processDefChName = getQueryStr("processDefCHName");
		flashvars.processDesc = getQueryStr("description");
		flashvars.mdfState = getQueryStr("mdfState");
		//flashvars.server = '<%=request.getLocalAddr() %>';
		flashvars.server = getServerStr();
		flashvars.port = '<%=request.getLocalPort() %>';
		flashvars.webcontext = '<%=request.getContextPath() %>';
		if(window.ActiveXObject)
			flashvars.ie = "true";
		else
			flashvars.ie = "false";
		<% 
			Map product = (Map)session.getAttribute("productInfo"); 
			if(product!=null){
		%>
			flashvars.productInfo = '<%=(String)product.get("productName") %>';
			var params = {};
			params.allowscriptaccess = "always";
			params.menu = "false";
			  
			var attributes = {};
			attributes.id = "flowdesigner";
			
			var hasReqestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
			
			if (hasReqestedVersion) {
				swfobject.embedSWF("flowdesigner3.swf", "myContent", "100%", "100%", "9.0.0", "expressInstall.swf",flashvars,params,attributes);
			}else{
				var alternateContent = '<%=needInstallFlash10%>';
				
				if(window.ActiveXObject){
					alternateContent += '<a href=DownloadFlp.jsp?fileName=install_flash_player_ax.exe><%=getFlash%></a>';//获取 Flash Player 10
				}else{
					alternateContent += '<a href=DownloadFlp.jsp?fileName=install_flash_player.exe><%=getFlash%></a>';
				}
	        
				document.write(alternateContent);  // insert non-flash content
			}
		<%}else{ %>
			document.write("<%=loginTip%>");
		<%} %>
		
		
		if(flashvars.editType == "config")
			document.title = "<%=busiProccfg%>";

		function keyDown(event){
			if(window.ActiveXObject) { // 由于IE不响应Flash内部的快捷键，故需要单独处理
				var swfObj=document.getElementById("flowdesigner");
				if(event.ctrlKey){
					if(event.keyCode==67){
						swfObj.sendKeyResult(event.keyCode);
					}else if(event.keyCode==86){
						swfObj.sendKeyResult(event.keyCode);
					}else if(event.keyCode==88){
						swfObj.sendKeyResult(event.keyCode);
					}else if(event.keyCode==89){
						swfObj.sendKeyResult(event.keyCode);
					}else if(event.keyCode==90){
						swfObj.sendKeyResult(event.keyCode);
					}else if(event.keyCode==65){
						swfObj.sendKeyResult(event.keyCode);
					}
				}else{
					if(event.keyCode==67){
						swfObj.sendKeyResult(event.keyCode,false);
					}
				} 
				
				//解决复制粘贴Ctrl+C，必须松开Ctrl，再按Ctrl+V的问题
				//swfObj.focus();
			}
		}
		
		// 屏蔽浏览器内置的快捷键，转换为编辑器定义的快捷键
		if(window.ActiveXObject) { // 由于IE不响应Flash内部的快捷键，故需要单独处理
			shortcut.add("Ctrl+1",
				function(evt) { 
					var swfObj=document.getElementById("flowdesigner");
					swfObj.sendKeyResult(49);
				},
				{'type':'keydown','propagate':false,'target':document}
				);
				
			shortcut.add("Ctrl+2",
				function(evt) { 
					var swfObj=document.getElementById("flowdesigner");
					swfObj.sendKeyResult(50);
				},
				{'type':'keydown','propagate':false,'target':document}
				);
			
			shortcut.add("Ctrl+S",
				function(evt) { 
					var swfObj=document.getElementById("flowdesigner");
					swfObj.sendKeyResult(83);
				},
				{'type':'keydown','propagate':false,'target':document}
				);
			shortcut.add("Ctrl+T",
				function(evt) { 
					var swfObj=document.getElementById("flowdesigner");
					swfObj.sendKeyResult(84);
				},
				{'type':'keydown','propagate':false,'target':document}
				);
		}
		
		function htmlFocus(){
			window.focus();
		}
		function  winBeforeUnload(event){  
			var swfObj=document.getElementById("flowdesigner");
			if(swfObj&&swfObj.isDirty()){
				event.returnValue = "<%=noSaveClose%>"; 
			}
		}
		
		function winUnload(){
			if(opener && typeof(window.opener.document)!='unknown' && typeof(window.opener.document)!='undefined'){
				//alert("close");
    			opener.dealByClose();
			}  
			//alert("not exist");
		}

</script>
<title><%=busiProcCust%></title>
<link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon">
</head>
<body scroll="no" onKeydown="keyDown(event)" style="margin: 1 1 1 1;" onbeforeunload="winBeforeUnload(event)" onUnload="winUnload()">
<div id="myContent" style="top: 0;left:0;margin: 0 0 0 0;"></body>
</html>

