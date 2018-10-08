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
    <title>车险登记明细</title>
    <script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/CIRegister/CarInsuranceDetail.js?v=1.0.622"></script>
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
    <div class="nui-toolbar" style="padding:2px;height:30px">
        <table class="table" id="table1" border="0" style="width:100%;border-spacing:0px 0px;">
            <tr>            
                <td>
                    <div class="mini-autocomplete" style="width:200px;"  popupWidth="600" textField="text" valueField="id" 
                    id="search_key" url="" value="carNo" placeholder="车牌号/客户名称/手机号/VIN码"  searchField="key" 
                    dataField="list" loadingText="数据加载中...">     
                    <div property="columns">
                        <div header="客户名称" field="guestFullName" width="30" headerAlign="center"></div>
                        <div header="客户手机" field="guestMobile" width="60" headerAlign="center"></div>
                        <div header="车牌号" field="carNo" width="40" headerAlign="center"></div>
                        <div header="送修人名称" field="contactName" width="30" headerAlign="center"></div>
                        <div header="送修人手机" field="mobile" width="60" headerAlign="center"></div>
                        <div header="VIN" field="vin" width="70" headerAlign="center"></div>
                    </div>
                </div>
                <input id="search_name"
                name="search_name"
                class="nui-textbox"
                emptyText="车牌号/客户名称/手机号/VIN码"
                onbuttonclick="onSearchClick()"
                width="200px"
                visible="false" 
                enabled="false" 
                showClose="false"
                allowInput="true"/>
                <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn">新增客户</a>
                <label style="font-family:Verdana;">工单号:</label>
                <label id="servieIdEl" style="font-family:Verdana;"></label>
            </td>     
            <td style="text-align:right;">
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="unfinish()" id="addBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返单</a>
                <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="addBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a>
                <a class="nui-button" plain="true" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="mainTabs" class="nui-tabs" activeIndex="0"
    style="width: 100%; height: auto" plain="false" onactivechanged="">
    <div title="保险基本信息">
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
    <div title="交强险信息">
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
    <div title="商业险信息">
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
<div class="nui-fit">

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
</body>
</html>