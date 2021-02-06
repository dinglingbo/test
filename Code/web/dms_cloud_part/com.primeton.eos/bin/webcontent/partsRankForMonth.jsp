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
<title>配件类型采购汇总按月排行</title>
	<%@include file="/common/sysCommon.jsp"%>
	<%@include file="/common/commonCloudPart.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />

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
                	<label style="font-family: Verdana;">开始日期 从：</label>
					<input class="nui-datepicker"name="guestFullName" style="width:width2M "/>
					<label style="font-family: Verdana;"> 至：</label>
					<input class="nui-datepicker"name="guestFullName" style="width:width2M "/>
					
				<label
					style="font-family: Verdana;">分店名称：</label> 
				
				 <input
					name="isPrimaryBusiness" id="isPrimaryBusiness"  
					class="nui-combobox width1" 
				 />
				 	<label
					style="font-family: Verdana;">配件类型编码：</label> 
					 <input
					name="isPrimaryBusiness" id="isPrimaryBusiness"  
					class="nui-textbox width1"/>
				<label
					style="font-family: Verdana;">配件类型名称：</label> 
				 <input
					name="isPrimaryBusiness" id="isPrimaryBusiness"  
					class="nui-textbox width1"/>
				
				 <input
					name="isPrimaryBusiness" id="isPrimaryBusiness"  
					class="nui-checkbox"/>
						<label
					style="font-family: Verdana;">包含内部供应商：</label> 
					<li class="separator"></li>
					<a class="nui-button" iconCls="icon-find" plain="true"
					 id="query" enabled="true"  onclick="superSearch">查询</a>
			 		<li class="separator"></li>
					<a class="nui-button" plain="true"
					onclick="sh()" id="shbutton" enabled="true">导出</a>
				
				</td>
			</tr>
		</table>
	</div>
	
	
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
				 		<div header="     ">
							<div property="columns" width="10">
						
						<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >分店名称</div>
						<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >配件类型分类</div>
						<div field="rpCode" allowSort="true" headerAlign="center"
								width="120"  >配件类型名称</div>
					   	
								
						</div>
						</div>
				
					 		<div header="Grand total">
							<div property="columns" width="10">
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