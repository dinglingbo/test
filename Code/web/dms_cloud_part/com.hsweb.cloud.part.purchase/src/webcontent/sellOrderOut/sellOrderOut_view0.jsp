<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>销售出库</title>
<script src="<%=webPath + contextPath%>/purchase/js/sellOrderOut/sellOrderOut.js?v=1.1.43"></script>
<style type="text/css">
.title {
	width: 70px;
	text-align: right;
}
.title.required {
	color: red;
}

.title.tip {
  color: blue;
}


.title.wide {
	width: 100px;
}

.mini-panel-border {
	border: 0;
}

.mini-panel-body {
	padding: 0;
}

body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}

</style>
</head>
<body>

<div class="nui-fit">
    <%@include file="/purchase/sellOrderOut/sellOrderOutDetail.jsp" %>
</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:320px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">建单日期:</td>
                <td>
                    <input id="sCreateDate"
                           name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eCreateDate"
                           name="eCreateDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td> 
            </tr>
            <tr>
                <td class="title">出库日期:</td>
                <td>
                    <input name="sAuditDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eAuditDate"
                           class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           width="100%"
                           showClearButton="false"/>
                </td>
            </tr>
            <tr>
                <td class="title">
                    <span style="letter-spacing: 6px;">客户:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择客户..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">出库单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件编码:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="partCodeList" name="partCodeList"></textarea>
                </td>
            </tr>
            <tr>
                <td class="title">配件名称:</td>
                <td colspan="3">
                    <input id="partName"
                           name="partName"
                           class="nui-textbox" 
                           width="100%"/>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>


<div id="advancedMorePartWin" class="nui-window"
     title="配件选择" style="width:650px;height:350px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
     <div class="nui-toolbar" style="padding:2px;border-bottom:1;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <input class="nui-textbox" width="100px" id="morePartCode" name="morePartCode" enabled="true" emptyText="编码"/>
                    <input class="nui-textbox" width="100px" id="morePartName" emptyText="名称" selectOnFocus="true" name="morePartName"/>
                    <span class="separator"></span>
                    <input id="sortType" class="nui-combobox" width="100px" textField="text" valueField="id" emptyText="排序类型"
                           value="1"  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/> 
                    <input class="nui-checkbox" id="showStock" trueValue="1" falseValue="0" text="库存数量>0"/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
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
            <div title="批次选择" id="enterTab" name="enterTab" >
                <div id="enterGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     borderStyle="border:1;"
                     showPager="true"
                     pageSize="20"
                     sizeList=[20,50,100,200]
                     dataField="partlist"
                     url=""
                     sortMode="client"
                     ondrawcell=""
                     onrowdblclick=""
                     idField="id"
                     totalField="page.count"
                     allowCellSelect="true" allowCellEdit="false">
                    <div property="columns">
                        <div header="基础信息" headerAlign="center">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="partBrandId" width="70" headerAlign="center">品牌</div>
                                <div field="partCode" width="80" headerAlign="center" allowSort="true">配件编码</div>
                                <div field="name" width="80" headerAlign="center" allowSort="true">名称</div>
                                <div field="enterUnitId" width="30" headerAlign="center" allowSort="true">单位</div>
                            </div>
                        </div>
                        <div header="库存信息" headerAlign="center">
                            <div property="columns">   
                                <div field="stockQty" width="55px" headerAlign="center" allowSort="true">
                                库存数量
                                </div>   
                                <div field="preOutQty" width="55px" headerAlign="center" allowSort="true">
                                待出库数量
                                </div>
                                <div field="storeId" width="60" headerAlign="center" allowSort="true">仓库</div>
                    <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true">
                                仓位
                                </div>
                                <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true">
                                入库日期
                                </div>
                                <div field="guestName" width="150px" headerAlign="center" allowSort="true">
                                供应商
                                </div>  
                                <div field="enterPrice" width="55px" headerAlign="center" allowSort="true">
                                成本单价
                                </div>
                                <div field="enterCode" align="left" width="55px" headerAlign="center" allowSort="true">
                                入库单号
                                </div>
                            </div>
                        </div>
                        <div header="" headerAlign="center">
                            <div property="columns">
                                <div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>

                                <div field="position_name" width="60" headerAlign="center" allowSort="true">型号</div>

                                <div field="carModelName" width="70" headerAlign="center" allowSort="true">品牌车型</div>
                                <div field="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div title="配件选择" id="partInfoTab" name="partInfoTab" url="" >
                <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:100%;"
                   selectOnLoad="true"
                   borderStyle="border:1;"
                   showPager="true"
                   pageSize="20"
                   sizeList=[20,50,100,200]
                   dataField="parts"
                   sortMode="client"
                   frozenStartColumn="0"
                   frozenEndColumn="1"
                   onrowdblclick="addSelectPart"
                   totalField="page.count"
                   allowCellSelect="true"
                   editNextOnEnterKey="true"
                   url="">
                  <div property="columns">
                      <div type="indexcolumn">序号</div>
                      <div field="code" name="code" width="100" headerAlign="center" header="配件编码"></div>
                      <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
                      <div field="name" name="name" width="100" headerAlign="center" header="配件名称"></div>
                      <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                      <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                      <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                      <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                      <div field="partBrandId" name="partBrandId" width="100" headerAlign="center" header="品牌"></div>
                      <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
                      <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div>
                  </div>
                </div>
            </div> 
            
          </div>
          
    </div>
</div>

<div id="advancedAddWin" class="nui-window"
     title="快速录入配件" style="width:400px;height:200px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedAddForm" class="form">
        <table style="width:100%;">
          
            <tr>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="格式:编码*数量*单价" width="100%" style="height: 110px;" id="fastCodeList" name="fastCodeList"></textarea>
                </td>
            </tr>
            
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedAddOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedAddCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>

<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>
            <td colspan="1" align="left">单号：</td>
            <td colspan="1" align="left"><span id="eServiceId"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">客户名称：</td>
            <td colspan="1" align="left"><span id="eGuestName"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">备注：</td>
            <td colspan="1" align="left"><span id="eRemark"></span></td>
        </tr>
        <tr>  
            <td colspan="1" align="center">配件编码</td>
            <td colspan="1" align="center">配件全称</td>
            <td colspan="1" align="center">品牌车型</td>
            <td colspan="1" align="center">单位</td>
            <td colspan="1" align="center">数量</td>
            <td colspan="1" align="center">单价</td>
            <td colspan="1" align="center">金额</td>
            <td colspan="1" align="center">备注</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  

</body>
</html>
