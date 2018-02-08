<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-01 16:06:07
  - Description:
-->
	
<head>
<title>客户选择</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <style type="text/css">
    	#button {
    		margin-top:-7px;
    	}
    </style>
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<div  class="nui-toolbar"  style="height:60px;width:100%" >
		<div  class="nui-form1" id="form1" style="height:100%">
			<input class="nui-hidden" name="criteria/_entity" value=""/>
			<table style="table-layout: fixed;" class="nui-form-table">
				<tr style="display: block; ">
					<td class="form_label" width="62px">
						<span style="margin-left: 2px;">查询选项：</span>
					</td>
					<td colspan="1">
						<input class="nui-combobox" width="120px" valueFromSelect="true"/>
					</td>
					<td class="form_label" width="70px">
						<span style="margin-left: 10px;">查询值：</span>
					</td>
					<td colspan="1">
						<input class="nui-textbox"  width="150px" />
					</td>
					<td >
						<div  class="nui-radiobuttonlist" valueField="id" repeatItems="2" textField="text" repeatLayout="table" 
							  data="[{ id: 0, text: '本店资料 '},{ id: 1, text: '所有资料' }]" value="0">
						</div>
						
					</td>
					<td>
						<a class="nui-button" plain="true" iconCls="icon-search" onclick="onSearch()">查询（Q）</a>
		                <a class="nui-button" plain="true" iconCls="icon-downgrade" onclick="onNext()">下一页（P）</a>
		                <a class="nui-button" plain="true" iconCls="icon-ok" onclick="onOk()">选择（X）</a>
					</td>
				</tr>
				<tr>
					<td>
						<div style="height: 0; width: 102%; border: 0.6px solid #AAAAAA; margin:-1px 0;"></div>
					</td>
				</tr>
				<tr >
					<td>
						<a class="nui-button" plain="true" id="button" iconCls="icon-add" onclick="onAdd()">新增客户（N）</a>
		                <a class="nui-button" plain="true" id="button" iconCls="icon-edit" onclick="onEdit()">修改客户（M）</a>
		                <a class="nui-button" plain="true" id="button" iconCls="icon-no" onclick="onCancel()">关闭（C）</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	    	<div  class="nui-fit" >
	    		<div  class="nui-datagrid" id="datagrid1" dataField="" style="width:100%;height:100%" url=""
		        	  pageSize="20" showPageInfo="false" multiSelect="true"
					  showPageIndex="false" showPage="false" showPageSize="false"
					  showReloadButton="false" showPagerButtonIcon="false"
				   	  allowSortColumn="true" showFooter="false">	
		        	
				    <div property="columns">
				    	<div type="indexcolumn" width="30px">序号</div>
						<div header="联系人" headerAlign="center">
				    		<div property="columns">
						    	<div field="" width="50px" headerAlign="center" allowSort="true">
						        	姓名
						        </div>
						        <div field="" width="50px" headerAlign="center" allowSort="true">
						        	身份
						        </div>
						    </div>
				    	</div>
				    	<div header="车辆信息" headerAlign="center">
				    		<div property="columns">
						    	<div field="" width="60px" headerAlign="center" allowSort="true">
						        	车牌号
						        </div>
						        <div field="" width="50px" headerAlign="center" allowSort="true">
						        	品牌
						        </div>
						        <div field="" width="60px" headerAlign="center" allowSort="true">
						        	车型
						        </div>
						        <div field="" width="30px" headerAlign="center" allowSort="true">
						        	状态
						        </div>
						        <div field="" width="80px" headerAlign="center" allowSort="true">
						        	来厂次数
						        </div>
						    </div>
				    	</div>
				        <div header="客户信息" headerAlign="center">
				    		<div property="columns">
						    	<div field="" width="90px" headerAlign="center" allowSort="true">
						        	客户名称
						        </div>
						        <div field="" width="80px" headerAlign="center" allowSort="true">
						        	联系人手机
						        </div>
						        <div field="" width="80px" headerAlign="center" allowSort="true">
						        	联系人电话
						        </div>
						    </div>
				    	</div>
				    	<div header="辅助信息" headerAlign="center">
				    		<div property="columns">
						    	<div field="" width="100px" headerAlign="center" allowSort="true">
						        	底盘号
						        </div>
						        <div field="" width="80px" headerAlign="center" allowSort="true">
						        	发动机号
						        </div>
						    </div>
				    	</div>
				    </div>
				</div>
			</div>
	<script type="text/javascript">
    	nui.parse();
    	
    	var grid = nui.get("datagrid1");
    	var formData = new nui.Form("#form1").getData(false, false);
    	grid.load(formData);
    	
    	function onAdd(){
    		nui.open({
    			url:"../../common/subpage/customerSubpage/AddEditCustomer.jsp",
    			title:"新增客户",
				width:460,
    	        height:640,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"add"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function onEdit(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"../../common/subpage/customerSubpage/AddEditCustomer.jsp",
    	            title:"修改客户",
    	            width:460,
    	            height:640,
    	            onload:function(){
    	                var iframe = this.getIFrameEl();
    	                var data = {pageType:"edit",record:{comguest:row}};
    	                //直接从页面获取，不用去后台获取
    	                iframe.contentWindow.setData(data);
    	            },
    	            ondestroy:function(action){
    	                if(action == "saveSuccess"){
    	                    grid.reload();
    	                }
    	            }
    	        });
    	    }else {
    	        nui.alert("请选中一条数据", "系统提示");
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
    	
    	//关闭窗口
        function CloseWindow(action) {
        	if (action == "close" && form.isChanged()) {
            	if (confirm("数据被修改了，是否先保存？")) {
            		saveData();
                }
            }
                if (window.CloseOwnerWindow)
                return window.CloseOwnerWindow(action);
                else window.close();
        }
    	//取消
        function onCancel() {
        	CloseWindow("cancel");
        }
    </script>
</body>
</html>