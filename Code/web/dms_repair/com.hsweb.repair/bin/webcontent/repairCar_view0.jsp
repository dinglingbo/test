<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonRepair.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-04-10 18:08:59
  - Description:
-->
<head>
<title>维修车辆</title>
<script src="<%=request.getContextPath()%>/repair/js/RepairBusiness/RepairArchives/repairCar.js?v=1.0.3"></script>
<style type="text/css">

.form_label {
	width: 72px;
	text-align: right;
}
</style>
</head>
<body>
<input class="nui-combobox" id="receType1" visible="false"/>
<input class="nui-combobox" id="receType2" visible="false"/>
<input class="nui-combobox" id="carBrand" visible="false"/>
<div class="nui-toolbar" style="border-bottom: 0;">
    <div class="nui-form1" id="queryInfoForm">
        <table class="table">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                </td>
                <td>
                    <label class="form_label">车牌号：</label>
                    <input class="nui-textbox" id="carNo"/>
                    <label class="form_label">工单号：</label>
                    <input class="nui-textbox" id="serviceCode"/>
                    <label class="form_label">车辆状态：</label>
                </td>
                <td>
                    <div id="searchType" class="nui-radiobuttonlist" repeatItems="2" repeatDirection="horizontal"
                         textField="text" valueField="id" value="1" data="[{id:1,text:'在修'},{id:2,text:'离厂'}]">
                    </div>
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" onclick="onSearch()" plain="true">查询</a>
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
                <a class="nui-button" plain="true" iconCls="icon-date" onclick="history()">维修历史</a>
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
                     allowSortColumn="true" frozenStartColumn="0" frozenEndColumn="0">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" width="30">序号</div>
                        <div field="carNo" headerAlign="center" allowSort="true" visible="true" header="车牌号"></div>
                        <div field="status" headerAlign="center" allowSort="true" visible="true" header="进程"></div>
                        <div field="serviceCode" headerAlign="center" allowSort="true" visible="true" header="工单号"></div>
                        <div field="carBrandId" headerAlign="center" allowSort="true" visible="true" header="品牌"></div>
                        <div field="carModel" headerAlign="center" allowSort="true" visible="true" header="品牌车型"></div>
                        <div field="mtAdvisor" headerAlign="center" allowSort="true" visible="true" header="维修顾问"></div>
                        <div field="enterDate" headerAlign="center" allowSort="true" visible="true" header="进厂时间" dateFormat="yyyy-MM-dd"></div>
                        <div field="planFinishDate" headerAlign="center" allowSort="true" visible="true" header="预计交车时间" dateFormat="yyyy-MM-dd"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false" style="border:0;">
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
                                <div field="itemCode" headerAlign="center" allowSort="true" visible="true" width="">项目编码</div>
                                <div field="itemName" headerAlign="center" allowSort="true" visible="true" width="100">项目名称</div>
                                <div field="itemKind" headerAlign="center" allowSort="true" visible="true" width="80">工种</div>
                                <div field="itemTime" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">工时</div>
                                <div field="subtotal" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额小计</div>
                                <div field="className" headerAlign="center" allowSort="true" visible="true" width="80">班组</div>
                                <div field="worker" headerAlign="center" allowSort="true" visible="true" width="80">承修人</div>
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
                    <input class="nui-combobox" emptyText="请选择..." id="mtAdvisorId-ad" name="mtAdvisorId" valueField="empid" textField="empname"/>
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
