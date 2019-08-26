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
<title>链车币定义</title>
<%@include file="/common/sysCommon.jsp"%>
<script
	src="<%=webPath + contextPath%>/tenant/js/saveChainCarCoin.js?v=1.0.0"></script>

</head>
<body>
<div class="nui-toolbar">
    <a class="nui-button" plain="true" onclick="addR()"><i class="fa fa-plus fa-lg"></i>&nbsp;新增</a>
    <a class="nui-button" plain="true" onclick="save()"><i class="fa fa-pencil fa-lg"></i>&nbsp;保存</a>
    <a class="nui-button" plain="true" onclick="doSearch()"><i class="fa fa-trash-o fa-lg"></i>&nbsp;禁用/启用</a>
</div>

	<div class="nui-fit">
		<div class="nui-fit">
			<div id="dgGrid" class="nui-datagrid" showPager="false"
				dataField="carCoin" sortMode="client" allowCellEdit="true"
				allowCellSelect="true" multiSelect="true" oncellcommitedit="onCellCommitEdit"
				 allowCellValid="true"
				style="width: 100%; height: 100%;">
				<div property="columns">
					<div type="indexcolumn" headerAlign="center">排序号</div>
					<div allowSort="true" field="sellPrice" summaryType="count"
						headerAlign="center" header="销售价(元)">
						<input property="editor" vtype="float" required="true" class="nui-textbox" />
					</div>
					<div vtype="required;int" allowSort="true" field="rechargeCoin"
						summaryType="count" headerAlign="center" header="充值链车币(个)">
						<input property="editor" vtype="int" required="true" class="nui-textbox" />
					</div>
					<div vtype="required;int" allowSort="true" field="giveCoin"
						summaryType="count" headerAlign="center" header="赠送链车币(个)">
						<input property="editor" vtype="int" required="true" class="nui-textbox" />
					</div>
					<div  allowSort="true" field="isDisabled"
						summaryType="count" headerAlign="center" header="状态">
						 <input  property="editor" enabled="true" name="statusList" dataField="statusList" 
                                class="nui-combobox" valueField="id" textField="name" data="statusList" /> 
					</div>	
					<div  allowSort="true" field="operateBtn" headerAlign="center" align="center" header="操作">
					</div>									
<!-- 					<div allowSort="true" field="recordDate" summaryType="count"
						dateFormat="yyyy-MM-dd" format="yyyy-MM-dd HH:mm"
						headerAlign="center" header="添加时间">
						<input property="editor" class="nui-datepicker" />
					</div> -->


				</div>
			</div>
		</div>
	</div>

</body>
<script type="text/javascript">
	
</script>
</html>