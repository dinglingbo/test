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
<title>快速录入</title>
<script src="<%=webPath + contextPath%>/common/js/fastPartChoose.js?v=1.0.107"></script>
<style type="text/css">
.table-label {
	text-align: right;
}
body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}
.title {
	width: 60px;
	text-align: right;
}

.title.required {
	color: red;
}
</style>
</head>
<body>

<div class="nui-fit">
    <div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" allowResize="true">
        <!--上：库存信息-->
        <div size="65%" showCollapseButton="false">
            <div class="nui-fit">
                <div class="nui-toolbar" style="padding:2px;border-bottom:1;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;">
                                <input class="nui-textbox" width="100px" id="morePartCode" name="morePartCode" selectOnFocus="true" enabled="true" emptyText="编码"/>
                                <input class="nui-textbox" width="100px" id="morePartName" emptyText="名称"  selectOnFocus="true" name="morePartName"/>
                                <input id="partBrandId"
                                   name="partBrandId"
                                   class="nui-combobox"
                                   width="100px"
                                   textField="name"
                                   valueField="id"
                                   valueFromSelect="true"
                                   emptyText="品牌"
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   nullItemText="品牌"/>
                                <input class="nui-textbox" width="100px" id="moreServiceId" emptyText="入库单号" selectOnFocus="true" name="moreServiceId"/>
                                <span class="separator"></span>
                                <input id="sortType" class="nui-combobox" width="100px" textField="text" valueField="id" emptyText="排序类型"
                                        value="4"  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/> 
                                <input class="nui-checkbox"  id="showStock" trueValue="1" falseValue="0" text="库存数量>0"/>
                                <span class="separator"></span>
                                <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                            
                                <input id="billTypeId" visible="false" class="nui-combobox" textField="name" valueField="customid" />
                                <input id="tempId" visible="false" class="nui-textbox" name="tempId" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div id="morePartTabs" class="nui-tabs" name="morePartTabs"
                            activeIndex="0" 
                            style="width:100%; height:100%;" 
                            plain="false" 
                            onactivechanged="onMoreTabChanged">
                        <div title="配件选择" id="partInfoTab" name="partInfoTab" url="" >
                            <div class="nui-fit">
                                <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                    selectOnLoad="true"
                                    borderStyle="border:1;"
                                    showPager="true"
                                    pageSize="20"
                                    sizeList=[20,50,100,200]
                                    dataField="parts"
                                    sortMode="client"
                                    onrowdblclick=""
                                    onshowrowdetail="onShowRowDetail"
                                    totalField="page.count"
                                    allowCellSelect="true"
                                    editNextOnEnterKey="true"
                                    url="">
                                    <div property="columns">
                                        <div type="indexcolumn">序号</div>
                                        <div type="expandcolumn" width="50" >替换件</div>
                                        <div field="code" name="code" width="100" headerAlign="center" header="配件编码"></div>
                                        <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
                                        <div field="name" name="name" width="100" headerAlign="center" header="配件名称"></div>
                                        <div field="partBrandId" name="partBrandId" width="80" headerAlign="center" header="品牌"></div>
                                        <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
                                        <div allowSort="true" datatype="float" name="outableQty" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                                        <!-- <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div> -->
                                        <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                                        <div allowSort="true" datatype="float" field="costPrice" summaryType="sum" width="60" headerAlign="center" header="成本单价"></div>
                                        <!-- <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div> -->
                                        <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div>
                                    </div>
                                </div>
                            </div>
                            
                        </div> 
                        <div title="批次选择" id="enterTab" name="enterTab" >
                            <div id="enterGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                    borderStyle="border:1;"
                                    selectOnLoad="true"
                                    showPager="true"
                                    pageSize="20"
                                    sizeList=[20,50,100,200]
                                    dataField="partlist"
                                    url=""
                                    onshowrowdetail="onShowRowDetail2"
                                    showModified="false"
                                    sortMode="client"
                                    ondrawcell=""
                                    onrowdblclick=""
                                    idField="id"
                                    totalField="page.count"
                                    allowCellSelect="true" allowCellEdit="false">
                                <div property="columns">
                                    <div type="indexcolumn">序号</div>
                                    <div type="expandcolumn" width="50" >替换件</div>
                                    <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
                                    <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
                                    <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
                                    <div allowSort="true" datatype="float" width="60" field="stockQty" name="stockQty" headerAlign="center" header="库存数量"></div>
                                    <div allowSort="true" datatype="float" width="60" field="preOutQty" headerAlign="center" header="待出库数量"></div>
                                    <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
                                    <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
                                    <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
                                    <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
                                    <div field="partBrandId" name="partBrandId" width="80" headerAlign="center" header="品牌"></div>
                                    <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
                                    <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
                                    <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="入库日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
                                    <div field="guestName" width="150px" headerAlign="center" allowSort="true" header="供应商"></div>  
                                    <div field="enterCode" align="left" width="100px" headerAlign="center" allowSort="true" header="入库单号"></div>
                                    <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
                                </div>
                            </div>
                        </div>
                        
                    </div>
                        
                </div>
            </div>
        </div>
        <!--下：辅助信息-->
        <div showCollapseButton="false">
            <div class="nui-fit">
                <div id="mainTabs" class="nui-tabs" name="mainTabs"
                    activeIndex="0" 
                    style="width:100%; height:100%;" 
                    plain="false" >
                    <div title="销售记录" name="outRecordTab" url="" ></div> 
                    <div title="价格信息" name="priceTab" url="" ></div> 
                    <div title="替换件" name="partCommonTab" url="" ></div> 
                </div>	
            </div>
        </div>
    </div>
