
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%-- <%@page import="com.primeton.cap.AppUserManager"%> --%>
<meta http-equiv="x-ua-compatible" content="IE=8;" />
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<%@include file="/common/sysCommon.jsp" %>
<title>汽车后市场云平台</title>
<style type="text/css">
.dtHighLight{
	background:#F0F8FF !important;
}
.menu .has-children .menu-icon{
	line-height: 36px;
}
</style>  
	<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/common/nui/themes/scripts/boot.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/res/third-party/scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/common/nui/themes/res/third-party/scrollbar/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
   
    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/menu/menu.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/common/nui/themes/frame1/res/menu/menu.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/common/nui/themes/frame1/res/menutip.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/tabs.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/frame.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/common/nui/themes/frame1/res/index.css" rel="stylesheet" type="text/css" />
    
    
    
    <!-- <script src="../../scripts/boot.js" type="text/javascript"></script>
    <link href="../../res/third-party/scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <script src="../../res/third-party/scrollbar/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
    <link href="res/menu/menu.css" rel="stylesheet" type="text/css" />
    <script src="res/menu/menu.js" type="text/javascript"></script>
    <script src="res/menutip.js" type="text/javascript"></script>
    <link href="res/tabs.css" rel="stylesheet" type="text/css" />
    <link href="res/frame.css" rel="stylesheet" type="text/css" />
    <link href="res/index.css" rel="stylesheet" type="text/css" /> -->
    <style type="text/css">

	    #_sys_tip_msg_ {
	        z-index: 9999;
	        position: fixed;
	        left: -20;
	        top: 90;
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
	    
	    a.mini-button.mini-state-default.mini-corner-all{
	    	width:70px;
	    }
	</style>
    
</head>
<body>
    
<div class="navbar">
    <div class="navbar-header">
        <div class="navbar-brand">汽车后市场云平台</div>
        <div class="navbar-brand navbar-brand-compact">云</div>
    </div>
    <ul class="nav navbar-nav">
        <li><a id="toggle"><span class="fa fa-bars" ></span></a></li>
        <li class="icontop"><a href="#"><i class="fa fa-hand-pointer-o"></i><span >汽配云</span></a></li>
        <!-- <li class="icontop"><a href="#"><i class="fa fa-puzzle-piece"></i><span >汽修云</span></a></li>
        <li class="icontop"><a href="#"><i class="fa fa-sort-amount-asc"></i><span >EPC云</span></a></li>
        <li class="icontop"><a href="#"><i class="fa fa-sort-amount-asc"></i><span >SRM云</span></a></li>
        <li class="icontop"><a href="#"><i class="fa fa-sort-amount-asc"></i><span >物流云</span></a></li>
        <li class="icontop"><a href="#"><i class="fa  fa-cog"></i><span >SAAS租赁</span></a></li> -->
    </ul>
    <ul class="nav navbar-nav navbar-right">
        <!-- <li ><a href="#"><i class="fa fa-paper-plane"></i> 代办</a></li>
        <li ><a href="#"><i class="fa fa-paper-plane"></i> 消息</a></li>
        <li ><a href="#"><i class="fa fa-paper-plane"></i> 公告</a></li>
        <li ><a href="#"><i class="fa fa-paper-plane"></i> 客服</a></li>
        <li ><a href="#"><i class="fa fa-paper-plane"></i> 续费</a></li>
        <li ><a href="#"><i class="fa fa-paper-plane"></i> 帮助</a></li> -->
        <li class="dropdown">
            <a class="dropdown-toggle userinfo" style="padding-top: 18px;">
                    <i class="fa fa-align-justify"></i><span >待处理</span><i class="fa fa-angle-down"></i>
            </a>
            <ul class="dropdown-menu pull-right">
                <li>
                    <a href="javascript:openGuestOrder();"><i class="fa fa-pencil-square-o"></i> 待处理客户订单</a>
                </li>
                <li>
                    <a href="javascript:openSellOrder();"><i class="fa fa-pencil-square-o"></i> 待收货单</a>
                </li>
            </ul>
        </li>
        <li class="dropdown">
            <a class="dropdown-toggle userinfo" style="padding-top: 18px;">
                    <i class="fa fa-align-justify"></i><span id="currOrgName">公司</span><i class="fa fa-angle-down"></i>
            </a>
            <ul class="dropdown-menu pull-right" id="orgsname">
                <!-- <li>
                    <a href="javascript:openGuestOrder();"><i class="fa fa-pencil-square-o"></i> 待处理客户订单</a>
                </li>
                <li>
                    <a href="javascript:openSellOrder();"><i class="fa fa-pencil-square-o"></i> 待收货单</a>
                </li> -->
            </ul>
        </li>
        <li class="dropdown">
            <!--<a class="dropdown-toggle userinfo">
                <img class="user-img" src="res/images/user.jpg" /><span id="currUserName">当前登录人:</span><i class="fa fa-angle-down"></i>
            </a>-->
            <a class="dropdown-toggle userinfo" style="padding-top: 18px;">
                <!--<img class="user-img" src="res/images/user.jpg" />-->
                <span id="currUserName">当前登录人:</span><i class="fa fa-angle-down"></i>
            </a>
            <ul class="dropdown-menu pull-right">
                <li id="orgName"><a href="#">所属：</a></li>
                <!-- <li ><a href="#"><i class="fa fa-eye "></i> 用户信息</a></li> -->
                <li><a href="javascript:updatePassWord();"><i class="fa fa-pencil-square-o"></i> 修改密码</a></li>
                <li><a href="<%=request.getContextPath()%>/coframe/auth/login/logout.jsp" target="_top"><i class="fa fa-user"></i> 退出登录</a></li>
            </ul>
        </li>
    </ul>
