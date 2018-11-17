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
<title>技师等级</title>
<%@include file="/common/sysCommon.jsp"%>
<script
	src="<%=webPath + contextPath%>/repair/cfg/js/x_makeAnAppointmentLocation.js?v=1.0.0"></script>

</head>
<body>


	<div class="nui-fit">
		<div
			style="width: 80%; height: 10%; margin-left: 10%; margin-top: 1%;">
			<input class="nui-button" onclick="javascript:addR()" text="新增"
				style="float: left; margin-top: 10px;"></input>&nbsp;&nbsp; <input
				class="nui-button" onclick="save" text="保存"
				style="margin-top: 10px;"></input>&nbsp;&nbsp; <input
				class="nui-button" onclick="javascript:doSearch()" text="刷新"
				style="margin-top: 10px;"></input>
		</div>
		<div class="nui-fit">
			<div id="dgGrid" class="nui-datagrid" showPager="false"
				dataField="list" sortMode="client" allowCellEdit="true"
				allowCellSelect="true" multiSelect="true" oncellcommitedit="onCellCommitEdit"
				 allowCellValid="true"
				style="width: 80%; height: 100%; margin-left: 10%;">
				<div property="columns">
					<div type="indexcolumn">序号</div>
					<div allowSort="true" field="name" summaryType="count"
						headerAlign="center" header="等级名称">
						<input property="editor" class="nui-textbox" />
					</div>
					<div vtype="required;int" allowSort="true" field="weight"
						summaryType="count" headerAlign="center" header="等级权重">
						<input property="editor" vtype="int;range:1,100;" class="nui-textbox" />
					</div>
					<div allowSort="true" field="recordDate" summaryType="count"
						dateFormat="yyyy-MM-dd" format="yyyy-MM-dd HH:mm"
						headerAlign="center" header="添加时间">
						<input property="editor" class="nui-datepicker" />
					</div>


				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	
</script>
</html>