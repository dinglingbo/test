<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 17:22:36
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchasePart/js/consumableItem/consumableItemOut.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
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
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <label style="font-family:Verdana;">仓库：</label>
                    <input id="storeId"
                           name="storeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                    <label style="font-family:Verdana;">助记码：</label>
                    <input class="nui-textbox" width="100" name="partCode"/>
                    <label style="font-family:Verdana;">编码尾号：</label>
                    <input class="nui-textbox" width="100" name="lastCode"/>
                    <label style="font-family:Verdana;">零件名称：</label>
                    <input class="nui-textbox" width="100" name="name"/>
                    <label style="font-family:Verdana;">只显示耗材：</label>
                    <input class="nui-checkbox" width="100" name="showConsumableItemOnly" trueVlaue="1" falseValue="0"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询库存</a>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询已领</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a class="nui-button" iconCls="icon-ok" plain="true" onclick="reView()" enabled="false" id="reViewBtn">领料出库</a>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">更多</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit" >
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <span>库存列表</span>
    </div>
    <div id="rightGrid1" class="nui-datagrid" style="width:100%;height:calc(50% - 27px);"
         showPager="false"
         dataField="ptsEnterMainList"
         idField="id"
         ondrawcell="onRightGrid1DrawCell"
         onrowclick="onRightGrid1RowClick"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="配件信息" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="配件编码"></div>
                    <div field="partName" headerAlign="center" header="配件名称"></div>
                    <!--<div field="partBrandName" width="60" headerAlign="center" header="品牌"></div>-->
                    <div field="applyCarModel" width="60" headerAlign="center" header="适用车型"></div>
                    <div field="unit" width="40" headerAlign="center" header="单位"></div>
                    <!--<div type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="含税" trueValue="1" falseValue="0"></div>-->
                </div>
            </div>
            <div header="库存" headerAlign="center">
                <div property="columns">
                    <div field="outableTotalQty" width="80" headerAlign="center" header="库存" align="right"></div>
                    <div field="enterTotalQty" width="80" headerAlign="center" header="入库数" align="right"></div>
                    <div field="outTotalQty" width="80" headerAlign="center" header="库存" align="right"></div>
                </div>
            </div>
            <div header="不含税" headerAlign="center">
                <div property="columns">
                    <div field="noTaxUnitPrice" width="80" headerAlign="center" header="单价" align="right"></div>
                </div>
            </div>
            <div header="含税" headerAlign="center">
                <div property="columns">
                    <div field="taxUnitPrice" width="80" headerAlign="center" header="单价" align="right"></div>
                    <div field="taxRate" width="80" headerAlign="center" header="税率" align="right"></div>
                </div>
            </div>
            <div header="入库单号" headerAlign="center">
                <div property="columns">
                    <div field="enterId" width="100" headerAlign="center" header="入库单号"></div>
                    <div field="guestFullName" width="100" headerAlign="center" header="供应商"></div>
                    <div field="enterDate" headerAlign="center" width="80" header="入库日期" dateFormat="yyyy-MM-dd"></div>
                </div>
            </div>
        </div>
    </div>
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <span>已领列表</span>
    </div>
    <div id="rightGrid2" class="nui-datagrid" style="width:100%;height:calc(50% - 27px);"
         showPager="false"
         dataField="enterDetailList"
         idField="detailId"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="零件信息" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="60" headerAlign="center" header="配件编码"></div>
                    <div field="partName" headerAlign="center" header="配件名称"></div>
                    <div field="partBrandName" width="60" headerAlign="center" header="品牌"></div>
                    <div field="applyCarModel" width="60" headerAlign="center" header="车型"></div>
                    <div field="unit" width="40" headerAlign="center" header="单位"></div>
                    <div field="unit" width="40" headerAlign="center" header="数量"></div>
                    <!--<div type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="含税" trueValue="1" falseValue="0"></div>-->
                </div>
            </div>
            <div header="领料信息" headerAlign="center">
                <div property="columns">
                    <div field="enterDate" headerAlign="center" width="80" header="领料日期" dateFormat="yyyy-MM-dd"></div>
                    <div field="partName" headerAlign="center" header="领料人"></div>
                    <div field="partBrandName" width="60" headerAlign="center" header="操作人"></div>
                    <div field="remark" width="60" headerAlign="center" header="备注"></div>
                </div>
            </div>
            <div header="成本信息" headerAlign="center">
                <div property="columns">
                    <div field="costUnitPrice" width="80" headerAlign="center" header="成本单价"></div>
                    <div field="costAmt" width="80" headerAlign="center" header="成本单价"></div>
                </div>
            </div>
            <div header="归库信息" headerAlign="center">
                <div property="columns">
                    <div field="partName" headerAlign="center" header="归库标志"></div>
                    <div field="enterDate" headerAlign="center" width="80" header="归库日期" dateFormat="yyyy-MM-dd"></div>
                    <div field="partName" headerAlign="center" header="归库人"></div>
                </div>
            </div>
            <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div field="guestFullName" width="100" headerAlign="center" header="供应商"></div>
                    <div field="enterDate" headerAlign="center" width="80" header="采购日期" dateFormat="yyyy-MM-dd"></div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
