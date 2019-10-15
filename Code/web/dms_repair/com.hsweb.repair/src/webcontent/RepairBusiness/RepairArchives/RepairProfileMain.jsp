<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-26 12:06:08
  - Description:
-->
<head>
<title>维修档案</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/RepairArchives/RepairProfileMain.js?v=1.0.5"></script>
<style type="text/css">

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" id="mtType1" visible="false"/>
<input class="nui-combobox" id="mtType2" visible="false"/>
<input class="nui-combobox" id="orgId" visible="false"/>
<input class="nui-combobox" id="insureComp" visible="false"/>
<input class="nui-combobox" id="receType1" visible="false"/>
<input class="nui-combobox" id="receType2" visible="false"/>
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
                    <label class="form_label">车牌号（客户）：</label>
                    <input class="nui-buttonedit" emptyText="请输入..." showClose="true" onbuttonclick="selectCustomer('guestId')" id="guestId"
                           allowInput="false"
                           oncloseclick="onClean()"/>
                    <label class="form_label">维修顾问：</label>
                    <input class="nui-combobox" emptyText="请选择..." id="mtAdvisorId" valueField="empId" textField="empName"/>
                    <a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">查询</a>
                    <a class="nui-button" onclick="advancedSearch()" plain="true">更多</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar"
     style="border-bottom: 0;">
    <table style="width: 100%">
        <tr>
            <td style="width: 100%">
                <a class="nui-button" plain="true" iconCls="icon-user" onclick="showCustomer()">客户资料</a>
                <a class="nui-button" plain="true" iconCls="icon-date" onclick="history()">维修历史</a>
                <a class="nui-menubutton" plain="true" iconCls="icon-print" menu="#printMenu">打印</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width: 100%; height: 100%;" allowResize="false" vertical="true" handlerSize="0" borderStyle="border:0;">
        <div size="45%" showCollapseButton="false" style="border:0">
            <div class="nui-fit">
                <div id="leftGrid" class="nui-datagrid"
                     style="width: 100%; height: 100%;"
                     dataField="list"
                     pageSize="20"
                     selectOnLoad="true"
                     totalField="page.count"
                     borderStyle="border-bottom:0;"
                     allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="5">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" width="30">序号</div>
                        <div header="基本信息" headerAlign="center">
                            <div property="columns">
                                <div field="orgid" headerAlign="center" allowSort="true" visible="true" header="公司名称"></div>
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" header="工单号"></div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" header="维修顾问"></div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" header="车牌号"></div>
                                <div field="serviceCard" headerAlign="center" allowSort="true" visible="true" header="接车卡号"></div>
                            </div>
                        </div>
                        <div header="辅助信息" headerAlign="center">
                            <div property="columns">
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" header="品牌"></div>
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" header="品牌车型"></div>
                                <div field="checker" headerAlign="center" allowSort="true" visible="true" header="质检员"></div>
                                <div field="contactorName" headerAlign="center" allowSort="true" visible="true" header="客户名称"></div>
                                <div field="serviceTypeId" headerAlign="center" allowSort="true" visible="true" header="业务类型"></div>
                                <div field="mtType" headerAlign="center" allowSort="true" visible="true" header="维修类型"></div>
                                <div field="insureCompCode" headerAlign="center" allowSort="true" visible="true" header="投保公司"></div>
                                <div field="sureMtDate" headerAlign="center" allowSort="true" visible="true" header="维修日期" dateFormat="yyyy-MM-dd"></div>
                                <div field="outDate" headerAlign="center" allowSort="true" visible="true" header="离厂日期" dateFormat="yyyy-MM-dd"></div>
                                <div type="checkboxcolumn" trueValue="1" falseValue="0" field="isCarWash" headerAlign="center" allowSort="true" visible="true" header="是否洗车"></div>
                                <div field="remark" headerAlign="center" allowSort="true" visible="true" header="备注"></div>
                            </div>
                        </div>
                        <div header="维修项目" headerAlign="center">
                            <div property="columns">
                                <div field="itemAmt" headerAlign="center" allowSort="true" visible="true" header="项目金额" datatype="float" align="right"></div>
                                <div field="itemPrefRate" headerAlign="center" allowSort="true" visible="true" header="优惠率" datatype="float" align="right" numberFormat="p" decimalPlaces="4"></div>
                                <div field="itemPrefAmt" headerAlign="center" allowSort="true" visible="true" header="优惠金额" datatype="float" align="right"></div>
                                <div field="itemSutotal" headerAlign="center" allowSort="true" visible="true" header="项目小计" datatype="float" align="right"></div>
                            </div>
                        </div>
                        <div header="材料信息" headerAlign="center">
                            <div property="columns">
                                <div field="partAmt" headerAlign="center" allowSort="true" visible="true" header="材料金额" datatype="float" align="right"></div>
                                <div field="partPrefRate" headerAlign="center" allowSort="true" visible="true" header="优惠率" datatype="float" align="right" numberFormat="p" decimalPlaces="4"></div>
                                <div field="partPrefAmt" headerAlign="center" allowSort="true" visible="true" header="优惠金额" datatype="float" align="right"></div>
                                <div field="partSubtotal" headerAlign="center" allowSort="true" visible="true" header="材料小计" datatype="float" align="right"></div>
                            </div>
                        </div>
                        <div header="金额信息" headerAlign="center">
                            <div property="columns">
                                <div field="mtAmt" headerAlign="center" allowSort="true" visible="true" header="维修金额" datatype="float" align="right"></div>
                                <div field="partManageExp" headerAlign="center" allowSort="true" visible="true" header="材料管理费" datatype="float" align="right"></div>
                                <div field="materialExp" headerAlign="center" allowSort="true" visible="true" header="辅料费" datatype="float" align="right"></div>
                                <div field="allowanceAmt" headerAlign="center" allowSort="true" visible="true" header="折让金额" datatype="float" align="right"></div>
                                <div field="otherExp" headerAlign="center" allowSort="true" visible="true" header="其他费用" datatype="float" align="right"></div>
                                <div field="totalPrefRate" headerAlign="center" allowSort="true" visible="true" header="整单优惠率" datatype="float" align="right" numberFormat="p" decimalPlaces="4"></div>
                                <div field="totalPrefAmt" headerAlign="center" allowSort="true" visible="true" header="总优惠金额" datatype="float" align="right"></div>
                                <div field="balaAmt" headerAlign="center" allowSort="true" visible="true" header="结算金额" datatype="float" align="right"></div>
                                <div field="billAmt" headerAlign="center" allowSort="true" visible="true" header="发票金额" datatype="float" align="right"></div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div id="mainTabs" class="nui-tabs" activeIndex="0"
                 style="width: 100%; height: 100%;" plain="false" onactivechanged="">
                <div title="维修套餐">
                    <div class="nui-fit">
                        <div id="packageGrid" class="nui-datagrid"
                             style="width: 100%; height: 100%;"
                             dataField="list"
                             showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                <div header="套餐信息">
                                    <div property="columns">
                                        <div type="expandcolumn" >#</div>
                                        <div field="packageName" headerAlign="center" allowSort="true"
                                             visible="true" width="">套餐名称
                                        </div>
                                        <div field="status" headerAlign="center"
                                             allowSort="true" visible="true" width="60">状态
                                        </div>
                                        <div field="pkgamt" headerAlign="center"
                                             allowSort="true" visible="true" width="80">套餐金额
                                        </div>
                                        <div field="discountAmt" headerAlign="center"
                                             allowSort="true" visible="true" width="80">优惠金额
                                        </div>
                                        <div field="subtotal" headerAlign="center"
                                             allowSort="true" visible="true" width="80">小计金额
                                        </div>
                                        <div field="amt4s" headerAlign="center"
                                             allowSort="true" visible="true" width="80">4S店金额
                                        </div>
                                        <div field="remark" headerAlign="center"
                                             allowSort="true" visible="true" width="">备注
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="packageDetailGrid_Form" style="display:none;">
                            <div id="packageDetailGrid" class="nui-datagrid"
                                 style="width: 100%; "
                                 dataField="list"
                                 showPager="false"
                                 selectOnLoad="true"
                                 allowSortColumn="true">
                                <div property="columns">
                                    <div field="typeName" headerAlign="center" allowSort="true"
                                         visible="true" width="60">类型
                                    </div>
                                    <div field="name" headerAlign="center"
                                         allowSort="true" visible="true" width="">名称
                                    </div>
                                    <div field="qty" headerAlign="center"
                                         allowSort="true" visible="true" width="80">工时/数量
                                    </div>
                                    <div field="remark" headerAlign="center"
                                         allowSort="true" visible="true" width="80">备注
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="估算项目/材料">
                    <div class="nui-splitter" style="width: 100%; height: 100%"
                         borderStyle="border:0;"
                         handlerSizel="0"
                         vertical="false" allowResize="false">
                        <div size="50%" showCollapseButton="false">
                            <div class="nui-fit">
                                <div id="rpsItemQuoteGrid"
                                     borderStyle="border-right:0;"
                                     class="nui-datagrid"
                                     dataField="list"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                        <div field="receTypeId" headerAlign="center"
                                             allowSort="true" visible="true" width="80">收费类型
                                        </div>
                                        <div field="itemKind" headerAlign="center"
                                             allowSort="true" visible="true" width="80">工种
                                        </div>
                                        <div field="itemTime" headerAlign="center"
                                             allowSort="true" visible="true" width="80">工时
                                        </div>
                                        <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额小计</div>
                                        <div field="itemCode" headerAlign="center"
                                             allowSort="true" visible="true" width="">项目编码
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="rpsPartQuoteGrid"
                                     dataField="list"
                                     class="nui-datagrid"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                        <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80">金额小计</div>
                                        <div field="receTypeId" headerAlign="center"
                                             allowSort="true" visible="true" width="80">收费类型
                                        </div>
                                        <div field="qty" headerAlign="center"
                                             allowSort="true" visible="true" width="80">数量
                                        </div>
                                        <div field="unitPrice" headerAlign="center"
                                             allowSort="true" visible="true" width="80">单价
                                        </div>
                                        <div field="status" headerAlign="center"
                                             allowSort="true" visible="true" width="80">状态
                                        </div>
                                        <div field="partCode" headerAlign="center"
                                             allowSort="true" visible="true" width="">零件编码
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="维修项目/材料">
                    <div class="nui-splitter" style="width: 100%; height: 100%"
                         borderStyle="border:0;"
                         handlerSize="6"
                         allowResize="false" vertical="false">
                        <div size="50%" showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="rpsItemGrid"
                                     class="nui-datagrid"
                                     dataField="list"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                        <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                                        <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                                        <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                                        <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额小计</div>
                                        <div field="className" headerAlign="center" allowSort="true" visible="true" width="80">班组</div>
                                        <div field="worker" headerAlign="center" allowSort="true" visible="true" width="80">承修人</div>
                                        <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="rpsPartGrid"
                                     dataField="list"
                                     class="nui-datagrid"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                        <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
                                        <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
                                        <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
                                        <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                                        <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="出单项目/材料">
                    <div class="nui-splitter" style="width: 100%; height: 100%"
                         borderStyle="border:0;"
                         handlerSize="6"
                         allowResize="false" vertical="false">
                        <div size="50%" showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="rpsItemBillGrid"
                                     class="nui-datagrid"
                                     dataField="list"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                        <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                                        <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                                        <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额小计</div>
                                        <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div showCollapseButton="false" style="border:0;">
                            <div class="nui-fit">
                                <div id="rpsPartBillGrid"
                                     dataField="list"
                                     class="nui-datagrid"
                                     style="width: 100%; height: 100%;"
                                     showPager="false"
                                     allowSortColumn="true">
                                    <div property="columns">
                                        <div headerAlign="center" type="indexcolumn" width="30">序号</div>
                                        <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
                                        <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
                                        <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
                                        <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
                                        <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div title="辅料清单">
					<div id="auxiliaryGrid" dataField="list" class="nui-datagrid"
                         style="width: 100%; height: 100%;"
                         showPager="false"
                         sortMode="client"
                         allowSortColumn="true">
                        <div property="columns">
                            <div field="partCode" headerAlign="center" allowSort="true"
                                 visible="true" width="">辅料编码
                            </div>
                            <div field="partName" headerAlign="center" allowSort="true"
                                 visible="true" width="">辅料名称
                            </div>
                            <div field="outQty" headerAlign="center" datatype="int" align="right"
                                 allowSort="true" visible="true" width="">数量
                            </div>
                            <div field="trueUnitPrice" headerAlign="center" datatype="float" align="right"
                                 allowSort="true" visible="true" width="">单价
                            </div>
                            <div field="trueCost" headerAlign="center" datatype="float" align="right"
                                 allowSort="true" visible="true" width="">金额
                            </div>
                        </div>
                    </div>
                </div>
                <div title="出车报告">
                    <div class="nui-fit">
                        <textarea class="nui-textarea" name="drawOutReport" id="drawOutReport" style="width:100%;height:100%;"></textarea>
                    </div>
                </div>
                <div title="描述信息">
                    <table class="nui-form-table" style="width: 100%;">
                        <tr>
                            <td>
                                <label>客户描述：</label>
                            </td>
                            <td>
                                <label>故障现象：</label>
                            </td>
                            <td>
                                <label>解决措施：</label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <textarea class="nui-textarea" name="guestDesc" id="guestDesc" style="width:100%;height:150px;"></textarea>
                            </td>
                            <td>
                                <textarea class="nui-textarea" name="faultPhen" id="faultPhen" style="width:100%;height:150px;"></textarea>
                            </td>
                            <td>
                                <textarea class="nui-textarea" name="solveMethod" id="solveMethod" style="width:100%;height:150px;"></textarea>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
    </div>

