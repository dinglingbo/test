<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 09:17:43
  - Description:
-->
<head>
<title>领料</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/common/fastPartForConsumable.js?v=1.1.5"></script>
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
.mini-textbox-border{
	width:55px;
}
</style>
</head>
<body>

<div class="nui-fit">
    <div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" allowResize="true">
        <!--上：库存信息-->
        <div size="100%" showCollapseButton="false">
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
                                        value="1"  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/> 
                                <input class="nui-checkbox" id="showStock" trueValue="1" falseValue="0" text="库存数量>0"/>
                                <span class="separator"></span>
                                <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onOut" id="out"><span class="fa fa-check fa-lg"></span>&nbsp;出库</a>
                                <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;关闭</a>
                            
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
                            >
   
                        <div title="批次选择" id="enterTab" name="enterTab" >
                            <div id="enterGrid" class="nui-datagrid" style="width:100%;height:100%;"
                                    borderStyle="border:1;"
                                    selectOnLoad="true"
                                    showPager="true"
                                    pageSize="20"
                                    sizeList=[20,50,100,200]
                                    dataField="partlist"
                                    url=""
                                    showModified="false"
                                    sortMode="client"
                                    ondrawcell=""
                                    onrowdblclick=""
                                    idField="id"
                                    totalField="page.count"
                                    allowCellSelect="true" 
                                     allowCellEdit="true"  multiSelect="true" 
                                    >
                                <div property="columns">
                                	<div type="checkcolumn" class="mini-radiobutton" header="选择"></div>
                                    <div type="indexcolumn">序号</div>
                                    <div field="partCode" name="partCode" width="80" headerAlign="center" header="配件编码"></div>
                                    <div field="oemCode" name="oemCode" width="80" headerAlign="center" header="OEM码"></div>
                                    <div field="partName" partName="name" width="80" headerAlign="center" header="配件名称"></div>
                                    <div allowSort="true" datatype="float" width="60" field="stockQty" name="stockQty" headerAlign="center" header="库存数量"></div>
                                    <div allowSort="true" datatype="float" width="60" field="preOutQty" headerAlign="center" header="待出库数量"></div>
                                    <div allowSort="true" datatype="float" width="60" field="outSignQty" headerAlign="center" header="出库数量">
                                    	<input property="editor" class="mini-textbox" style="width:20%;" minWidth="20" />
                                    </div>
                                    <div field="enterPrice" width="55px" headerAlign="center" allowSort="true" header="库存单价"></div>
                                    <div field="billTypeId" align="left" width="55px" headerAlign="center" allowSort="true" header="票据类型"></div>
                                    <div field="storeId" width="60" headerAlign="center" allowSort="true" header="仓库"></div>
                                    <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true" header="仓位"></div>
                                    <div field="partBrandId" name="partBrandId" width="60" headerAlign="center" header="品牌"></div>
                                    <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="车型"></div>
                                    <div field="enterUnitId" width="30" headerAlign="center" header="单位"></div>
                                    <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd H:mm:ss" width="120px" header="入库日期" format="yyyy-MM-dd H:mm:ss" headerAlign="center" allowSort="true"></div>
                                    <div field="guestName" width="120px" headerAlign="center" allowSort="true" header="供应商"></div>  
                                    <div field="serviceId" align="left" width="100px" headerAlign="center" allowSort="true" header="入库单号"></div>
                                    <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div> 
                                    <div field="operator" name="operator" width="50" headerAlign="center" header="领料人"></div>
                                    <div field="remark" name="remark" width="50" headerAlign="center" header="备注"></div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                        
                </div>
            </div>
        </div>
        
    </div>
</div>



<div id="advancedAddWin" class="nui-window"
     title="数量单价录入" style="width:400px;height:200px;"
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
                        <a class="nui-button" id="chooseBtn" onclick="onAdvancedAddOk" style="width:60px;margin-right:20px;">确定</a>
                        <a class="nui-button" onclick="onAdvancedAddCancel" style="width:60px;">取消</a>
                    </div>
                </div>
        </div>
        <div title="销价参数" id="priceTab" name="priceTab" >
            <div class="nui-fit">
                <div id="priceGrid" class="nui-datagrid" style="width:100%;height:100%;"
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
                       <div allowSort="true" field="operateDate" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
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
                            </td>
                        </tr>
                    </table>
            </div>

        </div> 

    </div>
    
</div>

</body>
</html>
