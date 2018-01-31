<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Adnuistrator
  - Date: 2018-01-23 09:46:46
  - Description:
-->
<head>
<title>班组定义</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>
<script
	src="<%= request.getContextPath() %>/js/DataBase/Team/TeamMain.js?v=1.0.1"></script>





</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">

	<div class="nui-toolbar" id="form1"
		style="height: 30px; padding: 2px; border-bottom: 0;">
		<input class="nui-hidden" name="criteria/_entity"
			value="com.hsapi.repair.DataBase.RpbClass" />
		<table class="table" id="table1" style="height: 100%">
			<tr style="width: 100%; height: 12%; line-height: 12%;">
				<td><label style="font-family: Verdana;">快速查询：</label> <a
					class="nui-button" plain="true" onclick="onSearch(0)">已启用</a> <a
					class="nui-button" plain="true" onclick="onSearch(1)">已禁用</a> <a
					class="nui-button" plain="true" onclick="onSearch(2)">全部</a></td>
			</tr>
		</table>
	</div>



	<div class="nui-splitter" style="width: 100%; height: 100%;"
		showHandleButton="false">
		<div size="45%" showCollapseButton="false">
			<!-- 班组 -->
			<div class="nui-toolbar"
				style="padding: 2px; border-top: 0; border-left: 0; border-bottom: 0;">
				<table style="width: 100%">
					<tr>
						<td style="white-space: nowrap;"><a class="nui-button"
							id="add" iconCls="icon-add" onclick="addTeam()" plain="true">添加班组</a>
							<a class="nui-button" id="update" iconCls="icon-edit"
							onclick="editTeam()" plain="true">编辑班组</a> <a class="nui-button"
							id="forbidden" iconCls="icon-no" onclick="disableTeam()"
							plain="true">禁用班组</a></td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="leftGrid" dataField="rpbclass" class="nui-datagrid"
					style="width: 100%; height: 95%;"
					url="com.hsapi.repair.team.TeamQuery.biz.ext" pageSize="20"
					showPageInfo="true" multiSelect="true" showPageIndex="false"
					showPage="true" showPageSize="false" showReloadButton="false"
					showPagerButtonIcon="false" totalCount="total"
					onselectionchanged="onSelectionChanged" allowSortColumn="true"
					selectOnLoad="true" onrowdblclick="editTeam"
					onrowclick="onLeftGridRowClick">

					<div property="columns">
						<div type="indexcolumn" headerAlign="center">序号</div>
						<div header="班组信息" headerAlign="center">
							<div property="columns">
								<div id="" field="" headerAlign="center" allowSort="true"
									visible="true">维修工种</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true" visible="true">班组名称</div>
								<div id="captainName" field="captainName" headerAlign="center"
									allowSort="true" visible="true">班组长名字</div>
								<div id="isDisabled" field="isDisabled" headerAlign="center"
									allowSort="true" visible="true" renderer="onIsDisabled">是否禁用</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div showCollapseButton="false" style="border-left: 0">
			<!-- 班组成员-->
			<div class="nui-toolbar" id="div_1"
				style="border-bottom: 0; padding: 0px;">

				<table style="width: 100%">
					<tr>
						<td style="white-space: nowrap;"><a class="nui-button"
							plain="true" iconCls="icon-add" onclick="addTeamMember()">添加成员</a>
							<a class="nui-button" plain="true" iconCls="icon-no"
							onclick="disableTeamMember()" id="disabledRight">禁用成员</a></td>
					</tr>
				</table>
			</div>
			<div class="nui-fit">
				<div id="rightGrid" dataField="rpbClassMembers" class="nui-datagrid"
					style="width: 100%; height: 95%;"
					url="com.hsapi.repair.team.TeamMemberQuery.biz.ext" pageSize="20"
					showPageInfo="true" multiSelect="true" showPageIndex="false"
					showPage="true" showPageSize="false" showReloadButton="false"
					showPagerButtonIcon="false" totalCount="total"
					allowSortColumn="true" selectOnLoad="true"
					onrowdblclick="disableTeamMember" ondrawcell="onDrawCell">
					<div property="columns">
						<div id="" field="" headerAlign="center" allowSort="true"
							visible="true" width="30px">序号</div>
						<div header="成员信息" headerAlign="center">
							<div property="columns">
								<div id="code" field="code" headerAlign="center"
									allowSort="true" visible="true">成员编号</div>
								<div id="name" field="name" headerAlign="center"
									allowSort="true">班组成员</div>
								<div id="idDisabled" field="idDisabled" headerAlign="center"
									allowSort="true">是否禁用</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<script type="text/javascript">
    	nui.parse();
    	
    	var grid = nui.get("leftGrid");
    	var grid2 = nui.get("rightGrid");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	
		
		
		
        function onSelectionChanged(e) {
        
            var dgrid = e.sender;
            var record = dgrid.getSelected();
            if (record) {
                grid2.load({ grid: record.id });
            }
        }
    	//重新刷新页面
    	function refresh(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false);
    		grid.load(json);
    		nui.get("update").enable();
    	}
    	//查询
    	function search(){
    		var form = new nui.Form("#form1");
    		var json = form.getData(false, false)
    		grid.load(json);
    	}
    	//重置查询条件
    	function reset(){
    		var form = new nui.Form("#form1");
    		grid.reset();
    	}
    	//enter键触发
    	function onKeyEnter(e){
    		search();
    	}
    	//选择列（判定，大于一编辑禁用）
    	function selectionChanged(){
    	    var rows = grid.getSelecteds();
    	    if(rows.length>1){
    	        nui.get("update").disable();
    	    }else{
    	        nui.get("update").enable();
    	    }
    	}
    	
    	
    	function addTeamMember(){
    		nui.open({
    			url:"TeamMemberAdd.jsp",
    			title:"添加班组成员",width:400,height:200,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"add"};
    			    iframe.contentWindow.setFormData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    		
    	}
    	
    	
    	    
    	    
    	    
    	
    </script>
</body>
</html>