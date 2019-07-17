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
<title>租户角色授权</title>
<script>
	(function(){
		nui.context='<%=contextPath %>'
	})();
	
	var data={};
	nui.DataTree.prototype.dataField='data';//兼容改造 
</script>
</head>
<body>

<div id="panel1" class="nui-panel" style="width:100%;height:100%;" showHeader="false"
    showToolbar="true" showCollapseButton="false" showFooter="false">
    <!--toolbar-->
    <div property="toolbar" style="padding:10px;height:20px;">
    	<table style="width:100%;">
                <tr>
                <td style="width:100%;">
                	 <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="deleteRole()" id="deletBtn"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
                </td>
                <td style="white-space:nowrap;">
                	<input id="roleName" name="roleName" class="nui-textbox" style="width:200px;" onenter="queryRole" emptyText="请输入角色名称" />
					<a class="nui-button" style="width:60px;" iconCls="icon-search" onclick="queryRole()">查询</a>
                </td>
            </tr>
        </table> 
    </div>
    <!--body-->
 	 <div class="nui-fit" >
            <div id="rightGrid" class="nui-datagrid" dataField="roleList" style="width: 100%; height: 100%;" 
                idField="roleId" allowResize="true"
                sizeList="[20,50,100]" 
                pageSize="20" 
                totalField="page.count" 
                showPager="true" 
                onselectionchanged="onLeftGridSelectionChanged"
                showPagerButtonIcon="true" 
                >
                <div property="columns">
                    <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
                     <div field="tenantId" width="140" headeralign="left" visible="true"><strong>租户ID</strong></div>
                    <div field="roleId" width="140" headeralign="left" visible="true"><strong>角色ID</strong></div>
                    <div field="roleCode" width="140" headeralign="left" visible="true"><strong>角色编码</strong></div>
                    <div field="roleName" width="140" headeralign="left" ><strong>角色名称</strong></div>
                    <div field="roleDesc" width="140" headeralign="left" visible="true"><strong>角色描述</strong></div>
                </div>
            </div> 
        </div>
</div>

</body>
</html>
<script type="text/javascript">
	nui.parse();
    var tenantId = null;
    var tenantType = null;
	var baseUrl = apiPath + sysApi + "/";
    var rightGrid = nui.get("rightGrid");
    var rightGridUrl = baseUrl + "com.hsapi.system.tenant.tenant.queryTenantRole.biz.ext";
    var deleteRoleUrl = baseUrl + "com.hsapi.system.tenant.role.deleteRole.biz.ext";
    $(document).ready(function(v) {
		rightGrid = nui.get("rightGrid");
		rightGrid.setUrl(rightGridUrl);
		getTenantId();
	    queryRole();
	    rightGrid.on("rowdblclick",function(e){
		   edit();
	    });
    });
    
    function queryRole(){
		var params = {};
		params.tenantType = tenantType;
	    params.tenantId = tenantId;
	    var roleName = nui.get("roleName").getValue();
	    if(roleName){
	       params.roleName = roleName;
	    }
		rightGrid.load({
		    params:params,
		    token:token
		}); 
    }
    
	function getTenantId(){
		tenantId = <%= request.getParameter("tenantId")%>;
		tenantType = <%= request.getParameter("tenantType")%>;
	}

	
	function edit(){
		var row = rightGrid.getSelected();
		if(row){
			nui.open({
				url : webPath + contextPath + "/common/function/edit_role.jsp?token=" + token,
				title : "编辑角色信息",
				width : 400,
				height : 300,
				allowDrag : true,
				allowResize : true,
				onload : function() {
					var iframe = this.getIFrameEl();
		            iframe.contentWindow.SetInitData(row);//显示该显示的功能
				},
				ondestroy : function(action) {
				    if(action=="ok"){
				      queryRole();
				    }
					
				}
			});
		}else{
		   showMsg("请选择一条记录","W");
		}
	}
	
	function add(){
		nui.open({
			url : webPath + contextPath + "/common/function/edit_role.jsp?token=" + token,
			title : "新增角色信息",
			width : 400,
			height : 300,
			allowDrag : true,
			allowResize : true,
			onload : function() {
				var iframe = this.getIFrameEl();
				var data = {};
				data.tenantId = tenantId;
	            iframe.contentWindow.SetInitData(data);//显示该显示的功能
			},
			ondestroy : function(action) {
			    if(action=="ok"){
			      queryRole();
			    }
				
			}
		});
	}
	
	function deleteRole() {
	    var row = rightGrid.getSelected();
	    if (!row) {
	        showMsg("请选中一条记录","W");
	        return;
	    }
	
	    if(row && row.roleId){
	        nui.confirm("确认删除吗？","提示",function(action) {
	            if (action == "ok") {
	                 nui.mask({
	                    el : document.body,
	                    cls : 'mini-mask-loading',
	                    html : '保存中...'
	                });
	
	                nui.ajax({
	                    url:deleteRoleUrl,
	                    type:"post",
	                    data:JSON.stringify({
	                        capRole: row,
	                        token:token
	                    }),
	                    success:function(data)
	                    {
	                        nui.unmask();
	                        if (data.errCode == "S"){
	                           leftGrid.reload();                   
	                        }else{
	                            showMsg(data.errMsg||"保存失败","W");
	                        }
	                    },
	                    error:function(jqXHR, textStatus, errorThrown){
	                        console.log(jqXHR.responseText);
	                        nui.unmask();
	                        showMsg("网络出错","W");
	                    }
	                });            
	            }
	        });
	    }else{
	        leftGrid.removeRow(row);
	    }   
   }
	
</script>
