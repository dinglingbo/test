<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/governor/frame/common.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/webcomp.tld" prefix="stree" %>
<%
String contextPath=request.getContextPath();
%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>


<script>

	function re(node)
	{
	node.icon.style.display="none"
	}
</script>
<script>
var STREE_LINE_ICON="<%=contextPath%>/governor/images/leftBar/tree/line.gif";
var STREE_LEAF_ICON="<%=contextPath%>/governor/images/leftBar/tree/leaf.gif";
var STREE_FLEAF_ICON="<%=contextPath%>/governor/images/leftBar/tree/FLeaf.gif";
var STREE_LLEAF_ICON="<%=contextPath%>/governor/images/leftBar/tree/LLeaf.gif";
var STREE_MINUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/minus.gif";
var STREE_LMINUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/LMinus.gif";
var STREE_FMINUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/FMinus.gif";
var STREE_PLUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/plus.gif";
var STREE_FPLUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/FPlus.gif";
var STREE_LPLUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/LPlus.gif";
var STREE_DEFAULTOPEN_ICON="<%=contextPath%>/governor/images/leftBar/tree/defaultOpen.png";
var STREE_DEFAULTCLOSE_ICON="<%=contextPath%>/governor/images/leftBar/tree/defaultClose.png";
var STREE_ROOTPLUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/rootPlus.gif";
var STREE_ROOTMINUS_ICON="<%=contextPath%>/governor/images/leftBar/tree/rootMinus.gif";
var STREE_BLANK_ICON="<%=contextPath%>/governor/images/leftBar/tree/treeBlank.gif";
</script>
<body class="frame_left_body">
<div height="100%" >
<table CELLPADDING="0" CELLSPACING="0" height="100%"  onselectstart="return false">
<tr >
<td id=polit valign="top">
		<TABLE height="100%" CELLPADDING="0" CELLSPACING="0"  >
          <TR>
			<TD height="0"><IMG SRC="<%=contextPath%>/images/leftBar/governorBarTitleBg.gif"></TD>
		  </TR>
		  <TR>
			<TD class="frame_left_table_td">
							<div id="treediv" style="overflow-y: auto ; height:100%">
							<nobr>
							<stree:tree id="tree" checkBoxType="simple" hasCheckBox="false" hasRoot="false"  >
									<stree:treeRoot onClickFunc=""  display="" icon="" onCheckFunc="" onRefreshFunc="" />
									<stree:treeNode onClickFunc="onclick"  nodeType="org" showField="show" xpath="list" onRefreshFunc="re" onClickFunc="doAction" >
											<stree:treeRelation field="pId" parentNodeType="root" value="-1"/>
											<stree:treeRelation field="pId" parentField="id" parentNodeType="org"/>
									</stree:treeNode>

							</stree:tree>
							</nobr>
							</div>
			</TD>
		   </TR>

		   <TR>
			 <TD><IMG SRC="<%=contextPath%>/images/leftBar/governorBarBottomBg.gif"  ></TD>
		   </TR>
		</TABLE>
</td>
</tr>
</table>
</div>
<script>
var politMsg="Home>";
//展开第一级
tree.rootNode.getChildren()[0].expandNode();
tree.rootNode.getChildren()[0].expandIcon.style.display="none";


//如果是非叶子节点,点击时伸展或收缩
function expandOrStrike(obj)
{
	if(obj.expand=="true"){
		closeHelp();
		obj.expand="false";
		obj.src="<%=contextPath%>/images/leftBar/HelpShrinkIcon.gif"
	}else{
		openHelp();
		obj.expand="true";
		obj.src="<%=contextPath%>/images/leftBar/HelpExtendIcon.gif"
	}
}
function closeHelp()
{
	polit.height="100%"
	helpInfo.style.display="none"
}
function openHelp()
{
	polit.height="70%"
	helpInfo.style.display="";
}

//点击树节点时触发的js函数
function doAction(node)
{
	var action=node.getProperty("action");
	
	if(action==""){
	      if( node.childrenContainer.style.display == "none" ){
				if(node.hasChild)
				  node.expandNode();
			}else{
				if(node.getText().indexOf("Governor")==-1)
					node.collapseNode();
			}
	}else{
		politMsg=getPolitMsg(node);
		top.frames["main"].location=action;
	}
}

//得到导行信息
function getPolitMsg(node)
{
	var msg=node.getText();
	parentNode=node.getParent();
	while(parentNode.getText().indexOf("Governor")==-1)
	{
		msg=parentNode.getText()+">"+msg;
		parentNode=parentNode.getParent();
	}
	return "Home>"+msg;

}
function dealScroll(){
	
	if (window.isFF){
		$id("treediv").style.height=document.body.clientHeight-50;
	}
	
}	
window.onload = function(){
	dealScroll();
}
window.onresize = function(){
	dealScroll();
}
</script>
</body>
</html>