</div>

<div class="container">
    
    <div class="sidebar">
        <div class="sidebar-toggle"><i class = "fa fa-fw fa-dedent" ></i></div>
        <div id="mainMenu"></div>
    </div>

    <div class="main">
        <div id="mainTabs" class="mini-tabs main-tabs" activeIndex="0" style="height:100%;" plain="false"
             buttons="#tabsButtons" arrowPosition="side" ontabload="ontabload">
            <div name="index" iconCls="fa-home" title="首页"> 
                <iframe id="formIframe" src="<%=request.getContextPath()%>/purchase/indexCloudPart_view0.jsp" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
            </div>
        </div>
        <div id="tabsButtons">
            <a class="tabsBtn" onclick="toHome()"><i class="fa fa-home"></i></a>
            <a class="tabsBtn" onclick="toRefresh()"><i class="fa fa-refresh"></i></a>
            <a class="tabsBtn" onclick="toClose()"><i class="fa fa-remove"></i></a>
            <a class="tabsBtn" onclick="toMax()"><i class="fa fa-arrows-alt"></i></a>
        </div>   
    </div>
   
</div>
<form id="toggleRole" role="form" method="post" action="">
	<input type="hidden" name="_eosFlowAction" value="toggleOrg">
	<input type="hidden" name="operatorId" value="" id="operatorId">
	<input type="hidden" name="orgid" value="" id="orgid">
</form>	


