<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>采购排行分析</title>
	<%@include file="/common/sysCommon.jsp"%>
	<%@include file="/common/commonCloudPart.jsp"%>

</head>
<body>
	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;"
		id="queryForm">
		<input class="nui-textbox" name="rOrp" id="rOrp" value="1" style="display: none;"></input>
		<table style="width: 100%;">
			<tr>
				<td>
					
					<!-- style="white-space:nowrap;"--> <label
					style="font-family: Verdana;" title="点击清空条件"><span
						onclick="clearQueryForm()">快速统计：</span></label> 
							<li class="separator"></li> 
				<a class="nui-menubutton " iconCls="icon-tip" menu="#popupMenu2"id="timeStatus" name="timeStatus">所有</a>
               		
               	 <ul id="popupMenu2" class="nui-menu" style="display:none;">
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus,'')" >所有</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'today')" >本日</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'tomorrow')" >昨日</li>
               		<li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'week')" >本周</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'month')" >本月</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'smounth')" >上月</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'year')" >本年</li>
                	</ul>		
				
                	<li class="separator"></li> 
				<label
					style="font-family: Verdana;">门店名称：</label> 
				

					
				 <input
					name="isPrimaryBusiness" id="isPrimaryBusiness"  
					class="nui-combobox width2" textField="text" valueField="value"
					data="const_yesno" emptyText="请选择..." allowInput="false"
					valueFromSelect="true" showNullItem="false" nullItemText="请选择..." />
					<li class="separator"></li>
					<a class="nui-button" iconCls="icon-find" plain="true"
					 id="query" enabled="true"  onclick="superSearch">查询</a>
			 
					<a class="nui-button" plain="true"
					onclick="sh()" id="shbutton" enabled="true">导出</a>
					<a href="javascript:superSearch()" >更多</a> 
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-tabs" style="height: 100%;">
	<div title="供应商排行">
	
		<div class="nui-fit">
		<!-- 供应商排行  -->
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			    url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" 
				onselectionchanged="statuschange"
				dataField="data" idField="id" treeColumn="name"
				parentField="parentId">
				<div property="columns" width="10">
				 	<div type="indexcolumn">序号</div>
				 	<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >公司名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >供应商编号</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >所属体系</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >供应商分类</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >供应商等级</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >供应商名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库金</div>
						
				</div>
			</div>
	
		</div>
	</div>
 	<div title="按商品排行">
 	
 			<div class="nui-fit">
		<!-- 按商品排行  -->
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			    url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" 
				onselectionchanged="statuschange"
				dataField="data" idField="id" treeColumn="name"
				parentField="parentId">
				<div property="columns" width="10">
				 	<div type="indexcolumn">序号</div>
				 	<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >公司名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >配件内码</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >商品名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >品牌</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >规格</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >适用车型</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >OE码</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实物码</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库金</div>
												
				</div>
			</div>
			</div>
	</div>
	 <div title="按品牌分析">
	 		<div class="nui-fit">
		<!-- 按品牌分析  -->
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			    url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" 
				onselectionchanged="statuschange"
				dataField="data" idField="id" treeColumn="name"
				parentField="parentId">
				<div property="columns" width="10">
				 	<div type="indexcolumn">序号</div>
				 	<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >公司名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >配件内码</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >商品名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库金</div>
												
				</div>
			</div>
			</div>
	</div>
	 <div title="按配件类型排行">
		 		<div class="nui-fit">
		<!-- 按配件类型排行  -->
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			    url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" 
				onselectionchanged="statuschange"
				dataField="data" idField="id" treeColumn="name"
				parentField="parentId">
				<div property="columns" width="10">
				 	<div type="indexcolumn">序号</div>
				 	<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >公司名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >类型编码</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >类型名称</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >入库金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >退货金额</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库数量</div>
							<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >实际入库金</div>
												
				</div>
			</div>
			</div>
	</div>
	</div>
</body>
<script type="text/javascript">

		 function superSearch(){
		 nui.open({
             url: "superSearch.jsp",
             title: "收款", width: 600, height: 350,
             onload: function () {
              },
             ondestroy: function (action) {
             }
         });}

</script>
</html>