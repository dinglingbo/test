<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<%@ page language="java" import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.IMUODataContext,com.eos.data.datacontext.UserObject,com.eos.data.datacontext.DataContextManager,commonj.sdo.DataObject"%>
<%@page import="java.util.HashMap,java.util.Map,com.hs.common.Env,com.hs.common.Utils,java.util.List"%>
<%@ taglib uri="http://eos.primeton.com/tags/html" prefix="h"%>
<%@ taglib uri="http://eos.primeton.com/tags/logic" prefix="l"%>
<%@ taglib uri="http://eos.primeton.com/tags/bean" prefix="b"%>
<%@ taglib uri="http://eos.primeton.com/tags/eos" prefix="e"%>

<%
	//应用地址 
	String contextPath=request.getContextPath();
	//api地址
//String apiPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort(); 
	//web地址
// 	String webPath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();  
	String apiPath = "";
	String webPath = "";
    //Web域 访问其他Web域使用：xxDomain + 页面路径
	String sysDomain = Env.getContributionConfig("system", "url", "webDomain", "SYS");
    String partDomain = Env.getContributionConfig("system", "url", "webDomain", "PART");
    String repairDomain = Env.getContributionConfig("system", "url", "webDomain", "REPAIR");
    String cloudPartDomain = Env.getContributionConfig("system", "url", "webDomain", "CLOUDPART");
    String crmDomain = Env.getContributionConfig("system", "url", "webDomain", "CRM");
    String frmDomain = Env.getContributionConfig("system", "url", "webDomain", "FRM");
    String wechatDomain = Env.getContributionConfig("system", "url", "webDomain", "WECHAT");
    
    //API域 访问其他API域使用：xxApi + API路径
	String sysApi = Env.getContributionConfig("system", "url", "apiDomain", "SYS");
    String partApi = Env.getContributionConfig("system", "url", "apiDomain", "PART");
    String repairApi = Env.getContributionConfig("system", "url", "apiDomain", "REPAIR");
    String cloudPartApi = Env.getContributionConfig("system", "url", "apiDomain", "CLOUDPART");
    String crmApi = Env.getContributionConfig("system", "url", "apiDomain", "CRM");
    String frmApi = Env.getContributionConfig("system", "url", "apiDomain", "FRM");
    String wechatApi = Env.getContributionConfig("system", "url", "apiDomain", "WECHAT");
	String saleApi = Env.getContributionConfig("system", "url", "apiDomain", "SALES");
	//暂不考虑前后端部署到不同服务器
	//String serverType = Env.getContributionConfig("system", "url", "api", "serverType");
	//apiPath = Env.getContributionConfig("system", "url", "api", serverType);
	
	//serverType = Env.getContributionConfig("system", "url", "web", "serverType");
	//webPath = Env.getContributionConfig("system", "url", "web", serverType);
	
	
	Cookie cookie = new Cookie("miniuiSkin", "bootstrap");
	// 设置Cookie的生命周期,如果设置为负值的话,关闭浏览器就失效.
	cookie.setMaxAge(-1);
	response.addCookie(cookie);
    String currentLanguage = request.getLocale().getLanguage().toLowerCase();
