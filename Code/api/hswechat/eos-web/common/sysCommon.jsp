<%@ page language="java" import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.IMUODataContext,com.eos.data.datacontext.UserObject,com.eos.data.datacontext.DataContextManager,commonj.sdo.DataObject"%>
<%@page import="java.util.HashMap,java.util.Map"%>




<script type="text/javascript" src="<%= request.getContextPath() %>/common/nui/nui.js"></script>
 <style type="text/css">
  #_sys_tip_msg_ {
        z-index: 9999;
        position: fixed;
        left: -20;
        top: 190;
        text-align: center;/* right*/        


        
        width: 100%;/**/
    }
     
    #_sys_tip_msg_ span {
        background-color: #03C440;
        /*opacity: .8;*/
        padding: 15px 20px;
        border-radius: 5px;
        text-align: center;
        
        word-wrap:break-word;
        word-break:break-all;
        overflow: hidden;
        width: 180px;
        height: 56px;
        display:inline-block;
        
        color: #fff;
        font-size: 14px;
    }
     
    #_sys_tip_msg_ span.E {
        background-color: #FC4236;
    }
    
    #_sys_tip_msg_ span.W {
        background-color: #FFCE42; /*#FFCE42  EAA000  F8D714**/
    }
    
    #_sys_tip_msg_ span.small {
        height: auto;
    }
 </style>
<link id="css_skin" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/nui/themes/default/miniui.css"/>
<link id="css_skin" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/nui/themes/bootstrap/skin.css"/>
<link id="css_skin" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/nui/themes/cupertino/skin.css"/>
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/common/nui/res/fonts/font-awesome/css/font-awesome.min.css"/>


<%
	String apiPath = "http://127.0.0.1:8080/"; 
	String webPath = "http://127.0.0.1:8080/"; 
	
	String wechatDomain = "default";
	String wechatApi = "default";
	String dms = "dms";
	
	String sysApi = "systemApi";
	String repairApi = "repairApi";
	
	HttpSession sessionss = request.getSession(false);
    String orgId="";
    String orgName="";
    String userId="";
	String userName="";
    String userRealName="";
    String token="";
    String tenantId = "default";
    String compType = "";
    String compAddress = "";
    String compTel = ""; 
    String isMaster = "";
   
    String empId = "";
    String bankName = "";
    String bankAccountNumber = "";
    String slogan1 = "";
    String slogan2 = "";
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
	String isCanSettle = "";
	if (sessionss == null || sessionss.getAttribute("userObject") == null) {
		%>backToLogin();<%
	}else{
		IUserObject u = (IUserObject) sessionss.getAttribute("userObject");	
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
                if(attr.get("compType") != null){
                	compType = attr.get("compType").toString();
                }
                if(attr.get("compAddress") != null){
                	compAddress = attr.get("compAddress").toString();
                }
                if(attr.get("compTel") != null){
                	compTel = attr.get("compTel").toString();
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
                
                if(attr.get("billParams") != null){
                	billParamsObj = attr.get("billParams");
                	
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
                }
              
                
			} catch (Exception e) {
				e.printStackTrace();
			}
            
            if(token==null || token.trim().length()==0){
                token= request.getParameter("token");
                if(!"214e2f71-4237-4601-9a1a-538bf982b995".equals(token)){
                    %><%
                }
            }
            
			if (orgId==null || orgId.trim().length()==0) {
                if(noOrgId==null || noOrgId.equals("N")){
                    %>
                    <%
                }
                sessionss.setAttribute("noOrgId", "Y");
			}else{
                sessionss.setAttribute("noOrgId", "N");
            }
		}
	}
 %>
 <script type="text/javascript">
 	//后台
 	var apiPath="<%=apiPath %>";
 	var wechatApi="<%=wechatApi %>";
 	var sysApi = "<%=sysApi %>";
 	var repairApi = "<%=repairApi %>";
 	var dms = "<%=dms %>";
 	//前端
 	var webPath="<%=webPath %>";
 	var wechatDomain="<%=wechatDomain %>";
 	
 	var token="<%=token %>";
 	
 	
 	
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
	
	 function showIndexMsg(message, msgType) {
        showMsgBox_index(message, 2000);
        if(msgType){
            $("#_sys_tip_msg_ span").addClass(msgType);
        }
        if((""+message).length < 36){
            $("#_sys_tip_msg_ span").addClass("small");
        }
    };
    
    function showIndexError(message) {
        showMsgBox_index(message, "E");
    };
    
    function showIndexWarn(message) {
        showMsgBox_index(message, "W");
    };
    
      function showMsgBox_index(message, life) {
        var time = 3000;
        if (life) {
            time = life;
        }
        
        _sysMsg_index = message;
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
    function showIndexMsg(message, msgType) {
        showMsgBox_index(message, 2000);
        if(msgType){
            $("#_sys_tip_msg_ span").addClass(msgType);
        }
        if((""+message).length < 36){
            $("#_sys_tip_msg_ span").addClass("small");
        }
    };
    
    function showIndexError(message) {
        showMsgBox_index(message, "E");
    };
    
    function showIndexWarn(message) {
        showMsgBox_index(message, "W");
    };
 </script>
 
 
