<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ page language="java" import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.IMUODataContext,com.eos.data.datacontext.UserObject,com.eos.data.datacontext.DataContextManager,commonj.sdo.DataObject"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env"%>
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>

<%
	//应用地址
	String contextPath=request.getContextPath();
	//api地址
	String apiPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort(); 
	//web地址
	String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();  
	
    //Web域 访问其他Web域使用：xxDomain + 页面路径
	String sysDomain = Env.getContributionConfig("system", "url", "webDomain", "SYS");
    String partDomain = Env.getContributionConfig("system", "url", "webDomain", "PART");
    String repairDomain = Env.getContributionConfig("system", "url", "webDomain", "REPAIR");
    String cloudPartDomain = Env.getContributionConfig("system", "url", "webDomain", "CLOUDPART");
    String crmDomain = Env.getContributionConfig("system", "url", "webDomain", "CRM");
    String frmDomain = Env.getContributionConfig("system", "url", "webDomain", "FRM");
    
    //API域 访问其他API域使用：xxApi + API路径
	String sysApi = Env.getContributionConfig("system", "url", "apiDomain", "SYS");
    String partApi = Env.getContributionConfig("system", "url", "apiDomain", "PART");
    String repairApi = Env.getContributionConfig("system", "url", "apiDomain", "REPAIR");
    String cloudPartApi = Env.getContributionConfig("system", "url", "apiDomain", "CLOUDPART");
    String crmApi = Env.getContributionConfig("system", "url", "apiDomain", "CRM");
    String frmApi = Env.getContributionConfig("system", "url", "apiDomain", "FRM");
	
	String serverType = Env.getContributionConfig("system", "url", "api", "serverType");
	apiPath = Env.getContributionConfig("system", "url", "api", serverType);
	
	serverType = Env.getContributionConfig("system", "url", "web", "serverType");
	webPath = Env.getContributionConfig("system", "url", "web", serverType);
	
	
	Cookie cookie = new Cookie("miniuiSkin", "bootstrap");
	// 设置Cookie的生命周期,如果设置为负值的话,关闭浏览器就失效.
	cookie.setMaxAge(-1);
	response.addCookie(cookie);
    String currentLanguage = request.getLocale().getLanguage().toLowerCase();
%>

