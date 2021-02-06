<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-02 17:22:36
  - Description:
-->
<head>
<title>耗材出库</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/consumableItem/consumableItemOut.js?v=1.0.20"></script>
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

<div id="panel1" class="nui-panel" title="" iconCls="" style="width:100%;height:50px;"
     showHeader="false"
     borderStyle="border-bottom:0"
     bodyStyle="background-color: #eef1f3;"
     showToolbar="false" showCollapseButton="false" showFooter="false" allowResize="false" collapseOnTitleClick="false">
    <!--body-->
    生产耗材是指维修作业过程中易损易耗、价值较低、不需在结算单上体现、不直接和客户结算的生产辅助用品。<br/>
    生产耗材主要有：螺丝、螺帽、垫片、电线、胶布、胶水、铁线、焊条、线扣、塑料扣、砂布、破布、刷子、洗衣粉等。
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <div class="form" id="queryForm">
        <table style="width:100%;">
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                    <label style="font-family:Verdana;">仓库：</label>
                    <input id="storeId"
                           name="storeId"
                           class="nui-combobox width1"
                           textField="name"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                    <label style="font-family:Verdana;">助记码：</label>
                    <input class="nui-textbox" width="100" name="queryCode"/>
                    <label style="font-family:Verdana;">编码尾号：</label>
                    <input class="nui-textbox" width="100" name="lastCode"/>
                    <label style="font-family:Verdana;">零件名称：</label>
                    <input class="nui-textbox" width="100" name="name"/>
                    <label style="font-family:Verdana;">只显示耗材：</label>
                    <input class="nui-checkbox" width="100" name="showConsumableItemOnly" trueValue="1" falseValue="0" value="1"/>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch1()">查询库存</a>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch2()">查询已领</a>
                </td>
            </tr>
            <tr>
                <td>
                    <a class="nui-button" iconCls="icon-ok" plain="true" onclick="itemOut()" enabled="true" id="reViewBtn">领料出库</a>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="advancedSearch()">更多</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-fit" >
    <div class="nui-splitter"
         handlerSize="0"
         borderStyle="border:0"
         style="width:100%;height:100%;">
        <div size="50%" showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;border-right:0;">
                <span>库存列表</span>
            </div>
            <div id="leftGrid" class="nui-datagrid"
                 borderStyle="border-right:0"
                 style="width:100%;height:calc(100% - 27px);"
                 showPager="true"
                 dataField="ptsEnterMainDetailList"
                 idField="detailId"
                 totalField="page.count"
                 pageSize="20"
                 url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div header="配件信息" headerAlign="center">
                        <div property="columns">
                            <div field="partCode" width="60" headerAlign="center" header="配件编码"></div>
                            <div field="partName" headerAlign="center" header="配件名称"></div>
                            <!--<div field="partBrandName" width="60" headerAlign="center" header="品牌"></div>-->
                            <div field="applyCarModel" width="60" headerAlign="center" header="适用车型"></div>
                            <div field="unit" width="40" headerAlign="center" header="单位"></div>
                            <!--<div type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="含税" trueValue="1" falseValue="0"></div>-->
                        </div>
                    </div>
                    <div header="库存" headerAlign="center">
                        <div property="columns">
                            <div field="outableQty" width="80" headerAlign="center" header="库存" align="right"></div>
                            <div field="enterQty" width="80" headerAlign="center" header="入库数" align="right"></div>
                            <div field="outQty" width="80" headerAlign="center" header="已出库" align="right"></div>
                        </div>
                    </div>
                    <div header="不含税" headerAlign="center">
                        <div property="columns">
                            <div field="noTaxUnitPrice" width="80" headerAlign="center" header="单价" align="right"></div>
                        </div>
                    </div>
                    <div header="含税" headerAlign="center">
                        <div property="columns">
                            <div field="taxUnitPrice" width="80" headerAlign="center" header="单价" align="right"></div>
                            <div field="taxRate" width="80" headerAlign="center" header="税率" align="right"></div>
                        </div>
                    </div>
                    <div header="入库单号" headerAlign="center">
                        <div property="columns">
                            <div field="enterCode" width="100" headerAlign="center" header="入库单号"></div>
                            <div field="guestFullName" width="100" headerAlign="center" header="供应商"></div>
                            <div field="enterDate" headerAlign="center" width="80" header="入库日期" dateFormat="yyyy-MM-dd"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;border-left:0;">
                <span>已领列表</span>
            </div>
            <div id="rightGrid" class="nui-datagrid"
                 borderStyle="border-left:0"
                 style="width:100%;height:calc(100% - 27px);"
                 showPager="true"
                 dataField="list"
                 idField="id"
                 totalField="page.count"
                 pageSize="20"
                 frozenStartColumn="0"
                 frozenEndColumn="1"
                 url="">
                <div property="columns">
                    <div type="indexcolumn">序号</div>
                    <div header="" headerAlign="center">
                        <div property="columns">
                            <div field="action" width="60" headerAlign="center" header="退回"></div>
                        </div>
                    </div>
                    <div header="零件信息" headerAlign="center">
                        <div property="columns">
                            <div field="partCode" width="60" headerAlign="center" header="配件编码"></div>
                            <div field="partName" headerAlign="center" header="配件名称"></div>
                            <div field="partBrandName" width="60" headerAlign="center" header="品牌"></div>
                            <div field="applyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                            <div field="unit" width="40" headerAlign="center" header="单位"></div>
                            <div field="outQty" width="40" headerAlign="center" header="数量"></div>
                            <!--<div type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="含税" trueValue="1" falseValue="0"></div>-->
                        </div>
                    </div>
                    <div header="领料信息" headerAlign="center">
                        <div property="columns">
                            <div field="pickDate" headerAlign="center" width="80" header="领料日期" dateFormat="yyyy-MM-dd"></div>
                            <div field="pickMan" headerAlign="center" header="领料人"></div>
                            <div field="recorder" width="60" headerAlign="center" header="操作人"></div>
                            <div field="remark" width="60" headerAlign="center" header="备注"></div>
                        </div>
                    </div>
                    <div header="成本信息" headerAlign="center">
                        <div property="columns">
                            <div field="trueUnitPrice" width="80" headerAlign="center" header="成本单价"></div>
                            <div field="trueCost" width="80" headerAlign="center" header="成本单价"></div>
                        </div>
                    </div>
                    <div header="归库信息" headerAlign="center">
                        <div property="columns">
                            <div field="returnSign" headerAlign="center" header="归库标志"></div>
                            <div field="returnDate" headerAlign="center" width="80" header="归库日期" dateFormat="yyyy-MM-dd"></div>
                            <div field="returnMan" headerAlign="center" header="归库人"></div>
                        </div>
                    </div>
                    <div header="其他信息" headerAlign="center">
                        <div property="columns">
                            <div field="guestFullName" width="100" headerAlign="center" header="供应商"></div>
                            <div field="enterDate" headerAlign="center" width="80" header="采购日期" dateFormat="yyyy-MM-dd"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:380px;"
     showModal="true"
     allowResize="false"
     allowDrag="false">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">日期:</td>
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
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span style="letter-spacing: 6px;">供应</span>商:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           allowInput="false"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">领用人:</td>
                <td colspan="3">
                    <input class="nui-textbox" emptyText="" width="100%" name="pickMan" />
                </td>
            </tr>
            <tr>
                <td class="title">零件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" name="partCodeList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">入库单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100px;" name="enterIdList"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk(2)" style="width:80px;margin-right:20px;">查询已领</a>
            <a class="nui-button" onclick="onAdvancedSearchOk(1)" style="width:80px;margin-right:20px;">查询库存</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

</body>
</html>