</body>
</html>
<script>
    var defDomin = "<%=request.getContextPath()%>";
    var mainTabs = mini.get("mainTabs");
    var loadingV = false;
    var obj = {};
    function activeTab(item) {
        var tabs = mini.get("mainTabs");
        var tab = tabs.getTab(item.id);
        if (!tab) {
            tab = { name: item.id, title: item.text, url: item.url, iconCls: item.iconCls, showCloseButton: true };
            tab = tabs.addTab(tab);
        }
        tabs.activeTab(tab);
    }

    function ontabload(){
	    if(loadingV){
    		if(obj){
    			doInitTab(obj);
    		}
    	}
	}
	
    function activeTabAndInit(item,params) {
        var tabs = mini.get("mainTabs");
        var tab = tabs.getTab(item.id);
        loadingV = true;
        if (!tab) {
            tab = { name: item.id, title: item.text, url: item.url, iconCls: item.iconCls, showCloseButton: true };
            tab = tabs.addTab(tab);
            
            tabs.activeTab(tab);
        
        	obj = params;
        	//doInitTab(params);
        }else{
        	tabs.activeTab(tab);
        	doInitTab(params);
        }
        
    }
    
    function doInitTab(params){
    	var tabs = mini.get("mainTabs");
    	var tab = tabs.getActiveTab();
    	var iframe = tabs.getTabIFrameEl(tab);
    	if(iframe.contentWindow && iframe.contentWindow.setInitData){
    		iframe.contentWindow.setInitData(params);
    	}
    	obj = {};
    }
    
    function toClose(){
        var tabs = mini.get("mainTabs");
        var tab = tabs.getActiveTab();
        if (tab && tab.name != "index") {
            tabs.removeTab(tab);
        }
    }
    
    function toHome(){
        var tabs = mini.get("mainTabs");
        var tab = tabs.getTab("index");
        
        tabs.activeTab(tab);
    }

    function toRefresh(){
        var tabs = mini.get("mainTabs");
        var tab = tabs.getActiveTab();
        
        if(tab.name == "index") {
        	tab.url = "/default/purchase/indexCloudPart_view0.jsp";
        }
        tabs.loadTab(tab.url, tab);
    }
    
    function updatePassWord(){
    	nui.open({
			url: defDomin + "/coframe/rights/user/update_password.jsp",
			title:"修改密码",
			width: "370px",
			height: "200px"
		});
    }
    
    function toMax(){
        launchFullscreen(document.documentElement);
    }

    // 判断各种浏览器，找到正确的方法
    function launchFullscreen(element) {
      if(element.requestFullscreen) {
        element.requestFullscreen();
      } else if(element.mozRequestFullScreen) {
        element.mozRequestFullScreen();
      } else if(element.webkitRequestFullscreen) {
        element.webkitRequestFullscreen();
      } else if(element.msRequestFullscreen) {
        element.msRequestFullscreen();
      }
    }
    // 启动全屏!
    //launchFullScreen(document.documentElement); // 整个网页
    //launchFullScreen(document.getElementById("videoElement")); // 某个页面元素
    
    // 判断浏览器种类
	function exitFullscreen() {
	  if(document.exitFullscreen) {
	    document.exitFullscreen();
	  } else if(document.mozCancelFullScreen) {
	    document.mozCancelFullScreen();
	  } else if(document.webkitExitFullscreen) {
	    document.webkitExitFullscreen();
	  }
	}
	// 退出全屏模式!
	//exitFullscreen();

    function openGuestOrder(){
        var item={};
        item.id = "guestOrder";
        item.text = "待处理客户订单";
        item.url = "/default/com.hsweb.cloud.part.purchase.pchsOrderSettle.flow";
        item.iconCls = "fa fa-sitemap";
        activeTab(item);
    }

    function openSellOrder(){
        var item={};
        item.id = "sellOrder";
        item.text = "待收货单";
        item.url = "/default/com.hsweb.cloud.part.purchase.sellOrderReceive.flow";
        item.iconCls = "fa fa-sitemap";
        activeTab(item);
    }

    $(function () {
    
    	

        //menu
        var menu = new Menu("#mainMenu", {
            itemclick: function (item) {
                if (!item.children) {
                    activeTab(item);
                }
            }
        });

        $(".sidebar").mCustomScrollbar({ autoHideScrollbar: true });

        new MenuTip(menu);
		/*menu.loadData(data);
        $.ajax({
            url: "skins/default/menu.txt",
            success: function (text) {
                var data = mini.decode(text);
                menu.loadData(data);
            }
        });*/
        //defDomin + org.gocom.components.coframe.auth.LoginManager.getMenuData.biz.ext
        $.ajax({
            url:  defDomin + "/org.gocom.components.coframe.auth.LoginManager.getMenuData.biz.ext",
            type: "POST",
            success: function(text){
                var treeNodes = text.treeNodes;
                var data = setMenuData(treeNodes);
                menu.loadData(data);
            }
        });

        var menuData=[];
        
        function setMenuData(treeNodes){
            if(!treeNodes) return;
            var tmpObj={};
            for(var i=0; i<treeNodes.length; i++){
                var node = treeNodes[i];
                var imagePath = node.imagePath;
                tmpObj={};
                tmpObj.text = node.menuName;
                tmpObj.id = node.menuPrimeKey;
                tmpObj.iconCls = imagePath||"fa fa-th-list";
                tmpObj.url = node.linkAction;
                if(node.childrenMenuTreeNodeList){
                    tmpObj.children = getChildrenData(node.childrenMenuTreeNodeList);
                }
                menuData.push(tmpObj);
            }
            return menuData;
        }

        function getChildrenData (treeNodes) {
            var data=[];
            var tmpObj={};
            for(var i=0; i<treeNodes.length; i++){
                var node = treeNodes[i];
                var imagePath = node.imagePath;
                tmpObj={};
                tmpObj.text = node.menuName;
                tmpObj.id = node.menuPrimeKey;
                tmpObj.iconCls = imagePath||"fa fa-file-text";
                tmpObj.url = defDomin + node.linkAction;
                if(node.childrenMenuTreeNodeList){
                    tmpObj.children = getChildrenData(node.childrenMenuTreeNodeList);
                }
                data.push(tmpObj);
            }
            return data;

        }

        function getChildren(node, treeNodes) {
            if(!treeNodes) return;
            for(var i=0; i<treeNodes.length; i++){
                var node = treeNodes[i];
                var id = node.menuPrimeKey;
                var iconCls = "fa fa-file-text";
                var text = node.menuName;
                var url = defDomin + node.linkAction;
                var children = node.childrenMenuTreeNodeList;

                var child = {};
                child.id = id;
                child.iconCls = iconCls;
                child.text = text;
                child.url = url;
                child.children = children;

                getChildren(child, children);
                node.push(child);
                //getChildren(children);
            }
        }
        
        //toggle
        $("#toggle, .sidebar-toggle").click(function () {
            $('body').toggleClass('compact');
            mini.layout();
        });

        //dropdown
        $(".dropdown-toggle").click(function (event) {
       	    if($(this).next().attr("id") == "orgsname"){
       	    	$("#orgsname").empty();
       	    	setOrgList();
       	    }
        
            $(this).parent().addClass("open");
            return false;
        });

        $(document).click(function (event) {
            $(".dropdown").removeClass("open");
        });
        
        window.onbeforeunload = function () {
	        return "离开此网站?";
	        //return null;
	    };
        
       document.getElementById('orgName').innerHTML = '<a href="#">所属：'+currOrgName+'</a>';
       document.getElementById('currOrgName').innerHTML = currOrgName;
       document.getElementById('currUserName').innerHTML = "当前登录人:" + currUserName + " ";
       
       $.ajax({
            url:  apiPath + sysApi + "/com.hs.common.login.authRequried.biz.ext",
            type: "POST",
            data : JSON.stringify({
                token: token
            }),
            success: function(text){
            }
        });
       
       
    });

    //切换角色
    function changeOrgs(orgid) {
        if (orgid != currOrgId) {
        	$("#toggleRole")[0].action = "com.hsapi.system.auth.login.login.flow";
            $("#operatorId").val(currUserId);
            $("#orgid").val(orgid);
            $("#toggleRole")[0].submit();
            //nui.confirm('切换公司后将重新加载页面，是否继续?','温馨提示',function(action){
            //    if (action == "ok") {
            //        $("#toggleRole")[0].action = "com.hsapi.system.auth.login.login.flow";
            //        $("#operatorId").val(currUserId);
            //        $("#orgid").val(orgid);
            //        $("#toggleRole")[0].submit();
            //    } else {
                    //mini.get("changeRole").setValue(vGrid);
           //     }
            //});
        }
    }
    
    function setOrgList(){
    	$.ajax({
            url:  apiPath + sysApi + "/com.hsapi.system.auth.LoginManager.getOrgList.biz.ext?userId="+currUserId,
            type: "POST",
            data : JSON.stringify({
                token: token
            }),
            success: function(text){
                var orgList = text.orgList;
                if(orgList && orgList.length>0){
                    for (var i = 0; i < orgList.length; i++) {
                        var rtoken = '<li><a href="javascript:void(0);" onclick="changeOrgs('
                                + orgList[i].orgid
                                + ')" title="'
                                + orgList[i].orgname + '">';
                        rtoken = rtoken + orgList[i].orgname;
                        rtoken = rtoken + '</a></li>';
                        $("#orgsname").append(rtoken);
                    }
                }
            }
        });
    	
    }
    
    
    var _sysMsg_index;
	//提示成功信息	
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
