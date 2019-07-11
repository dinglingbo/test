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
<title>客户标签列表</title>
<%@include file="/common/sysCommon.jsp"%>
<script src="<%= request.getContextPath() %>/repair/cfg/js/guestTab.js?v=1.0.3"></script>

</head>
<body>

<div style="width: 80%; height: 10%; margin-left: 5px; margin-top: 1%;">
	<input  class="nui-button" onclick="addR" text="新增"  style="float:center; margin-top: 10px;"></input>	
	<input  class="nui-button" onclick="save" text="保存"  style="float:center; margin-top: 10px;"></input>	
</div>
<div id="dgGrid" class="nui-datagrid" style="width:100%;height:100%;"
	 dataField="data" sortMode="client" allowCellSelect="true" allowCellEdit="true" showpager="false"
	 showModified="false" showSummaryRow="true"
	 style="width: 80%; height: 40%; margin-left: 10%; ">
	<div property="columns">
		<div type="indexcolumn">序号</div>
		<div allowSort="true" field="id" visible="false" headerAlign="center" header="主键"></div>
		<div allowSort="true" field="name"  summaryType="count" headerAlign="center" header="标签名称">
				<input property="editor" class="nui-textbox"/>
		</div>
		<div allowSort="true" allowSort="true" field="isDisabled"  headerAlign="center" header="状态">
			<input property="editor" class="nui-combobox" textField="name" data="statusList"
				valueField="id" />
		</div>
		<div field="operateBtn" name="operateBtn" align="center" width="50" headerAlign="center" header="操作"></div>
	</div>
</div>
    
</body>
 <script type="text/javascript">
      
       
    </script>
</html>