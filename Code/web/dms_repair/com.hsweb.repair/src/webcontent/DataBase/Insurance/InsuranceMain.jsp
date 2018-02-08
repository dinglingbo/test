<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-24 09:45:50
  - Description:
-->
<head>
<title>保险公司</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/js/DataBase/Insurance/InsuranceMain.js?v=1.0.1" ></script>
    
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	
	
        <div  class="nui-toolbar"  style="height:30px">
        	<div  class="nui-form1" id="form1" style="height:100%">
        	<input class="nui-hidden" name="criteria/_entity" value="com.hsapi.repair.common.ComGuest"/>
        	
	        	<table class="table" id="table1" style="height:100% ">
	        	   <tr>
	        	   		<td>
	        	    		 <label style="font-family:Verdana;">快速查询：</label>
	        	    	
	        	         	<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(0)">已启用</a>
	                	 	<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(1)">已禁用</a>
	                	 	<a class="nui-button" plain="true" style="color:#0000FF" onclick="onSearch(2)">全部</a>
	        	        </td>
	        	   </tr>
	        	</table>
        	</div>
        </div>
    
	
	<div class="nui-toolbar" id="div_1" style="border-bottom:0;padding:0px;height:30px">
		<table style="width:100%">
			<tr >
				<td style="width:100%" >
					<a class="nui-button" id="add" iconCls="icon-add" onclick="add()" plain="true">新增（A）</a>
					<a class="nui-button" id="update" iconCls="icon-edit" onclick="edit()" plain="true">修改（E）</a>
					<a class="nui-button" id="forbidden" iconCls="icon-no" onclick="forbidden()" plain="true">禁用（L）</a>
				</td>
        	</tr>
    	</table>
    </div>
    
    <div class="nui-fit" >
		<div id="datagrid1" dataField="comguests" class="nui-datagrid" style="width:100%;height:100%;" 
             url="com.hsapi.repair.insurance.InsuranceQuery.biz.ext" 
             pageSize="20" showPageInfo="true" multiSelect="true" showPageIndex="false" showPage="true"  showPageSize="false"
             showReloadButton="false" showPagerButtonIcon="false"  totalCount="total"
             onselectionchanged="selectionChanged" allowSortColumn="true">
			<div property="columns">
				<div type="indexcolumn" >序号</div>
				<div header="保险公司信息" headerAlign="center">
					<div property="columns">
						<div id="code"  field="code" headerAlign="center" allowSort="true" width="15%">保险公司代码</div>
                    	<div id="fullName" field="fullName" headerAlign="center" allowSort="true" visible="true"width="35%">保险公司名称</div>
						<div id="contactor" field="contactor" headerAlign="center" allowSort="true" width="10%">联系人</div>
						<div id="contactorTel" field="contactorTel" headerAlign="center" allowSort="true" width="20%">联系人电话</div>
						<div id="orderIndex" field="orderIndex" headerAlign="center" allowSort="true" width="8%" dataType="int">排序号</div>
						<div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" width="12%" renderer="onIsDisabled">是否禁用</div>
						
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
    	
    	function add(){
    		nui.open({
    			url:"InsuranceDetail.jsp",
    			title:"新增保险公司",width:450,height:300,
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
    	
    	function edit(){
    	    var row = grid.getSelected();
    	    if(row) {
    	        nui.open({
    	            url:"InsuranceDetail.jsp",
    	            title:"修改保险公司",
    	            width:450,
    	            height:300,
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
    	function onIsDisabled(e) {
        if (e.value == 1) return "禁用";
        if (e.value == 0) return "启用";
    }
    	
    	//禁用
    	function forbidden(){
    	    
    	    
    	    
    	}
    	
	</script>
	
</body>
</html>