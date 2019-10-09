<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:17:43
  - Description:
-->
<head>
<title>配件查询</title>
<script src="<%=webPath + contextPath%>/common/js/embed/containPartInfo.js?v=2.0.14"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
</style>
</head>
<body>

<div class="nui-fit">
    <div  class="nui-splitter" style="width:100%;height:100%;" style="border:0;" handlerSize="0">
        <div size="200px" showCollapseButton="false">
            <div id="queryForm" class="form" style="text-align:center;padding:10px;">
                <table style="width:100%;">
                    <tr>
                        <td>
                            <input class="nui-textbox" width="100%" id="search-code" name="partCode" enabled="true" emptyText="编码"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="nui-textbox" width="100%" id="search-name" emptyText="名称" selectOnFocus="true" name="name"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="nui-textbox" width="100%" id="search-applyCarModel" selectOnFocus="true" emptyText="品牌车型" name="applyCarModel"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input class="nui-textbox" width="100%" selectOnFocus="true" id="search-namePy" emptyText="拼音" name="namePy"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input id="partBrandId"
                                   name="partBrandId"
                                   class="nui-combobox"
                                   width="100%"
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择品牌"
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   nullItemText="请选择品牌"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <textarea class="nui-textarea" emptyText="编码列表(多个编码请换行输入)" width="100%" style="height:80px;" id="partCodeList" name="partCodeList"></textarea>
                        </td>
                    </tr>
                    <tr style="display:none;">
                        <td>
                            <input class="nui-combobox" width="100%" id="applyCarBrandId" name="applyCarBrandId" enabled="true" emptyText="厂牌" textField="nameCn" valueField="id"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a class="nui-button" width="100%" iconCls="" plain="false" onclick="onSearch()">查&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;询</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a class="nui-button" width="100%" iconCls="" plain="false" onclick="onClear()">清空条件</a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <a class="nui-button" width="100%" iconCls="" plain="false" onclick="addPart()">新增配件</a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div showCollapseButton="false">
            <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                <div class="form" id="buttonForm">
                    <table style="width:100%;">
                        <tr>
                            <td style="white-space:nowrap;">
                                <a class="nui-button" id="pchsOrderAddBtn" visible="false" iconCls="" plain="true" onclick="addPchsOrder()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增采购订单</a> 
                                <a class="nui-button" id="sellOrderAddBtn" visible="false" iconCls="" plain="true" onclick="addSellOrder()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增销售订单</a> 
                                <a class="nui-button" id="pchsShopAddBtn" visible="false" iconCls="" plain="true" onclick="addPchsShop()"><span class="fa fa-check fa-lg"></span>&nbsp;添加到采购车</a>
                                <a class="nui-button" id="sellShopAddBtn" visible="false" iconCls="" plain="true" onclick="addSellShop()"><span class="fa fa-check fa-lg"></span>&nbsp;添加到销售车</a>

                                <!-- <a class="nui-button" iconCls="" plain="true" onclick="addPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;新增编码</a> -->
                                
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="nui-fit">
              <div id="partGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           dataField="parts"
                           url=""
                           ondrawcell="onPartGridDraw"
                           onrowdblclick="onRowDblClick"
                           idField="id"
                           totalField="page.count"
                           pageSize="100"
                           showPager="false"
                           allowCellSelect="true"
                           showLoading="true"
                           selectOnLoad="true"
                           multiSelect="true"
                           onselectionchanged="onGridSelectionChanged"
                           showFilterRow="false" allowCellSelect="true" allowCellEdit="true">
                      <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div type="checkcolumn" width="25"></div>
                              <div field="qualityTypeId" width="60" headerAlign="center">品质</div>
                              <div field="partBrandId" width="70" headerAlign="center">品牌</div>
                              <div field="code" width="80" headerAlign="center" allowSort="true">编码</div>
                              <div field="name" width="80" headerAlign="center" allowSort="true">名称</div>
                              <div field="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
                              <div field="unit" width="30" headerAlign="center" allowSort="true">单位</div>
                              <div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>
                              <div field="stockQty" width="60" headerAlign="center" allowSort="true">库存数量</div>
                              <div field="lastEnterPrice" width="60" headerAlign="center" allowSort="true">最近采购单价</div>
                              <div field="lastOutPrice" width="60" headerAlign="center" allowSort="true">最近销售单价</div>
                              <!-- <div field="position_name" width="60" headerAlign="center" allowSort="true">型号</div>
                              <div field="applyCarModel" width="70" headerAlign="center" allowSort="true">品牌车型</div>
                              <div field="carTypeIdF" width="80" headerAlign="center" allowSort="true">一级分类</div>
                              <div field="carTypeIdS" width="80" headerAlign="center" allowSort="true">二级分类</div>
                              <div field="carTypeIdT" width="80" headerAlign="center" allowSort="true">三级分类</div>
                              <div field="pchsPrice" width="60" headerAlign="center" align="right" allowSort="true">建议采购单价</div>
                              <div field="pchsSPrice" width="60" headerAlign="center" align="right" allowSort="true">4S采购单价</div>
                              <div field="sellPrice" width="60" headerAlign="center" align="right" allowSort="true">建议销售单价</div>
                              <div field="sellSPrice" width="70" headerAlign="center" align="right" allowSort="true">4S销价</div>
                              <div field="isDisabled" width="50" headerAlign="center">状态</div>
                              <div field="position_name" width="70" headerAlign="center" header="售价方式" allowSort="true"></div>
                              <div field="abcType" width="80" headerAlign="center" allowSort="true">ABC类型</div>
                              <div field="produceFactory" width="80" headerAlign="center" allowSort="true">生产厂家</div>
                              <div field="nameEn" width="120" headerAlign="center" allowSort="true">英文名称</div>
                              <div field="id" width="50" headerAlign="center">配件ID</div> -->

                      </div>
              </div>
            </div>
        </div>
    </div>
        
</div>


</body>
</html>
