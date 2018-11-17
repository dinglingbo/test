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
<title>应付账款管理</title>
	<%@include file="/common/sysCommon.jsp"%>
<script src="<%=webPath + contextPath%>/frm/js/arap/payFunds.js?v=1.0.1"
	type="text/javascript"></script>

</head>
<body>
	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;"
		id="queryForm">
			<input class="nui-textbox" name="rOrp" id="rOrp" value="-1" style="display: none;"></input>
		<table style="width: 100%;">
			<tr>
				<td>
					<!-- style="white-space:nowrap;"--> <label
					style="font-family: Verdana;" title="点击清空条件"><span
						onclick="clearQueryForm()">快速查询：</span></label> 
						
				<a class="nui-menubutton " iconCls="icon-tip" menu="#popupMenu2"id="timeStatus" name="timeStatus">所有</a>
               		
               	 <ul id="popupMenu2" class="nui-menu" style="display:none;">
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus,'')" >所有</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'today')" >本日</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'yesterday')" >昨日</li>
               		<li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'week')" >本周</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'month')" >本月</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'smounth')" >上月</li>
                    <li iconCls="icon-tip" onclick="setMenu2(this, timeStatus, 'year')" >本年</li>
                	</ul>		
				
					<li class="separator"></li> 
					<label
					style="font-family: Verdana;" title="点击清空条件"><span
						>业务状态：</span></label> 
				<a class="nui-menubutton " iconCls="icon-tip" menu="#popupMenu1"  id="assignStatus" name="assignStatus">所有</a>
                <ul id="popupMenu1" class="nui-menu" style="display:none;">
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus,'')" id="typeAll">所有</li>
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 0)" id="type0">挂账</li>
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 1)" id="type1">待审核</li>
               
                </ul>	
                	<li class="separator"></li> 
						
						
						<label
					style="font-family: Verdana;">工单号：</label> 
					<input
					class="nui-textbox" name="gd" id="gd" enabled="true" /> 
					
					
					
				 <input
					name="isPrimaryBusiness" id="isPrimaryBusiness" visible="false"
					class="nui-combobox width2" textField="text" valueField="value"
					data="const_yesno" emptyText="请选择..." allowInput="false"
					valueFromSelect="true" showNullItem="false" nullItemText="请选择..." />
					<a class="nui-button" iconCls="icon-find" plain="true"
					onclick="query()" id="query" enabled="true">查询</a>
					<li class="separator"></li> 
					<a class="nui-button" plain="true"
					onclick="sh()" id="shbutton" enabled="true">单据审核</a> <a
					class="nui-button" plain="true" id="skbutton"
					enabled="true" onclick="fk">付款</a> 
				</td>
			</tr>
		</table>
	</div>

	<div class="nui-fit">
		<div class="nui-fit">
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			    url="<%=apiPath + frmApi%>/com.hsapi.frm.setting.QueryInt.biz.ext" 
				onselectionchanged="statuschange"
				
				dataField="data" idField="id" treeColumn="name"
				parentField="parentId">
				<div property="columns" width="10">
				 	<div type="indexcolumn" >序号</div>
				 	<div field="id" allowSort="true" headerAlign="center"
				 		visible="false"width="120"></div>
					<div header="基本信息" headerAlign="center">
						<div property="columns" width="10">
	
							<div type="checkcolumn">选择</div>
							<div field="serviceCode" allowSort="true" headerAlign="center"
								width="120">工单号</div>
							<div field="guestFullName" allowSort="true" headerAlign="center"
								width="120">往来单位</div>
							<div field="serviceTypeId" allowSort="true" headerAlign="center"
								width="120">业务类型</div>
							<div field="billStatus" allowSort="true" headerAlign="center"
								width="120">业务状态</div>

						</div>
					</div>
					<div header="应付信息" headerAlign="center">
						<div property="columns" width="10">


							<div field="rpAmt" allowSort="true" headerAlign="center"
								width="120">应付金额</div>
							<div field="rpAmtYes" allowSort="true" headerAlign="center"
								width="120">已付金额</div>
							<div field="rpAmtNo" allowSort="true" headerAlign="center"
								width="120">未付金额</div>

						</div>
					</div>
				
					<div header="财务信息" headerAlign="center">
						<div property="columns" width="10">


							<div field="recorder" allowSort="true" headerAlign="center"
								width="120">结转人</div>
							<div field="recordDate" allowSort="true" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm"
								width="120">结转日期</div>
							<div field="auditor" allowSort="true" headerAlign="center"
								width="120">审核人</div>
							<div field="auditDate" allowSort="true" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm"
								width="125">审核日期</div>
						

						</div>
					</div>
					<div header="其他信息">
						<div property="columns" width="10">


							<div field="remark" allowSort="true" headerAlign="center"
								width="120">备注</div>


						</div>
					</div>
				</div>

			</div>
		</div>
		<!--
    </div>
    -->
	</div>
</body>
</html>