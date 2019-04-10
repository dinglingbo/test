<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!--  
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>采购入库</title>
<script src="<%=webPath + contextPath%>/manage/js/inOutManage/purchaseOrderEnter/purchaseOrderEnter.js?v=1.2.10"></script>
<style type="text/css">


.title {
  width: 60px;
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


    <!--采购入库信息-->
    <%@include file="/manage/inOutManage/purchaseOrderEnter/purchaseEnterDetail.jsp" %>



<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:450px;height:350px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
          <tr>
                <td class="title">创建日期:</td>
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
                <td class="title">入库日期:</td>
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
                <td class="title">入库单号:</td>
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
               frozenStartColumn="0"
               frozenEndColumn="1"
               sortMode="client"
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
                <div field="code" name="code" width="100" headerAlign="center" header="配件编码"></div>
                <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OEM码"></div>
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
            <td colspan="1" align="center">仓库</td>
            <td colspan="1" align="center">仓位</td>
            <td colspan="1" align="center">OEM码</td>
            <td colspan="1" align="center">规格/方向/颜色</td>   
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div>  

</body>
</html>
