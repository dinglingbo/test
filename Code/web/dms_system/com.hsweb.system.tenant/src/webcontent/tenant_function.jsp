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

<div class="nui-splitter" style="width: 100%; height: 100%;">
	<div size="400" showcollapsebutton="true">
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
						url="com.hsapi.system.tenant.permissions.getAppFunction.biz.ext"
						idField="id" textField="text" parentField="parentId" resultAsTree="false" checkedField="isCheck"
						showTreeIcon="true" ajaxData="setRoleId" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" showCheckBox="true" checkRecursive="true">
					</ul>
				</div>
			
			</div>
		</div>

	</div>
	<div showcollapsebutton="true">
		<div class="nui-toolbar"  >
			<input class="nui-textbox" id="tenantId" name="tenantId" width="50" emptyText="租户ID">
			<a class="nui-button" plain="true" onclick="refresh()"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
			<a class="nui-button" plain="true" onclick="deleteMenu()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
			<a class="nui-button" plain="true" onclick="saveMenu()"><i class="fa fa-save"></i>&nbsp;保存</a>

		</div>
		<div class="nui-fit" >
			<div id="rightGrid" class="nui-datagrid" 
			     style="width: 100%; height: 100%;" 
				 idField="roleId" allowResize="true"
				 showPager="false" 
				 dataField="list"
				 allowCellSelect="true"
				 allowCellEdit="true"
				 showSummaryRow="true"
				 showPagerButtonIcon="true" >
				
				<div property="columns">
					<div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
					<div field="id" width="50" headeralign="left" summaryType="count"><strong>id</strong><input property="editor" class="nui-textbox" /></div>
					<div field="tenantId" width="50" headeralign="left" ><strong>tenant_id</strong><input property="editor" class="nui-textbox" /></div>
					<div field="orgid" width="50" headeralign="left" ><strong>orgid</strong><input property="editor" class="nui-textbox" /></div>
					<div field="resId" width="100" headeralign="left" ><strong>res_id</strong><input property="editor" class="nui-textbox" /></div>
					<div field="resType" width="50" headeralign="left" ><strong>res_type</strong><input property="editor" class="nui-textbox" /></div>
					<div field="resName" width="100" headeralign="left" ><strong>res_name</strong><input property="editor" class="nui-textbox" /></div>
					<div field="type" width="30" headeralign="left" ><strong>type</strong><input property="editor" class="nui-textbox" /></div>
					<div field="resParentId" width="50" headeralign="left" ><strong>res_parent_id</strong><input property="editor" class="nui-textbox" /></div>
					<div field="isDisabled" width="50" headeralign="left" ><strong>is_disabled</strong><input property="editor" class="nui-textbox" /></div>
					<div field="scope" width="50" headeralign="left" ><strong>scope</strong><input property="editor" class="nui-textbox" /></div>
				</div>
			</div> 
		</div>
	</div>
</div>


</body>
</html>
<script type="text/javascript">
	nui.parse();
	var funcTree = nui.get("funcTree");
	funcTree.expandLevel(0);
	var rightGrid = nui.get("rightGrid");

	var baseUrl = apiPath + sysApi + "/";
	var gridUrl = baseUrl + "com.hsapi.system.tenant.permissions.queryTenantFunction.biz.ext";
	rightGrid.setUrl(gridUrl);

	function refresh(){
		var tenantId = nui.get("tenantId").getValue()||0;
		rightGrid.load({tenantId:tenantId,token:token});
	}

	function deleteMenu(){
		var row = rightGrid.getSelected();
		if(row){
			rightGrid.removeRow(row);
		}
	}

	var saveUrl = baseUrl + "com.hsapi.system.tenant.permissions.saveTenantFunction.biz.ext";
	function saveMenu(){
		var tenantId = nui.get("tenantId").getValue();
		if(!tenantId) {
			nui.alert("请输入租户ID再保存！");
			return;
		}

		var addList = rightGrid.getChanges("added");
		var editList = rightGrid.getChanges("modified");
		var delList = rightGrid.getChanges("removed");

		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '保存中...'
		});

		nui.ajax({
			url : saveUrl,
			type : "post",
			data : JSON.stringify({
				addList : addList,
				editList : editList,
				delList : delList,
				token: token
			}),
			success : function(data) {
				nui.unmask(document.body);
				data = data || {};
				if (data.errCode == "S") {
					nui.alert("保存成功!","",function(e){
						refresh();
					});
				} else {
					nui.alert(data.errMsg || "保存失败!");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				// nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}

	function setRoleId(){
		return {"token":token};
		//return {"roleId":"<%= request.getParameter("roleId")%>"};
	}

	function saveTree(){
		var funcDatas = funcTree.getCheckedNodes();
		var leafNodes = [];
		for(var cursor = 0; cursor < funcDatas.length; cursor++){
			var node = funcDatas[cursor];
			if(funcTree.isLeaf(node)){
				leafNodes.push(node);
			}
		}

		var tenantId = nui.get("tenantId").getValue();
		if(!tenantId) {
			nui.alert("请输入租户ID再保存！");
			return;
		}
		
		var addList = getAddList(tenantId,leafNodes);
		if(!addList || addList.length<=0)return;
		
		nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存中...'
	    });
        nui.ajax({
            url: saveUrl,
            type: 'POST',
	        data:JSON.stringify({
	            addList:addList,
	            token:token
	        }),
            cache: false,
            contentType:'text/json',
            success: function (text) {
            	nui.unmask();
            	if(text.errCode == 'S'){
                    nui.alert("添加资源成功");
            	}else{
                    nui.alert("添加源源失败");
                }
            },
            error: function () {
            	nui.unmask();
            	nui.alert("添加源源失败");
            }
        });
	}

	function getAddList(tenantId,leafNodes){
		var arr = [];
		for(var i=0; i<leafNodes.length; i++){
			var row = leafNodes[i];
			if(row.type == 'function'){
				var rows = rightGrid.findRows(function(row) {
					if (row.resId == leafNodes[i].id)
						return true;
				});
				if(rows && rows.length>0){
				}else{
					
					var obj = {
						tenantId: tenantId, 
						orgid: tenantId,
						resId: row.id,
						resType: 'function',
						resName: row.text,
						resParentId: row.parentId,
						isDisabled: 0,
						scope: row.scope,
						type: row.appPc
					};
					arr.push(obj);
				}
			}
			
		}
		return arr;
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