<script src="<%=contextPath%>/common/nui/nui.js" type="text/javascript"></script>
<script src="<%=contextPath%>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
<script type="text/javascript">
	var contextPath = "<%=contextPath%>";
	var apiPath		= "<%=apiPath%>";
	var webPath		= "<%=webPath%>";
	
    var sysDomain   = "<%=sysDomain%>";
    var partDomain   = "<%=partDomain%>";
    var repairDomain   = "<%=repairDomain%>";
    var cloudPartDomain   = "<%=cloudPartDomain%>";
    var crmDomain   = "<%=crmDomain%>";
    var frmDomain   = "<%=frmDomain%>";
    
    var sysApi   = "<%=sysApi%>";
    var partApi   = "<%=partApi%>";
    var repairApi   = "<%=repairApi%>";
    var cloudPartApi   = "<%=cloudPartApi%>";
    var crmApi   = "<%=crmApi%>";
    var frmApi   = "<%=frmApi%>";
	
	$(function(){
		nui.context='<%=contextPath %>'
	})
    
    <%
	HttpSession session = request.getSession(false);
    String orgId="";
    String orgName="";
    String userId="";
	String userName="";
    String userRealName="";
    String token="";
    String tenantId = "default";
    String compType = "";
    String isMaster = "";
    String empId = "";
	Map attr=new HashMap();
	if (session == null || session.getAttribute("userObject") == null) {
		%>backToLogin();<%
	}else{
		IUserObject u = (IUserObject) session.getAttribute("userObject");		
		if (u != null) {
            orgId = u.getUserOrgId();
            orgName = u.getUserOrgName();
            userId = u.getUserId();
            userName = u.getUserName();
            userRealName = u.getUserRealName();
            
			String noOrgId = "N";
			
            try {
				attr = u.getAttributes();
				token = attr.get("token").toString();
                noOrgId = session.getAttribute("noOrgId").toString();
                tenantId = attr.get("tenantId").toString();
                isMaster = attr.get("isMaster").toString();
                empId = attr.get("empId").toString();
                compType = attr.get("compType").toString();
			} catch (Exception e) {
			}
            
            if(token==null || token.trim().length()==0){
                token= request.getParameter("token");
                if(!"214e2f71-4237-4601-9a1a-538bf982b995".equals(token)){
                    %>backToLogin();<%
                }
            }
            
			if (orgId==null || orgId.trim().length()==0) {
                if(noOrgId==null || noOrgId.equals("N")){
                    %>//alert("未能获取用户orgId属性，功能无法正常使用!");//backToLogin();
                    <%
                }
                session.setAttribute("noOrgId", "Y");
			}else{
                session.setAttribute("noOrgId", "N");
            }
		}
	}
    %>	

	var currOrgId = "<%=orgId %>";
    var currOrgName = "<%=orgName %>";
    var currUserId = "<%=userId %>";
	var currUserName = "<%=userName %>";
    var currUserRealName = "<%=userRealName %>";
    var currTenantId = "<%=tenantId %>";
    var currCompType = "<%=compType %>";
    var currIsMaster = "<%=isMaster %>";
    var currEmpId = "<%=empId %>";
    var token = "<%=token %>";
    //alert("token=" + token);
    
    /* var _sysMsg_;
	//提示成功信息	
	function showMsgBox(message, life) {
		var time = 3000;
		if (life) {
			time = life;
		}
		
		_sysMsg_ = message;
        $("#_sys_tip_msg_").remove();
        
        if ($("#_sys_tip_msg_").text().length > 0) {
	    	var msg = "<span>" + message + "</span>";
	        $("#_sys_tip_msg_").empty().append(msg);
	    } else {
			var msg = "<div id='_sys_tip_msg_'><span>" + message + "</span></div>";
			$("body").append(msg);
	    }
		
		//$("#_sys_tip_msg_").fadeIn(1000);
  
		setTimeout($("#_sys_tip_msg_").stop().delay(1000).fadeOut(time), time);
	};
	
	//提示错误信息
	function showMsg(message, msgType) {
		showMsgBox(message, 2000);
        if(msgType){
            $("#_sys_tip_msg_ span").addClass(msgType);
        }
        if((""+message).length < 36){
            $("#_sys_tip_msg_ span").addClass("small");
        }
	};
    
    function showError(message) {
		showMsg(message, "E");
	};
    
    function showWarn(message) {
		showMsg(message, "W");
	}; */
	
	var _sysMsg_;
	//提示成功信息	
	function showMsgBox(message, life) {
		parent.showMsgBox_index(message, life);
	};
	
	//提示错误信息
	function showMsg(message, msgType) {
		parent.showIndexMsg(message, msgType);
	};
    
    function showError(message) {
		showMsg(message, "E");
	};
    
    function showWarn(message) {
		showMsg(message, "W");
	};
	
	//showMsg("Hello success!"); // 第二个参数life是指消息显示时间
	//showError("Hello error!");
    function backToLogin(){
		var url = window.location.pathname;
		/* for(var i=0;i<excludedFlows.length;i++){
			if(url && ''!=url
				&& -1!=url.lastIndexOf(excludedFlows[i])){//例外的不拦截
				return false;
			}
		} */
		if(window.parent!=window
			&& ("function"==typeof window.parent.backToLogin)){//判断是否有父页面，有则调用父页面的方法		
			window.parent.backToLogin();
		}else{
		//	debugger;
			showMsg("登录超时，正在跳转！", "E");
            window.top.location.href = sysDomain + "/coframe/auth/login/login.jsp";			
		}
	}

		
</script>
<script src="<%=webPath + contextPath%>/common/js/sysCommon.js?v=1.0.3" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/constantDef.js?v=1.1" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/init.js?v=1.8" type="text/javascript"></script>
