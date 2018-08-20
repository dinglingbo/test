<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-08-08 09:53:27
  - Description:
-->
<head>
<title>计次卡查询</title>
<script
	src="<%=request.getContextPath()%>/repair/js/Card/rpsCardTimesList.js?v=1.1.3"></script>
</head>

<body>
	<div id="queryform" class="nui-form">
		<div class="nui-toolbar">
			<input class="nui-hidden" name="criteria/_entity"
				value="com.hsapi.repair.data.rpb.RpbCardStored">
			<table id="table1">
				<tr>
					<td style="width: 90%;height:100% ">
						<spand>&nbsp;&nbsp;&nbsp;计次卡列表&nbsp;&nbsp;</spand>
						<a class="nui-button" onclick="searchOne()">查看</a>			    
					</td>
					<td>
					<a class="nui-button" onclick="search()" style="margin:right"> <i class="fa fa-file-excel-o" aria-hidden="true"></i>导出EXCEL</a>	
					<spand>&nbsp;&nbsp;&nbsp;</spand>					 
					<a class="nui-button" onclick="refresh()" ><i class="fa fa-refresh" ></i>刷新列表</a>
						
					</td>
				</tr>
			</table>
		</div>
	</div>
<div class="nui-fit">
		<div id="datagrid1" dataField="params" class="nui-datagrid"
			pageSize="10" onDrawCell="onDrawCell"  
			
			     showPager="true"
        
                    totalField="page.count"
                    sortMode="client"
                    allowCellSelect="true"
                    allowCellEdit="true"
                    showModified="false"
                   
			 allowSortColumn="true" style="width: 100%;height:100% ">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn"></div>
				
				<div field="fullName" headerAlign="center" allowSort="true"
					>姓名</div>
				
				<div field="mobile" headerAlign="center" allowSort="true"  >
					电话</div>

				<div field="carOn" headerAlign="center" allowSort="true">
					车牌号</div>
				<div field="cardName" headerAlign="center" allowSort="true">
				  计次卡名称</div>
				
				<div field="id" headerAlign="center" allowSort="true">
					剩余次数
				</div>
				
				<div field="recordData" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd">
					创建时间</div>
				<div field="pastDate" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd">
					到期时间</div>
				<div field="sellAmt" headerAlign="center" allowSort="true">
					销售金额</div>
				<div field="status" headerAlign="center" allowSort="true">
				状态</div>

			</div>
		</div>
	</div>
</body>
</html>
