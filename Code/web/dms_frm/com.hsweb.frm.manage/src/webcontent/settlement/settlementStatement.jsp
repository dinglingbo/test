<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	<%@include file="/common/common.jsp"%>
	<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-09 15:38:18
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/repair/RepairBusiness/Reception/js/echarts.js" type="text/javascript"></script>
    <script src="<%= request.getContextPath() %>/manage/settlement/js/settlementStatement.js?v=1.0.1" type="text/javascript"></script>
    <style type="text/css">
		.m{
				width: 120px;
				height: 40px;
				font-size: 18px;
				background: #578ccd;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
			}
		.n{
				width: 120px;
				height: 40px;
				font-size: 18px;
				background: #2ac476;
				color: #fff;
				text-align: center;
				display: block;
				border-radius: 5px;
				text-decoration: none;
				line-height: 2;
			}
			  
    </style>
</head>
<body >
			<table>
				<tr>
					<td>
						<a id="today"  class="m" onclick="settleOK(1)">今天</a>
					</td>
					<td>
						<a id="thisWeek" class="m"  onclick="settleOK(2)">本周</a>
					</td>
					<td>
						<a id="thisMonth"  class="m" onclick="settleOK(3)">本月</a>
					</td>
					<td>
						<a id="thisQuarter" class="m"  onclick="settleOK(4)">本季度</a>
					</td>
					<td>
						<a id="thisYear" class="n"  onclick="settleOK(5)">本年</a>
					</td>
					<td>
					 <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid" onValueChanged="settleOK()"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
					</td>
				</tr>
			</table>
                   
<div style="height:500px;width:900px" id="chartContainer"></div>

</body>
</html>