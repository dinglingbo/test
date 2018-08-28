<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
    - Author(s): huang
    - Date: 2014-08-13 12:27:01
    - Description:
  --%>
<head>
<title>储值卡定义</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/cardList.js?v=1.3.4"></script>
</head>
<body>
	<div id="queryform" class="nui-form">
		<div class="nui-toolbar">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsapi.repair.data.rpb.RpbCardStored">
			<table id="table1">
				<tr>
					<td>会员卡名称: <input class="nui-textbox"
						name="criteria/_expr[1]/name" /> <input class="nui-hidden"
						name="criteria/_expr[1]/_op" value="like"> <input
						class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
						<a class="nui-button" onclick="search()" plain="true"> <span
							class="fa fa-search fa-lg"></span>&nbsp; 查询
					</a> <span></span> <a
						class="nui-button"  onclick="add()" plain="true">
							<span class="fa fa-plus fa-lg"></span>增加 </a> <a id="update" class="nui-button" 
						onclick="edit()" plain="true"> 
						<span class="fa fa-edit fa-lg"></span>
					修改 </a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="card" class="nui-datagrid"
			pageSize="50" onDrawCell="onDrawCell"
			onrowclick="" allowSortColumn="true"
			style="width: 100%; height: 100%;">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn" >选择</div>
				<div field="id" headerAlign="center" allowSort="true"
					visible="false">会员卡ID</div>
				<div field="name" headerAlign="center" allowSort="true">会员卡名称</div>

<!-- 				<div field="useRange" headerAlign="center" allowSort="true"> -->
<!-- 					适用范围</div> -->
				<div field="canModify" headerAlign="center" allowSort="true">
					是否允许修改金额</div>
				<div field="periodValidity" headerAlign="center" allowSort="true">
					有效期(月)</div>
				<div field="rechargeAmt" headerAlign="center" allowSort="true">
					充值金额</div>
				<div field="giveAmt" headerAlign="center" allowSort="true">
					赠送金额</div>
				<div field="totalAmt" headerAlign="center" allowSort="true">
					总金额</div>

				<div field="salesDeductType" headerAlign="center" allowSort="true">
					销售提成方式</div>
				<div field="salesDeductValue" headerAlign="center" allowSort="true">
					销售提成值</div>
				<div field="status" renderer="onstatus" headerAlign="center"
					allowSort="true">状态</div>
				<div field="remark" headerAlign="center" allowSort="true">卡说明</div>
			</div>
		</div>
	</div>
</body>
</html>