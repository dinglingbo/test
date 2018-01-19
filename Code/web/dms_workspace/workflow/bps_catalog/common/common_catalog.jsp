<%@include file="/frame/common/common.jsp"%>
<style type="text/css">
<!--
.response_message {
	Border: 1px solid #FCA689;
	font-size: 9pt;
	height: 19px;
	color: #ff0000;
	background: #FEF9BA;
	padding-top: 2px;
	whiteSpace:nowrap;
}
-->
</style>
<script>
function hiddenResponseMessage(div){
	div.style.display="none";
}

function showMessage(div,message){
	div.innerHTML="&nbsp;&nbsp;"+message+"&nbsp;&nbsp;";
	div.style.display="";
}

function getSelectNode(){
	var curNode = parent.frames["catalogleft"].window.document.getElementById("catalogtree").getSelectNode();
	if(curNode==null){
	   var curNode = parent.frames["catalogleft"].window.document.getElementById("catalogtree").getRootNode();
	}
	return curNode;
}

function getSelectParentNode(){
	var curNode = parent.frames["catalogleft"].window.document.getElementById("catalogtree").getSelectNode();
	if(curNode==null){
	   var curNode = parent.frames["catalogleft"].window.document.getElementById("catalogtree").getRootNode();
	   return curNode;
	}
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

function getCurNodeByUUIDFromParent(parentNode,curUUID){
	var children = parentNode.getChildren();
	var goalNode = "";
	//alert(children.length);
	for(var k=0;k<children.length;k++){
		node = children[k];
		var nodeCuid = node.getProperty("catalogUuid");
		//alert("nodeCuid=="+nodeCuid+"||curUUID=="+curUUID);
		if(nodeCuid==curUUID){
			goalNode = node;
			break;
		}
	}
	
	if(goalNode!=""){
		//alert("goal");
		return goalNode;
	}
	//alert("parent");
	return parentNode;
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

function _clickEvent_common(obj){
	if (isIE) {
		obj.click();
	} else {		
		var evt = document.createEvent("MouseEvents");
		evt.initEvent("click", true, true);
		obj.dispatchEvent(evt); 
	}
}

function _addSelectOption_common(obj,txt,val,selected){
	var oOption = document.createElement("OPTION");
	oOption.text = txt;
	oOption.value = val;			
	if(selected){
		oOption.selected = true;
	}
	obj.options.add(oOption);
}

</script>