</div>


<ul id="printMenu" class="nui-menu" style="display:none;">
    <li class="separator"></li>
    <li>打印维修委托单（A）</li>
    <li>打印派工单（C）</li>
    <li>打印结算单（E）</li>
    <li>打印出单结算单（F）</li>
</ul>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:410px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="form_label">离厂日期 从:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
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
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">业务类型:</td>
                <td colspan="1">
                    <input class="nui-combobox" name="serviceTypeId"
                           valueField="customid" textField="name"
                           id="serviceTypeId"/>
                </td>
                <td class="form_label">维修顾问:</td>
                <td colspan="1">
                    <input class="nui-combobox" emptyText="请选择..." id="mtAdvisorId-ad" name="mtAdvisorId" valueField="empId" textField="empName"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">客户:</td>
                <td colspan="3">
                    <input class="nui-buttonedit" emptyText="请输入..."
                           style="width: 100%"
                           showClose="false" onbuttonclick="selectCustomer('guestId-ad')" id="guestId-ad" name="guestId"
                           allowInput="false"/>
                </td>
            </tr>
            <tr>
                <td class="form_label">底盘号:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" id="underpanNo" name="underpanNo" />
                </td>
            </tr>
            <tr>
                <td class="form_label">车牌号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" id="carNoList" name="carNoList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="form_label">工单号:</td>
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