<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-10 12:12:04
  - Description:
-->
<head>
<title>报价未修查询</title>
<script src="<%=request.getContextPath()%>/repair/js/UnrepairedQuotation/UnrepairedQuotationMain.js?v=1.0.0"></script>
<style type="text/css">

table {
	font-size: 12px;
}

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}
</style>
</head>
<body>
<input class="nui-combobox" id="mtType1" visible="false"/>
<input class="nui-combobox" id="mtType2" visible="false"/>
<input class="nui-combobox" id="carBrand" visible="false"/>
<input class="nui-combobox" id="noMtType1" visible="false"/>
<input class="nui-combobox" id="noMtType2" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table" id="table1">
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
                    <label>单据类型：</label>
                    <input class="nui-combobox"
                           value="11"
                           data="[{id:11,text:'整单未修'},{id:6,text:'部分未修'}]"
                           name="status"/>
                    <label>车牌号：</label>
                    <input class="nui-textbox" name="carNo"/>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" onclick="onSearch()">查询</a>
                    <a class="nui-button" onclick="advancedSearch()" plain="true">更多</a>
                    <span class="separator"></span>
                    <a class="nui-button" plain="true" iconCls="icon-expand" onclick="export()">导出</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit">
    <div class="nui-splitter" style="width:100%;height:100%;" vertical="true"
         borderStyle="border:0;"
         allowResize="false">
        <div size="55%" showCollapseButton="false" style="border:0;">
            <div class="nui-fit">
                <div id="mainGrid" class="nui-datagrid" style="width: 100%; height: 100%;"
                     pageSize="20"
                     dataField="list"
                     sortMode="client"
                     totalField="page.count" allowSortColumn="true">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" allowSort="true" width="30px">序号</div>
                        <div header="辅助信息" headerAlign="center">
                            <div property="columns">
                                <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" width="">工单号</div>
                                <div field="carNo" headerAlign="center" allowSort="true" visible="true" width="">车牌号</div>
                                <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" width="">维修顾问</div>
                            </div>
                        </div>
                        <div header="基本信息" headerAlign="center">
                            <div property="columns">
                                <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" width="">品牌</div>
                                <div field="carModel" headerAlign="center" allowSort="true" visible="true" width="">品牌车型</div>
                                <div field="contactorName" headerAlign="center" allowSort="true" visible="true" width="">客户名称</div>
                                <div field="serviceTypeId" headerAlign="center" allowSort="true" visible="true" width="">业务类型</div>
                                <div field="mtType" headerAlign="center" allowSort="true" visible="true" width="">维修类型</div>
                            </div>
                        </div>
                        <div header="未修信息" headerAlign="center">
                            <div property="columns">
                                <div field="noMtFileMan" headerAlign="center" allowSort="true" visible="true" width="">操作人</div>
                                <div field="quoteDate" headerAlign="center" allowSort="true" visible="true" width="" dateFormat="yyyy-MM-dd">报价时间</div>
                                <div field="noMtFileDate" headerAlign="center" allowSort="true" visible="true" width=""  dateFormat="yyyy-MM-dd">确定未修时间</div>
                                <div field="noMtType" headerAlign="center" allowSort="true" visible="true" width="">未修类型</div>
                                <div field="noMtReason" headerAlign="center" allowSort="true" visible="true" width="">未修原因</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
            <div class="nui-splitter" style="width:100%;height:100%;"
                 borderStyle="border:0;"
                 allowResize="false">
                <div size="50%" showCollapseButton="false" style="border:0;">
                    <div class="nui-fit">
                        <div id="rpsItemQuoteGrid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                             sortMode="client" showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                                <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="">项目名称</div>
                                <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="">工种</div>
                                <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="">工时</div>
                                <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="">金额小计</div>
                                <div field="status" headerAlign="center" allowSort="true" visible="true" width="">状态</div>
                            </div>
                        </div>
                    </div>
                </div>
                <div showCollapseButton="false" style="border:0;">
                    <div class="nui-fit">
                        <div id="rpsPartQuoteGrid" dataField="list" class="nui-datagrid" style="width: 100%; height: 100%;"
                             sortMode="client" showPager="false"
                             allowSortColumn="true">
                            <div property="columns">
                                <div type="indexcolumn" headerAlign="center" allowSort="true" width="30">序号</div>
                                <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
                                <div field="partName" headerAlign="center" allowSort="true" visible="true" width="">零件名称</div>
                                <div field="qty" headerAlign="center" allowSort="true" visible="true" width="">数量</div>
                                <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="">单价</div>
                                <div field="amt" headerAlign="center" allowSort="true" visible="true" width="">金额</div>
                                <div field="status" headerAlign="center" allowSort="true" visible="true" width="">状态</div>
                            </div>
                        </div>
                    </div>
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
                <td class="form_label">未修日期 从:</td>
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
                <td class="form_label">报价单号:</td>
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