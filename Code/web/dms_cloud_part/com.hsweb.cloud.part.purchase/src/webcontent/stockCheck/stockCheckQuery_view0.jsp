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
<title>盘点单明细</title>
<script src="<%=webPath + contextPath%>/purchase/js/stockCheck/stockCheckQuery.js?v=1.0.2"></script>
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

				<label style="font-family:Verdana;">审核日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="partNameAndPY" width="100px" emptyText="配件名称/拼音"  class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">配件编码：</label> -->
                <input id="partCode" width="100px" emptyText="配件编码"  class="nui-textbox"/>
               <!--  <label style="font-family:Verdana;">订单单号：</label> -->
                <input id="serviceId" width="100px" emptyText="盘点单号"  class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">客户：</label> -->
                <input name="orgCarBrandId"
                       id="orgCarBrandId"
                       class="nui-combobox"
                       textField="name"
                       valueField="customid"
                       valueFromSelect="true"
                       emptyText="厂牌"
                       url=""
                       width="120px"
                       allowInput="true"
                       showNullItem="false"
                       popupHeight="100%"
                       nullItemText="请选择..."/>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择客户..." visible="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <input id="storeId"
	                   name="storeId"
	                   class="nui-combobox width1"
	                   textField="name"
	                   valueField="id"
	                   emptyText="仓库"
	                   url=""
	                   valueFromSelect="true"
	                   allowInput="true"
	                   showNullItem="false"
	                   nullItemText="请选择..."/>
                <span class="separator"></span>
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>

                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="detailList"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         allowSort="true"
         url=""
         pageSize="500"
         sizeList="[500,1000,2000]"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="" headerAlign="center">
                <div property="columns">
                    <div allowSort="true"width="120" field="createDate" headerAlign="center" header="盘点日期" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date"></div>
                    <div allowSort="true" field="serviceId" width="180" summaryType="count" headerAlign="center" header="盘点单号" allowSort="true" dataType="string"></div>
                    <div field="orderMan" width="60" headerAlign="center" header="盘点员" allowSort="true" dataType="string"></div>
                    <!-- <div allowSort="true" field="billStatus" width="60" headerAlign="center" header="单据状态"></div>
                    <div allowSort="true" field="enterTypeId" width="60" headerAlign="center" header="入库类型"></div>
                    <div allowSort="true" field="settType" width="60" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div> -->
                    <div allowSort="true" field="storeId" width="100" headerAlign="center" header="盘点仓库" allowSort="true" dataType="string"></div>
                </div>
            </div>
            <div header="盘点信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="comPartName"width="140" headerAlign="center" header="配件名称" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="comOemCode" width="140"headerAlign="center" header="OE码" allowSort="true" dataType="string"></div>
                    <div field="orgCarBrandId" width="60" headerAlign="center" header="厂牌"></div>
                    <div allowSort="true" field="partBrandId" width="60" headerAlign="center" header="品牌" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="applyCarModel" width="120" headerAlign="center" header="品牌车型" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="enterUnitId" width="60" headerAlign="center" header="单位" allowSort="true" dataType="string"></div>
                </div>
            </div>
            <div header="数量" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" datatype="float" summaryType="sum" field="sysQty" width="60" headerAlign="center" header="系统数量"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="trueQty" width="60" headerAlign="center" header="实盘数量"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="exhibitQty" width="60" headerAlign="center" header="盈亏数量"></div>
                    <div allowSort="true" datatype="float" field="exhibitPrice" width="60" headerAlign="center" header="盈亏单价"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="exhibitAmt" width="60" headerAlign="center" header="盈亏金额"></div>
                    <div allowSort="true" field="dc" width="40" headerAlign="center" header="盈亏状态"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="mainRemark" width="150" headerAlign="center" header="主备注" allowSort="true" dataType="string"></div>
                    <div allowSort="true" field="detailRemark" width="100" headerAlign="center" header="明细备注" allowSort="true" dataType="string"></div><!-- 
                	<div allowSort="true" datatype="float" summaryType="sum" field="trueOutQty" width="60" headerAlign="center" header="已出库数量"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="notOutQty" width="60" headerAlign="center" header="未出库数量"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="adjustQty" width="60" headerAlign="center" header="调整数量"></div> -->
                    <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                    <div allowSort="true" width="120"field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm" allowSort="true" dataType="date"></div>
                    <div allowSort="true" field="partId" width="60" headerAlign="center" header="配件ID"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:360px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
        	<tr>
                <td class="title">盘点日期:</td>
                <td>
                    <input name="sOrderDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eOrderDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">审核日期:</td>
                <td>
                    <input name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eAuditDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">盘点单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="partCodeList" name="partCodeList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件名称:</td>
                <td colspan="3">
                    <input id="partName"
                           name="partName"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">盘点员:</td>
                <td colspan="3">
                    <input id="orderMan"
                           name="orderMan"
                           class="nui-textbox" 
                           width="100%"/>
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
