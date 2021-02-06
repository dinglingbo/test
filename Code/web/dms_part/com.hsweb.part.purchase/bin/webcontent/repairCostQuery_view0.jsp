<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-07 18:20:14
  - Description:
-->
<head>
<title>在修成本查询</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/repairMgr/repairCostQuery.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
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
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">工单号：</label>
                    <input class="nui-textbox" name="carCode" enabled="true"/>
                    <label style="font-family:Verdana;">车牌号：</label>
                    <input class="nui-textbox" name="carNo" enabled="true"/>
                    <label style="font-family:Verdana;">零件编码：</label>
                    <input class="nui-textbox" name="partCode" enabled="true"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="ptsOutMainDetailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         frozenStartColumn="0"
         frozenEndColumn="8"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="配件信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partName" width="60" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                    <div allowSort="true" field="appCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                    <div allowSort="true" field="unit" width="60" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="业务类型"></div>
                    <div allowSort="true" field="outQty" width="60" headerAlign="center" header="数量"></div>
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
                </div>
            </div>
            <div header="车辆信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="serviceCode" width="60" headerAlign="center" header="工单号"></div>
                    <div allowSort="true" field="carNo" headerAlign="center" header="车牌号"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="维修顾问"></div>
                </div>
            </div>
            <div header="领料信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="pickDate" width="60" headerAlign="center" header="领料日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="pickMan" headerAlign="center" header="领料人"></div>
                    <div allowSort="true" field="auditor" width="60" headerAlign="center" header="操作人"></div>
                </div>
            </div>
            <div header="成本信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="trueUnitPrice" width="60" headerAlign="center" header="成本单价"></div>
                    <div allowSort="true" datatype="float" field="trueCost" width="60" headerAlign="center" header="成本金额"></div>
                </div>
            </div>
            <div header="销售信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="sellUnitPrice" width="60" headerAlign="center" header="销售单价"></div>
                    <div allowSort="true" datatype="float" field="sellAmt" width="60" headerAlign="center" header="销售金额"></div>
                </div>
            </div>
            <div header="盈利信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="costUnitPrice" width="60" headerAlign="center" header="毛利"></div>
                    <div allowSort="true" datatype="float" field="costAmt" width="60" headerAlign="center" header="成本率%"></div>
                    <div allowSort="true" datatype="float" field="costAmt" width="60" headerAlign="center" header="毛利率%"></div>
                </div>
            </div>
            <div header="归库信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="returnDate" width="60" headerAlign="center" header="归库日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="returnSign" headerAlign="center" header="归库标志"></div>
                    <div allowSort="true" field="returnMan" width="60" headerAlign="center" header="归库人"></div>
                </div>
            </div>
            <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="guestFullName" headerAlign="center" header="供应商"></div>
                    <div allowSort="true" field="enterDate" width="60" headerAlign="center" header="采购日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="repairDate" width="60" headerAlign="center" header="维修日期" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="outDate" width="60" headerAlign="center" header="离厂日期" dateFormat="yyyy-MM-dd"></div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
