var STREE_CHECKBOX_TRUE_ICON= "";//全选
var STREE_CHECKBOX_TRUE_ICON1= "";//半选
var STREE_CHECKBOX_FALSE_ICON= "";//不选

STREE_CHECKBOX_TRUE_ICON = contextPath + "/common/skins/skin0/images/basic/checkbox_true.gif";
STREE_CHECKBOX_TRUE_ICON1 = contextPath + "/common/skins/skin0/images/basic/checkbox_true1.gif";	
STREE_CHECKBOX_FALSE_ICON = contextPath + "/common/skins/skin0/images/basic/checkbox_false.gif";

String.prototype.endWith = function(oString){
	var reg = new RegExp(oString+"$");
	return reg.test(this);
};

//取得节点初始状态
function getNodeCheckboxSrc(node) {
	var parentNode = node.getParent();
	if (parentNode && !parentNode.isroot) {
		var parentNodeState = getCheckboxElement(parentNode).src;
		if (parentNodeState.endWith(STREE_CHECKBOX_TRUE_ICON)) {
			return STREE_CHECKBOX_TRUE_ICON;
		} else {
			return STREE_CHECKBOX_FALSE_ICON;
		}
	}
	return STREE_CHECKBOX_FALSE_ICON;
}

//取得节点的checkbox的html字符串
function getCheckboxHtml(node, callbackFuncString) {
	var chkImg = "<img align='middle'";
	if(isFF) {
		chkImg = "<img align='top'";
	}
	chkImg += " name='checkbox4rtree' onclick='switchStateFromCheckbox(this, \"" + callbackFuncString + "\");' src='" + getNodeCheckboxSrc(node) + "'>";
	return chkImg;
}

//取得节点的表示checkbox的对象
function getCheckboxElement(node) {
	var tagEles = node.cell.getElementsByTagName("IMG");
	for (var i = 0; i < tagEles.length; i++) {
		if (tagEles[i].name == 'checkbox4rtree') {
			return tagEles[i];
		}
	}		
}

//是全选状态
function isSelectedState(state) {
	return state.endWith(STREE_CHECKBOX_TRUE_ICON);
}

//是半选状态
function isHalfSelectedState(state) {
	return state.endWith(STREE_CHECKBOX_TRUE_ICON1);
}

//是不选状态
function isNotSelectedState(state) {
	return state.endWith(STREE_CHECKBOX_FALSE_ICON);
}

//改变当前节点的状态
function switchCurrentState(node, currentState) {
	var obj = getCheckboxElement(node);
	if (currentState == undefined || currentState == 'undefined' || currentState == "") {
		if (isSelectedState(obj.src)) {
			obj.src = STREE_CHECKBOX_FALSE_ICON;
		} else {
			obj.src = STREE_CHECKBOX_TRUE_ICON;
		}
	} else {
		obj.src = currentState;
	}
	return obj.src;
}

//改变父节点的状态
function switchParentState(node, nodeState) {
	var parentNode = node.getParent();
	if (parentNode && !parentNode.isroot) {
		var parentNodeState = nodeState;
		var childrenNode = parentNode.getChildren();
		var parentNodeCheckboxObj = getCheckboxElement(parentNode);
		//全选状态
		if (isSelectedState(nodeState)) {
			parentNodeState = STREE_CHECKBOX_TRUE_ICON;
			for (var i = 0; i < childrenNode.length; i++) {
				if (childrenNode[i] == node) {
					continue;
				}
				var childNodeSrc = getCheckboxElement(childrenNode[i]).src;					
				if (isSelectedState(childNodeSrc)) {
					continue;
				} else if (isHalfSelectedState(childNodeSrc)) {
					parentNodeState = STREE_CHECKBOX_TRUE_ICON1;
					break;
				} else if (isNotSelectedState(childNodeSrc)) {
					parentNodeState = STREE_CHECKBOX_TRUE_ICON1;
					break;
				}
			}
			
		//半选状态
		} else if (isHalfSelectedState(nodeState)) {
			parentNodeState = STREE_CHECKBOX_TRUE_ICON1;	
		
		//不选状态		
		} else if (isNotSelectedState(nodeState)) {
			parentNodeState = STREE_CHECKBOX_FALSE_ICON;
			for (var i = 0; i < childrenNode.length; i++) {
				if (childrenNode[i] == node) {
					continue;
				}
				var childNodeSrc = getCheckboxElement(childrenNode[i]).src;
				if (isSelectedState(childNodeSrc)) {
					parentNodeState = STREE_CHECKBOX_TRUE_ICON1;
					break;
				} else if (isHalfSelectedState(childNodeSrc)) {
					parentNodeState = STREE_CHECKBOX_TRUE_ICON1;
					break;
				} else if (isNotSelectedState(childNodeSrc)) {					
					continue;
				}
			}
		}
		parentNodeCheckboxObj.src = parentNodeState;
		
		//递归改变父节点状态
		switchParentState(parentNode, parentNodeState);
	}
	
}

//改变子结点的状态
function switchChildState(node, nodeState) {
	if (!node || node == null || node.isleaf) {
		return;
	}
	var childrenNode = node.getChildren();
	if (childrenNode) {
		for (var i = 0; i < childrenNode.length; i++) {				
			getCheckboxElement(childrenNode[i]).src = nodeState;
			//递归改变子节点状态
			switchChildState(childrenNode[i], nodeState);
		}
	}
}

