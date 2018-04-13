<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ page language="java" import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.IMUODataContext,com.eos.data.datacontext.UserObject,com.eos.data.datacontext.DataContextManager"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env"%>

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
%>
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>
<% String currentLanguage = request.getLocale().getLanguage().toLowerCase();%>
<style type="text/css">
    html, body
    {
        font-size:12px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        /**overflow:hidden;**/
    }
</style>

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
			alert("登录超时，正在跳转！");
            window.top.location.href = sysDomain + "/coframe/auth/login/login.jsp";			
		}
	}
	<%
	HttpSession session = request.getSession(false);
	String token="";
	Map attr=new HashMap();
	if (session == null || session.getAttribute("userObject") == null) {
		%>alert(123);backToLogin();<%
	}else{
		IUserObject u = (IUserObject) session.getAttribute("userObject");		
		if (u != null) {
			String orgId = u.getUserOrgId();
			String noOrgId = "N";
            try {
				attr = u.getAttributes();
				token = attr.get("token").toString();
                noOrgId = session.getAttribute("noOrgId").toString();
			} catch (Exception e) {
			}
            
            if(token==null || token.trim().length()==0){
                %>backToLogin();<%
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
	
	var token = "<%=token %>";
    //alert("token=" + token);
</script>
<script src="<%=sysDomain%>/common/js/sysCommon.js?v=1.0" type="text/javascript"></script>
<script src="<%=sysDomain%>/common/js/constantDef.js?v=1.0" type="text/javascript"></script>
<script src="<%=sysDomain%>/common/js/init.js?v=1.0" type="text/javascript"></script>