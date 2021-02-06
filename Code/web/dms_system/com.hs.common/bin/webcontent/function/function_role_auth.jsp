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
    
    <!--body-->
 	<div class="nui-fit" style="padding:0px 10px 10px 10px;">
		
		
		
		
		<div class="nui-splitter" style="width: 100%; height: 100%;">
	        <div size="70%" showcollapsebutton="true">
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
    
	           <div class="nui-fit">
	           		<ul id="funcTree" class="nui-tree" style="width:100%;height:100%;"
						url="<%=apiPath + sysApi%>/com.hsapi.system.tenant.permissions.getRoleResauthValue.biz.ext"
						idField="id" textField="text" parentField="parentId" resultAsTree="false" checkedField="isCheck"
						showTreeIcon="true" ajaxData="setRoleId" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" 
						showCheckBox="true" checkRecursive="true" >
					</ul>
	           </div>
	        </div>
	        <div showcollapsebutton="true">
	        	<div property="toolbar" style="padding:10px;">
			    	<table style="width:100%;">
			            <tr>
			                <td style="white-space:nowrap;">
								<a class="nui-button" iconCls="" onclick="saveBtn" plain="true"><span class="fa fa-save fa-lg"></span>&nbsp;保存 </a>
			                </td>
			            </tr>
			        </table> 
			    </div>
	        	<div class="nui-fit" style="padding:0px 5px 5px 5px;">
				    <div id="btngrid" dataField="btnList" class="nui-datagrid" style="width:100%;height:100%;" showPager="false" showModified="false"
				    url="" allowResize="false"  multiSelect="false"  allowCellEdit="true" allowCellSelect="true">
					    <div property="columns">
					    	<div type="indexcolumn">序号</div>
					        <div field="name" width="100" headerAlign="center" allowSort="false">按钮/标签名称</div> 
					        <div field="check" width="100" headerAlign="center" allowSort="false">是否授权
					        	<input property="editor" class="nui-combobox" textField="name" data="statusList"
							valueField="id" />
					        </div>   
					    </div>
					</div>
				</div>
	        </div>
		</div>
			
	</div>

</div>
</div>
</body>
</html>
<script type="text/javascript">
	nui.parse();
	var statusList = [{id:0,name:"否"},{id:1,name:"是"}];
	var statusHash = {0:"否",1:"是"};
	var defDomin = "<%=request.getContextPath()%>";
	var btngrid = nui.get("btngrid");
	var funcTree = nui.get("funcTree");
	funcTree.expandLevel(0);
	
	var btnUrl = apiPath + sysApi + '/com.hsapi.system.tenant.permissions.getRoleResbtnauthValue.biz.ext';
    btngrid.setUrl(btnUrl);

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
	         show = 1;
	         return {"roleId":"<%= request.getParameter("roleId")%>","tenantId":"<%= request.getParameter("tenantId")%>","type":"PC","token":token};
	    }else{
	       return {"roleId":"<%= request.getParameter("roleId")%>","type":"PC","token":token};
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
				type: "pc",
				functions:leafNodes,
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
					
					//nui.alert("权限设置成功");
				}else{
				    if(show){
				       parent.parent.showMsg("权限设置失败","E");
				    }else{
				       parent.showMsg("权限设置失败","E");
				    }
					
					//nui.alert("权限设置失败");
				}
			},
			error: function () {
				nui.unmask();
				if(show){
				    parent.parent.showMsg("权限设置失败","E");
				 }else{
				    parent.showMsg("权限设置失败","E");
				 }
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
	
	funcTree.on("nodeselect",function(e){
		var row = e.selected;
		if(row) {
			var data = {
				roleId:"<%= request.getParameter("roleId")%>",
				resId: row.id,
				token:token
			}
			btngrid.load(data);
		}else {
			btngrid.setData([]);
		}
	});
	
	btngrid.on("drawcell",function(e){
        switch (e.field) {
            case "check":
                if (statusHash[e.value]) {
                    e.cellHtml = statusHash[e.value] || "";
                } else {
                    e.cellHtml = "";
                }
				break;
            default:
                break;
        }
	});
	
	function saveBtn(){
		var data = btngrid.getData();
		var resId = "";
		if(data && data.length > 0) {
			resId = data[0].resId;
		}
		
		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '保存中...'
		});

		var saveRoleResbtnauthUrl = baseUrl + "com.hsapi.system.tenant.permissions.saveFunctionBtnAuths.biz.ext";

		nui.ajax({
			url: saveRoleResbtnauthUrl,
			type: 'POST',
			data:nui.encode({
				roleId:"<%=request.getParameter("roleId") %>",
				resId: resId,
				btnList: data,
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
					
					//nui.alert("权限设置成功");
				}else{
				    if(show){
				       parent.parent.showMsg("权限设置失败","E");
				    }else{
				       parent.showMsg("权限设置失败","E");
				    }
					
					//nui.alert("权限设置失败");
				}
			},
			error: function () {
				nui.unmask();
				if(show){
				    parent.parent.showMsg("权限设置失败","E");
				 }else{
				    parent.showMsg("权限设置失败","E");
				 }
				//nui.alert("权限设置失败");
			}
		});
		
	}
	
</script>
