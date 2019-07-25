<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/commonPart.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-06-20 15:13:12
  - Description:
-->
<head>
<title>线上支付</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />	
     <script src="<%=webPath + contextPath%>/manage/settlement/js/onlinePayment.js?v=1.0.0" type="text/javascript"></script>  
</head>
<body>
	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<table style="width: 100%">
			<tr>
				<td style="width: 100%">
					<label style="font-family:Verdana;">姓名：</label>
					<input class="nui-textbox" width="100px" id="guestName" name="guestName" onenter="search()"/>
					<label style="font-family:Verdana;">车牌：</label>
					<input class="nui-textbox" width="100px" id="carNo" name="carNo" onenter="search()" />
					<a class="nui-button"  iconCls="" onclick="search()" plain="true"><span class="fa fa-search"></span>&nbsp;查询</a>
					<a class="nui-button" plain="true" iconCls="" onclick="invalid()"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>
<!-- 					<a class="nui-button" plain="true" iconCls="" onclick="edit()"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
					<a class="nui-button" onclick="save('edit')" plain="true" style="width: 60px;"><span class="fa fa-save fa-lg"></span>&nbsp;保存</ a> -->
					<!-- <a class="nui-button"  iconCls="" onclick="addTenantId()" plain="true"><span class="fa fa-user-o"></span>&nbsp;添加租户</a> -->
				</td>
			</tr>
		</table>
	</div>
	<div class="nui-fit">
			<div size="60%" showCollapseButton="true">
				<div id="datagrid1" 
					dataField="list" 
					class="nui-datagrid"
					style="width: 100%; height: 100%;"
					url=""
					showPager = "false"
					showModified="false" onrowclick="setTenantId()"
					pageSize="50" showPageInfo="true" multiSelect="false"
					showReloadButton="true" showPagerButtonIcon="true"
					totalField="page.count" 
					allowSortColumn="true">
					<div property="columns">			
						<div  field="billCode" headerAlign="center" allowSort="true" visible="true" width="150px">单据编号</div>
						<div  field="settleStatus" headerAlign="center" allowSort="true" visible="true" width="80px">结算状态</div>
						<div  field="guestName" headerAlign="center" allowSort="true" visible="true" width="80px">客户名称</div>
						<div  field="carNo" headerAlign="center" allowSort="true" visible="true" width="100px">车牌</div>
						<div  field="totalAmt" headerAlign="center" allowSort="true" visible="true" width="80px">金额</div>
						<div  field="remark" headerAlign="center" allowSort="true" visible="true" width="120px">备注</div>					
						<div  field="settleDate" headerAlign="center" allowSort="true" visible="true" width="150px">结算日期</div>
						<div  field="creator" headerAlign="center" allowSort="true" visible="true" width="60px">建档人</div>
						<div  field="createDate" headerAlign="center" allowSort="true" visible="true" width="120px" dateFormat="yyyy-MM-dd HH:mm">建档日期</div>											
					</div>
				</div>
			</div>       	
	</div>
</body>
</html>