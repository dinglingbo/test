<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:26:31
  - Description:
-->
<head>
<title>进价行情</title>
<script src="baseData/js/purchasePrice/purchasePrice.js?v=1.0.0"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}
</style>
</head>
<body>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td>
                <span style="color: blue;">查询全国当前配件市场最新进价，降低采购成本，可按配件编码、配件名称、配件描述信息进行查询</span>
            </td>
        </tr>
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">品牌：</label>
                <input id="brand"
                       class="nui-combobox width1"
                       textField="text"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="true"
                       showNullItem="true"
                       nullItemText="请选择..."/>
                <label style="font-family:Verdana;">查询关键字：</label>
                <input class="nui-textbox" width="100" id="key"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="datagrid1" class="nui-datagrid" allowResize="true" style="width:100%;height:100%;"
         url=""  idField="id" multiSelect="true"
         pageSize="50"
         frozenStartColumn="0"
         frozenEndColumn="4">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <!--<div type="checkcolumn" ></div>-->
            <div header="配件进价信息" headerAlign="center">
                <div property="columns">
                    <div field="dept_name" width="100" headerAlign="center" header="配件编码"></div>
                    <div field="position_name" width="80" headerAlign="center" header="配件名称"></div>
                    <div field="position_name" width="100" headerAlign="center" header="最新进价"></div>
                    <div field="dept_name" width="100" headerAlign="center" header="最近更新日期"></div>
                </div>
            </div>
            <div header="零件基本信息" headerAlign="center">
                <div property="columns">
                    <div field="position_name" width="80" headerAlign="center" header="品牌"></div>
                    <div field="position_name" width="80" headerAlign="center" header="类型"></div>
                    <div field="dept_name" width="100" headerAlign="center" header="车型"></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
