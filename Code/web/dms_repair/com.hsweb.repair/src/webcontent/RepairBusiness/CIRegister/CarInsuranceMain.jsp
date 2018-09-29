<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-27 09:33:59
  - Description:
-->
<head>
<title>车险登记</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceMain.js?v=1.0.6"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 84px;
}
</style>

</head>
<body>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                </td>
                <td>
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
                </td>
                <td>
                    <label class="form_label">车牌号：</label>
                    <input class="nui-textbox" name="carNo" id="carNo-search"/>
                    <label class="form_label">客户名称：</label>
                    <input class="nui-textbox" name="guestName" id="guestName"/>
                    <a class="nui-button" iconCls="" onclick="onSearch()" plain="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" onclick="advancedSearch()" plain="true"><span class="fa fa-binoculars fa-lg"></span>&nbsp;更多</a>
                </td>
                <td>
                    <a class="nui-button" plain="true" iconCls="" onclick="add()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" plain="true" iconCls="" onclick="save()"><span class="fa fa-floppy-o fa-lg"></span>&nbsp;保存</a>
                    <a class="nui-button" plain="true" iconCls="" onclick="settlement()"><span class="fa fa-cny fa-lg"></span>&nbsp;结算</a>
                    <a class="nui-button" plain="true" iconCls="" onclick="undo()"><span class="fa fa-rotate-left fa-lg"></span>&nbsp;返单</a>
                    <a class="nui-button" plain="true" iconCls="" onclick="print()"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                </td>                
            </tr>
        </table>
    </div>
</div>

