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
<title>销售提成明细</title>
<script src="<%=webPath + contextPath%>/report/js/deductDetail.js?v=2.0.9"></script>
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

				<label style="font-family:Verdana;">订单日期 从：</label>
                <input class="nui-datepicker" id="startDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                <span class="separator"></span> 
                <input id="deductMemName" width="120px" emptyText="提成成员名称"  class="nui-textbox"/>
                <input id="partName" width="120px" emptyText="配件名称"  class="nui-textbox"/>
                <input id="partCode" width="120px" emptyText="配件编码"  class="nui-textbox"/>
                <input id="orderCode" width="120px" emptyText="销售订单单号"  class="nui-textbox"/>
                <input id="outCode" width="120px" emptyText="出库订单单号"  class="nui-textbox"/>

                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
               
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="data"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         pageSize="100"
         totalField="page.count"
         sizeList="[100,500,1000]"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="订单信息" headerAlign="center">
                <div property="columns">
                    <div field="deductMemName" width="80" headerAlign="center" header="提成成员名称"></div>
                    <div field="deductType" width="80" headerAlign="center" header="提成类型"></div>
                    <div allowSort="true" field="orderCode" width="170" headerAlign="center" header="销售订单号"></div>
                    <div allowSort="true" field="outCode" summaryType="sum" width="170" headerAlign="center" header="出库单号"></div>  
                    <div allowSort="true" field="orderAmt" summaryType="sum" width="80" headerAlign="center" header="订单总金额"></div>     
                    <div allowSort="true" field="outAmt"summaryType="sum" width="80" headerAlign="center" header="当前出库金额"></div> 
                    <div allowSort="true" field="outGross" summaryType="sum" width="80" headerAlign="center" header="当前出库毛利"></div>                                                       
                </div>
            </div>
            <div header="提成信息" headerAlign="center">
                <div property="columns">
                	<div allowSort="true" summaryType="sum" field="deductAmt" width="80" headerAlign="center" header="提成金额"></div>
                	<div allowSort="true" field="type" width="110" headerAlign="center" header="提成方式"></div>
                    <div allowSort="true" datatype="float"  field="beginAmt" width="100" headerAlign="center" header="销售金额开始区间"></div>
                    <div allowSort="true" datatype="float" field="endAmt" width="100" headerAlign="center" header="销售金额结束区间"></div>
                    <div allowSort="true" datatype="float"  field="deductRate" width="80" headerAlign="center" header="提成比例%"></div>
                </div>
            </div>
            <div header="配件信息" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="partCode" width="150" headerAlign="center" header="配件编码"></div>
                    <div allowSort="true" field="partName"width="150" headerAlign="center" header="配件名称"></div>
                    <div allowSort="true" field="fullName"width="150" headerAlign="center" header="配件全称"></div>
                </div>
            </div>       
            <div header="其他" headerAlign="center">
                <div property="columns">
                	  <div allowSort="true" field="createDate"width="120" headerAlign="center" header="订单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                </div>
            </div>
        </div>
    </div>
</div>




</body>
</html>
