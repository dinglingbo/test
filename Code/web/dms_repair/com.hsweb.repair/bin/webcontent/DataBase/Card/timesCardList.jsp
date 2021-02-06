<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%--
- Author(s): huang
- Date: 2014-08-13 12:27:01
- Description:
  --%>
<head>
<title>计次卡定义</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/timesCardList.js?v=1.4.5">
	</script>
</head>
<body>

	<!--footer-->


	<div class="nui-toolbar" style="border-bottom: 0; padding: 0px;">
		<div id="queryform" class="nui-form" align="center">
			<!-- 数据实体的名称 -->
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsapi.repair.data.rpbse.RpbCardTimes">
			<!-- 排序字段 -->
             
			<table style="width: 100%;" id="table1">
				<tr>
					<td style="width: 100%;">计次卡名称: <input class="nui-textbox"
						name="criteria/_expr[1]/name" id="cardName" onenter="search()"/> <input class="nui-hidden"
						name="criteria/_expr[1]/_op" value="like"> <input
						class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all" >
						<a class="nui-button" onclick="search()" plain="true">
						<span class="fa fa-search fa-lg"></span> 查询 </a> 
						<a  class="nui-button"  onclick="add()" id="addBtn"
						plain="true"> <span class="fa fa-plus fa-lg"></span>增加 </a> 
						<a  class="nui-button" id="updateBtn"
						 onclick="edit()" plain="true"><span class="fa fa-edit fa-lg"></span> 修改 </a>				
						<a class="nui-button" iconCls="" plain="true" onclick="onBuy()" id = "onBuy" visible = "false"><span class="fa fa-check fa-lg"></span>&nbsp;购买</a>
							<a class="nui-button" onclick="lookCardTimes()" plain="true"> <span
							class="fa fa-search fa-lg"></span>&nbsp; 查看详情
					</a>
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" dataField="timesCard" class="nui-datagrid" 
			style="width: 100%; height: 100%;" pageSize="20" showPageInfo="true"
			onDrawCell="onDrawCell" onselectionchanged="selectionChanged"
			allowSortColumn="false">
			<div property="columns">
				<div type="indexcolumn" header="序号" width="20px"></div>
				<div type="checkcolumn" class="mini-radiobutton" header="选择" width="20px"></div>
				<div field="orgid" headerAlign="center" allowSort="true" width="20px">归属</div>
				<div field="id" headerAlign="center" allowSort="true"
					visible="false">计次卡ID</div>
				<div field="name" headerAlign="center" allowSort="true" width="100px">计次卡名称</div>
				<div field="periodValidity" headerAlign="center" allowSort="true" width="50px">
					有效期(月)</div>
				<div field="sellAmt" headerAlign="center" allowSort="true" width="50px">
					销售价格</div>
				<div field="totalAmt" headerAlign="center" allowSort="true" width="50px">
					总价值</div>
				<div field="isShare" headerAlign="center" allowSort="true" width="50px">
					是否共享</div>
				<!-- <div field="salesDeductType" headerAlign="center" allowSort="true">销售提成方式</div>
				<div field="salesDeductValue" headerAlign="center" allowSort="true">
					销售提成值</div> -->
				<div field="status" headerAlign="center" allowSort="true" width="40px">状态</div>
				<div field="useRemark" headerAlign="center" allowSort="true" width="120px">
					使用说明</div>
				<div field="remark" headerAlign="center" allowSort="true" width="120px">卡说明</div>
			</div>
		</div>
	</div>


</body>
</html>
