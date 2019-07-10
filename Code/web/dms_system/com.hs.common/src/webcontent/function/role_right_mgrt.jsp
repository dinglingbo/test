<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/common/sysCommon.jsp"%>

<html>
<!--
  - Author(s): steven
  - Date: 2018-05-30 08:57:57
  - Description:
-->
<head>
    <title>角色权限管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script>
		var defDomin = "<%=request.getContextPath()%>";
	</script>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
        font-family: Microsoft YaHei !important;
    }

    .mini-toolbar {
        border: 0px  solid #ccc !important;
        border-bottom: 1px solid #ccc !important;
        /* background: #fafafa; */
    }

    .mini-grid-headerCell, .mini-grid-topRightCell { 
        border-right: #c5c5c5 0px solid;
    }

    .mini-grid-headerCell {
     border-right: #A5ACB5 0px solid;
 }


 .mini-grid-cell, .mini-grid-headerCell, .mini-grid-filterCell, .mini-grid-summaryCell {
     border-right: #d2d2d2 0px solid;
 } 

 .mini-grid .mini-grid-rightCell {
    border-right-width: 0px; 
}

</style> 
</head>
<body> 


    <div class="nui-splitter" style="width: 100%; height: 100%;">
        <div size="270" showcollapsebutton="true">
           <!--  <div class="nui-toolbar"  >
                <a class="nui-button" plain="true" onclick="queryRole()"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
                <a class="nui-button" plain="true" onclick="editRole('new')"><i class="fa fa-plus"></i>&nbsp;新增</a> 
                <a class="nui-button" plain="true" onclick="editRole('edit')"><i class="fa fa-pencil"></i>&nbsp;修改</a>
                <a class="nui-button" plain="true" onclick="deleteRole()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>

            </div> -->
            <div class="nui-fit" >
            <div id="leftGrid2" class="nui-datagrid" dataField="roleList" style="width: 100%; height: 100%;" 
                idField="roleId" allowResize="true"
                sizeList="[20,50,100]" 
                pageSize="20" 
                totalField="page.count" 
                showPager="true" 
                onselectionchanged="onLeftGridSelectionChanged"
                showPagerButtonIcon="true" >
                
                <div property="columns">
                    <div type="indexcolumn" name="index" width="30px" headeralign="center" >  <strong>序号</strong></div>
                    <div field="roleId" width="140" headeralign="left" visible="false"><strong>角色名称</strong></div>
                    <div field="roleCode" width="140" headeralign="left" visible="false"><strong>角色编码</strong></div>
                    <div field="tenantId" width="140" headeralign="left" visible="false"><strong>租户ID</strong></div>
                    <div field="roleName" width="140" headeralign="left" ><strong>角色名称</strong></div>
                    <div field="roleDesc" width="140" headeralign="left" visible="false"><strong>角色描述</strong></div>
                </div>
            </div> 
            </div>

        </div>
        <div showcollapsebutton="true">
            <div id="mainTabs" name="mainTabs" class="nui-tabs" activeIndex="0" style="width:100%;height:100%;padding:0px;" bodyStyle="padding:0;border:0;" onactivechanged="ontopTabChanged">
                <div title="PC权限" name="resTab"  url=""></div>
                <div title="APP权限" name="appTab"  url=""></div>
                <!-- <div title="员工" name="userTab" url=""></div> -->
             </div>
        </div>
