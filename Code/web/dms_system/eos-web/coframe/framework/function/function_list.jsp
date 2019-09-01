<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.eos.system.utility.StringUtil"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@include file="/coframe/tools/skins/common.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): fangwl (mailto:fangwl@primeton.com)
  - Date: 2013-03-01 10:35:26
  - Description:功能列表，tab页中使用
-->
<head>
</head>
<body>
	
	
	<div class="nui-splitter" vertical="true"
		style="width: 100%; height: 100%;" allowResize="true">
		<!-- 上 -->
		<div size="60%" showCollapseButton="false">
			<div style="padding:5px 5px 0px 5px;">
				 <div class="nui-toolbar" style="border-bottom:0;">
			        <table style="width:100%;">
			            <tr>
				            <td style="width:100%;">
				                <a class="nui-button" iconCls="" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;增加</a>
				            	<a class="nui-button" iconCls="" onclick="edit()" id="edit_btn"><span class="fa fa-edit fa-lg"></span>&nbsp;编辑</a>
				            	<a class="nui-button" iconCls="" onclick="remove()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
				            </td>
			            </tr>
			        </table>
			    </div>
			</div>
		
			<div class="nui-fit" style="padding:0px 5px 5px 5px;">
				<input id="parentgroupid" name="parentgroupid" class="nui-hidden" />
			    <div id="functiongrid" class="nui-datagrid" style="width:100%;height:100%;" showPager="false"
			    url="" onselectionchanged="selectionChanged" idField="funccode" allowResize="false"
			    sizeList="[10,20,50,100]" multiSelect="true" onrowdblclick="edit()">
				    <div property="columns">
				        <div type="checkcolumn" ></div>
				        <div field="funcname" width="100" headerAlign="center" allowSort="false">功能名称</div>    
				        <div field="functype" width="100" headerAlign="center" allowSort="false" renderer="onResTypeRenderer">功能类型</div>                            
				        <div field="ismenu" width="100" headerAlign="center" allowSort="false" renderer="onIsMenuRenderer">是否定义为菜单</div>
				        <div field="appFuncgroup.funcgroupname" width="100" headerAlign="center" allowSort="false">所属功能组</div>
				    </div>
				</div>
			</div>
		</div>
		<!-- 下 -->
		<div showCollapseButton="false">
			<div style="padding:5px 5px 0px 5px;">
				 <div class="nui-toolbar" style="border-bottom:0;">
			        <table style="width:100%;">
			            <tr>
				            <td style="width:100%;">
				                <a class="nui-button" iconCls="" onclick="addBtn()"><span class="fa fa-plus fa-lg"></span>&nbsp;增加</a>
				            	<a class="nui-button" iconCls="" onclick="editBtn()" id="edit_btn"><span class="fa fa-edit fa-lg"></span>&nbsp;编辑</a>
				            	<a class="nui-button" iconCls="" onclick="removeBtn()"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
				            </td>
			            </tr>
			        </table>
			    </div>
			</div>
		
			<div class="nui-fit" style="padding:0px 5px 5px 5px;">
				<input id="funccode" name="funccode" class="nui-hidden" />
			    <div id="btngrid" class="nui-datagrid" style="width:100%;height:100%;" showPager="false"
			    url="" idField="funccode" allowResize="false"
			    sizeList="[10,20,50,100]" multiSelect="true" onrowdblclick="editBtn()">
				    <div property="columns">
				        <div type="checkcolumn" ></div>
				        <div field="code" width="100" headerAlign="center" allowSort="false">按钮编码</div> 
				        <div field="name" width="100" headerAlign="center" allowSort="false">按钮名称</div>   
				        <div field="btnArea" width="100" headerAlign="center" allowSort="false">按钮区域</div>  
				        <div field="displayorder" width="50" headerAlign="center" allowSort="false">序号</div>   
				        <div field="btndesc" width="200" headerAlign="center" allowSort="false">描述</div>
				        <div field="resId" width="100" headerAlign="center" allowSort="false">所属资源</div>
				    </div>
				</div>
			</div>
		</div>
	</div>
	
    <script type="text/javascript">
	 	nui.parse();
		var grid = nui.get("functiongrid");
		var btngrid = nui.get("btngrid");
        var parentgroupid = <%=StringUtil.htmlFilter(request.getParameter("realId")) %>;
		document.getElementById("parentgroupid").value = parentgroupid;
		var data = {funcgroupid:parentgroupid,token:token};
		//org.gocom.components.coframe.framework.FunctionManager.queryFunction.biz.ext
		var url = apiPath + sysApi + '/com.hsapi.system.tenant.permissions.queryApplication.biz.ext';
        grid.setUrl(url);
        grid.load(data);
        
        var btnUrl = apiPath + sysApi + '/com.hsapi.system.tenant.permissions.queryApplicationBtn.biz.ext';
        btngrid.setUrl(btnUrl);
		
        function add() {
            nui.open({
                url: "<%=request.getContextPath() %>/coframe/framework/function/function_add.jsp",
                title: "新增功能", 
                width: 600, 
            	height: 375,
                onload: function () {
                	var id = document.getElementById("parentgroupid").value;
                	var data = {parentgroupid:id};
                	var iframe = this.getIFrameEl();
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if(action=="ok"){
                    	parent.refresh();
                        grid.reload();
                    }
                }
            });
        }
        
        function edit() {
            var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/coframe/framework/function/function_edit.jsp",
                    title: "编辑功能", 
                    width: 600, 
           			height: 375,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                    	if(action=="ok"){
	                    	parent.refresh();
	                        grid.reload();
                        }
                    }
                });
                
            } else {
                alert("请选中一条记录");
            }
            
        }
        
        function remove() {
            var rows = grid.getSelecteds();
            var nodes = [];
            
            for(var i=0; i<rows.length;i++){
            	nodes.push({funccode:rows[i].funccode,type:"function"});//realId
            }
            //"org.gocom.components.coframe.framework.ApplicationManager.deleteApplications.biz.ext",
            if (rows.length > 0) {
                nui.confirm("确定删除选中记录？","删除确认",function(action){
	            	if(action!="ok") return;
                    var json = nui.encode({nodes:nodes,token:token});
                    $.ajax({
                         url: apiPath + sysApi + "/com.hsapi.system.tenant.permissions.deleteApplications.biz.ext",
		                type: 'POST',
		                data: json,
		                cache: false,
		                contentType:'text/json',
                        success: function (text) {
                            grid.reload();
                            parent.refresh();
                        },
                        error: function () {
                        }
                    });
                }); 
            } else {
                alert("请选中一条记录");
            }
        }
        
        function onResTypeRenderer(e) {
            if (e.value == "flow") return "页面流";
            if (e.value == "app") return "APP";
            if (e.value == "page") return "页面";
            if (e.value == "form") return "表单";
            if (e.value == "view") return "视图";
            if (e.value == "startprocess") return "启动流程";
            else return "其他";
        }
        
        function onIsMenuRenderer(e) {
            if (e.value == "1") return "是";
            else return "否";
        }
        
        function selectionChanged(){
			var rows = grid.getSelecteds();
			if(rows.length>1){
				//disable edit button
				nui.get("edit_btn").disable();
			}else{
				nui.get("edit_btn").enable();
				
				var data = {funccode:rows[0].funccode,token:token};
				btngrid.load(data);
				document.getElementById("funccode").value = rows[0].funccode;
			}
			
		}
		
		function addBtn() {
            nui.open({
                url: "<%=request.getContextPath() %>/coframe/framework/function/funcbtn_add.jsp",
                title: "新增按钮", 
                width: 600, 
            	height: 375,
                onload: function () {
                	var id = document.getElementById("funccode").value;
                	var data = {resId:id};
                	var iframe = this.getIFrameEl();
                    iframe.contentWindow.SetData(data);
                },
                ondestroy: function (action) {
                	if(action=="ok"){
                        btngrid.reload();
                    }
                }
            });
        }
		
		function editBtn() {
            var row = btngrid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/coframe/framework/function/funcbtn_edit.jsp",
                    title: "编辑按钮", 
                    width: 600, 
           			height: 375,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                    	if(action=="ok"){
	                        btngrid.reload();
                        }
                    }
                });
                
            } else {
                alert("请选中一条记录");
            }
            
        }
        
        function removeBtn() {
            var rows = btngrid.getSelecteds();
            var nodes = [];
            
            for(var i=0; i<rows.length;i++){
            	nodes.push({id:rows[i].id});//realId
            }
            //"org.gocom.components.coframe.framework.ApplicationManager.deleteApplications.biz.ext",
            if (rows.length > 0) {
                nui.confirm("确定删除选中记录？","删除确认",function(action){
	            	if(action!="ok") return;
                    var json = nui.encode({nodes:nodes,token:token});
                    $.ajax({
                         url: apiPath + sysApi + "/com.hsapi.system.tenant.permissions.deleteFuncbtns.biz.ext",
		                type: 'POST',
		                data: json,
		                cache: false,
		                contentType:'text/json',
                        success: function (text) {
                            btngrid.reload();
                        },
                        error: function () {
                        }
                    });
                }); 
            } else {
                alert("请选中一条记录");
            }
        }
		
		
	</script>
</body>
</html>