//改变状态
function switchStateFromCheckbox(checkboxObj, callbackFuncString) {
	var currentNode = checkboxObj.parentNode.parentNode.parentNode;
	
	switchState(currentNode);
	
	if (callbackFuncString == undefined || callbackFuncString == 'undefined' || callbackFuncString == "") {
		return;
	}
	eval(callbackFuncString + "();");
}

//添加实体到列表中
function addSelectedNode(nodeSelectedList, node, nodeType) {
	var childrenNode = node.getChildren();
	//不是根节点，并且是叶子节点，或者没有孩子
	if (!node.isroot && (node.isleaf || !node.hasChild || (childrenNode && childrenNode.length == 0))) {
		 //选中状态
		if(isNodeSelectedState(node)) {
			if (trim(nodeType).length > 0) {
				if (nodeType == getNodeType(node)) {
					nodeSelectedList.push(node);
				}
			} else {
				nodeSelectedList.push(node);
			}
		}
		return;
	}	
	
	if (childrenNode) {
		for (var i = 0; i < childrenNode.length; i++) {				
			addSelectedNode(nodeSelectedList, childrenNode[i], nodeType);
		}
	}
}

//创建隐藏数据
function createHiddenEntityData(treeObj, nodeSelectedList, submitXpath) {
	var divHidden = document.createElement("div");
	treeObj.getRootNode().appendChild(divHidden);
	
	var strBuff = new StringBuffer();
	for (var i = 0; i < nodeSelectedList.length; i++) {
		strBuff.append(_createOneEntityHidden(i + 1, nodeSelectedList[i].entity, submitXpath));
	}
	divHidden.innerHTML = strBuff.toString();
}

//创建一个实体的隐藏表单数据
function _createOneEntityHidden(index, entity, submitXpath) {
	var buffer = new StringBuffer();
	var keys = entity.getKeys();
	for(var i = 0; i < keys.length; i++){
		var obj = entity.getProperty(keys[i]);
		buffer.append("<input type='hidden' name='").append(submitXpath).append("[").append(index).append("]/")
			.append(keys[i]).append("' value='").append(obj).append("'/>");
	}
	return buffer;
}

/**
 *
 * 改变节点状态
 * 参数currentState 可以没有，如果没有，会自动切换选中状态
 *
 */
function switchState(currentNode, currentState) {
	var currentState = switchCurrentState(currentNode, currentState);
	switchParentState(currentNode, currentState);
	switchChildState(currentNode, currentState);
	currentNode.selected();
}

/**
 *
 * 渲染Checkbox类型的节点显示
 *
 */
function renderCheckboxNode(node, nodeType, nodeTextDisplay, callbackFuncString) {
	node.setText(getCheckboxHtml(node, callbackFuncString) + nodeTextDisplay);
	node.setAttribute("NODE_TYPE", nodeType);
}

/**
 *
 * 取得选中的节点
 *
 */
function getSelectedNodeList(treeObj, nodeType) {
	var rootNode = treeObj.getRootNode();
	var nodeSelectedList = new Array();
	
	addSelectedNode(nodeSelectedList, rootNode, nodeType);
	return nodeSelectedList;
}

/**
 *
 * 创建提交选中的节点隐藏数据
 *
 */
function createSubmitRTreeHiddenData(treeObj, nodeType, submitXpath) {		
	var nodeSelectedList = getSelectedNodeList(treeObj, nodeType);
	createHiddenEntityData(treeObj, nodeSelectedList, submitXpath);
}

/**
 *
 * 是全选状态
 *
 */
function isNodeSelectedState(node) {
	return isSelectedState(getCheckboxElement(node).src);
}

/**
 *
 * 是半选状态
 *
 */
function isNodeHalfSelectedState(node) {
	return isHalfSelectedState(getCheckboxElement(node).src);
}

/**
 *
 * 是不选状态
 *
 */
function isNodeNotSelectedState(node) {
	return isSelectedState(getCheckboxElement(node).src);
}

/**
 *
 * 取得节点类型
 *
 */
function getNodeType(node) {
	return node.getAttribute("NODE_TYPE");
}

/**
 *
 * 取得节点
 *
 */
function findTreeNode(treeObj, nodeType, nodePropertyName, nodePropertyValue) {
	var node = treeObj.cur_node;
	if (!node.isroot && (getNodeType(node) == nodeType) && (node.getProperty(nodePropertyName) == nodePropertyValue)) {
		return node;
	}
	return findTreeNode2(treeObj.getRootNode(), nodeType, nodePropertyName, nodePropertyValue);
}

function findTreeNode2(node, nodeType, nodePropertyName, nodePropertyValue) {	
	if (!node.isroot && (getNodeType(node) == nodeType) && (node.getProperty(nodePropertyName) == nodePropertyValue)) {
		return node;
	}
	var childrenNode = node.getChildren();
	if (childrenNode) {
		for (var i = 0; i < childrenNode.length; i++) {				
			node = findTreeNode2(childrenNode[i], nodeType, nodePropertyName, nodePropertyValue);
			if (node != null) {
				return node;
			}
		}
	}
	return null;
}