<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:52
  - Description:
-->
<head>
<title>储蓄卡充值查询</title>
<script src="<%=request.getContextPath()%>/repair/js/RechargeQuery/RechargeQueryMain.js?v=1.0.2"></script>
<style type="text/css">
html,body {
	margin: 0;
	padding: 0;
	border: 0;
	width: 100%;
	height: 100%;
	overflow: hidden;
}

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>

<input id="startDate"
       visible="false"
       allowInput="false"
       showClearButton="false"
       class="nui-datepicker"/>
<input id="endDate"
       visible="false"
       allowInput="false"
       showClearButton="false"
       class="nui-datepicker"/>
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
                    <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" iconCls="icon-undo" onclick="onRefund()">退款</a>
                    <a class="nui-button" plain="true" iconCls="icon-goto" onclick="onRecharge()">转充值</a>
                    <a class="nui-button" plain="true" iconCls="icon-remove" onclick="onRemove">删除</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印</a>
                    <a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
         pageSize="50"
         totalField="page.count" allowSortColumn="true"
         frozenStartColumn="0" frozenEndColumn="0">
        <div property="columns">
            <div type="indexcolumn" headerAlign="center" width="30">序号</div>
            <div header="客户信息" headerAlign="center">
                <div property="columns">
                    <div field="fullName" headerAlign="center" allowSort="true" visible="true" width="">客户名称</div>
                    <div field="cardNo" headerAlign="center" allowSort="true" visible="true" width="">会员卡号</div>
                    <div field="mobile" headerAlign="center" allowSort="true" visible="true" width="">客户电话</div>
                    <div field="rechargeDate" headerAlign="center" allowSort="true" visible="true" width="" dateFormat="yyyy-MM-dd">充值日期</div>
                </div>
            </div>
            <div header="充值信息" headerAlign="center">
                <div property="columns">
                    <div field="rechargeAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">充值金额</div>
                    <div field="largessAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">赠送金额</div>
                    <div field="integral" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">赠送积分</div>
                </div>
            </div>
            <div header="余额信息" headerAlign="center">
                <div property="columns">
                    <div field="cardBalaAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">储蓄余额</div>
                    <div field="largessBalaAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">赠送余额</div>
                    <div field="integral" headerAlign="center" allowSort="true" visible="true" width="" datatype="int" align="right">赠送积分</div>
                </div>
            </div>
            <div header="备注" headerAlign="center">
                <div property="columns">
                    <div field="recorder" headerAlign="center" allowSort="true" visible="true" width="">记录人</div>
                    <div field="recordDate" headerAlign="center" allowSort="true" visible="true" width="" dateFormat="yyyy-MM-dd">记录日期</div>
                    <div field="remark" headerAlign="center" allowSort="true" visible="true" width="">备注</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="form_label">充值日期 从:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           showClearButton="false"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">客户卡号:</td>
                <td colspan="3">
                    <input class="nui-textbox" name="cardNo" style="width: 100%;"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">客户名称:</td>
                <td colspan="3">
                    <input class="nui-textbox" name="guestFullName" style="width: 100%;"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">充值金额 从:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="rechargeAmtStart" style="width: 100%;"/>
                </td>
                <td class="">至:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="rechargeAmtEnd" style="width: 100%;"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">剩余金额 从:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="balaAmtStart" style="width: 100%;"/>
                </td>
                <td class="">至:</td>
                <td colspan="1">
                    <input class="nui-textbox" name="balaAmtEnd" style="width: 100%;"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchClear" style="width:60px;margin-right:20px;">清除</a>
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>
</html>