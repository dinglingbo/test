<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>MAC地址清单查询</title>
<script src="<%=webPath + contextPath%>/common/js/macAddressSet.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 90px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	/*border-right: 0;*/
	
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>


	<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <input id="macAddress" width="200px" emptyText="MAC地址" class="nui-textbox"/>
                <input id="name" width="200px" emptyText="设备名" class="nui-textbox"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                
                <a class="nui-button" iconCls="" plain="true" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                
                <a class="nui-button" iconCls="" plain="true" onclick="del()" id="delBtn" visible="true"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                
                <!-- 
                <a class="nui-button" plain="true" iconCls="" onclick="import()" id="importGuestBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>

                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> -->

                
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="rs"
         idField="id"
         allowCellEdit="true"
         allowCellSelect="true"
		 multiSelect="true"
         sortMode="client"
         allowSort="true"
         url=""
         pageSize="100"
         sizeList="[100,200,500]"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn" width="20">序号</div>
            <div type="checkcolumn" width="25"></div>
            <div allowSort="true" field="macAddress" width="120" headerAlign="center" header="MAC地址" allowSort="true" dataType="string">
            	<input property="editor" allowInput="true" class="nui-textbox"/>
            </div>
            <div allowSort="true" field="name" width="120" headerAlign="center" header="设备名" allowSort="true" dataType="string">
            	<input property="editor" allowInput="true" class="nui-textbox"/>
            </div>
            <div allowSort="true" field="remark" width="120" headerAlign="center" header="说明" allowSort="true" dataType="string">
            	<input property="editor" allowInput="true" class="nui-textbox"/>
            </div>
        </div>
    </div>
</div>


<div id="exportDiv" style="display:none"> 
</div>
</body>
</html>
