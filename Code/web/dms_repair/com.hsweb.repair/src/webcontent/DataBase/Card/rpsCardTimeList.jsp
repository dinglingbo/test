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
	src="<%=request.getContextPath()%>/repair/js/Card/rpsCardTimesList.js?v=1.1.4"></script>
</head>

<body>
	<div id="queryform" class="nui-form">
	
<div class="nui-toolbar" style="border-bottom: 0;">
	<div id="queryForm">
		<table>
			<tr>
				<td>
					<label style="font-family:Verdana;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;快速查询：</label>
					<label class="form_label">客户名称：</label>
					<input class="nui-textbox" name="name" id="name-search"/>
					<label class="form_label">计次卡名称：</label>
					<input class="nui-textbox" name="name" id="name-search"/>
					<a class="nui-button" plain="true" iconCls="icon-search" onclick="onSearch()">查询</a>
				</td>
				<td >		
			       <a class="nui-button" onclick="searchOne()">查看详情</a>	
				   <a class="nui-button" onclick="dealtWithCard()">次卡办理</a>		    
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
