<%@page pageEncoding="UTF-8"%>
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<%
String needInstallFlash10 = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_dg_jsp.need_install_flash10");
String getFlash = ResourcesMessageUtil.getI18nResourceMessage("biz_process_custom_dg_jsp.get_flash");
String calendarDetail = ResourcesMessageUtil.getI18nResourceMessage("biz_calendar_editor_jsp.calendar_detail");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript" src="swfobject.js"></script>
<script type="text/javascript" src="AC_OETags.js"></script>

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
		flashvars.locale = getQueryStr("locale");
		flashvars.calendarID = getQueryStr("calendarUUID");
		flashvars.server = getServerStr();
		flashvars.port = '<%=request.getLocalPort() %>';
		flashvars.webcontext = '<%=request.getContextPath() %>';
		
		var params = {};
		params.allowscriptaccess = "always";
		params.menu = "false";
		  
		var attributes = {};
		attributes.id = "calendar";
		
		var hasReqestedVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
		
		if (hasReqestedVersion) {
			swfobject.embedSWF("calendar.swf", "myContent", "100%", "100%", "9.0.0", "expressInstall.swf",flashvars,params,attributes);
		}else{
			var alternateContent = '<%=needInstallFlash10%>';
			
			if(window.ActiveXObject){
				alternateContent += '<a href=DownloadFlp.jsp?fileName=install_flash_player_ax.exe><%=getFlash%></a>';
			}else{
				alternateContent += '<a href=DownloadFlp.jsp?fileName=install_flash_player.exe><%=getFlash%></a>';
			}
			document.write(alternateContent);  // insert non-flash content
		}
		

</script>
<title><%=calendarDetail%></title>
<link rel="shortcut icon" href="<%=request.getContextPath()%>/favicon.ico" type="image/x-icon">
</head>
<body scroll="no">
<div id="myContent"></body>
</html>