<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height: 100%;"
         borderStyle="border:0;"
         allowResize="false">
        <div size="400" showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
            <div id="leftGrid" dataField="list" class="nui-datagrid"
                     style="width: 100%; height: 100%;"
                     pageSize="50"
                     totalField="page.count"
                     sortMode="client"
                     selectOnLoad="true"
                     allowSortColumn="true">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true"
                             visible="true" width="30">序号
                        </div>
                        <div header="">
                            <div property="columns">
                                <div field="status" headerAlign="center"
                                     allowSort="true" visible="true" width="40px">状态
                                </div>
                            </div>
                        </div>
                        <div header="">
                            <div property="columns">
                                <div field="carNo" headerAlign="center"
                                     allowSort="true" visible="true" width="60px">车牌号
                                </div>
                                <div field="insuranceMan" headerAlign="center"
                                     allowSort="true" visible="true" width="80px">被保险人
                                </div>
                                <div field="carBrandId" headerAlign="center"
                                     allowSort="true" visible="true" width="60px">品牌
                                </div>
                                <div field="carModel" headerAlign="center"
                                     allowSort="true" visible="true" width="180px">车型
                                </div>
                            </div>
                        </div>
                        <div header="交强险" headerAlign="center">
                            <div property="columns">
                                <div field="insuranceSaliDate" headerAlign="center" dateFormat="yyyy-MM-dd"
                                     allowSort="true" visible="true" width="100px">购买日期
                                </div>
                                <div field="insuranceSaliDue" headerAlign="center" dateFormat="yyyy-MM-dd"
                                     allowSort="true" visible="true" width="100px">到期日期
                                </div>
                            </div>
                        </div>
                        <div header="商业险" headerAlign="center">
                            <div property="columns">
                                <div field="insuranceBizDate" headerAlign="center" dateFormat="yyyy-MM-dd"
                                     allowSort="true" visible="true" width="100px">购买日期
                                </div>
                                <div field="insuranceBizDue" headerAlign="center" dateFormat="yyyy-MM-dd"
                                     allowSort="true" visible="true" width="100px">到期日期
                                </div>
                            </div>
                        </div>
                        <div header="">
                            <div property="columns">
                                <div field="serviceCode" headerAlign="center"
                                     allowSort="true" visible="true" width="150px">工单号
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div id="mainTabs" class="nui-tabs" activeIndex="0"
                 style="width: 100%; height: 100%;" plain="false" onactivechanged="">
                <div title="基本信息">
                    <div id="basicInfoForm">
                        <input class="nui-hidden" name="id"/>
                        <input class="nui-hidden" name="orderType"/>                        
                        <input class="nui-hidden" name="carId" id="carId"/>
                        <input class="nui-hidden" name="insuranceAmt"/>
                        <input class="nui-hidden" name="insuranceSaliAmt"/>
                        <input class="nui-hidden" name="insuranceBizAmt"/>
                        <input class="nui-hidden" name="carBoartTax"/>
                        <input class="nui-hidden" name="insuranceSaliRate"/>
                        <input class="nui-hidden" name="insuranceBizRate"/>
                        <input class="nui-hidden" name="commissionAmt"/>
                        <input class="nui-hidden" name="othetExpense"/>
                        <input class="nui-hidden" name="discount"/>
                        <input class="nui-hidden" name="grossProfit"/>
                        <input class="nui-hidden" name="status"/>
                        <div class="nui-panel" title="保险基本信息" style="border-bottom:0; width: 100%;">
                            <table>
                                <tr>
                                    <td>
                                        <label>保险单号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" enabled="false" name="serviceCode"/>
                                    </td>
                                    <td>
                                        <label>客户名称：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-buttonedit" showClose="false" onbuttonclick="selectCustomer('guestId')" id="guestId"
                                               name="guestId"
                                               style="width: 100%;"
                                               allowInput="false"/>
                                    </td>
                                    <!-- <td>
                                        <label>客户类型：</label>
                                    <td>
                                    <td>
                                        <input class="nui-combobox"
                                               data="[{id:1,text:'售后'},{id:0,text:'销售'}]"
                                               name="orderType"/>
                                    </td> -->
                                </tr>
                                <tr>                                    
                                    <td>
                                        <label>被保险人：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="insuranceMan" id="insuranceMan"/>
                                    </td>
                                    <td>
                                        <label>联系电话：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" name="mobile" id="mobile"/>
                                    </td>
                                    <td>
                                        <label>车牌号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" enabled="false" name="carNo" id="carNo"/>
                                    </td>
                                </tr>
                                <tr>
                                    
                                    <td>
                                        <label>品牌：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" enabled="false"
                                               valueField="id" textField="nameCn"
                                               id="carBrandId" name="carBrandId"/>
                                    </td>
                                    <td>
                                        <label>车型：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-textbox" style="width: 100%;" enabled="false" name="carModel" id="carModel"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>VIN：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" style="width: 150px;"  enabled="false" name="underpanNo" id="underpanNo"/>
                                    </td>
                                    <td>
                                        <label>发动机号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" enabled="false" name="engineNo" id="engineNo"/>
                                    </td>
                                    <td>
                                        <label>投保日期：</label>
                                    </td>
                                    <td>
                                        <input class="nui-datepicker" format="yyyy-MM-dd" name="buyDate"
                                               timeFormat="HH:mm:ss" showTime="false" showOkButton="false" showClearButton="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>销售顾问：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" textField="empName" valueField="empId" name="insuranceCommissioner"
                                               id="insuranceCommissioner"/>
                                    </td>
                                    <td>
                                        <label>保险类型：</label>
                                    </td>
                                    <td>
                                        <input class="nui-combobox" name="insuranceType"
                                               valueField="customid" textField="name"
                                               id="insuranceType"/>
                                    </td>                                    
                                    <td>
                                        <label>制单员：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" enabled="false" name="recorder"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="nui-panel" title="交强险信息" style="border-bottom: 0;  width: 100%;margin-top: 5px;">
                            <table>
                                <tr>
                                    <td>
                                        <label>交强险保单号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" style="width: 200px;" name="insuranceSaliNo"/>
                                    </td>
                                    <td>
                                        <label>生效日期：</label>
                                    </td>
                                    <td>
                                        <input class="nui-datepicker" format="yyyy-MM-dd" name="insuranceSaliDate"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td>
                                        <label>到期日期：</label>
                                    </td>
                                    <td>
                                        <input class="nui-datepicker" format="yyyy-MM-dd" name="insuranceSaliDue"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>投保公司：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-combobox" allowInput="false"
                                               style="width: 100%;"
                                               textField="fullName"
                                               id="insuranceSaliComany"
                                               name="insuranceSaliComany"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>投保内容：</label>
                                    </td>
                                    <td colspan="5">
                                        <input class="nui-textarea"
                                               style="width: 100%;"
                                               name="insuranceSaliContent"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="nui-panel" title="商业险信息" style="border-bottom: 0; width: 100%;margin-top: 5px;">
                            <table>
                                <tr>
                                    <td>
                                        <label>商业险保单号：</label>
                                    </td>
                                    <td>
                                        <input class="nui-textbox" style="width: 200px;" name="insuranceBizNo"/>
                                    </td>
                                    <td>
                                        <label>生效日期：</label>
                                    </td>
                                    <td>
                                        <input class="nui-datepicker" format="yyyy-MM-dd" name="insuranceBizDate"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                    <td>
                                        <label>到期日期：</label>
                                    </td>
                                    <td>
                                        <input class="nui-datepicker" format="yyyy-MM-dd" name="insuranceBizDue"
                                               showOkButton="false" showClearButton="true"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>投保公司：</label>
                                    </td>
                                    <td colspan="3">
                                        <input class="nui-combobox" allowInput="false"
                                               style="width: 100%;"
                                               textField="fullName"
                                               id="insuranceBizComany"
                                               name="insuranceBizComany"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>投保内容：</label>
                                    </td>
                                    <td colspan="5">
                                        <input class="nui-textarea"
                                               style="width: 100%;"
                                               name="insuranceBizContent"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                <div title="险种信息">
                    <div class="nui-splitter" style="width: 100%; height: 100%;"
                         borderStyle="border:0;"
                         allowResize="false">
                        <div size="150" showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="insuranceGrid" class="nui-datagrid"
                                     showPager="false"
                                     style="width: 100%; height: 100%;">
                                    <div property="columns">
                                        <div field="action" headerAlign="center" allowSort="true"
                                             visible="true" width="40" header="操作">
                                        </div>
                                        <div field="name" headerAlign="center" allowSort="true"
                                             visible="true" width="">保险险种</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="detailGrid" dataField="list" class="nui-datagrid"
                                     style="width: 100%; height: 100%;"
                                     showPager="false" sortMode="client"
                                     allowCellEdit="true" allowCellSelect="true"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div header="" headerAlign="center">
                                            <div property="columns">
                                                <div field="action" headerAlign="center"
                                                     allowSort="true" visible="true" width="40">操作</div>
                                            </div>
                                        </div>
                                        <div header="险种信息" headerAlign="center">
                                            <div property="columns">
                                                <div field="insuranceId" headerAlign="center"
                                                     allowSort="true" visible="true" width="100">承保险种</div>
                                                <div field="dutyAmt" headerAlign="center"
                                                     allowSort="true" visible="true" width="100" header="责任限额（万元）" align="right">
                                                    <input property="editor" class="nui-spinner" showButton="false"  minValue="0" maxValue="100000000" style="width:100%;"/>
                                                </div>
                                                <div field="premium" headerAlign="center"
                                                     allowSort="true" visible="true" width="80"  header="保险费（元）" align="right" numberFormat="¥#,0.00">
                                                    <input property="editor" class="nui-spinner" showButton="false"  minValue="0" maxValue="100000000" style="width:100%;"/>
                                                </div>
                                                <div field="remark" headerAlign="center"
                                                     allowSort="true" visible="true" width="" header="备注">
                                                    <input property="editor" class="nui-textbox" style="width:100%;"/>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:420px;height:300px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="form_label">登记日期 从:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
                           class="nui-datepicker"/>
                </td>
                <td>至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           allowInput="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">交强险保单号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="insuranceSaliNo" />
                </td>
            </tr>
            <tr>
                <td class="form_label">交强险保单号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="insuranceBizNo" />
                </td>
            </tr>
            <tr>
                <td class="form_label">底盘号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="underpanNo" />
                </td>
            </tr>
            <tr>
                <td class="form_label">车牌号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" name="carNoList"></textarea>
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