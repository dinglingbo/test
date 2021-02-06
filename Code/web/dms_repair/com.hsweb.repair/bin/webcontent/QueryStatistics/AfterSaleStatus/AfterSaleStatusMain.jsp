<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:15:02
  - Description:
-->
<head>
<title>售后状况表</title>
<script src="<%=request.getContextPath()%>/repair/js/AfterSaleStatus/AfterSaleStatusMain.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 84px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" visible="false" id="orgId"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-menubutton" plain="true" iconCls="icon-date" id="searchByDateBtn" menu="#popupMenu" >本日</a>
                    <ul id="popupMenu" class="nui-menu" style="display:none;">
                        <li iconCls="icon-date" onclick="quickSearch(0)">本日</li>
                        <li iconCls="icon-date" onclick="quickSearch(1)">昨日</li>
                        <li iconCls="icon-date" onclick="quickSearch(2)">本周</li>
                        <li iconCls="icon-date" onclick="quickSearch(3)">上周</li>
                        <li iconCls="icon-date" onclick="quickSearch(4)">本月</li>
                        <li iconCls="icon-date" onclick="quickSearch(5)">上月</li>
                        <li iconCls="icon-date" onclick="quickSearch(6)">本年</li>
                        <li iconCls="icon-date" onclick="quickSearch(7)">上年</li>
                    </ul>
                    <label style="font-family:Verdana;">起始日期：</label>
                    <input name="startDate"
                           id="startDate"
                           allowInput="false"
                           showClearButton="false"
                           class="nui-datepicker"/>
                    <label style="font-family:Verdana;">终止日期：</label>
                    <input name="endDate"
                           id="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           showClearButton="false"/>
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印</a>
                    <a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div class="nui-tabs" style="width:100%;height:60%;" activeIndex="0">
        <div title="售后状况数据">
            <div id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                 showPager="false" sortMode="client"
                 allowSortColumn="true">
                <div property="columns">
                    <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                    <div header="维度" headerAlign="center">
                        <div property="columns">
                            <div field="orgid" headerAlign="center" allowSort="true" visible="true" width="">分店名称</div>
                        </div>
                    </div>
                    <div header="车次数据" headerAlign="center">
                        <div property="columns">
                            <div field="quoteCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">报价车次</div>
                            <div field="repairCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">维修车次</div>
                            <div field="accidentCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">事故车次</div>
                            <div field="finishedCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">完工车次</div>
                            <div field="settleCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">结算车次</div>
                            <div field="settleAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">结算金额</div>
                            <div field="firstGuestCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">首次到店客户</div>
                            <div field="noMtCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">报价维修</div>
                        </div>
                    </div>
                    <div header="在修车数据" headerAlign="center">
                        <div property="columns">
                            <div field="bigAccidentCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">事故车次</div>
                            <div field="bigAccidentAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">事故车维修金额
                            </div>
                            <div field="bigVerhaulCount" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">普通车次</div>
                            <div field="bigVerhaulAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">普通车维修金额
                            </div>
                        </div>
                    </div>
                    <div header="毛利" headerAlign="center">
                        <div property="columns">
                            <div field="grossProfit" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">毛利</div>
                            <div field="grossProfitRate" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right" numberFormat="p">毛利率</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div title="车次日线图">

        </div>
        <div title="新客户走势图">
        </div>
    </div>
</div>
</body>
</html>