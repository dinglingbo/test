<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 09:35:37
  - Description:
-->
<head>
<title>车险销售查询</title>
<script src="<%=request.getContextPath()%>/repair/js/CarInsuranceQueryMain/CarInsuranceQueryMain.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 72px;
}
</style>
</head>
<body>
<input class="nui-combobox" id="carBrand" visible="false"/>
<input class="nui-combobox" id="insureComp" visible="false"/>
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
                    <span class="separator"></span>
                    <a class="nui-button" onclick="advancedSearch()" plain="true">更多</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" iconCls="icon-print" onclick="print()">打印(P)</a>
                    <a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出(E)</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div id="grid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
         pageSize="20"
         sortMode="client"
         totalField="page.count"
         frozenStartColumn="0" frozenEndColumn="6">

        <div property="columns">
            <div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
            <div header="" headerAlign="center">
                <div property="columns">
                    <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="150">保险单号</div>
                    <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="70">车牌号</div>
                    <div field="insuranceMan" headerAlign="center" allowSort="true" visible="true" width="70px">被保险人</div>
                    <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="60px">品牌</div>
                    <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="60px">品牌车型</div>
                    <div field="insuranceType" headerAlign="center" allowSort="true" visible="true" width="60px">保险类型</div>
                </div>
            </div>
            <div header="交强险" headerAlign="center">
                <div property="columns">
                    <div field="insuranceSaliComany" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                    <div field="insuranceSaliDate" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="">购买日期</div>
                    <div field="insuranceSaliDue" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="">到期日期</div>
                </div>
            </div>
            <div header="商业险" headerAlign="center">
                <div property="columns">
                    <div field="insuranceBizComany" headerAlign="center" allowSort="true" visible="true" width="">投保公司</div>
                    <div field="insuranceBizDate" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="">购买日期</div>
                    <div field="insuranceBizDue" headerAlign="center" allowSort="true" visible="true" dateFormat="yyyy-MM-dd" width="">到期日期</div>
                </div>
            </div>
            <div header="保险费用" headerAlign="center">
                <div property="columns">
                    <div field="insuranceSaliAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">交强险</div>
                    <div field="insuranceBizAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">商业险</div>
                    <div field="carBoartTax" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">车船税</div>
                    <div field="insuranceAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">保费</div>
                </div>
            </div>
            <div header="返点及收入" headerAlign="center">
                <div property="columns">
                    <div field="commissionAmt" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">佣金</div>
                    <div field="discount" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">返利</div>
                    <div field="othetExpense" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">其他费用</div>
                    <div field="grossProfit" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right">毛利</div>
                    <div field="insuranceSaliRate" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right" numberFormat="p">交强险佣金率</div>
                    <div field="insuranceBizRate" headerAlign="center" allowSort="true" visible="true" width="" datatype="float" align="right" numberFormat="p">商业险佣金率</div>
                </div>
            </div>
            <div header="" headerAlign="center">
                <div property="columns">
                    <div field="" headerAlign="center" allowSort="true" visible="true" width="180px">备注</div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:280px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="form_label">结算日期 从:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           showClearButton="false"
                           class="nui-datepicker"/>
                </td>
                <td class="form_label">至:</td>
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
                <td class="form_label">业务类型:</td>
                <td colspan="1">
                    <input class="nui-combobox" name="insuranceType"
                           valueField="customid" textField="name"
                           id="insuranceType"/>
                </td>
                <td class="form_label">车险专员:</td>
                <td colspan="1">
                    <input class="nui-combobox" emptyText="请选择..." id="insuranceCommissioner" name="insuranceCommissioner" valueField="empName" textField="empName"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">客户:</td>
                <td colspan="3">
                    <input class="nui-buttonedit" emptyText="请输入..."
                           style="width: 100%"
                           showClose="false" onbuttonclick="selectCustomer()" id="guestId" name="guestId"
                           allowInput="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">保险单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" id="serviceCodeList" name="serviceCodeList"></textarea>
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