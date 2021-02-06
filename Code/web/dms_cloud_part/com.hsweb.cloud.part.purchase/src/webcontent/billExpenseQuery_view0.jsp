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
<title>费用登记明细</title>
<script src="<%=webPath + contextPath%>/purchase/js/billExpenseQuery.js?v=1.0.6"></script>
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
                <input id="serviceId" width="100px" emptyText="业务单号"  class="nui-textbox"/>
                <input id="elLogisticsNo" width="100px" emptyText="物流单号"  class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">客户：</label> -->
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择物流公司..." 
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
               <input name="stateSign" id="stateSign" class="nui-combobox width1"
                                     textField="name"
                                     valueField="id"
                                     valueFromSelect="true"
                                     emptyText="请选择对账状态..."
                                     url=""
                                     allowInput="true"
                                     showNullItem="false"
                                     width="100px"
                                     nullItemText="请选择对账状态.."
                                     onvalidation=""/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                
                <input name="settleTypeId" visible="false"
                                     id="settleTypeId"
                                     class="nui-combobox width1"
                                     textField="name"
                                     valueField="customid"
                                     enabled="false"
                                     valuefromselect="true"
                                     allowInput="true"
                                     selectOnFocus="true"
                                     showNullItem="false"
                                     width="100%"/>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="list"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         showSummaryRow="true">
        <div property="columns">
            <div type="indexcolumn">序号</div>
            <div header="" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="billServiceId" width="130" summaryType="count" headerAlign="center" header="业务单号"></div>
                    <div allowSort="true" field="fullName" width="130" summaryType="count" headerAlign="center" header="物流公司"></div>
                    <div allowSort="true" field="logisticsNo" width="100" summaryType="count" headerAlign="center" header="物流单号"></div>
                    <div allowSort="true" field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
                    <div allowSort="true" field="expenseTypeCode" width="60" headerAlign="center" header="费用项目"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="expenseAmt" width="60" headerAlign="center" header="费用金额"></div>
                </div>
            </div>
            <div header="其他" headerAlign="center">
                <div property="columns">
                    <div allowSort="true" field="stateSign" width="60" headerAlign="center" header="对账状态"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="haveStateAmt" width="60" headerAlign="center" header="已对账金额"></div>
                    <div allowSort="true" datatype="float" summaryType="sum" field="noStateAmt" width="60" headerAlign="center" header="未对账金额"></div>
                    <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
                    <div field="creator" width="60" headerAlign="center" header="创建人"></div>
                    <div allowSort="true" field="createDate"width="120" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                    <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                    <div allowSort="true" field="auditDate"width="120" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:260px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
        	<tr>
                <td class="title">创建日期:</td>
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
                <td class="title">业务单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">物流单号:</td>
                <td colspan="3">
                    <input id="logisticsNo"
                           name="logisticsNo"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
            <tr>
                <td class="title">费用项目:</td>
                <td colspan="3">
                    <input name="comIncomeId" visible="true"
                                     id="comIncomeId"
                                     class="nui-combobox width1"
                                     textField="name"
                                     valueField="id"
                                     enabled="true"
                                     valuefromselect="true"
                                     allowInput="true"
                                     selectOnFocus="true"
                                     showNullItem="false"
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

<div id="exportDiv" style="display:none"> 
</div>
</body>
</html>