</div>




<div id="advancedAddWin" class="nui-window"
     title="数量单价录入" style="width:400px;height:230px;"
     showModal="true" showHeader="false"
     allowResize="false"
     allowDrag="true">
     <div id="optTabs" class="nui-tabs" name="optTabs"
        activeIndex="0" 
        style="width:100%; height:100%;" 
        plain="false" >
        <div title="数量单价" id="qpTab" name="qpTab" >
                <div id="advancedAddForm" class="form">
                    <table style="width:100%;padding-top: 20px">
                        <tr>
                            <td class="title required">
                                <label>仓库：</label>
                            </td>
                            <td>
                                <input id="storeId"
                                        name="storeId"
                                        class="nui-combobox"
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
                                <label>仓位：</label>
                            </td>
                            <td>
                                <input id="storeShelf" name="storeShelf" class="nui-textbox"  vtype="" selectOnFocus="true" width="100%" value="1"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title required">
                                <label>数量：</label>
                            </td>
                            <td>
                                <input id="qty" name="qty" class="nui-textbox" onvaluechanged="calc('qty')" vtype="float" selectOnFocus="true" width="100%" value="1"/>
                            </td>
                            <td class="title required">
                                <label>单价：</label>
                            </td>
                            <td>
                                <input id="price" name="price" class="nui-textbox width1" onvaluechanged="calc('price')" vtype="float" selectOnFocus="true" enabled="true" width="100%"/>
                            </td>
                        </tr>
                        <tr>
                            <td class="title required">
                                <label>金额：</label>
                            </td>
                            <td>
                                <input id="amt" name="amt" class="nui-textbox" onvaluechanged="calc('amt')" vtype="float" selectOnFocus="true" enabled="true" width="100%"/>
                            </td>
                            <td class="title">
                                <label>备注：</label>
                            </td>
                            <td>
                                <input id="remark" name="remark" class="nui-textbox" selectOnFocus="true" enabled="true" width="100%"/>
                            </td>
                        </tr>
                        
                    </table>
                    <div style="text-align:center;padding:10px;">
                        <a class="nui-button" id="chooseBtn" checkOnClick="true" onclick="onAdvancedAddOk" style="width:60px;margin-right:20px;">确定</a>
                        <a class="nui-button" onclick="onAdvancedAddCancel" style="width:60px;">取消</a>
                    </div>
                </div>
        </div>
        <div title="销价参数" id="priceTab" name="priceTab" >
            <div class="nui-fit">
                <div id="priceGrid" class="nui-datagrid" style="width:100%;height:80%;"
                    showPager="false"
                    dataField="price"
                    allowCellSelect="true"
                    allowCellEdit="true"
                    sortMode="client"
                    pageSize="10000"
                    sizeList="[1000,5000,10000]"
                    showSummaryRow="false">
                   <div property="columns">
                       <div allowSort="true" field="name" width="100" headerAlign="center" header="价格类型"></div>
                       <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="售价">
                            <input property="editor" vtype="float" class="nui-textbox"/>
                       </div>
                       <div allowSort="true" datatype="float" field="operator" width="60" headerAlign="center" header="创建人"></div>
                       <div allowSort="true" field="operateDate" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                   </div>
               </div>
            </div>
            <div class="nui-toolbar" style="padding:0px;border-bottom:1;">
                    <table style="width:100%;">
                        <tr>
                            <td style="width:100%;text-align:center;">
                                <a class="nui-button" iconCls="" plain="true" onclick="savePrice" id="savePriceBtn">
                                    <span class="fa fa-save fa-lg"></span>&nbsp;保存设置
                                </a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onAdvancedAddCancel" id="savePriceBtn">
                                    <span class="fa fa-close fa-lg"></span>&nbsp;取消
                                </a>
                            </td>
                        </tr>
                    </table>
            </div>

        </div> 

    </div>
    
</div>

<!-- 配件选择 -->
<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

   <div id="innerPartGrid"
       dataField="parts"
       allowCellWrap = true
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
            <div field="partName" name="partName" width="100" headerAlign="center" header="配件名称"></div>
            <div field="partBrandId" name="partBrandId" width="80" headerAlign="center" header="品牌"></div>
            <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
            <div allowSort="true" datatype="float" name="outableQty" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
            <!-- <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div> -->
            <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
            <div allowSort="true" datatype="float" field="costPrice" summaryType="sum" width="60" headerAlign="center" header="成本单价"></div>
            <!-- <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div> -->
            <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
      </div>
   </div>
</div>

<!-- 批次选择 -->
<div id="editFormDetail2" style="display:none;padding:5px;position:relative;">

   <div id="innerPartGrid2"
       dataField="partlist"
       allowCellWrap = true
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
            <div field="partName" partName="name" width="100" headerAlign="center" header="配件名称"></div>
            <div allowSort="true" datatype="float" width="60" field="stockQty" name="stockQty" headerAlign="center" header="库存数量"></div>
            <div allowSort="true" datatype="float" width="60" field="preOutQty" headerAlign="center" header="待出库数量"></div>
            <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
            <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
            <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
            <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
            <div field="partBrandId" name="partBrandId" width="80" headerAlign="center" header="品牌"></div>
            <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
            <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
            <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" header="入库日期" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true"></div>
            <div field="guestName" width="150px" headerAlign="center" allowSort="true" header="供应商"></div>  
            <div field="enterCode" align="left" width="100px" headerAlign="center" allowSort="true" header="入库单号"></div>
            <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
      </div>
   </div>
</div>

</body>
</html>
