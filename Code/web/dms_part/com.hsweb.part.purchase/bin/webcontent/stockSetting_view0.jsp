<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!--
  - Author(s): chenziming
  - Date: 2018-02-01 17:25:23
  - Description:
-->
<head>
<title>库存设置</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/stockMgr/stockSetting.js?v=1.0.4"></script>
<style type="text/css">
</style>
</head>
<body>
<input class="nui-combobox" visible="false" id="unit"/>
        <input class="nui-combobox" visible="false" id="abcType"/>
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
                    <label style="font-family:Verdana;">仓位：</label>
                    <input class="nui-textbox" width="100" name="stockLocation"/>
                    <label style="font-family:Verdana;">配件编码：</label>
                    <input class="nui-textbox" width="100" name="partCode"/>
                    <label style="font-family:Verdana;">名称：</label>
                    <input class="nui-textbox" width="100" name="name"/>
                    <label style="font-family:Verdana;">品牌：</label>
                    <input id="carBrand"
                           name="carBrand"
                           class="nui-combobox width1"
                           textField="nameCn"
                           valueField="id"
                           emptyText="请选择..."
                           url=""
                           allowInput="false"
                           showNullItem="false"
                           nullItemText="请选择..."/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                    <!--<a class="nui-button" plain="true" onclick="advancedSearch()">更多</a>-->
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" iconCls="icon-add" plain="true" onclick="addInbound()">计算销量</a>
                <a class="nui-button" iconCls="icon-edit" plain="true" onclick="storeCycEdit()">周期定义</a>
                <a class="nui-button" iconCls="icon-ok" plain="true" onclick="setStoreLocationBatch()">批量设置仓位</a>
                <!--<a class="nui-button" iconCls="icon-save" plain="true" onclick="save()" id="saveEnterMainBtn">保存</a>-->
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <div class="nui-splitter"
         allowResize="false"
         style="width:100%;height:100%;">
        <div size="210" showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;text-align: center;">
                <span>系统分类</span>
            </div>
            <div class="nui-fit">
                <ul id="tree1" class="nui-tree" url="" style="width:100%;"
                    dataField="partTypes"
                    ondrawnode="onDrawNode"
                    onnodedblclick="onNodeDblClick"
                    showTreeIcon="true" textField="name" idField="id" parentField="parentid" resultAsTree="false">
                </ul>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-top:0;border-left:0;border-right:0;">
                <span>零件列表</span>
            </div>
            <div class="nui-fit" >
                <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     frozenStartColumn="0"
                     frozenEndColumn="0"
                     borderStyle="border:0;"
                     dataField="ptsStockCycList"
                     url=""
                     ondrawcell="onPartGridDraw"
                     idField="id"
                     totalField="page.count"
                     selectOnLoad="true"
                     pageSize="50"
                     sortMode="client"
                     showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="partId" width="50" headerAlign="center" header="内码"></div>
                                <div field="partCode" width="80" headerAlign="center" allowSort="true" header="配件编码"></div>
                                <div field="partName" width="80" headerAlign="center" allowSort="true" header="配件名称"></div>
                                <div field="partFullName" width="80" headerAlign="center" allowSort="true" header="配件全称"></div>
                                <div field="qualityTypeId" width="80" headerAlign="center" allowSort="true" header="品质"></div>
                                <div field="partBrandId" width="80" headerAlign="center" allowSort="true" header="品牌"></div>
                                <div field="applyCarModel" width="80" headerAlign="center" allowSort="true" header="品牌车型"></div>
                            </div>
                        </div>
                        <div header="库存信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="stockQty" width="50" headerAlign="center" header="数量" align="right"></div>
                                <div field="stockPrice" width="80" headerAlign="center" allowSort="true" header="单价" align="right"></div>
                                <div field="stockAmt" width="80" headerAlign="center" allowSort="true" header="金额" align="right"></div>
                                <div field="suggestPrice" width="80" headerAlign="center" allowSort="true" header="建议销价" align="right"></div>
                                <div field="daySellValume" width="80" headerAlign="center" allowSort="true" header="日销量" align="right"></div>
                                <div field="monthSellValume" width="80" headerAlign="center" allowSort="true" header="月销量" align="right"></div>
                            </div>
                        </div>
                        <div header="周期信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="orderCyc" width="50" headerAlign="center" header="订货周期" align="right"></div>
                                <div field="arriveCyc" width="80" headerAlign="center" allowSort="true" header="到货周期" align="right"></div>
                                <div field="safeCyc" width="80" headerAlign="center" allowSort="true" header="安全库存周期" align="right"></div>
                            </div>
                        </div>
                        <div header="上下限" headerAlign="center">
                            <div property="columns">
                                <div field="stockUpLimit" width="60" headerAlign="center" align="right" allowSort="true" header="上限"></div>
                                <div field="stockDownLimit" width="60" headerAlign="center" align="right" allowSort="true" header="下限"></div>
                            </div>
                        </div>
                        <div header="仓位信息" headerAlign="center">
                            <div property="columns">
                                <div field="storeLocation" width="60" headerAlign="center" align="right" allowSort="true" header="存储仓位"></div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div field="carTypeIdF" width="60" headerAlign="center" allowSort="true" header="一级分类"></div>
                                <div field="carTypeIdS" width="60" headerAlign="center" allowSort="true" header="二级分类"></div>
                                <div field="carTypeIdT" width="60" headerAlign="center" allowSort="true" header="三级分类"></div>
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
