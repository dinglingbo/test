<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 16:51:28
  - Description:
-->
<head>
<title>进销存明细</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/queryMgr/inventoryDetailQuery.js?v=1.0.4"></script>
<style type="text/css">
.title {
	width: 60px;
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
    <table style="width:100%;">
        <tr>
            <td style="white-space:nowrap;">
                <label style="font-family:Verdana;">快速查询：</label>
               <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>
	                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
	                    <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
	                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
	                    <li class="separator"></li>
	                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
	                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
	                    <li class="separator"></li>
	                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
	                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
	                    <li class="separator"></li>
	                    <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
	                    <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
	                </ul>
                <span class="separator"></span>
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(6)">未审</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(7)">已审</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(8)">已过帐</a>-->
                <!--<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(9)">全部</a>-->
                <!--<span class="separator"></span>-->
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
                <span class="separator"></span>
                <label style="font-family:Verdana;">仓库：</label>
                <input id="storeId"
                       name="storeId"
                       class="nui-combobox width1"
                       textField="name"
                       valueField="id"
                       emptyText="请选择..."
                       url=""
                       allowInput="false"
                       showNullItem="false"
                       nullItemText="请选择..."/>
                <label style="font-family:Verdana;">仓库：</label>
                <div class="nui-radiobuttonlist"
                     repeatItems="2"
                     id="countWay"
                     width="200px"
                     style="position: absolute;top: 4px;display: inline-table;"
                     textField="text" valueField="id" value="1" data="[{id:1,text:'金额'},{id:2,text:'数量'}]">
                </div>
            </td>
        </tr>
    </table>
</div>
<!--<div class="nui-toolbar" style="padding:2px;border-bottom:0;">-->
    <!--<table style="width:100%;">-->
        <!--<tr>-->
            <!--<td style="width:100%;">-->
                <!--<a class="nui-button" iconCls="icon-add" plain="true" onclick="addInbound()">打印</a>-->
            <!--</td>-->
        <!--</tr>-->
    <!--</table>-->
<!--</div>-->
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="false"
         dataField="list"
         idField="partId"
         sortMode="client"
         frozenStartColumn="0"
         frozenEndColumn="0">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="维度" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partId" width="100" headerAlign="center" header="内码"></div>
                    <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partName" width="100" headerAlign="center" header="配件名称"></div>
<!--                     <div allowSort="true" field="partFullName" width="100" headerAlign="center" header="配件全称"></div> -->
                </div>
            </div>
            <div header="采购" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="purchaseEnter" width="60" headerAlign="center" header="采购入库" dataType="float" align="right"></div>
                    <div allowSort="true" datatype="float" field="purchaseOut" headerAlign="center" header="采购退货" dataType="float" align="right"></div>
                </div>
            </div>
            <div header="维修" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="repairOut" width="60" headerAlign="center" header="出库" dataType="float" align="right"></div>
                    <div allowSort="true" datatype="float" field="repairEnter" headerAlign="center" header="归库" dataType="float" align="right"></div>
                </div>
            </div>
            <div header="退货" headerAlign="center">
                <div property="columns">
<!--                     <div allowSort="true" datatype="float" field="sellOut" width="60" headerAlign="center" header="出库" dataType="float" align="right"></div> -->
                    <div allowSort="true" datatype="float" field="sellEnter" headerAlign="center" header="退货" dataType="float" align="right"></div>
                </div>
            </div>
            <div header="移仓" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="allotEnter" width="60" headerAlign="center" header="入库" dataType="float" align="right"></div>
                    <div allowSort="true" datatype="float" field="allotOut" headerAlign="center" header="出库" dataType="float" align="right"></div>
                </div>
            </div>
            <div header="耗材" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" field="materialOut" width="60" headerAlign="center" header="出库" dataType="float" align="right"></div>
                    <div allowSort="true" datatype="float" field="materialEnter" headerAlign="center" header="归库" dataType="float" align="right"></div>
                </div>
            </div>
            <div header="库存" headerAlign="center">
                <div property="columns">
                    <div field="beginCount" width="60" headerAlign="center" header="期初" dataType="float" align="right"></div>
                    <div field="endCount" headerAlign="center" header="期末" dataType="float" align="right"></div>
                    <div field="currCount" headerAlign="center" header="当前" dataType="float" align="right"></div>
                </div>
            </div>
            <div header="盘点" headerAlign="center">
                <div property="columns">
                    <div field="inventoryProfit" width="60" headerAlign="center" header="盘盈" dataType="float" align="right"></div>
                    <div field="inventoryLoss" headerAlign="center" header="盘亏" dataType="float" align="right"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:220px;height:150px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">起始日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
            </tr>
            <tr>
                <td class="title">终止日期:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>



</body>
</html>
