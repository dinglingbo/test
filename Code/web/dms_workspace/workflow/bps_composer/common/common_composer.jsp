<%@include file="/frame/common/common.jsp"%>
<h:script src="/workflow/bps_composer/common/scripts/i18n/common_composer.js" i18n="true"/>
<style type="text/css">
<!--
body {
	color: #00368F;
	background: #F7FCFD;
	font-family: Arial !important "宋体";
	FONT-SIZE: 9pt;
	background:#FFFFFF;
	margin:0px;
	background:url(<%=request.getContextPath()%>/workflow/wfmanager/images/MainFrameBg.gif) no-repeat;
	overflow:auto;
}
.response_message {
	Border: 1px solid #FCA689;
	font-size: 9pt;
	height: 19px;
	color: #ff0000;
	background: #FEF9BA;
	padding-top: 2px;
	whiteSpace:nowrap;
}

#listleft{
	float:left;
	white-space:nowrap;
}
#listright{
	float:right;
	white-space:nowrap;
}
-->
</style>
<script>
function list_selectAll() {
  var g = $name("chkall");
  var rows=$id("group1").getRows();
  if (g.checked) {         
     for (i=0;i<rows.length;i++) {
          rows[i].setSelected();
     }
  } else {
     for (i=0;i<rows.length;i++) {
          rows[i].disSelected();
     }
  }
}

function hiddenResponseMessage(div){
	div.style.display="none";
}

function showMessage(div,message){
	div.innerHTML="&nbsp;&nbsp;"+message+"&nbsp;&nbsp;";
	div.style.display="";
}

function getSelectNode(){
	var curNode = parent.frames["left"].window.document.getElementById("catalogFlowTree").getSelectNode();
	return curNode;
}

function getSelectParentNode(){
	var curNode = parent.frames["left"].window.document.getElementById("catalogFlowTree").getSelectNode();
	return curNode.getParent();
}

function refreshSelectNode(){
	var curNode = getSelectNode();
	curNode.reloadChild();
}

function refreshSelectParentNode(){
	var curNode = getSelectParentNode();
	curNode.reloadChild();
}

function refreshNodeByCatalogUuid(uid){
	if(uid==-1||uid==""||uid==null){
		uid = "99999";
	}
	//获取树节点
	var rootNode = parent.frames["left"].window.document.getElementById("catalogFlowTree").getRootNode();
	var children = rootNode.getChildren();
	var goalNode = "";
	//alert("refreshNodeByCatalogUuid---"+children.length);
	for(var k=0;k<children.length;k++){
		//alert("refreshNodeByCatalogUuid---"+k);
		node = children[k];
		var nodeCuid = node.getProperty("catalogUUID");
		if(nodeCuid==uid){
			goalNode =  node;
			break;
		}
		var tempNode = getNodeByCuid(node,uid);
		//alert(tempNode);
		if(tempNode!="") {
			goalNode =  tempNode;
			break;
		}
		//alert("refreshNodeByCatalogUuidforfor---"+k);
	}
	//alert("xxxxxxxxxxxxxxx");
	if(goalNode!=""){
		goalNode.reloadChild();
	}
}

function getTreeNodeByCuid(uid){
	if(uid==-1||uid==""||uid==null){
		uid = "99999";
	}
	//获取树节点
	var rootNode = parent.frames["left"].window.document.getElementById("catalogFlowTree").getRootNode();
	var children = rootNode.getChildren();
	var goalNode = "";
	//alert("refreshNodeByCatalogUuid---"+children.length);
	for(var k=0;k<children.length;k++){
		//alert("refreshNodeByCatalogUuid---"+k);
		node = children[k];
		var nodeCuid = node.getProperty("catalogUUID");
		if(nodeCuid==uid){
			goalNode =  node;
			break;
		}
		var tempNode = getNodeByCuid(node,uid);
		//alert(tempNode);
		if(tempNode!="") {
			goalNode =  tempNode;
			break;
		}
		//alert("refreshNodeByCatalogUuidforfor---"+k);
	}
	//alert("xxxxxxxxxxxxxxx");
	if(goalNode!=""){
		return goalNode;
	}
}

function getNodeByCuid(node,uid){
	var nodeCuid = node.getProperty("catalogUUID");
	if(nodeCuid==uid){
		return node;
	}
	var children = node.getChildren();
	//alert("getNodeByCuid+---"+children.length);
	for(var i=0;i<children.length;i++){
		var tempNode = getNodeByCuid(children[i],uid);
		if(tempNode!="") return tempNode;
	}
	//alert("retun-getNodeByCuid");
	return "";
}

/**覆盖eos的js实现**/
function _rtreenode_onclick()
{
	var rtreeView = findRTree( this );
	var model = rtreeView.model;
	model.menu.hide();
	function expandOrCollapseNode()
	{
		//如果是叶子节点，不做处理

		if( rtreeNode.isleaf )
			return;

		if( rtreeNode.childrenContainer.style.display == "none" )
		{
			rtreeNode.expandNode();
		}else
		{
			rtreeNode.collapseNode();
		}
	}
	//eventManager.stopPropagation();

	var rtreeNode = this;
	var src = eventManager.getElement();

	if( src == this.cell || src == this.expandIcon || src == this.icon )	//选中节点
	{
		this.selected();
	}
	if( src == this.cell || src == this.expandIcon || src == this.icon)			//触发用户自定义动作
	{
		var functionName = model.getEntityInfo( this.entity.name ).onclick;
		if( functionName )
		{
			fireUserEvent(functionName, [this]);
		}
	}
	if( src == this.expandIcon )	//点击展开关闭结点
	{
		expandOrCollapseNode();
	}
}

    function selClickNode(selObjID,targetName){
	   	var rows=$id("group1").getRows();
		for(var i=0;i<rows.length;i++){
			if(rows[i].getParam(targetName)==selObjID){
		   		rows[i].setSelected();
			}else{
				rows[i].disSelected();
			}
    	}
    }
    
    
    function _clickEvent_common(obj){
		if (isIE) {
			obj.click();
		} else {		
			var evt = document.createEvent("MouseEvents");
			evt.initEvent("click", true, true);
			obj.dispatchEvent(evt); 
		}
	}

</script>