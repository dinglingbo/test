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
<link
	href="<%=webPath + contextPath%>/css/style1/style_form_edit.css?v=1.1"
	rel="stylesheet" type="text/css" />
<script src="<%= request.getContextPath() %>/tenant/js/review_register.js?v=1.9.2"
	type="text/javascript"></script>
</head>
<body>
	<div class="nui-toolbar" style="padding: 2px; border-bottom: 0;"
		id="queryForm">
		<input class="nui-textbox" name="rOrp" id="rOrp" value="1" style="display: none;"></input>
		<table style="width: 100%;">
			<tr>
				<td>
					
					<input class="nui-combobox" id="provinceId" visible="false" textField="name" url="" valueField="code"/>
					<input class="nui-combobox" id="cityId" visible="false" textField="name" url="" valueField="code"/>
                	<label style="font-family: Verdana;" title="点击清空条件"><span>审核状态：</span></label> 
							<a class="nui-menubutton "  menu="#popupMenu1"  id="assignStatus" name="assignStatus" >所有</a>
               	 <ul id="popupMenu1" class="nui-menu" style="display:none;">
                    <li iconCls="icon-tip" onclick="(this, assignStatus, '')" id="type1">所有</li>
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus,0)" id="typeAll">未审</li>
                    <li iconCls="icon-tip" onclick="setMenu1(this, assignStatus,1)" id="type0">已审</li>
                    </ul>	
               
               		<li class="separator"></li>
                            <label style="font-family:Verdana;">创建日期 从：</label>
                            <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                            <label style="font-family:Verdana;">至</label>
                            <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
					<li class="separator"></li>
					<a class="nui-button"  plain="true" href="javascript:query();" id="query" enabled="true"  onclick="superSearch">查询</a>
						<a class="nui-button"  plain="true"
					 id="sh" enabled="true"  onclick="audit">审核</a>
					 	<a class="nui-button"  plain="true"
					 id="jy" name="jy" enabled="true"  onclick="stopUse">禁用</a>
					  	<a class="nui-button"  plain="true" visible="false"
					 id="qy" name="qy" enabled="true"  onclick="stopUse">启用</a>
			 	</td>
			</tr>
		</table>
	</div>
	
	
		<div class="nui-fit">
		<!-- 供应商排行  -->
			<div id="dgGrid" class="nui-datagrid"
				style="width: 100%; height: 100%;" showPager="true" pageSize="10"
				sizeList="[10,20,50]" allowAlternating="true" multiSelect="true"
			    url="<%= request.getContextPath() %>/com.primeton.tenant.reView.allRegister.biz.ext" 
				onselectionchanged="changebutton"
				>
				<div property="columns" width="10">
						<div type="checkcolumn">选择</div>
						<div field="id" allowSort="true" headerAlign="center"  visible="false"
								width="120"  >用户id</div>
				 		<div field="type" allowSort="true" headerAlign="center"
								width="120"  >用户分类</div>
						<div field="mobile" allowSort="true" headerAlign="center"
								width="120"  >手机号</div>
						<div field="name" allowSort="true" headerAlign="center"
								width="120"  >用户名称</div>
					    <div field="companyName" allowSort="true" headerAlign="center"
								width="120"  >公司名称</div>
						<div field="provinceId" allowSort="true" headerAlign="center"
								width="120"  >省份</div>
						<div field="cityId" allowSort="true" headerAlign="center"
								width="120"  >城市</div>
						<div field="status" allowSort="true" headerAlign="center"
								width="120"  >审核状态</div>
						<div field="isDisabled" allowSort="true" headerAlign="center"
								width="120"  >是否禁用</div>
						<div field="recorder" allowSort="true" headerAlign="center"
								width="120"  >建档人</div>
						<div field="recordDate" allowSort="true" headerAlign="center" dateFormat="yyyy-MM-dd H:mm:ss"
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