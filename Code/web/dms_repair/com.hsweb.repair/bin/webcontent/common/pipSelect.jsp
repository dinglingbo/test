<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
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
<script src="<%=request.getContextPath()%>/repair/js/pipSelect.js?v=1.0.12"></script>
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
                    <input class="nui-textbox" id="queryValue" emptyText="请输入查询条件" width="130px"/>
                </td>
                <td>
                    <a class="nui-button" plain="false"  onclick="onSearch()"><span class="fa fa-search"></span>&nbsp;查询</a>
                </td>
            </tr>
            <tr style="display:none">
                <td colspan="2">
                    <a class="nui-menubutton" plain="true" menu="#queryItemTab" id="itemTab">套餐</a>

                    <ul id="queryItemTab" class="nui-menu" style="display:none;">
                            <li iconCls="" onclick="queryType(0)" id="type10">客户已购买</li>
                            <li iconCls="" onclick="queryType(1)" id="type10">套餐</li>
                            <li iconCls="" onclick="queryType(2)" id="type11">项目</li>
                            <li iconCls="" onclick="queryType(3)" id="type11">配件</li>
                    </ul>

                    <!-- <a class="nui-button" plain="false"  onclick="onSearch()">选择分类查</a> -->
                    <input class="nui-combobox" name="serviceTypeId" id="serviceTypeId" valueField="id" textField="name"
                           allowInput="true" valueFromSelect="true" visible="false"/>
                    <input name="type" id="type" visible="false" class="nui-combobox" textField="name" valueField="customid"/>
                    <input class="nui-combobox" name="partBrand" id="partBrand" valueField="id" textField="name"
                           allowInput="true" valueFromSelect="true" visible="false"/>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div class="nui-tabs"
                id="mainTab" onactivechanged="onTabChanged"
                activeIndex="0" style="width: 100%; height: 100%;" plain="false" borderStyle="border:0;">
            <div title="客户已购买">
                <div  class="nui-fit">
                    <div class="nui-datagrid" style="width:100%;height:100%;"
                            id="cardTimesGrid"
                            dataField="data"
                            idField="id"
                            showPager="false"
                            allowSortColumn="true"
                            sortMode="client">
                        <div property="columns">
                            <div type="expandcolumn" >#</div>
                            <div field="prdtName" width="100" headerAlign="center" allowSort="true" header="产品名称"></div>
                            <div field="prdtType" width="60" headerAlign="center" allowSort="true" header="产品类别"></div>
                            <div field="canUseTimes" width="60" headerAlign="center" allowSort="true" header="可使用次数"></div>
                            <div field="doTimes" name="doTimes" width="60" headerAlign="center" header="使用中次数"></div>
                            <div field="balaTimes" width="60" headerAlign="center" allowSort="true" header="剩余次数"></div>
                        </div>
                    </div>
                    <div id="cardDetailGrid_Form" style="display:none;">
                        <div id="cardTimesDetail" class="nui-datagrid" style="width:100%;"
                            dataField="data" showPager="false">
                            <div property="columns">
                                <div field="prdtName" width="100" headerAlign="center" allowSort="true" header="名称"></div>
                                <div field="qty" width="60" headerAlign="center" allowSort="true" header="工时/数量"></div>
                                <div field="amt" width="60" headerAlign="center" allowSort="true" header="金额"></div>
                                <div field="prdtType" width="60" headerAlign="center" allowSort="true" header="类型"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- <div title="套餐" borderStyle="border:0;">
                <div  class="nui-fit">
                    <div class="nui-datagrid" style="width:100%;height:100%;"
                            id="packageGrid"
                            dataField="list"
                            idField="id"
                            showPager="true"
                            totalField="page.count"
                            pageSize="20"
                            allowSortColumn="true"
                            sortMode="client">
                        <div property="columns">
                            <div type="expandcolumn" >#</div>
                            <div field="name" width="100" headerAlign="center" allowSort="true" header="套餐名称"></div>
                            <div field="amount" width="60" headerAlign="center" allowSort="true" header="套餐金额"></div>
                            <div field="serviceTypeId" width="60" headerAlign="center" allowSort="true" header="套餐类别"></div>
                        </div>
                    </div>
                    <div id="detailGrid_Form" style="display:none;">
                        <div id="packageDetail" class="nui-datagrid" style="width:100%;"
                            dataField="data" showPager="false">
                            <div property="columns">
                                <div field="prdtName" width="100" headerAlign="center" allowSort="true" header="名称"></div>
                                <div field="qty" width="60" headerAlign="center" allowSort="true" header="工时/数量"></div>
                                <div field="amt" width="60" headerAlign="center" allowSort="true" header="金额"></div>
                                <div field="prdtType" width="60" headerAlign="center" allowSort="true" header="类型"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div> -->
            <div title="项目">
                <div  class="nui-fit">
                    <div class="nui-datagrid" style="width:100%;height:100%"
                            id="itemGrid"
                            dataField="list"
                            pageSize="20"
                            totalField="page.count"
                            allowSortColumn="true">
                        <div property="columns">
                            <div field="name" width="100" headerAlign="center" allowSort="true" header="项目名称"></div>
                            <div field="itemTime" width="50" headerAlign="center" allowSort="true" header="工时"></div>
                            <div field="amt" width="60" headerAlign="center" allowSort="true" header="金额"></div>
                            <div field="type" width="60" headerAlign="center" allowSort="true" header="项目类型"></div>
                            <div field="serviceTypeId" width="60" headerAlign="center" allowSort="true" header="业务类型"></div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- <div title="配件">
                <div class="nui-fit">
                    <div class="nui-datagrid" style="width:100%;height:100%"
                            id="partGrid" dataField="parts"
                            pageSize="20"
                            totalField="page.count"
                            allowSortColumn="true" >
                        <div property="columns">
                            <div field="name" width="100" headerAlign="center" allowSort="true" header="配件名称"></div>
                            <div field="code" width="100" headerAlign="center" allowSort="true" header="配件编码"></div>
                            <div field="oemCode" headerAlign="center" width="100" allowSort="true" header="OEM码"></div>
                            <div field="" headerAlign="center" width="50" allowSort="true" header="库存"></div>
                            <div field="partBrandId" headerAlign="center" width="60" allowSort="true" header="配件品牌"></div>
                        </div>
                    </div>
                </div>

            </div> -->
        </div>
    </div>



</div>

</body>
</html>