</div>
<div id="roleForm" class="nui-window" title="窗体" style="width:500px;height:200px;"  allowDrag="true" >
    <input id="roleId" name="roleId" class="nui-hidden" />
    <input id="roleCode" name="roleCode" class="nui-hidden" />
    <input id="tenantId" name="tenantId" class="nui-hidden" />
    <table style="table-layout: fixed; border-collapse:separate;border-spacing:5px; ">
        <tr>
            <td style="width: 90px;text-align:right">角色名称：</td>
            <td><input class="nui-textbox"  id="roleName" name="roleName" style="width: 324px;"/></td>

        </tr>

        <tr>
            <td style="width: 90px;text-align:right">角色描述：</td>
            <td colspan="3"><input class="nui-textarea" id="roleDesc" name="roleDesc" style="width: 324px;height:60px;"  /></td>
            </tr>
        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="save()" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>
    
   <script type="text/javascript"> 
 
	var baseUrl = apiPath + sysApi + "/";
	var leftGridUrl = baseUrl + "com.hsapi.system.tenant.tenant.queryTenantRole.biz.ext";
	/* var saveUrl = baseUrl + "com.hsapi.system.tenant.role.saveRole.biz.ext";
	var deleteRoleUrl = baseUrl + "com.hsapi.system.tenant.role.deleteRole.biz.ext"; */
	
	var leftGrid2;
	var roleForm;
	var action;
	var mainTabs = null;
	var tenantId = null;
    var tenantType = null;
	$(document).ready(function(v) {
		leftGrid2 = nui.get("leftGrid2");
		leftGrid2.setUrl(leftGridUrl);
	    roleForm = new nui.get("#roleForm");
	    mainTabs = nui.get("mainTabs");
	    getTenantId();
	    queryRole();
	});
	
	function queryRole() {
	    var params = {};
	    params.tenantId = tenantId;
	    leftGrid2.load({
	        params:params,
	        token:token
	    });  
	
	    /* var db = new nui.DataBinding();
	    db.bindForm("roleForm", leftGrid2); */    
	}
	
	function getTenantId(){
		tenantId = <%= request.getParameter("tenantId")%>;
		tenantType = <%= request.getParameter("tenantType")%>;
	}
	
	/* function editRole(action) {
	    var row = {};
	    if (action != 'new') {
	        var row = leftGrid.getSelected();
	        if (!row) {
	            alert("请选中一条记录");
	            return;
	        }   
	    } else {
	        var timestamp = new Date().getTime();
	        var newRow = {roleName: "新角色", roleCode: timestamp};
	        leftGrid.addRow(newRow, 0);
	
	        leftGrid.deselectAll();
	        leftGrid.select(newRow);
	    }
	    action = action;
	    var title = action == 'new' ? '新增角色' : '修改角色';
	    roleForm.setTitle(title);
	    roleForm.showAtPos("center", "middle");   
	} */
	
	function save() {
	    var role = leftGrid.getChanges();
	    var json = nui.encode(role);
	    
	    if (action == 'new') {
	        role = {action: action};
	    } else {            
	        var row = leftGrid.getSelected();
	        role.roleId = row.roleId;   
	    }
	
	    nui.mask({
	        el : document.body,
	        cls : 'mini-mask-loading',
	        html : '保存中...'
	    });
	
	    nui.ajax({
	        url:saveUrl,
	        type:"post",
	        data:JSON.stringify({
	            capRole: role[0],
	            token:token
	        }),
	        success:function(data)
	        {
	            nui.unmask();
	            if (data.errCode == "S"){
	                roleForm.hide();
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
	
	function deleteRole() {
	    var row = leftGrid.getSelected();
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
	
	function onCancel(e) {
	    roleForm.hide();
	}
	function onLeftGridSelectionChanged() {
	    var row = leftGrid2.getSelected();
	
	    loadResAndUser(row);
	}
	function loadResAndUser(row) {
	    if (row) {
	        var roleId = row.roleId||0;
	        var roleCode = row.roleCode||"";
	        var roleName = row.roleName||"";
	        var tenantId = row.tenantId||0;
	        var tab = mainTabs.getActiveTab();
	        var falg = 1;
	        if(tab.name == "resTab"){
	            mainTabs.loadTab(webPath + defDomin + "/common/function/function_role_auth.jsp?roleId="+roleId+"&roleCode="+roleCode+"&roleName="+roleName+"&tenantId="+tenantId+"&falg="+falg+"&token="+token, tab);  
	        }else if(tab.name == "userTab"){
	            mainTabs.loadTab(webPath + defDomin + "/common/function/employee_auth.jsp?roleId="+roleId+"&falg="+falg+"&token="+token, tab);   
	        }else if(tab.name == "appTab"){
	            mainTabs.loadTab(webPath + defDomin + "/common/function/app_role_auth.jsp?roleId="+roleId+"&roleCode="+roleCode+"&roleName="+roleName+"&tenantId="+tenantId+"&falg="+falg+"&token="+token, tab);   
	        }
	    } else {
	    }
	
	}
	function ontopTabChanged(e){
	    var tab = e.tab;
	    var name = tab.name;
	
	    var row = leftGrid2.getSelected();
	    if(!row) return;
	    var roleId = row.roleId||0;
	    var roleCode = row.roleCode||"";
	    var roleName = row.roleName||"";
	    var tenantId = row.tenantId||0;
	     var falg = 1;
	    if(name == "resTab"){
	        mainTabs.loadTab(webPath + defDomin + "/common/function/function_role_auth.jsp?roleId="+roleId+"&roleCode="+roleCode+"&roleName="+roleName+"&tenantId="+tenantId+"&falg="+falg+"&token="+token, tab);  
	    }else if(name == "userTab"){
	        mainTabs.loadTab(webPath + defDomin + "/common/function/employee_auth.jsp?roleId="+roleId+"&falg="+falg+"&token="+token, tab);   
	    }else if(name == "appTab"){
	        mainTabs.loadTab(webPath + defDomin + "/common/function/app_role_auth.jsp?roleId="+roleId+"&roleCode="+roleCode+"&roleName="+roleName+"&tenantId="+tenantId+"&falg="+falg+"&token="+token, tab);   
	    }
	    
	}
    
</script>
</body>
</html>