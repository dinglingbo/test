<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-20 15:13:12
  - Description:
-->
<head>
<title>首页客服人员</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<%@ include file="/common/sysCommon.jsp"%>		
     <script src="<%=webPath + contextPath%>/common/js/setCustomer.js?v=1.0.9" type="text/javascript"></script>  
</head>
<body>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<label style="font-family:Verdana;">姓名：</label>
					<input class="nui-textbox" width="100px" id="name" name="name" onenter="search()"/>
					<label style="font-family:Verdana;">手机号码：</label>
					<input class="nui-textbox" width="100px" id="mobile" name="mobile" onenter="search()" />
					<a class="nui-button"  iconCls="" onclick="search()" plain="true"><span class="fa fa-search"></span>&nbsp;查询</a>
					<a class="nui-button" plain="true" iconCls="" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
					<a class="nui-button" plain="true" iconCls="" onclick="edit()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
					<a class="nui-button"  iconCls="" onclick="addTenantId()" plain="true"><span class="fa fa-user-o"></span>&nbsp;添加租户</a>
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" 
			dataField="rs" 
			class="nui-datagrid"
			style="width: 100%; height: 100%;"
			url=""
			showModified="false" onrowdblclick="edit()"
			pageSize="50" showPageInfo="true" multiSelect="false"
			showReloadButton="true" showPagerButtonIcon="true"
			totalField="page.count" 
			allowSortColumn="true">

			<div property="columns">			
				<div id="name" field="name" headerAlign="center" allowSort="true" visible="true" width="60px">姓名</div>
				<div id="tel" field="mobile" headerAlign="center" allowSort="true" visible="true" width="100px">手机号码</div>
				<div id="sex" field="sex" headerAlign="center" allowSort="true" visible="true" width="40px">性别</div>
				<div id="qq" field="qq" headerAlign="center" allowSort="true" visible="true" width="100px">QQ</div>
				<div id="wechat" field="wechat" headerAlign="center" allowSort="true" visible="true" width="100px">微信</div>
				<div id="email" field="email" headerAlign="center" allowSort="true" visible="true" width="100px">邮箱</div>
				<div id="birthday" field="birthday" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="60px">生日</div>
				<div id="weChat" field="weChat" headerAlign="center" allowSort="true" visible="true" width="100px">备注</div>
				<div id="remark" field="remark" headerAlign="center" allowSort="true" visible="true" width="60px">建档人</div>
				<div id="recordDate" field="recordDate" headerAlign="center" allowSort="true" visible="true" width="100px" dateFormat="yyyy-MM-dd HH:mm">建档日期</div>							
		
				
			</div>
		</div>
	</div>
</body>
</html>