<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-02 14:20:21
  - Description:
-->
<head>
<title>产品选择</title>
<script src="<%=request.getContextPath()%>/repair/js/pipSelect.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.asLabel .mini-textbox-border,.asLabel .mini-textbox-input,.asLabel .mini-buttonedit-border,.asLabel .mini-buttonedit-input,.asLabel .mini-textboxlist-border
	{
	border: 0;
	background: none;
	cursor: default;
}

.asLabel .mini-buttonedit-button,.asLabel .mini-textboxlist-close {
	display: none;
}

.asLabel .mini-textboxlist-item {
	padding-right: 8px;
}

.point input {
	color: red;
	font-size: 12px;
	font-weight: 600;
}
</style>

</head>
<body>
<div class="nui-fit">

    <div class="nui-toolbar" style="padding: 2px; border: 0;;">
        <table class="nui-form-table">
            <tr>
                <td>
                    <label>查询项：</label>
                </td>
                <td>
                    <input class="nui-combobox" id="queryItem"
                            data="[{id:0,text:'编码'},{id:1,text:'名称'},{id:2,text:'拼音'}]" value="1"/>
                </td>
                <td>
                    <label>查询值：</label>
                </td>
                <td>
                    <input class="nui-textbox" id="queryValue"/>
                </td>
                <td>
                    <div class="nui-radiobuttonlist" valueField="id" repeatItems="3" textField="text" repeatLayout="table"
                            id="queryTabId"
                            data="[{ id: 1, text: '套餐'},{ id: 2, text: '工时' },{ id: 3, text: '配件' }]" value="1">
                    </div>
                </td>
                <td>
                    <a class="nui-button" plain="false"  onclick="onSearch()"><span class="fa fa-search"></span>&nbsp;查询</a>
                    <a class="nui-button" plain="false"  onclick="onOk()"><span class="fa fa-check"></span>&nbsp;选择</a>
                </td>
            </tr>
        </table>
    </div>
    <div  class="nui-fit">
        <div class="nui-tabs"
                id="mainTab"
                activeIndex="0" style="width: 100%; height: 100%;" plain="false" borderStyle="border:0;">
            <div title="套餐信息" borderStyle="border:0;">
                <div class="nui-datagrid" style="width:100%;height:100%;"
                        id="packageGrid"
                        dataField="rs"
                        idField="id"
                        showPager="true"
                        totalField="page.count"
                        pageSize="20"
                        allowSortColumn="true"
                        sortMode="client">
                    <div property="columns">
                        <div type="expandcolumn" >#</div>
                        <div field="packageName" width="180" headerAlign="center" allowSort="true" header="套餐名称"></div>
                        <div field="packageAmt" width="100" headerAlign="center" allowSort="true" header="套餐金额"></div>
                    </div>
                </div>
                <div id="detailGrid_Form" style="display:none;">
                    <div id="packageDetail" class="nui-datagrid" style="width:100%;"
                        dataField="rs" showPager="false">
                        <div property="columns">
                            <div field="type" width="60" headerAlign="center" allowSort="true" header="类型"></div>
                            <div field="itemName" width="120" headerAlign="center" allowSort="true" header="名称"></div>
                            <div field="qty" width="120" headerAlign="center" allowSort="true" header="工时/数量"></div>
                            <div field="amt" width="120" headerAlign="center" allowSort="true" header="工时/配件金额"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div title="工时信息">
                <div class="nui-datagrid" style="width:100%;height:100%"
                        id="itemGrid"
                        dataField="rs"
                        pageSize="20"
                        totalField="page.count"
                        allowSortColumn="true">
                    <div property="columns">
                        <div field="itemName" width="180" headerAlign="center" allowSort="true" header="项目名称"></div>
                        <div field="astandTime" width="100" headerAlign="center" allowSort="true" header="时间（h）/（副）"></div>
                        <div field="astandSum" headerAlign="center" allowSort="true" header="工时金额"></div>
                    </div>
                </div>
            </div>
            <div title="配件信息">
                <div class="nui-fit">
                    <div class="nui-datagrid" style="width:100%;height:100%"
                            id="partGrid" dataField="rs"
                            pageSize="20"
                            totalField="page.count"
                            allowSortColumn="true" >
                        <div property="columns">
                            <div field="code" width="100" headerAlign="center" allowSort="true" header="配件编码"></div>
                            <div field="name" width="180" headerAlign="center" allowSort="true" header="配件名称"></div>
                            <div field="astandSum" headerAlign="center" allowSort="true" header="OEM码"></div>
                            <div field="astandSum" headerAlign="center" allowSort="true" header="库存"></div>
                            <div field="id" headerAlign="center" allowSort="true" header="配件品牌"></div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>



</div>

</body>
</html>