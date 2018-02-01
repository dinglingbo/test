<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 14:09:04
  - Description:
-->
<head>
<title>客户档案</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body style="margin:0;height:100%;width:100%;overflow:hidden">
	<div  class="nui-toolbar"  style="height:30px">
        	<div  class="nui-form1" id="form1" style="height:100%">
        	<input class="nui-hidden" name="criteria/_entity" value=""/>
	        	<table class="table" id="table1" style="height:100% ">
	        	   <tr>
	        	   		<td>
	        	    		<label style="font-family:Verdana;">快速查询：</label>
	        	    	
	        	         	<a class="nui-button" plain="true" onclick="onSearch(0)">本日来厂</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(1)">昨日来厂</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(2)">本日新客户</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(3)">本月新客户</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(4)">本月所有来厂客户</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(5)">本月流失回厂</a>
	                	 	<a class="nui-button" plain="true" onclick="onSearch(6)">上月流失回厂</a>
	                	</td>
	        	   </tr>
	        	</table>
        	</div>
        </div>
	
	<div class="nui-toolbar" id="div_1" style="border-bottom:0;padding:0px;">
    	<table style="width:100%">
        	<tr>
            	<td style="width:100%">
            		<a class="nui-button" iconCls="icon-add" onclick="add()" plain="true">新增（A）</a>
                    <a class="nui-button" iconCls="icon-edit" onclick="edit()" plain="true">修改（E）</a>
                    <a class="nui-button" iconCls="icon-date" onclick="amalgamate()" plain="true">资料合并</a>
                    <a class="nui-button" iconCls="icon-date" onclick="split()" plain="true">资料拆分</a>
                    <a class="nui-button" iconCls="icon-history" onclick="history()" plain="true">维修历史（W）</a>
                </td>
        	</tr>
    	</table>
    </div>
	<div  class="nui-fit">
				<div id="datagrid1" dataField="" class="nui-datagrid" style="width:100%;height:100%;" 
			         url="" 
			         pageSize="20" showPageInfo="true" multiSelect="true" showPageIndex="true" showPage="true"  showPageSize="true"
			         showReloadButton="true" showPagerButtonIcon="true"  totalCount="total"
			         onselectionchanged="selectionChanged" allowSortColumn="true"
			    	 virtualScroll="true" virtualColumns="true"
			    	 frozenStartColumn="0" frozenEndColumn="7"
			    >
			                
			        <div property="columns">
			        	<div width="30px" type="indexcolumn">序号</div>
				    	<div header="车辆信息" headerAlign="center" >
				    		<div property="columns">
				    			<div id="type" field="type" headerAlign="center" allowSort="true" visible="true" width="80px">车牌号</div>
						    	<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="80px">品牌</div>
							    <div id="captainName" field="captainName" headerAlign="center" allowSort="true" visible="true"width="80px">车型</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="120px">VIN</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="80px">保险到期</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="80px">年审日期</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="80px">投保公司</div>
				    		</div>
				    	</div>
				    	<div header="客户信息" headerAlign="center">
				    		<div property="columns">
				    			<div id="type" field="type" headerAlign="center" allowSort="true" visible="true" width="60px">档案号</div>
						    	<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="100px">客户名称</div>
							    <div id="captainName" field="captainName" headerAlign="center" allowSort="true" visible="true" width="100px">地址</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="100px">最后来厂日期</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="100px">最后离厂日期</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="50px">营销员</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="50px">建档人</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="70px">建档日期</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="70px">来厂次数</div>
							    <div id="isDisabled" field="isDisabled" headerAlign="center" allowSort="true" visible="true" width="70px">离厂天数</div>
				    		</div>
				    	</div>
				    	<div header="其他信息" headerAlign="center">
				    		<div property="columns">
				    			<div id="type" field="type" headerAlign="center" allowSort="true" visible="true" width="120px">发动机号</div>
						    	<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="80px">生产年份</div>
							    <div id="captainName" field="captainName" headerAlign="center" allowSort="true" visible="true" width="50px">颜色</div>
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
    			url:"CustomerProfileDetail.jsp",
    			title:"客户资料",width:450,height:650,
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
    	            url:"CustomerProfileDetail.jsp",
    	            title:"修改客户",
    	            width:500,
    	            height:680,
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
    	
    	function amalgamate(){
    		nui.open({
    			url:"Amalgamate.jsp",
    			title:"资料合并",width:600,height:400,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"amalgamate"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	
    	function split(){
    		nui.open({
    			url:"Split.jsp",
    			title:"资料拆分",width:800,height:430,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"split"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
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