<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-08 16:15:05
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/queryMgr/partFillRate.js?v=1.0.0"></script>
<style type="text/css">
.title {
	width: 70px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-body {
	padding: 0;
}
</style>
</head>
<body>


<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div id="queryForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">
                    <label style="font-family:Verdana;">分店名称：</label>
                </td>
                <td style="white-space:nowrap;width: 100px;">
                    <input id="orgId"
                           class="nui-combobox width1"
                           textField="orgName"
                           valueField="orgId"
                           emptyText="请选择..."
                           url=""
                           allowInput="true"
                           showNullItem="true"
                           width="100%"
                           nullItemText="请选择..."/>
                </td>
                <td class="title">起始日期 从:</td>
                <td style="white-space:nowrap;width: 100px;">
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="" style="width:20px;">至:</td>
                <td style="white-space:nowrap;width: 100px;">
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd HH:mm"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">统计满足率</a>
                    <a class="nui-menubutton " menu="#popupMenu" >生成采购计划</a>
                    <ul id="popupMenu" class="mini-menu" style="display:none;">
                        <li iconCls="" >生成A类采购计划</li>
                        <li iconCls="" >生成B类采购计划</li>
                        <li iconCls="" >生成C类采购计划</li>
                        <li iconCls="" onclick="">清除筛选条件</li>
                    </ul>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit" >
    <div id="datagrid1" class="nui-datagrid" style="width:100%;height:100%;"
         frozenStartColumn="0"
         frozenEndColumn="5"
         dataField="parts"
         url=""
         ondrawcell="onPartGridDraw"
         idField="id"
         selectOnLoad="true"
         sortMode="client"
         showPager="false"
         showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="采购信息" headerAlign="center">
                <div property="columns">
                    <div field="partCode" width="80" headerAlign="center" allowSort="true">配件编码</div>
                    <div field="partName" width="80" headerAlign="center" allowSort="true">配件名称</div>
                    <div field="partBrandId" width="70" headerAlign="center" allowSort="true">品牌</div>
                    <div field="applyCarModel" width="70" headerAlign="center" allowSort="true">品牌车型</div>
                    <div field="fullName" width="120" headerAlign="center" allowSort="true">价格</div>
                </div>
            </div>
            <div header="起止日期时间段数据" headerAlign="center">
                <div property="columns">
                    <div field="spec" width="60" headerAlign="center" allowSort="true">出库次数</div>
                    <div field="position_name" width="60" headerAlign="center" allowSort="true">出库数量</div>
                    <div field="applyCarModel" width="70" headerAlign="center" allowSort="true">满足数量</div>
                    <div field="carTypeIdF" width="80" headerAlign="center" allowSort="true">满足率</div>
                </div>
            </div>
            <div header="终止日期前六月销量数据" headerAlign="center">
                <div property="columns">
                    <div field="retailPrice" width="60" headerAlign="center" align="right" allowSort="true">前6月销量</div>
                    <div field="wholeSalePrice" width="60" headerAlign="center" align="right" allowSort="true">前5月销量</div>
                    <div field="uniformSellPrice" width="70" headerAlign="center" align="right" allowSort="true">前4月销量</div>
                    <div field="retailPrice" width="60" headerAlign="center" align="right" allowSort="true">前3月销量</div>
                    <div field="wholeSalePrice" width="60" headerAlign="center" align="right" allowSort="true">前2月销量</div>
                    <div field="uniformSellPrice" width="70" headerAlign="center" align="right" allowSort="true">前1月销量</div>
                    <div field="retailPrice" width="60" headerAlign="center" align="right" allowSort="true">出库数量</div>
                    <div field="wholeSalePrice" width="60" headerAlign="center" align="right" allowSort="true">销售频率</div>
                </div>
            </div>
            <div header="月加权平均销量" headerAlign="center">
                <div property="columns">
                    <div field="dept_name" width="60" headerAlign="center" allowSort="true">加权平均销量</div>
                </div>
            </div>
            <div header="库存信息" headerAlign="center">
                <div property="columns">
                    <div field="dept_name" width="60" headerAlign="center" allowSort="true">库存数量</div>
                </div>
            </div>
            <div header="计划采购信息" headerAlign="center">
                <div property="columns">
                    <div field="dept_name" width="60" headerAlign="center" allowSort="true">数量</div>
                    <div field="dept_name" width="60" headerAlign="center" allowSort="true">金额</div>
                </div>
            </div>
        </div>
    </div>
</div>



</body>
</html>
