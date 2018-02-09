<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 17:32:01
  - Description:
-->
<head>
<title>客户索赔</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js"
	type="text/javascript"></script>

</head>
<body style="margin: 0; height: 100%; width: 100%; overflow: hidden">
	<div  class="nui-toolbar"  style="height:26px">
		<div class="nui-form1" id="form1" style="height: 100%">
			<input class="nui-hidden" name="criteria/_entity" value="" />
			
			<table class="table" id="table1" style="height: 100%;">
				<tr style="display: block; margin:-3px 0">
					<td>
						<label style="font-family:Verdana;">快速查询：</label>
					</td>
					<td>
						<a class="nui-button"  plain="true">开始日期：</a>
					</td>
					<td>
						<input class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd"/>
					</td>
					<td>
						<a class="nui-button"  plain="true">结束日期：</a>
					</td>
					<td>
					<input class="nui-datepicker" viewDate="new Date()" format="yyyy-MM-dd"/>
					</td>
					<td>
						<a class="nui-button"  plain="true">车牌号：</a>
					</td>
					<td>
						<input class="nui-combobox"  />
					</td>
					<td>
						<a class="nui-button"  plain="true">结算状态：</a>
					</td>
					<td>
						<input class="nui-combobox"  />
					</td>
					<td>
						<a class="nui-button" iconCls="icon-search" onclick="search()" plain="true">查询</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-toolbar"  style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<a class="nui-button" plain="true" iconCls="icon-add" onclick="register()">登记</a> 
					<a class="nui-button" plain="true" iconCls="icon-ok" onclick="onOk()">处理</a>
					<a class="nui-button" plain="true" iconCls="icon-search" onclick="check()">查看</a> 
					<a class="nui-button" plain="true" iconCls="icon-undo" onclick="relist()">返单</a> 
					<a class="nui-MenuButton" plain="true" iconCls="icon-print"  menu="#printMenu">打印（P）</a>
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">


		<div class="nui-fit">
			<div id="datagrid1" dataField="rpbclass" class="nui-datagrid"
				style="width: 100%; height: 100%;"
				url=""
				pageSize="20" showPageInfo="true" multiSelect="true"
				showPageIndex="false" showPage="true" showPageSize="false"
				showReloadButton="false" showPagerButtonIcon="false"
				totalCount="total" onselectionchanged="selectionChanged"
				allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="4">


				<div property="columns">
					<div field="type" headerAlign="center" allowSort="true"
						visible="true" width="30px">序号</div>
					<div header="基本信息" headerAlign="center">
						<div property="columns">
							<div field="type" headerAlign="center" allowSort="true"
								visible="true" width="100px">索赔单号</div>
							<div field="name" headerAlign="center" allowSort="true"
								visible="true" width="60px">索赔类型</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">预索赔日期</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="60px">结算状态</div>
						</div>
					</div>
					<div header="费用信息" headerAlign="center">
						<div property="columns">
							<div field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">工时金额</div>
							<div field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">配件金额</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">其他费用</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">折让金额</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">结算金额</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">机电提成</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">钣金提成</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">喷漆提成</div>
						</div>
					</div>
					<div header="维修业务" headerAlign="center">
						<div property="columns">
							<div field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">业务单号</div>
							<div field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">业务顾问</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">维修日期</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">离厂日期</div>
						</div>
					</div>
					<div header="客户信息" headerAlign="center">
						<div property="columns">
							<div field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">客户名称</div>
							<div field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">车牌号</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">厂牌</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">车型</div>
						</div>
					</div>
					<div header="仓库审核信息" headerAlign="center">
						<div property="columns">
							<div field="type" headerAlign="center" allowSort="true"
								visible="true" width="80px">审核状态</div>
							<div field="name" headerAlign="center" allowSort="true"
								visible="true" width="80px">审核日期</div>
							<div field="captainName" headerAlign="center"
								allowSort="true" visible="true" width="80px">审核人</div>
						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<ul id="printMenu" class="nui-menu" style="display:none;">
		<li class="separator"></li>
        <li onclick="print()">打印维修委托单（A）</li>
        <li>打印派工单（C）</li>
	    <li>打印结算单（E）</li>
	    <li>打印出单结算单（F）</li>
    </ul>

	<script type="text/javascript">
    	nui.parse();
    	
    	function register(){
    		nui.open({
    			url:"./subpage/ClaimRegister.jsp",
    			title:"索赔登记",width:880,height:640,
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
    	function onOk(){
    		nui.open({
    			url:"./subpage/ClaimRegister.jsp",
    			title:"索赔登记",width:880,height:640,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"onOk"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    	function check(){
    		nui.open({
    			url:"./subpage/CheckClaimRegister.jsp",
    			title:"索赔登记",width:880,height:640,
    			onload:function(){
    			    var iframe = this.getIFrameEl();
    			    var data = {pageType:"register"};
    			    iframe.contentWindow.setData(data);
    			},
    			
    		    ondestroy:function(action){
    		    grid.reload();
    		}	
    		});
    	}
    </script>
</body>
</html>