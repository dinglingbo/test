<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-01-31 16:41:54
  - Description:
-->
<head>
<title>库存查询</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/stockMgr/stockQuery.js?v=1.0.4"></script>
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
                    <label style="font-family:Verdana;">分店名称：</label>
                    <input id="orgid"
                           name="orgid"
                           class="nui-combobox width1"
                           textField="orgname"
                           valueField="orgid"
                           emptyText="请选择..."
                           url=""
                           allowInput="false"
                           showNullItem="true"
                           nullItemText="请选择..."/>
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
                    <label style="font-family:Verdana;">配件编码：</label>
                    <input class="nui-textbox" width="100" name="partCode"/>
                    <label style="font-family:Verdana;">名称：</label>
                    <input class="nui-textbox" width="100" name="name"/>
                </td>
            </tr>
            <tr>
                <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">仓位：</label>
                    <input class="nui-textbox" width="100" name="storeLocation"/>
                    <label style="font-family:Verdana;">品牌车型：</label>
                    <input class="nui-textbox" width="100" name="applyCarModel"/>
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
                <span>配件列表</span>
            </div>
            <div class="nui-fit" >
                <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     frozenStartColumn="0"
                     frozenEndColumn="3"
                     borderStyle="border:0;"
                     dataField="ptsStockCycList"
                     url=""
                     ondrawcell="onPartGridDraw"
                     idField="id"
                     totalField="page.count"
                     selectOnLoad="true"
                     pageSize="50"
                     sortMode="true"
                     allowCellWrap="true"
                     showSummaryRow="true"
                     showFilterRow="false" allowCellSelect="true" allowCellEdit="false">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        <div header="分店仓库信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="orgName" width="100" headerAlign="center" header="分店名称"></div>
                                <div allowSort="true" field="storeId" width="50" headerAlign="center" header="仓库"></div>
                                <div allowSort="true" field="storeLocation" width="50" headerAlign="center" header="仓位"></div>
                            </div>
                        </div>
                        <div header="配件信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="partId" width="70" headerAlign="center" header="内码"></div>
                                <div allowSort="true" field="partCode" width="121" headerAlign="center" allowSort="true" header="配件编码"></div>
                                <div allowSort="true" field="partName" width="121" headerAlign="center" allowSort="true" header="配件名称"></div>
                                <div allowSort="true" field="partFullName" width="200" headerAlign="center" allowSort="true" header="配件全称"></div>
                                <div allowSort="true" field="qualityTypeId" width="70" headerAlign="center" allowSort="true" header="品质"></div>
                                <div allowSort="true" field="partBrandId" width="70" headerAlign="center" allowSort="true" header="品牌"></div>
                                <div allowSort="true" field="abcType" width="60" headerAlign="center" allowSort="true" header="ABC分类"></div>
                            </div>
                        </div>
                        <div header="库存信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="stockQty" width="50" headerAlign="center" header="数量" align="right" summaryType="sum"></div>
                                <div allowSort="true" field="unit" width="80" headerAlign="center" allowSort="true" header="单位" align="right"></div>
                                <div allowSort="true" field="stockPrice" width="80" headerAlign="center" allowSort="true" header="单价" align="right"></div>
                                <div allowSort="true" field="stockAmt" width="80" headerAlign="center" allowSort="true" header="金额" align="right" summaryType="sum"></div>
                                <div allowSort="true" field="suggestPrice" width="80" headerAlign="center" allowSort="true" header="建议销价" align="right"></div>
                                <div allowSort="true" field="lastSellPrice" width="80" headerAlign="center" allowSort="true" header="最后销价" align="right"></div>
                            </div>
                        </div>
                        <div header="上下限" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="stockUpLimit" width="60" headerAlign="center" align="right" allowSort="true" header="上限" align="right"></div>
                                <div allowSort="true" field="stockDownLimit" width="60" headerAlign="center" align="right" allowSort="true" header="下限" align="right"></div>
                            </div>
                        </div>
                        <div header="其他信息" headerAlign="center">
                            <div property="columns">
                                <div allowSort="true" field="applyCarModel" width="60" headerAlign="center" allowSort="true" header="品牌车型"></div>
                                <div allowSort="true" field="carTypeIdF" width="60" headerAlign="center" allowSort="true" header="一级分类"></div>
                                <div allowSort="true" field="carTypeIdS" width="60" headerAlign="center" allowSort="true" header="二级分类"></div>
                                <div allowSort="true" field="carTypeIdT" width="60" headerAlign="center" allowSort="true" header="三级分类"></div>
                                <div allowSort="true" field="lastEnterDate" dateFormat="yyyy-MM-dd" width="80" headerAlign="center" allowSort="true" header="最近入库日期"></div>
                                <div allowSort="true" field="lastOutDate" dateFormat="yyyy-MM-dd" width="80" headerAlign="center" allowSort="true" header="最近出库日期"></div>
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
