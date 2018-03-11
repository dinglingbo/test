<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-01-31 17:24:45
  - Description:
-->
<head>
<title>jsp auto create</title>
<script src="<%= request.getContextPath() %>/purchasePart/js/inventoryMgr/inventoryLoss.js?v=1.0.8"></script>
<style type="text/css">
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	border: 0;
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
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)" id="type0">本日</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)" id="type1">昨日</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)" id="type2">本周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)" id="type3">上周</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)" id="type4">本月</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)" id="type5">上月</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(6)" id="type6">未审</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(7)" id="type7">已审</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(8)" id="type8">已过帐</a>
                <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(9)" id="type9">全部</a>
                <span class="separator"></span>
                <label style="font-family:Verdana;">出库单号：</label>
                <input class="nui-textbox" id="outId" enabled="true"/>
                <span class="separator"></span>
                <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addInbound()" enabled="true">新增</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editInbound()" enabled="false" id="editEnterMainBtn">修改</a>
                <a class="nui-button" iconCls="icon-save" plain="true" onclick="save()" enabled="false" id="saveEnterMainBtn">保存</a>
                <a class="nui-button" iconCls="icon-undo" plain="true" onclick="cancelEditInbound()" enabled="false" id="cancelEditEnterMainBtn">取消</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="review()" enabled="false" id="reViewBtn">审核</a>
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
            <div title="出库单列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     selectOnLoad="true"
                     sortMode="client"
                     ondrawcell="onLeftGridDrawCell"
                     onrowdblclick="onLeftGridRowDblClick"
                     dataField="ptsOutMainList"
                     url="">
                    <div property="columns">
                        <div field="id" headerAlign="center" header="出库单号" allowSort="true"></div>
                        <div field="outDate" width="80" headerAlign="center" header="出库日期" dateFormat="yyyy-MM-dd H:ss:mm" allowSort="true"></div>
                        <div field="billStatus" width="30" headerAlign="center" header="状态" allowSort="true"></div>
                    </div>
                </div>
                <!--footer-->
                <div property="footer">
                    <input class='nui-textbox' value='' id="leftGridCount" readonly="true" style='vertical-align:middle;'/>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div title="出库信息" class="nui-panel"
                 style="width:100%;height: 110px;">
                <div id="basicInfoForm" class="form">
                    <table style="width: 100%;">
                        <tr>
                            <td class="title">
                                <label>出库单号：</label>
                            </td>
                            <td>
                                <input class="nui-textbox" width="100%" name="id" enabled="false" emptyText="新增出库单"/>
                            </td>
                            <td class="title">
                                <label>出库日期：</label>
                            </td>
                            <td width="100">
                                <input name="outDate"
                                       width="100%"
                                       showTime="true"
                                       class="nui-datepicker" enabled="false" format="yyyy-MM-dd H:mm:ss"/>
                            </td>
                            <td class="title required">
                                <label>仓库：</label>
                            </td>
                            <td>
                                <input id="storeId"
                                       name="storeId"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="id"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="true"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>盘亏原因：</label>
                            </td>
                            <td colspan="3">
                                <input name="backReasonId"
                                       id="backReasonId"
                                       class="nui-combobox width1"
                                       textField="name"
                                       valueField="customid"
                                       emptyText="请选择..."
                                       url=""
                                       allowInput="true"
                                       showNullItem="false"
                                       width="100%"
                                       nullItemText="请选择..."/>
                            </td>
                            <td class="title">
                                <label>盘点人：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-textbox" name="seller" width="100%">
                            </td>
                        </tr>
                        <tr>
                            <td class="title">
                                <label>备注：</label>
                            </td>
                            <td colspan="3">
                                <input class="nui-textbox" width="100%" name="remark"/>
                            </td>
                            <td class="title">
                                <label>盘亏金额：</label>
                            </td>
                            <td colspan="1">
                                <input class="nui-textbox" width="100%" name="totalAmt" enabled="false" style="text-align: right;"/>
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
                     url="">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                                <div field="partCode" width="100" headerAlign="center" header="配件编码" allowSort="true"></div>
                                <div field="partName" headerAlign="center" header="配件名称" allowSort="true"></div>
                                <div field="brandName" width="60" headerAlign="center" header="品牌" allowSort="true"></div>
                                <div field="applyCarModel" width="60" headerAlign="center" header="车型" allowSort="true"></div>
                                <div field="unit" width="40" headerAlign="center" header="单位" align="right" allowSort="true"></div>
                            </div>
                        </div>
                        <div header="数量金额信息" headerAlign="center">
                            <div property="columns">
                                <div field="outQty" width="40" headerAlign="center" header="数量" align="right" allowSort="true" dataType="int"></div>
                                <div field="sellUnitPrice" width="40" headerAlign="center" header="单价" align="right" allowSort="true" dataType="float"></div>
                                <div field="sellAmt" width="40" headerAlign="center" header="金额" align="right" allowSort="true" dataType="float"></div>
                            </div>
                        </div>
                        <div header="其他" headerAlign="center">
                            <div property="columns">
                                <div field="remark" width="60" headerAlign="center" header="备注"></div>
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
                <td class="title">出库日期:</td>
                <td>
                    <input name="startDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="endDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="true"/>
                </td>
            </tr>
            <tr>
                <td class="title">出库单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" name="outIdList"></textarea>
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
