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
<title>工作组</title>
<%@include file="/common/sysCommon.jsp"%>
<script src="<%=webPath + contextPath%>/repair/cfg/js/workTeam.js?v=1.0.1"></script>

</head>
<body>


<div class="nui-fit">
	<div style="width: 80%; height: 10%; margin-left: 10%; margin-top: 1%;">
		<input  class="nui-button" onclick="javascript:addR()" text="新增"  style="float:left; margin-top: 10px;"></input>&nbsp;&nbsp;
		<input  class="nui-button" onclick="save" text="保存"  style=" margin-top: 10px;"></input>&nbsp;&nbsp;	
		<input  class="nui-button" onclick="javascript:doSearch()" text="刷新"  style=" margin-top: 10px;"></input>	
	</div>
	<div class="nui-fit">
		<div id="dgGrid" class="nui-datagrid"
			showPager="false"
			dataField="list" sortMode="client" allowCellEdit="true" allowCellSelect="true" multiSelect="true"
        allowCellValid="true" oncellvalidation="onCellValidation" 
			style="width: 80%; height: 100%; margin-left: 10%; ">
			<div property="columns">
				<div type="indexcolumn">序号</div>
				<div allowSort="true" field="name"  summaryType="count" headerAlign="center" header="名称">
						<input  property="editor" class="nui-textbox"/>
				</div>
		
			</div>
		</div>
	</div>
</div>
    
</body>
 <script type="text/javascript">
      
       
    </script>
</html>