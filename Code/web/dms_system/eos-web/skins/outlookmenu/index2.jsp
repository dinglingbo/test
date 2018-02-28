<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.primeton.cap.AppUserManager"%>
<meta http-equiv="x-ua-compatible" content="IE=8;" />
<html>
<head>
<%@include file="/coframe/tools/skins/common.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DMS管理系统2</title>
<style type="text/css">
.dtHighLight{
	background:#F0F8FF !important;
}
</style>
</head>
<body class="index">
<div class="nui-fit">
	<ul id="tree1" class="nui-outlookmenu" url="org.gocom.components.coframe.auth.LoginManager.getMenuList.biz.ext" 
		style="width:100%;height:100%;"  onitemclick="onItemSelect" expandOnNodeClick="true"
        textField="text" idField="id" parentField="pid" resultAsTree="false"
        showTreeIcon="true" dataField="treeNodes">        
    </ul>		
</div> 
</body>
 
</html>
<script type="text/javascript">
    nui.parse();
 
    var contextPath = '<%=contextPath%>';
   	function onItemSelect(e){
   		var item = e.item;
   		var isLeaf = item.isLeaf;
   		var url = item.url;
   		if(isLeaf){
   			if(url.indexOf("http") < 0 ){
   				iframe.src = contextPath + "/" + item.url;
   			}else{
   				iframe.src = item.url;
   			}	
	   		setPositionBar("<li><!--[if lt IE 8]><span class='left'></span><![endif]--><a>" + item.text + "</a><b class='arrow'></b></li>",item);
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
   	function setPositionBar(position,node){
   		if (node.ownerMenu&&node.ownerMenu.ownerItem){
   			var positionHtml = "<li><!--[if lt IE 8]><span class='left'></span><![endif]--><a>" + node.ownerMenu.ownerItem.text + "</a><b class='arrow'></b></li>"+position;
   			var parentNode = node.ownerMenu.ownerItem;
   			setPositionBar(positionHtml, parentNode);
   		}else{
   			var tree = nui.get("tree1");
   			var group = tree.getActiveGroup();
   			var positionHtml = "<li><!--[if lt IE 8]><span class='left'></span><![endif]--><a>" + group.title + "</a><b class='arrow'></b></li>"+position;
			positionHtml = "<li class='index'><a><span>首页</span></a><b class='arrow'></b></li>"+positionHtml;
			$("#positionbar").html(positionHtml);
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