<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.primeton.cap.AppUserManager"%>
<meta http-equiv="x-ua-compatible" content="IE=8;" />
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<%@include file="/common/sysCommon.jsp" %>
	<title>汽车后市场云平台</title>
	  
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/common/nui/themes/scripts/boot.js" type="text/javascript"></script>

	<link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/menu/menu.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/common/nui/themes/frame3/res/menu/menu.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/common/nui/themes/frame3/res/menupop.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/tabs.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/frame.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/common/nui/themes/frame3/res/index.css" rel="stylesheet" type="text/css" />
    <link href="<%=request.getContextPath()%>/common/nui/themes/res/third-party/scrollbar/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <script src="<%=request.getContextPath()%>/common/nui/themes/res/third-party/scrollbar/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>

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
</head>
<body>
    

<div class="sidebar">
    <div id="mainMenu"></div>
</div>

<div class="container">
    <div class="navbar">
        <div class="navbar-brand">洗美工坊</div>
        <ul class="nav navbar-nav navbar-right">
            <!-- <li><a href="#"><i class="fa fa-paper-plane"></i> 代办事项</a></li>
            <li><a href="javascript:updatePassWord();"><i class="fa fa-pencil-square-o"></i> 修改密码</a></li> -->
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
                    <img class="user-img" src="res/images/user.jpg" />个人资料<i class="fa fa-angle-down"></i>
                </a>-->
                <a class="dropdown-toggle userinfo" style="padding-top: 18px;">
	                <!--<img class="user-img" src="res/images/user.jpg" />-->
	                <span id="currUserName">当前登录人:</span><i class="fa fa-angle-down"></i>
	            </a>
                <ul class="dropdown-menu pull-right">
                    <li id="orgName"><a href="#">所属：</a></li>
                    <li><a href="javascript:updatePassWord();"><i class="fa fa-pencil-square-o"></i> 修改密码</a></li>
                    <!-- <li><a href="#"><i class="fa fa-eye "></i> 用户信息</a></li> -->
                    <li><a href="<%=request.getContextPath()%>/coframe/auth/wlogin/logout.jsp"><i class="fa fa-user"></i> 退出登录</a></li>
                </ul>
            </li>
        </ul>
    </div>

    <div class="main">
        <div id="mainTabs" class="mini-tabs indexTabs" activeIndex="0" style="width:100%;height:100%;" plain="false"
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

        function autoScrollbar() {
            var jq = $(".mCSB_container");
            if (jq.parent().height() >= jq.children().outerHeight()) {
                jq.css("height", "100%");
            } else {
                jq.css("height", "auto");
            }
        }
        $(window).on("resize", function () {
            autoScrollbar();
        });
        autoScrollbar();

        new MenuPop(menu);

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
                tmpObj.iconCls = imagePath||"fa fa-desktop";
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
                var iconCls = "fa fa-desktop";
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

        //dropdown
        $(".dropdown-toggle").click(function (event) {
            $(this).parent().addClass("open");
            return false;
        });
        
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

       //document.getElementById('orgName').innerHTML = '<a href="#">所属：'+currOrgName+'</a>';
        
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
            nui.confirm('切换公司后将重新加载页面，是否继续?','温馨提示',function(action){
                if (action == "ok") {
                    $("#toggleRole")[0].action = "com.hsapi.system.auth.login.wlogin.flow";
                    $("#operatorId").val(currUserId);
                    $("#orgid").val(orgid);
                    $("#toggleRole")[0].submit();
                } else {
                    //mini.get("changeRole").setValue(vGrid);
                }
            });
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
