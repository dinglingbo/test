<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/sysCommon.jsp"%>
<html>
<!-- 
  - Author(s): liuzn (mailto:liuzn@primeton.com)
  - Date: 2013-03-01 13:51:37
  - Description:
-->
<%@page import="com.eos.foundation.eoscommon.ResourcesMessageUtil"%>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<title>角色功能授权</title>
<script>
	(function(){
		nui.context='<%=contextPath %>'
	})();
	
	var data={};
	nui.DataTree.prototype.dataField='data';//兼容改造 
</script>
</head>
<body>
<div class="nui-fit" style="padding:10px;">
<div id="panel1" class="nui-panel" style="width:100%;height:100%;" showHeader="false"
    showToolbar="true" showCollapseButton="false" showFooter="false">
    <!--toolbar-->
    <div property="toolbar" style="padding:10px;">
    	<table style="width:100%;">
                <tr>
                <td style="width:100%;">
                	<a class="nui-button" iconCls="" onclick="saveTree" plain="true"><span class="fa fa-save fa-lg"></span>&nbsp;保存 </a>
                	<span class="separator"></span>
			        <a class="nui-button" iconCls="" onclick="expandAll()" tooltip="全部展开" plain="true"><span class="fa fa-expand fa-lg"></span></a>
					<a class="nui-button" iconCls="" onclick="collapseAll()" tooltip="全部折叠" plain="true"><span class="fa fa-compress fa-lg"></span></a>
                </td>
                <td style="white-space:nowrap;">
                	<input id="key" class="nui-textbox" style="width:100px;" onenter="onKeyEnter" emptyText="请输入查询条件" />
					<a class="nui-button" style="width:60px;" iconCls="icon-search" onclick="search()">查询</a>
                </td>
            </tr>
        </table> 
    </div>
    <!--body-->
 	<div class="nui-fit" style="padding:0px 10px 10px 10px;">
		<ul id="funcTree" class="nui-tree" style="width:100%;height:100%;"
			url="<%=apiPath + sysApi%>/com.hsapi.system.tenant.permissions.getRoleResauthValue.biz.ext"
			idField="id" textField="text" parentField="parentId" resultAsTree="false" checkedField="isCheck"
			showTreeIcon="true" ajaxData="setRoleId" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" showCheckBox="true" checkRecursive="true">
		</ul>
	</div>

</div>
</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();
	var defDomin = "<%=request.getContextPath()%>";
	var funcTree = nui.get("funcTree");
	funcTree.expandLevel(0);

	var baseUrl = apiPath + sysApi + "/";
    
    var show = null;
    $(document).ready(function(v) {
	    getShow();
	});
    
    function getShow(){
      show = <%= request.getParameter("falg")%>;
    }
	function setRoleId(){
	    var falg = <%= request.getParameter("falg")%>;
	    if(falg){
	         return {"roleId":"<%= request.getParameter("roleId")%>","tenantId":"<%= request.getParameter("tenantId")%>","type":"APP","token":token};
	    }else{
	       return {"roleId":"<%= request.getParameter("roleId")%>","type":"APP ","token":token};
	    }
	}

	function saveTree(){
		var funcDatas = funcTree.getCheckedNodes();
		var leafNodes = [];
		for(var cursor = 0; cursor < funcDatas.length; cursor++){
			var node = funcDatas[cursor];
			if(funcTree.isLeaf(node)){
				var nodeRow = {};
				nodeRow.realId = node.id;
				nodeRow.checked = node.checked;
				nodeRow.isCheck = node.isCheck;
				nodeRow.type = node.type;
				leafNodes.push(nodeRow);
			}
		}
		<%-- var json = nui.encode({functions:leafNodes,roleId:"<%=request.getParameter("roleId") %>"}); --%>
		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '保存中...'
		});

		//webPath + defDomin + "/org.gocom.components.coframe.framework.FunctionAuth.saveFunctionAuths.biz.ext"
		var saveRoleResauthUrl = baseUrl + "com.hsapi.system.tenant.permissions.saveFunctionAuths.biz.ext";

		nui.ajax({
			url: saveRoleResauthUrl,
			type: 'POST',
			data:nui.encode({
				roleId:"<%=request.getParameter("roleId") %>",
				functions:leafNodes,
				type: "app",
				token:token
			}),
			cache: false,
			contentType:'text/json',
			success: function (text) {
				nui.unmask();
				if(text.errCode == 'S'){
					if(show){
				       parent.parent.showMsg("权限设置成功","S");
				    }else{
				       parent.showMsg("权限设置成功","S");
				    }
				}else{
					
					//nui.alert("权限设置失败");
					if(show){
				       parent.parent.showMsg("权限设置失败","E");
				    }else{
				       parent.showMsg("权限设置失败","E");
				    }
				}
			},
			error: function () {
				nui.unmask();
				if(show){
				    parent.parent.showMsg("权限设置失败","E");
				 }else{
				    parent.showMsg("权限设置失败","E");
				 }
				//parent.showMsg("权限设置失败","E");
				//nui.alert("权限设置失败");
			}
		});
		
	}

	function search(){
		var filtedNodes = [];
		var key = nui.get("key").getValue();
		if(key == ""){
			funcTree.clearFilter();
		}else{
			var rootNode = funcTree.getRootNode();
			funcTree.cascadeChild(
				rootNode,
				function(node){
					var pNode = funcTree.getParentNode(node);
					var nofind = true;
					for(i = 0; i < filtedNodes.length; i++){
						if(filtedNodes[i] == pNode.id){
							filtedNodes.push(node.id);
							nofind = false;
							break;
						}
					}
					if(nofind){
						var text = node.text ? node.text.toLowerCase() : "";
						if(text.indexOf(key) != -1){
							filtedNodes.push(node.id);
						}
					}
				}
			);
			funcTree.filter(function(node){
				for(i = 0; i < filtedNodes.length; i++){
					if(filtedNodes[i] == node.id){
						return true;
					}
				}
			});
		}
	}

	function expandAll(){
		funcTree.expandAll();
	}

	function collapseAll(){
		funcTree.collapseAll();
	}
</script>
