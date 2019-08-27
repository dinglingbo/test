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
<title>采购订单</title>
<script src="<%=webPath + contextPath%>/purchase/js/purchaseOrder/purchaseOrder.js?v=1.0.59"></script>
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
    <div id="mainTabs" class="nui-tabs" name="mainTabs"
           activeIndex="0" 
           style="width:100%; height:100%;" 
           plain="false" 
           onactivechanged="ontopTabChanged">

        <div title="配件信息" id="partInfoTab" name="partInfoTab" url="" >
            <!--配件基本信息-->
            <%@include file="/purchase/purchaseOrder/pchsPartInfo.jsp" %>
          <!-- <div class="nui-fit">
              <iframe id="formIframePart" src="" frameborder="0" scrolling="yes" height="height: 110px;" width="100%" noresize="noresize"></iframe>
          </div> -->
        </div> 
        <div title="采购订单" id="billmain" name="billmain" >
            <!--采购订单信息-->
            <%@include file="/purchase/purchaseOrder/purchaseOrderDetail.jsp" %>
        </div>
        <div title="采购车" name="purchaseAdvanceTab" url="" >
          <!-- <div class="nui-fit">
                <iframe id="formIframePchs" src="" frameborder="0" scrolling="yes" height="height: 110px;" width="100%" noresize="noresize"></iframe>
          </div> -->
        </div>   
    </div>
</div>


<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:350px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
          <tr>
                <td class="title">订货日期:</td>
                <td>
                    <input id="sOrderDate"
                           name="sOrderDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eOrderDate"
                           name="eOrderDate"
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
                <td class="title">创建日期:</td>
                <td>
                    <input name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eCreateDate"
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
                <td class="title">提交日期:</td>
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
                    <span style="letter-spacing: 6px;">供应</span>商:
                </td>
                <td colspan="3">
                    <input id="advanceGuestId"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('advanceGuestId')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">订单单号:</td>
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
     title="配件选择" style="width:700px;height:350px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     style="padding:2px;border-bottom:0;"
     allowDrag="true">
     <div class="nui-toolbar" >
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               onrowdblclick="addSelectPart"
               onshowrowdetail="onShowRowDetail"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div type="expandcolumn" width="50" >替换件</div>
                <div field="code" name="code" width="100" headerAlign="center" header="配件编码"></div>
                <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OE码"></div>
                <div field="name" name="name" width="100" headerAlign="center" header="配件名称"></div>
                <div field="partBrandId" name="partBrandId" width="100" headerAlign="center" header="品牌"></div>
                <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
                <div allowSort="true" datatype="float" name="outableQty" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div>
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
            <td colspan="1" align="left">供应商名称：</td>
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

<div id="advancedTipWin" class="nui-window"
        title="未成功导入配件" style="width:400px;height:200px;"
        showModal="true"
        allowResize="false"
        allowDrag="true">
        <div id="advancedTipForm" class="form">
            <table style="width:100%;height: 100%;">
            
                <tr>
                    <td colspan="3">
                        <textarea class="nui-textarea" emptyText="" width="100%" style="height: 100%;" id="imprtPastCodeList" name="imprtPastCodeList"></textarea>
                    </td>
                </tr>
                
            </table>
        </div>
    </div>

<div id="setPriceWin" class="nui-window"
        title="设置价格" style="width:600px;height:200px;"
        showModal="true"
        allowResize="false"
        allowDrag="true">
        <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td colspan="">
                    <a class="nui-button" iconCls="" plain="true" onclick="savePrice()"><span class="fa fa-save fa-lg"></span>&nbsp;设置价格</a>
                </td>
            </tr>  
        </table>
        </div>
 		<div id="priceGrid" class="nui-datagrid" style="width:100%;height:80%;"
                showPager="false"
                dataField="price"
                allowCellSelect="true"
                allowCellEdit="true"
                sortMode="client"
                pageSize="10000"
                sizeList="[1000,5000,10000]"
                oncellcommitedit="onCellCommit"
                showSummaryRow="false">
               <div property="columns">
                   <div allowSort="true" field="name" width="100" headerAlign="center" header="价格类型"></div>
                   <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="销售价">
                        <input property="editor" vtype="float" class="nui-textbox"/>
                   </div>
                   <div allowSort="true" datatype="float" field="wholePrice" width="60" headerAlign="center" header="批发价">
                        <input property="editor" vtype="float" class="nui-textbox"/>
                   </div>
                   <div allowSort="true" datatype="float" field="lowestSellPrice" width="60" headerAlign="center" header="最低销售价">
                        <input property="editor" vtype="float" class="nui-textbox"/>
                   </div>
                   <div allowSort="true" datatype="float" field="operator" width="60" headerAlign="center" header="创建人"></div>
                   <div allowSort="true" field="operateDate" headerAlign="center" header="创建日期" dateFormat="yyyy-MM-dd HH:mm"></div>
               </div>
          </div>
    </div>
</body>

<!-- 替换件 -->
<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

   <div id="innerPartGrid"
       dataField="parts"
       allowCellWrap = true
       class="nui-datagrid"
        onrowdblclick="addSelectPart"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
            <div type="indexcolumn">序号</div>
            <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
            <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OE码"></div>
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
</html>