%>
<!-- 汽配需要 -->
<!-- <meta http-equiv="refresh"content="13680"/> -->
<script src="<%=contextPath%>/common/nui/nui.js?v=1.0.0" type="text/javascript"></script> 

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
    var wechatDomain   = "<%=wechatDomain%>";
    
    var sysApi   = "<%=sysApi%>";
    var partApi   = "<%=partApi%>";
    var repairApi   = "<%=repairApi%>";
    var cloudPartApi   = "<%=cloudPartApi%>";
    var crmApi   = "<%=crmApi%>";
    var frmApi   = "<%=frmApi%>";
    var wechatApi   = "<%=wechatApi%>";
	var saleApi   = "<%=saleApi%>";
	
	$(function(){
		nui.context='<%=contextPath %>';
		nui.parse();

	})
    
    <%
	HttpSession session = request.getSession(false);
    String orgId="";
    String orgName="";
    String loginName = "";
    String userId="";
	String userName="";
    String userRealName="";
    String token="";
    String tenantId = "default";
    String compType = "";
    String compAddress = "";
    String compTel = ""; 
    String compLogoPath = "";
    String isMaster = "";
    String empId = "";
    String empTel = "";
    String bankName = "";
    String bankAccountNumber = "";
    String slogan1 = "";
    String slogan2 = "";
    String imCode = "";
    String imDisabled = "";
    String isReadSysmsg = "";
	Map attr=new HashMap();
	Object billParamsObj = null;
	Map billParams = new HashMap();
	String repairBillQrcodeFlag = "0";
	String repairBillCmodelFlag = "0";
	String repairSettorderPrintShow = "";
	String repairSettPrintContent = "";
	String repairEntrustPrintContent = "";
	String repairPchsRtnFlag = "1";
	String repairDefaultStore = "";
	String repairBillMobileFlag = "0";
	String isJobItemShowPart = "0";
	String repairStoreControlFlag = "0";
	String isOpenElectronics = "0";
	String isCanSettle = "";
	String isCanfreeCarnovin = "";
	String orgs = "";
	String systemImg = "";
	String systemName = "";
	//车牌默认前缀
	String systemCarNoPrefix = "";
	//派工是否默认开启APP提醒
	String isOpenAppRemind = "0";
	//派工是否默认开启微信提醒
	String isOpenWeChatRemind = "0";	
	//是否开启报价提醒
	String isOpenOfferRemind = "0";
	//结算打印单路径
	String repairSettPrintUrl = "";	
	
	String source = "";
	String orgJsonStr = "";
	String isCanBelowCost="";
	String swithBatchFlag ="";
	String srmUserId = "";
	String cloudSellOrderPrintContent ="";
	String isNeedNewLine = "";
	String isOpenCredit = "";
	String isOpenApp = "";
	String isOnlySeeOwn ="";
	String isBanSeePrice ="";
	String isSalesman = "";
	String isCommission = "";
	//仓先生公司ID
	String agencyId = "";
	
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
				         
                if(attr.get("token") != null){
                	token = attr.get("token").toString();
                }
                if(attr.get("loginName") != null){
                	loginName = attr.get("loginName").toString();
                }
                if(attr.get("noOrgId") != null){
                	noOrgId = attr.get("noOrgId").toString();
                }
                if(attr.get("tenantId") != null){
                	tenantId = attr.get("tenantId").toString();
                }
                if(attr.get("isMaster") != null){
                	isMaster = attr.get("isMaster").toString();
                }
                if(attr.get("empId") != null){
                	empId = attr.get("empId").toString();
                }
                if(attr.get("empTel") != null){
                	empTel = attr.get("empTel").toString();
                }
                if(attr.get("compType") != null){
                	compType = attr.get("compType").toString();
                }
                if(attr.get("compAddress") != null){
                	compAddress = attr.get("compAddress").toString();
                }
                if(attr.get("compTel") != null){
                	compTel = attr.get("compTel").toString();
                }
                if(attr.get("compLogoPath") != null){
                	compLogoPath = attr.get("compLogoPath").toString();
                }
                if(attr.get("bankName") != null){
                	bankName = attr.get("bankName").toString();
                }
                if(attr.get("bankAccountNumber") != null){
                	bankAccountNumber = attr.get("bankAccountNumber").toString();
                }
                if(attr.get("slogan1") != null){
                	slogan1 = attr.get("slogan1").toString();
                }
                if(attr.get("slogan2") != null){
                	slogan2 = attr.get("slogan2").toString();
                }
                if(attr.get("isCanSettle") != null){
                	isCanSettle = attr.get("isCanSettle").toString();
                }
                if(attr.get("isCanfreeCarnovin") != null){
                	isCanfreeCarnovin = attr.get("isCanfreeCarnovin").toString();
                }
                if(attr.get("isCanBelowCost") != null){
                	isCanBelowCost = attr.get("isCanBelowCost").toString();
                }
                if(attr.get("orgs") != null){
                	orgs = attr.get("orgs").toString();
                }
                if(attr.get("systemImg") != null){
                	systemImg = attr.get("systemImg").toString();
                }
                if(attr.get("systemName") != null){
                	systemName = attr.get("systemName").toString();
                }
                 if(attr.get("systemCarNoPrefix") != null){
                	systemCarNoPrefix = attr.get("systemCarNoPrefix").toString();
                }  
                if(attr.get("isOpenAppRemind") != null){
                	isOpenAppRemind = attr.get("isOpenAppRemind").toString();
                }  
                if(attr.get("isOpenWeChatRemind") != null){
                	isOpenWeChatRemind = attr.get("isOpenWeChatRemind").toString();
                }  
                if(attr.get("isOpenOfferRemind") != null){
                	isOpenOfferRemind = attr.get("isOpenOfferRemind").toString();
                }           
                if(attr.get("source") != null){
                	source = attr.get("source").toString();
                }
                if(attr.get("orgJsonStr") != null){
                	orgJsonStr = attr.get("orgJsonStr").toString();
                }
                if(attr.get("srmUserId") != null){
                	srmUserId = attr.get("srmUserId").toString();
                }
                if(attr.get("imCode") != null){
                	imCode = attr.get("imCode").toString();
                }
                if(attr.get("imDisabled") != null){
                	imDisabled = attr.get("imDisabled").toString();
                }
                if(attr.get("isReadSysmsg") != null){
                	isReadSysmsg = attr.get("isReadSysmsg").toString();
                }
                if(attr.get("agencyId") != null){
                	agencyId = attr.get("agencyId").toString();
                }
                if(attr.get("isSalesman") != null){
                	isSalesman = attr.get("isSalesman").toString();
                }
                
                if(attr.get("billParams") != null){
                	billParamsObj = attr.get("billParams");
                	billParams = Utils.obj2Map(billParamsObj);
                	
	                if(billParams.get("repairBillQrcodeFlag") != null){
	                	repairBillQrcodeFlag = billParams.get("repairBillQrcodeFlag").toString();
	                }
	                if(billParams.get("repairBillCmodelFlag") != null){
	                	repairBillCmodelFlag = billParams.get("repairBillCmodelFlag").toString();
	                }
	                if(billParams.get("repairSettorderPrintShow") != null){
	                	repairSettorderPrintShow = billParams.get("repairSettorderPrintShow").toString();
	                }
	                if(billParams.get("repairSettPrintContent") != null){
	                	repairSettPrintContent = billParams.get("repairSettPrintContent").toString();
	                	repairSettPrintContent = repairSettPrintContent.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	                }
	                if(billParams.get("repairEntrustPrintContent") != null){
	                	repairEntrustPrintContent = billParams.get("repairEntrustPrintContent").toString();
	                	repairEntrustPrintContent = repairEntrustPrintContent.replaceAll("(\r\n|\r|\n|\n\r)", "<br>");
	                }
	                if(billParams.get("repairPchsRtnFlag") != null){
	                	repairPchsRtnFlag = billParams.get("repairPchsRtnFlag").toString();
	                }
	                if(billParams.get("repairDefaultStore") != null){
	                	repairDefaultStore = billParams.get("repairDefaultStore").toString();
	                }
	                if(billParams.get("swithBatchFlag") != null){
	                	swithBatchFlag = billParams.get("swithBatchFlag").toString();
	                }
	                if(billParams.get("repairBillMobileFlag") != null){
	                	repairBillMobileFlag = billParams.get("repairBillMobileFlag").toString();
	                }
	                //派工单是否打印配件
	               if(billParams.get("isJobItemShowPart") != null){
	                	isJobItemShowPart = billParams.get("isJobItemShowPart").toString();
	                }     
	                if(billParams.get("repairStoreControlFlag") != null){
	                	repairStoreControlFlag = billParams.get("repairStoreControlFlag").toString();
	                }
	                //销售单、销售出库打印内容
                    if(billParams.get("cloudSellOrderPrintContent") != null){
	                	cloudSellOrderPrintContent = billParams.get("cloudSellOrderPrintContent").toString();
	                }
	                //打印单是否换行
	                if(billParams.get("isNeedNewLine") != null){
	                	isNeedNewLine = billParams.get("isNeedNewLine").toString();
	                }
	                //是否开启信誉额度管理
	                if(billParams.get("isOpenCredit") != null){
	                	isOpenCredit = billParams.get("isOpenCredit").toString();
	                }
	                //是否开启APP
	                if(billParams.get("isOpenApp") != null){
	                	isOpenApp = billParams.get("isOpenApp").toString();
	                }
	                //业务员是否只可见自己的客户和订单
	                if(billParams.get("isOnlySeeOwn") != null){
	                	isOnlySeeOwn = billParams.get("isOnlySeeOwn").toString();
	                }
	                //业务员是否可见采购价
	                if(billParams.get("isBanSeePrice") != null){
	                	isBanSeePrice = billParams.get("isBanSeePrice").toString();
	                }
	                if(billParams.get("isOpenElectronics") != null){
	                	isOpenElectronics = billParams.get("isOpenElectronics").toString();
	                }
	                //是否开启分级提成
	                if(billParams.get("isCommission") != null){
	                	isCommission = billParams.get("isCommission").toString();
	                }
	                //结算单打印界面
	                if(billParams.get("repairSettPrintUrl") != null){
	                	repairSettPrintUrl = billParams.get("repairSettPrintUrl").toString();
	                }
	                
                }
              
                
			} catch (Exception e) {
				e.printStackTrace();
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
	var currOrgid = "<%=orgId %>";
    var currOrgName = "<%=orgName %>";
    var currLoginName = "<%=loginName %>";
    var currUserId = "<%=userId %>";
	var currUserName = "<%=userName %>";
    var currUserRealName = "<%=userRealName %>";
    var currTenantId = "<%=tenantId %>";
    var currCompType = "<%=compType %>";
    var currIsMaster = "<%=isMaster %>";
    var currEmpId = "<%=empId %>";
    var currEmpTel = "<%=empTel %>";
    var token = "<%=token %>";
    var currImCode = "<%=imCode %>";
    var currImDisabled = "<%=imDisabled %>";
    var currIsReadSysmsg = "<%=isReadSysmsg %>";
    var currCompAddress = "<%=compAddress %>";
    var currCompTel = "<%=compTel %>";
    var currCompLogoPath = "<%=compLogoPath %>";
    var currBankName = "<%=bankName %>";
    var currSlogan1 = "<%=slogan1 %>";
    var currSlogan2 = "<%=slogan2 %>";
    var currBankName = "<%=bankName %>";
    var currBankAccountNumber = "<%=bankAccountNumber %>";
    var currRepairBillQrcodeFlag = "<%=repairBillQrcodeFlag %>";
	var currRepairBillCmodelFlag = "<%=repairBillCmodelFlag %>";
	var currRepairSettorderPrintShow = "<%=repairSettorderPrintShow %>";
	var currRepairSettPrintContent = "<%=repairSettPrintContent %>";
	var currRepairEntrustPrintContent = "<%=repairEntrustPrintContent %>";
	var currRepairPchsRtnFlag = "<%=repairPchsRtnFlag %>";
	var currRepairDefaultStore = "<%=repairDefaultStore %>";
	var currRepairBillMobileFlag = "<%=repairBillMobileFlag %>";
	var currIsJobItemShowPart = "<%=isJobItemShowPart%>";
	var currRepairStoreControlFlag = "<%=repairStoreControlFlag %>";
	var currIsOpenElectronics = "<%=isOpenElectronics %>";
	var currIsCanSettle = "<%=isCanSettle %>";
	var currIsCanfreeCarnovin = "<%=isCanfreeCarnovin %>";
	var currIsCanBelowCost ="<%=isCanBelowCost %>";
	var currSwithBatchFlag ="<%=swithBatchFlag %>";
	var currOrgs = "<%=orgs %>";
	var currSystemImg = "<%=systemImg %>";
	var currSystemName = "<%=systemName %>";
	var currSystemCarNoPrefix = "<%=systemCarNoPrefix %>";
	var currIsOpenAppRemind = "<%=isOpenAppRemind %>";
	var currIsOpenWeChatRemind = "<%=isOpenWeChatRemind %>";
	var currIsOpenOfferRemind = "<%=isOpenOfferRemind %>";
	var currSource = "<%=source %>";
	currOrgs = currOrgs.replace(/\*/g,"");
	var currOrgJsonStr = "<%=orgJsonStr %>";
	currOrgJsonStr = currOrgJsonStr.replace(/'/g,'"');
	var currOrgList = JSON.parse(currOrgJsonStr);
	var currSrmUserId = "<%=srmUserId %>";
	var currCloudSellOrderPrintContent = "<%=cloudSellOrderPrintContent %>";
	var currIsNeedNewLine = "<%=isNeedNewLine %>";
	var currIsOpenCredit ="<%=isOpenCredit %>";
	var currIsOpenApp ="<%=isOpenApp%>";
	var currIsOnlySeeOwn ="<%=isOnlySeeOwn%>";
	var currIsBanSeePrice ="<%=isBanSeePrice%>";
	var currAgencyId ="<%=agencyId %>";
	var currIsSalesman = "<%=isSalesman %>";
	var currIsCommission ="<%=isCommission %>";
	var currRepairSettPrintUrl ="<%=repairSettPrintUrl %>";
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
	
	//禁止拖拽
	document.ondragstart = function() {
	    return false;
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
		
		
		if(window.parent!=window && ("function"==typeof window.parent.backToLogin)){//判断是否有父页面，有则调用父页面的方法		
			window.parent.backToLogin();
		}
		//汽修 
		else{   
		   showMsg("登录超时，正在跳转！", "E");
		   if(currSource=="easy"){
		 		window.top.location.href = sysDomain + "/coframe/auth/easy/login.jsp";
			}else if(currSource=="waveBox"){
		 		window.top.location.href = sysDomain + "/coframe/auth/waveBox/login.jsp";
			}else{
			   window.top.location.href = sysDomain + "/coframe/auth/login/login.jsp";
			}
		
 		}
	// 汽配
// 		 else{
// 			debugger;
// 			showMsg("登录超时，正在跳转！", "E");
//           window.top.location.href = sysDomain + "/coframe/auth/loginCloud/login.jsp";			
// 		} 
		
 		
	}

</script>
<script src="<%=webPath + contextPath%>/common/js/sysCommon.js?v=1.2.0" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/constantDef.js?v=1.2" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/init.js?v=1.9.4" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/jsCryptoJS.js?v=1.0" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/settleCenter.js?v=1.1" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/date.js?v=1.9" type="text/javascript"></script>
<script src="<%=webPath + contextPath%>/common/js/clipboard.min.js?v=1.7" type="text/javascript"></script>
<link href="<%=webPath + contextPath%>/common/nui/themes/cupertino/skin.css" rel="stylesheet"	type="text/css" />
<%--  <link href="<%=webPath + contextPath%>/common/nui/themes/bootstrap/skin.css" rel="stylesheet"	type="text/css" />   --%>
<link href="<%=webPath + contextPath%>/common/nui/res/fonts/font-awesome/css/font-awesome.min.css" type="text/css" rel="stylesheet"/>
<%@include file="./sysNotice.jsp" %>
<style type="text/css">
    html, body
    {
        font-size:12px;
        padding:0;
        margin:0;
        border:0;
        height:100%;
        /* white-space: nowrap; */
        /**overflow:hidden;**/
    }
    
    
</style>

