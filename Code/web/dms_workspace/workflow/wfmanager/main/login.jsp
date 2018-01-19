<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ include file = "/workflow/wfmanager/common/common.jsp"%>
<html>
	<head>
	<title><b:message key="login_jsp.title"/></title><!-- BPS管理监控端登录 -->
	<script type="text/javascript">
	    function focusUserName(){
			$name('user/userName').focus();
		} 
		function doSubmit(){
		//FIXME:document.getElementById --> $id
			var temp = $id('user/userName').value;
		 	if(trim(temp)==''){
		 		alert("<b:message key="login_jsp.enterUserID"/>")<!-- 请输入用户ID! -->
		 		return false;
		 	}
		 		
		}
		
		function popUpMessage(str)
		{
		    var bodyHeight = document.body.offsetHeight;
		    var bodyWidth = document.body.offsetWidth- 26;
		    var fImg = "<%=request.getContextPath() %>/workflow/wfmanager/images/error.gif";
		    var fFontColor = "#FF0000";
		
		    s = "<table bgcolor=#808080 border=0 cellpadding=0 cellspacing=1><tr><td>" +
		    	"<table cellSpacing=0 cellPadding=0 width="+ bodyWidth + " height=60 bgcolor=#EEEEEE border=0>" +
		    		"<tr><td>&nbsp;&nbsp;<img height=16 width=16 src="+ fImg +
		    		"><strong>消息</strong></td></tr><tr><td class=info>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="+ fFontColor +">" + str + "</font></td></tr></table></td></tr></table>";    
		    document.all["detail"].innerHTML = s;
		    var dStyle = $id("detail").style;
		    dStyle.left = document.body.scrollLeft + 3;
		    dStyle.top = document.body.scrollTop + bodyHeight - 68;
		    dStyle.width = 140;
		    dStyle.visibility = "visible";
		}
		
	</script>
	</head>
	<body topmargin="0" leftmargin="0" rightmargin="0" marginwidth="0" onload="focusUserName()">
	
	<table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
	  <tr height="50">
	    <td valign="top">
	      <table width="100%" border=0 align="left" cellpadding="0" cellspacing="0">
	        <tr>
	          <td width="772" height="50"><img src="<%=request.getContextPath() %>/workflow/wfcomponent/web/images/index/BPS6.0-Bar.jpg"></td>
	          <td style="background:#016F88;border-bottom:1px solid #fff;">&nbsp;</td>
	        </tr>
	      </table>
	     </td>
	  </tr>
	  <tr style="background:url(<%=request.getContextPath() %>/workflow/wfcomponent/web/images/index/BPSBg.jpg);background-repeat:repeat-x;">
	    <td height="105" align="center" valign="top">&nbsp;</td>
	  </tr>
	  <tr>
	    <td align="center" valign="top" style="background:#76BAC5;">
	      <table width="491" height="424" border="0" cellpadding="0" cellspacing="0" background="../images/BPSManagerLogin.jpg">
	        <tr>
	          <td align="center" valign="middle">
			  <form name="userlogin" 	action="com.primeton.workflow.manager.UserLogin.flow?_eosFlowAction=loginAction" onsubmit="return doSubmit();" method="post">
	            <table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">
	              
	              <tr>
	                <td colspan="2">&nbsp;</td>
	              </tr>
	              <tr>
	                <td width="28%">&nbsp;</td>
	                <td width="72%">&nbsp;</td>
	              </tr>
	              
	              <tr>
	                <td align="right"><b:message key="login_jsp.userName"/></td><!-- 用户名: -->
	                <td align="left">
	                  <input type="text" name="user/userName" class="textbox" style="width:200px" size="30"/>
	                </td>
	              </tr>
	              <tr>
	                <td align="right"><b:message key="login_jsp.password"/></td><!-- 密&nbsp;码: -->
	                <td align="left">
	                  <input type="password" name="password" class="textbox" style="width:200px" size="30"/>
	                  &nbsp;&nbsp;&nbsp;<input type="submit" name="Submit" value="<b:message key="login_jsp.login"/>" class="button"/><!-- 登录 -->
	                  <input type="hidden" name="loginPage" value="/workflow/wfmanager/main/login.jsp">
	                </td>
	              </tr>
	              <tr><td align="center" colspan="2">&nbsp;</td></tr>
	            </table>
				</form>
	          </td>
	        </tr>
	      </table>
	    </td>
	  </tr>
	  <tr height="27">
	    <td>
	    <div id="detail" style="z-index: 3; position: absolute;float: left"></div>    
	    <table height="27" cellSpacing=0 cellPadding=0 width="100%" border=0>
	        <tr>
	          <td  vAlign=top align=left background="<%=request.getContextPath()%>/workflow/wfcomponent/web/images/index/BottomBg.jpg"><table height="100%" cellSpacing=0 cellPadding=0 width="100%" border=0>
	              <tr>
	                <td nowrap="nowrap" align=center valign="middle" height=27><font style="font-size:9pt">Copyright &reg; 2008 Primeton Technologies Ltd.All right reserved.</font> </td>
	              </tr>
	            </table></td>
	        </tr>
	      </table></td>
	  </tr>
	</table>
	<script language="javascript">
	<l:present property="errorMessage">
	
		
		popUpMessage('<b:write property="errorMessage"/>');
	
		</l:present>
	</script>
	</body>
	
</html>