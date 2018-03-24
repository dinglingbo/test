<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-01-31 16:24:58
  - Description:
-->
<head>
<title>销售出库</title>
<script src="<%= request.getContextPath() %>/purchasePart/js/sellMgr/sellOut.js?v=1.0.21"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
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
                <a class="nui-menubutton " iconCls="icon-date" menu="#popupMenuDate" id="menuBtnDateQuickSearch">本日</a>
                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 0, '本日')" id="type0">本日</li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 1, '昨日')" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 2, '本周')" id="type2">本周</li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 3, '上周')" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 4, '本月')" id="type4">本月</li>
                    <li iconCls="icon-date" onclick="quickSearch(menuBtnDateQuickSearch, 5, '上月')" id="type5">上月</li>
                </ul>
                <a class="nui-menubutton " iconCls="icon-tip" menu="#popupMenuStatus" id="menuBtnStatusQuickSearch">全部</a>
                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                    <li iconCls="icon-tip" onclick="quickSearch(menuBtnStatusQuickSearch, 6, '未审')" id="type6">未审</li>
                    <li iconCls="icon-tip" onclick="quickSearch(menuBtnStatusQuickSearch, 7, '已审')" id="type7">已审</li>
                    <li iconCls="icon-tip" onclick="quickSearch(menuBtnStatusQuickSearch, 8, '已过账')" id="type8">已过账</li>
                    <li iconCls="icon-tip" onclick="quickSearch(menuBtnStatusQuickSearch, 9, '全部')" id="type9">全部</li>
                </ul>
                <label style="font-family:Verdana;">客户名称：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择查询客户..."
                       allowInput="false"
                       onbuttonclick="selectCustomer('searchGuestId')" selectOnFocus="true" />

                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" iconCls="icon-expand" plain="true" onclick="advancedSearch()">更多</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addInbound()">新增</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editInbound()" id="editEnterMainBtn" enabled="false">修改</a>
                <a class="nui-button" iconCls="icon-save" plain="true" onclick="save()" id="saveEnterMainBtn" enabled="false">保存</a>
                <a class="nui-button" iconCls="icon-undo" plain="true" onclick="cancelEditInbound()" id="cancelEditEnterMainBtn" enabled="false">取消</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()" id="reViewBtn" enabled="false">审核</a>
            </td>
        </tr>
    </table>
</div>

