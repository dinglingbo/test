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
   <style type="text/css">
      a.optbtn {
            width: 52px;
            /* height: 26px; */
            border: 1px #d2d2d2 solid;
            background: #f2f6f9;
            text-align: center;
            display: inline-block;
            /* line-height: 26px; */
            margin: 0 4px;
            color: #000000;
            text-decoration: none;
            border-radius: 5px;
        }
       /*  body {
            padding: 0px;
        } */
   </style>
</head>

<body>

    <!-- <div class="nui-toolbar"  >
	   <input class="nui-textbox" id="tenantId" name="tenantId" width="50" emptyText="租户ID">
	   <a class="nui-button" plain="true" onclick="refresh()"><i class="fa fa-refresh"></i>&nbsp;刷新</a>
       <a class="nui-button" plain="true" onclick="deleteMenu()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
       <a class="nui-button" plain="true" onclick="saveMenu()"><i class="fa fa-save"></i>&nbsp;保存</a>
    </div> -->
<div id="panel1" class="nui-panel" style="width:100%;" showHeader="false"
    showToolbar="true" showCollapseButton="false" showFooter="false">
    <!--toolbar-->
    <div property="toolbar" style="padding:10px;height:20px;">
    	<table style="width:100%;">
                <tr>
                <td style="width:100%;">
                      <a class="nui-button" plain="true" onclick="saveMenu()"><i class="fa fa-save"></i>&nbsp;保存</a>
                	  <a class="nui-button" plain="true" onclick="deleteMenu()"><i class="fa fa-trash-o"></i>&nbsp;删除</a>
                </td>
                <td style="white-space:nowrap;">
                	<input id="resName" name="resName" class="nui-textbox" style="width:200px;" onenter="queryRole" emptyText="请输入资源名称" />
					<a class="nui-button" style="width:60px;" iconCls="icon-search" onclick="queryRole()">查询</a>
                </td>
            </tr>
        </table> 
    </div>
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
					<div field="itemOptBtn" name="itemOptBtn" width="80" headerAlign="center" header="资源操作" align="center" ></div>
				</div>
			</div> 
		</div>
	</div>

</body>
</html>
<script type="text/javascript">
	nui.parse();
	var rightGrid = nui.get("rightGrid");
	var tenantId = null;
    var tenantType = null;
	var baseUrl = apiPath + sysApi + "/";
	var gridUrl = baseUrl + "com.hsapi.system.tenant.permissions.queryTenantFunction.biz.ext";
	
    $(document).ready(function(v) {
		rightGrid = nui.get("rightGrid");
		rightGrid.setUrl(gridUrl);
		getTenantId();
	    refresh();
	    rightGrid.on("rowdblclick",function(e){
		   edit();
	    });
	    rightGrid.on("drawcell", function (e) {
	        var record = e.record;
            var uid = record._uid;
	        var s = "";
	        if(e.field=="itemOptBtn"){
	          s = ' <a class="optbtn" href="javascript:addRow(\'' + uid + '\')">分配</a>';
	          s = s + ' <a class="optbtn" href="javascript:deletRow(\'' + uid + '\')">删除</a>';
	          e.cellHtml = s;
	        }
	    });
    });

	function refresh(){
	    var resName = nui.get("resName").getValue();
	    if(resName){
	       rightGrid.load({tenantId:tenantId,resName:resName,token:token});
	    }else{
	       rightGrid.load({tenantId:tenantId,token:token});
	    }
		
	}
    var deleteTenantMenuUrl = baseUrl + "com.hsapi.system.tenant.tenant.deleteTenantMenu.biz.ext";
	function deleteMenu(){
		var row = rightGrid.getSelected();
		var list = [];
		var temp = {};
		temp.tenantId = row.tenantId;
		if(row.tenantId<0){
		    temp.tenantType = Math.abs(row.tenantId);
		}
		list.push(temp);
		if(row){
			//rightGrid.removeRow(row);
			nui.confirm("确认删除吗？","提示",function(action) {
	            if (action == "ok") {
	                 nui.mask({
	                    el : document.body,
	                    cls : 'mini-mask-loading',
	                    html : '保存中...'
	                });
	                
	                nui.ajax({
	                    url:deleteTenantMenuUrl,
	                    type:"post",
	                    data:JSON.stringify({
	                        menu: row,
	                        list:list,
	                        token:token
	                    }),
	                    success:function(data)
	                    {
	                        nui.unmask();
	                        if (data.errCode == "S"){
	                           refresh(); 
	                           showMsg("删除成功","S");                  
	                        }else{
	                            showMsg(data.errMsg||"删除失败","E");
	                        }
	                    },
	                    error:function(jqXHR, textStatus, errorThrown){
	                        console.log(jqXHR.responseText);
	                        nui.unmask();
	                        showMsg("网络出错","E");
	                    }
	                });            
	            }
	        });
		}
	}

    function getTenantId(){
		tenantId = <%= request.getParameter("tenantId")%>;
		tenantType = <%= request.getParameter("tenantType")%>;
	}
    
	var saveUrl = baseUrl + "com.hsapi.system.tenant.permissions.saveTenantFunction.biz.ext";
	function saveMenu(){
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
				   showMsg("保存成功","W");
				   refresh();
					/* nui.alert("保存成功!","",function(e){
						refresh();
					}); */
				} else {
					showMsg(data.errMsg || "保存失败!","E");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				// nui.alert(jqXHR.responseText);
				console.log(jqXHR.responseText);
			}
		});
	}

	<%-- function setRoleId(){
		return {"roleId":"<%= request.getParameter("roleId")%>"};
	} --%>
    function addRow(row_uid){
       var row = rightGrid.getRowByUID(row_uid);
       if(row){
           nui.open({
				url : webPath + contextPath + "/common/function/select_tenant.jsp?token=" + token,
				title : "选择租户",
				width : 700,
				height : 600,
				allowDrag : true,
				allowResize : true,
				onload : function() {
					var iframe = this.getIFrameEl();
		            iframe.contentWindow.setData(row);//显示该显示的功能
				},
				ondestroy : function(action) {
				    if(action=="ok"){
				      queryRole();
				    }
					
				}
			});
       }
       
    }
    
    function deletRow(row_uid){
        var row = rightGrid.getRowByUID(row_uid);
       if(row){
           nui.open({
				url : webPath + contextPath + "/common/function/select_tenant.jsp?token=" + token,
				title : "选择租户",
				width : 700,
				height : 600,
				allowDrag : true,
				allowResize : true,
				onload : function() {
					var iframe = this.getIFrameEl();
					row.delet = 1;
		            iframe.contentWindow.setData(row);//显示该显示的功能
				},
				ondestroy : function(action) {
				    if(action=="ok"){
				      queryRole();
				    }
					
				}
			});
       }
    }

</script>
