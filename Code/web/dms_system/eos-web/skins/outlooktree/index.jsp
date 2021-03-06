<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.primeton.cap.AppUserManager"%>
<meta http-equiv="x-ua-compatible" content="IE=8;" />
<html>
<head>
<%@include file="/coframe/tools/skins/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>普元-用户机构及权限管理系统</title>
<style type="text/css">
.dtHighLight{
	background:#F0F8FF !important;
}
</style>
</head>
<body class="index">
<div class="nui-fit">
<div id="wrapper" class="wrap">
	<div id="header">
		<div class="head-in clearfix">
			<div class="fl clearfix">
				<h1 class="logo"></h1>
				<h2 class="name">应用基础框架</h2>
			</div>
			<div class="options fr">
				<div class="time font-5"><span id="currentData"></span></div>
			</div>
		</div>
	</div>
	<div class="nui-fit">
		<div id="container">
				<div id="wrapper" class="wrap">
					<!--侧边栏-->
					<div class="sidebar">
						<!--用户信息区-->
						<div class="user">
							<img class="head" src="<%=contextPath%>/coframe/tools/skins/skin1/images/user-head.gif" width="51" height="51" alt="" />
							<p class="tips">
								<span class="font-1"><strong>您好，<%=AppUserManager.getCurrentUserId() %></strong></span>
								<span><a class="set" href="#" onclick="javascript:updatepwd()">修改密码</a><a class="login-out" href="<%=contextPath%>/coframe/auth/login/logout.jsp" target="_top">注销</a></span>
							</p>
						</div>
						<!--左侧菜单-->
						<div class="nui-fit">
							<ul id="tree1" class="nui-outlooktree" url="org.gocom.components.coframe.auth.LoginManager.getMenuList.biz.ext" 
								style="width:100%;height:100%;"  onnodeselect="onItemSelect" expandOnNodeClick="true"
			                    textField="text" idField="id" parentField="pid" resultAsTree="false"
			                    showTreeIcon="true" dataField="treeNodes">        
					        </ul>		
						</div> 
					</div>
					<!--右侧主内容区-->
					<div class="main">
						<!--面包屑导航条-->
						<div class="positionbar">
							<ul class="position clearfix" id="positionbar">
								<li class="index">
									<a><span>首页</span></a><b class="arrow"></b>
								</li>
							</ul>
						</div>
						<!--主体内容显示区-->
						<div class="submain radius">
							<b class="b1"></b>
							<b class="b2"></b>
							<div class="fmain">
								<div class="nui-fit" style="padding:5px;">
								<iframe id="mainframe" src="<%=contextPath %>/coframe/auth/welcome/welcome.jsp" frameborder="0" name="main" style="width:100%;height:100%;" border="0"></iframe>
								</div>
							</div>
							<b class="b3"></b>
							<b class="b4"></b>
						</div>
					</div>
				</div>
		</div>
	</div>
	<div id="footer">
		<p>(c) Copyright Primeton 2012. All Rights Reserved. <%=com.primeton.ext.common.l7e.ImprimaturMgr.getImprimatur().getEditionInfo(com.eos.data.datacontext.DataContextManager.current().getCurrentLocale())%></p>
	</div>
</div>
</div>
</body>
 
</html>
<script type="text/javascript">
    nui.parse();
    
    var iframe = document.getElementById("mainframe");
 
    var contextPath = '<%=contextPath%>';
   	function onItemSelect(e){
   		var item = e.node;
   		var isLeaf = e.isLeaf;
   		var url = item.url;
   		if(isLeaf){
   			if(url.indexOf("http") < 0 ){
   				iframe.src = contextPath + "/" + item.url;
   			}else{
   				iframe.src = item.url;
   			}	
   			setPositionBar("",item);
   		}else{
   			item.expanded=true;	
   		}
   	}
   	function setPositionBar(position,node){
   		var tree = nui.get("tree1");
   		if (!node){
   			var group = tree.getActiveGroup();
   			var positionHtml = "<li><!--[if lt IE 8]><span class='left'></span><![endif]--><a>" + group.title + "</a><b class='arrow'></b></li>"+position;
			positionHtml = "<li class='index'><a><span>首页</span></a><b class='arrow'></b></li>"+positionHtml;
			$("#positionbar").html(positionHtml);
   		}else{
   			var dataList = tree.getList();
   			var positionHtml = "<li><!--[if lt IE 8]><span class='left'></span><![endif]--><a>" + node.text + "</a><b class='arrow'></b></li>"+position;
   			var parentNode;
   			if (node.pid){
	   			for(i=0; i<dataList.length; i++){
	   				var item = dataList[i];
	   				if (item.id==node.pid){
	   					parentNode = dataList[i];
	   					break;
	   				}
	   			}
   			}
   			setPositionBar(positionHtml, parentNode);
   		}
   	}
   	
   	function updatepwd(){
   		var jspUrl = "<%=contextPath%>/coframe/rights/user/update_password.jsp";
		nui.open({
			url: jspUrl,
			title:"修改密码",
			width: "370px",
			height: "200px"
		});
   	}
</script>