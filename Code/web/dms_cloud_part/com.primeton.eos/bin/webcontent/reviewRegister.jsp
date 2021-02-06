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
<title>注册审核</title>
	<%@include file="/common/sysCommon.jsp"%>
	<%@include file="/common/commonCloudPart.jsp"%>
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
<script src="<%=webPath + contextPath%>/eos/js/review_register.js?v=1.1"
	type="text/javascript"></script>
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
						
				<a class="nui-menubutton "menu="#popupMenu2"id="timeStatus" name="timeStatus">所有</a>
               		
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
                	<label style="font-family: Verdana;" title="点击清空条件"><span>业务状态：</span></label> 
					<a class="nui-menubutton"  menu="#popupMenu1"  id="assignStatus" name="assignStatus">所有</a>
                	<ul id="popupMenu1" class="nui-menu" style="display:none;">
	                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus,'')" id="typeAll">所有</li>
	                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 0)" id="type0">未处理</li>
	                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 1)" id="type1">已审核</li>
	                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus, 2)" id="type2">审核未通过</li>
               		</ul>	
               		<li class="separator"></li>
                	<label style="font-family: Verdana;">开始日期 从：</label>
					<input class="nui-datepicker width1"name="guestFullName" style="width:width2M "/>
					<label style="font-family: Verdana;"> 至：</label>
					<input class="nui-datepicker width1"name="guestFullName" style="width:width2M "/>
					<li class="separator"></li>
					<a class="nui-button"  plain="true"
					 id="query" enabled="true"  onclick="superSearch">查询</a>
						<a class="nui-button"  plain="true"
					 id="query" enabled="true"  onclick="superSearch">审核</a>
			 	</td>
			</tr>
		</table>
	</div>
	
	
		<div class="nui-fit">
		<!-- 供应商排行  -->
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="20"
				sizeList="[20,30,50]" allowAlternating="true" multiSelect="true"
			    url="<%=apiPath + frmApi%>/com.hsapi.cloud.part.register.review.allRegister.biz.ext" 
				>
				<div property="columns" width="10">
						<div type="checkcolumn">选择</div>
				 		<div field="type" allowSort="true" headerAlign="center"
								width="120"  >用户分类</div>
						<div field="mobile" allowSort="true" headerAlign="center"
								width="120"  >手机号</div>
						<div field="name" allowSort="true" headerAlign="center"
								width="120"  >用户名称</div>
					    <div field="companyName" allowSort="true" headerAlign="center"
								width="120"  >公司名称</div>
						<div field="provinceId" allowSort="true" headerAlign="center"
								width="120"  >省份ID</div>
						<div field="cityId" allowSort="true" headerAlign="center"
								width="120"  >城市ID</div>
						<div field="status" allowSort="true" headerAlign="center"
								width="120"  >状态</div>
						<div field="isDisabled" allowSort="true" headerAlign="center"
								width="120"  >是否禁用</div>
						<div field="recorder" allowSort="true" headerAlign="center"
								width="120"  >建档人</div>
						<div field="recordDate" allowSort="true" headerAlign="center"
								width="120"  >建档日期</div>
								
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