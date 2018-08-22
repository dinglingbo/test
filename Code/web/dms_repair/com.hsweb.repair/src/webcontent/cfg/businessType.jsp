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
<title>业务分类列表</title>
<%@include file="/common/sysCommon.jsp"%>
<script src="<%=webPath + contextPath%>/repair/cfg/js/businessType.js?v=1.0.0"></script>

</head>
<body>


<div class="nui-fit">
	<div style="width: 80%; height: 10%; margin-left: 10%; margin-top: 1%;">
		<input  class="nui-button" onclick="save" text="保存"  style="float:left; margin-top: 10px;"></input>		
	</div>
	<div class="nui-fit">
		<div id="dgGrid" class="nui-datagrid"
			showPager="false"
			dataField="list" sortMode="client" allowCellSelect="true" allowCellEdit="true"
			showModified="false" showSummaryRow="true"
			style="width: 80%; height: 100%; margin-left: 10%; ">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div allowSort="true" field="name"  summaryType="count" headerAlign="center" header="名称">
						<input property="editor" class="nui-textbox"/>
				</div>
				<div allowSort="true" allowSort="true" field="isDisabled"  headerAlign="center" header="状态">
					<input property="editor" class="nui-combobox" textField="name" data="statusList"
						valueField="id" />
				</div>
				<div field="operateBtn" name="operateBtn" align="center" width="50" headerAlign="center" header="操作"></div>
			</div>
		</div>
	</div>
</div>
    
</body>
 <script type="text/javascript">
      
       
    </script>
</html>