<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="false"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="300" showCollapseButton="false">
            <div title="销售单列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     selectOnLoad="true"
                     ondrawcell="onLeftGridDrawCell"
                     onrowdblclick="onLeftGridRowDblClick"
                     dataField="ptsOutMainList"
                     sortMode="client"
                     idFiled="id"
                     url="">
                    <div property="columns">
                        <div allowSort="true" field="billStatus" width="25" headerAlign="center" header="状态"></div>
                        <div allowSort="true" field="guestFullName" headerAlign="center" header="客户名称" align="left"></div>
                        <div allowSort="true" field="outDate" width="80" headerAlign="center" header="销售日期" dateFormat="yyyy-MM-dd H:ss"></div>
                    </div>
                </div>
                <!--footer-->
                <div property="footer">
                    <input class='nui-textbox' value='' id="leftGridCount" readonly="true" style='vertical-align:middle;'/>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div title="销售信息" class="nui-panel"
                 style="width:100%;height: 150px;">
                <div id="basicInfoForm" class="form">
                    <input class="nui-hidden" name="id">
                    <input class="nui-hidden" name="taxSign" id="taxSign"/>
                    <table style="width: 100%;">
                        <tr>
                            <td class="title">
                                <label>销售单号：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" width="100%" name="outCode" enabled="false" emptyText="新增出库单"/>
                            </td>
                            <td class="title required">
                                <label>销售日期：</label>
                            </td>
                            <td width="100">
                                <input name="outDate"
                                       width="100%"
                                       showTime="false"
                                       allowInput="false"
                                       class="nui-datepicker" enabled="false" format="yyyy-MM-dd"/>
                            </td>
                            <td class="title required">
                                <label>仓库：</label>
                            </td>
                            <td>
                                <input id="storeId"
                                       name="storeId"
                                       allowInput="false"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="id"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                            <td class="title required">
                                <label>票据类型：</label>
                            </td>
                            <td>
                                <input name="billTypeId"
                                       id="billTypeId"
                                       allowInput="false"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="customid"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title required">
                                <label>客户名称：</label>
                            </td>
                            <td colspan="3">
                                <input id="guestId"
                                       name="guestId"
                                       allowInput="false"
                                       class="nui-buttonedit"
                                       emptyText="请选择查询客户..."
                                       onbuttonclick="selectCustomer('guestId')"
                                       width="100%"
                                       allowInput="false"
                                       selectOnFocus="true" />
                            </td>
                            <td class="title">
                                <label>验货员：</label>
                            </td>
                            <td colspan="1">
                                <input name="checker"
                                       id="checker"
                                       allowInput="false"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="name"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                            <td class="title">
                                <label>单据状态：</label>
                            </td>
                            <td>
                                <input name="billStatus"
                                       id="billStatus"
                                       allowInput="false"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="customid"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       enabled="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>销售员：</label>
                            </td>
                            <td colspan="1">
                                <input name="seller"
                                       id="seller"
                                       allowInput="false"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="name"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="false"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                            <td class="title">
                                <label>发票号：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" width="100%" name="sourceId"/>
                            </td>
                            <td class="title">
                                <label>总金额：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-textbox" width="100%" name="receivableAmt" enabled="false" style="text-align: right;"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>备注：</label>
                            </td>
                            <td colspan="5">
                                <input class="nui-textbox" width="100%" name="remark"/>
                            </td>
                            <td class="title">
                                <label>税率：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-textbox" width="100%" name="billTaxRate"
                                       id="billTaxRate"
                                       enabled="true" style="text-align: right;"/>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="nui-toolbar" style="padding:2px;border-left:0;">
                <table style="width:100%;">
                    <tr>
                        <td style="white-space:nowrap;">
                            <a class="nui-button" plain="true" iconCls="icon-add" onclick="addPart()" id="addPartBtn" enabled="false">添加</a>
                            <a class="nui-button" plain="true" iconCls="icon-edit" onclick="editPart()" id="editPartBtn" enabled="false">修改</a>
                            <a class="nui-button" plain="true" iconCls="icon-remove" onclick="deletePart()" id="deletePartBtn" enabled="false">删除</a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit">
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     dataField="outDetailList"
                     idField="detailId"
                     sortMode="client"
                     editNextOnEnterKey="true"
                     allowCellWrap="true"
                     showSummaryRow="true"
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="partCode" width="100" headerAlign="center" header="配件编码"></div>
                                <div allowSort="true" field="partFullName" headerAlign="center" header="配件名称"></div>
                                <div allowSort="true" field="unit" width="40" headerAlign="center" header="单位"></div>
                                <div allowSort="true" datatype="int" field="outQty" width="40" headerAlign="center" header="数量" summaryType="sum"></div>
                            </div>
                        </div>
                        <div header="销售金额信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" datatype="float" field="sellUnitPrice" width="60" headerAlign="center" header="单价" align="right"></div>
                                <div allowSort="true" datatype="int" field="discountRate" width="60" headerAlign="center" header="折扣率(%)" align="right"></div>
                                <div allowSort="true" datatype="float" field="discountLastAmt" width="60" headerAlign="center" header="金额" align="right" summaryType="sum"></div>
                            </div>
                        </div>
                        <div header="其他" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:250px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">入库日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           allowInput="false"
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
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span>客户名称;</span>
                </td>
                <td colspan="3">
                    <input id="btnEditSupplierAvd"
                           name="guestId"
                           allowInput="false"
                           class="nui-buttonedit"
                           emptyText="请选择客户..."
                           allowInput="false"
                           onbuttonclick="selectCustomer('btnEditSupplierAvd')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">销售单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" name="outIdList" emptyText="" width="100%" style="height: 100px;"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>
</body>
</html>
