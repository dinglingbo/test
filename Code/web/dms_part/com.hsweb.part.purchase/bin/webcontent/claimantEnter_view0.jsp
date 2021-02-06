<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-03-07 19:14:42
  - Description:
-->
<head>
<title>索赔归库查询</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/repairMgr/claimantEnter.js?v=1.0.0"></script>
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
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本日</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">本周</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)" id="type5">上月</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(10)" id="type10">本年</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(11)" id="type11">上年</a>
                </td>
            </tr>
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">归库日期 从：</label>
                    <input name="startDate"
                           class="nui-datepicker"/>
                    <label style="font-family:Verdana;">至：</label>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           showClearButton="true"/>
                    <span class="separator"></span>
                    <label style="font-family:Verdana;">车牌号：</label>
                    <input class="nui-textbox" name="carCode" enabled="true"/>
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
         frozenEndColumn="7"
         url="">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="归库信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="enterCode" width="100" headerAlign="center" header="归库单号"></div>
                    <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partName" width="60" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="unit" width="60" headerAlign="center" header="单位"></div>
                    <div allowSort="true" field="qty" width="60" headerAlign="center" header="数量"></div>
                    <div allowSort="true" datatype="float" field="costUnitPrice" width="60" headerAlign="center" header="单价"></div>
                    <div allowSort="true" datatype="float" field="costAmt" width="60" headerAlign="center" header="金额"></div>
                </div>
            </div>
            <div header="其他信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partCode" width="60" headerAlign="center" header="归库时间" dateFormat="yyyy-MM-dd"></div>
                    <div allowSort="true" field="modifier" width="60" headerAlign="center" header="归库人"></div>
                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
