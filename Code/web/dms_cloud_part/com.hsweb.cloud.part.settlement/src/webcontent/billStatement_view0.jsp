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
<title>月结对账</title>
<script src="<%=webPath + contextPath%>/settlement/js/billStatement.js?v=1.0.52"></script>
<style type="text/css">
.title {
  width: 85px;
  text-align: right;
}

.title.required {
  color: red;
}

.title.wide {
  width: 100px;
}

.mini-panel-bopder {
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
                
                <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本日</a>

                <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(0)" id="type0">本日</li>
                    <li iconCls="" onclick="quickSearch(1)" id="type1">昨日</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                    <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                    <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                </ul>

                <a class="nui-menubutton " menu="#popupMenuType" id="menunametype">未审</a>

                <ul id="popupMenuType" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(6)" id="type6">未审</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已审</li>
                    <span class="separator"></span>
                    <li iconCls="" onclick="quickSearch(8)" id="type8">全部</li>
                </ul>

                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择往来单位..." visible="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                
                <a class="nui-button" iconCls="" plain="true" visible="false" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                <a class="nui-button" iconCls="" plain="true" onclick="backAudit()" id="backAuditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;反审核</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="printBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
           
            </td>
        </tr>
    </table>
</div>


<div class="nui-fit">
    <input class="nui-hidden" name="auditSign" id="auditSign"/>
	<input class="nui-hidden" name="billStatusId" id="billStatusId"/>
    <div class="nui-splitter"
         id="splitter"
         allowResize="true"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="220" showCollapseButton="true">
          <div title="对账列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="true"
                     pageSize="50"
                     sizeList=[20,50,100,200]
                     selectOnLoad="true"
                     showModified="false"
                     ondrawcell="onLeftGridDrawCell"
                     onrowdblclick=""
                     onselectionchanged="onLeftGridSelectionChanged"
                     onbeforedeselect="onLeftGridBeforeDeselect"
                     dataField="list"
                     url="">
                    <div property="columns">
                      <div type="indexcolumn">序号</div>
                      	<div field="id" width="55" headerAlign="center" header="主键" visible="false"></div>
                      	<div field="auditSign" width="55" headerAlign="center" header="状态"></div>
                        <div field="guestName" width="150" headerAlign="center" header="往来单位"></div>
                        <div field="createDate" width="130" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="对账日期"></div>
                        <div field="stateMan" width="60" headerAlign="center" header="对账员"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="对账单号"></div>
                        <div field="fMonth" headerAlign="center" width="70" header="账单月份"></div>
                        <div field="rpAmt" headerAlign="center" width="70" header="对账金额"></div>
                        <div field="invoiceRegister" headerAlign="center" width="70" header="开票登记"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                        <div field="auditDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:120px;">
                      <legend><span>对账单信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id"/>
                              <input class="nui-hidden" name="settleTypeId"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-hidden" name="auditSign" id="auditSign"/>
                              <input name="billTypeId" visible="false"
                                     id="billTypeId"
                                     class="nui-combobox width1"
                                     textField="name"
                                     valueField="customid"
                                     enabled="false"
                                     valuefromselect="true"
                                     allowInput="true"
                                     selectOnFocus="true"
                                     showNullItem="false"
                                     width="100%"/>
                              <input name="settleTypeId" visible="false"
                                     id="settleTypeId"
                                     class="nui-combobox width1"
                                     textField="name"
                                     valueField="customid"
                                     enabled="false"
                                     valuefromselect="true"
                                     allowInput="true"
                                     selectOnFocus="true"
                                     showNullItem="false"
                                     width="100%"/>
                              <table style="width: 100%;">
                                  <tr>
                                      <td class="title required">
                                          <label>往来单位：</label>
                                      </td>
                                      <td colspan="1">
                                          <input id="guestId"
                                             name="guestId"
                                            
                                             dataField="suppliers"
                                             textField="fullName"
                                             loadingText="查询中"
                                             valueField="id"
                                             class="nui-autocomplete"
                                             emptyText="请选择往來单位..."
                                             allowInput="true"
                                             onvaluechanged="onGuestValueChanged"
                                             popupEmptyText="未找到往来单位"
                                             url=""  searchField="key"
                                             width="72%"
                                             placeholder="请选择往来单位"
                                             selectOnFocus="true" />
                                          <a class="nui-button" iconCls="" plain="false" onclick="selectSupplier('guestId')" id="selectSupplierBtn"><span class="fa fa-check fa-lg"></span></a>
<!--                                       	<input id="btnEdit1" width="8%" class="mini-buttonedit"  onbuttonclick="selectSupplier('guestId')"/> -->
                                      </td>
                                      <td class="title required">
                                          <label>对账员：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="stateMan" name="stateMan" width="100%">
                                      </td>
                                      <td class="title required">
                                          <label>对账日期：</label>
                                      </td>
                                      <td width="120">
                                          <input name="createDate"
                                                 id="createDate"
                                                 width="100%"
                                                 enabled="false"
                                                 showTime="true"
                                                 class="nui-datepicker" enabled="false" format="yyyy-MM-dd HH:mm"/>
                                      </td>
                                      <td class="title">
                                          <label>对账单号：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="serviceId" name="serviceId" width="100%" enabled="false">
                                      </td>
                                       <td class="title">
                                          <label>账单月份：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="fMonth" name="fMonth" width="100%" enabled="false">
                                      </td>
                                  </tr>
                                  <tr>
                                      <td class="title required">
                                          <label>对账金额：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="rpAmt" name="rpAmt" width="100%" enabled="false">
                                      </td>
                                      <td class="title required">
                                          <label>优惠金额：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="voidAmt" name="voidAmt" width="100%" vtype="float" selectOnFocus="true" enabled="false">
                                      </td>
                                      <td class="title required">
                                          <label>应结金额：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="trueRpAmt" name="trueRpAmt" width="100%" enabled="false">
                                      </td>
                                      <td class="title">
                                          <label>本次应收：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="rAmt" name="rAmt" width="100%" enabled="false">
                                      </td>
                                      <td class="title">
                                          <label>本次应付：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="pAmt" name="pAmt" width="100%" enabled="false">
                                      </td>
                                  </tr>
                                  <tr>
                           			  <td class="title required">
                                          <label>对账类型：</label>
                                      </td>
                                      <td colspan="1">
                                           <input name="balaType" visible=""
			                                 id="balaType"
			                                 class="nui-combobox width1"
			                                 textField="name"
			                                 valueField="id"
			                                 enabled="true"
			                                 valuefromselect="true"
			                                 allowInput="true"
			                                 selectOnFocus="true"
			                                 showNullItem="false"
			                                 data="balaTypeList"
			                                 width="100%"/>
                                      </td>
                                  	 <td class="title">
                                          <label>开票登记：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="invoiceRegister" name="invoiceRegister" width="100%">
                                      </td>
                                      
                                      <td cl
                                      <td class="title">
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="remark" name="remark" width="100%">
                                      </td>
                                      <td class="title">
                                          <label>历史欠收：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="debtRAmt" name="debtRAmt" width="100%" enabled="false">
                                      </td>
                                      <td class="title">
                                          <label>历史欠付：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="debtPAmt" name="debtPAmt" width="100%" enabled="false">
                                      </td>
                                  </tr>
                              </table>
                          </div>
                         
                      </div>
                  </fieldset>
                  <div class="nui-toolbar" style="padding:2px;border-left:0;">
                      <table style="width:100%;">
                          <tr>
                              <td style="white-space:nowrap;">
                                  <a class="nui-button" plain="true" iconCls="" onclick="addBill()" id="addBillBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;添加</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="deleteBill()" id="deleteBillBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                              </td>
                          </tr>
                      </table>
                  </div>
                  <div class="nui-fit">
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="detailList"
                           idField="id"
                           showSummaryRow="true"
                           ondrawcell="onRightGridDraw"
                           allowCellSelect="true"
                           allowCellEdit="true"
                           oncellcommitedit="onCellCommitEdit"
                           ondrawsummarycell="onDrawSummaryCell"
                           onselectionchanged=""
                           oncellbeginedit=""
                           showModified="false"
                           multiSelect="true"
                           editNextOnEnterKey="true"
                           onshowrowdetail="onShowRowDetail"
                           url="">
                          <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div type="checkcolumn" width="20"></div>
                              <div type="expandcolumn" width="20" >#</div>
                              <div field="guestId" width="60" headerAlign="center" header="客户ID" visible="false"></div>
                              <div field="guestName" width="60" headerAlign="center" header="客户名称" visible="false"></div>
                              <div field="typeCode" width="60" headerAlign="center" header="业务类型"></div>
                              <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="单据金额"></div>                            
                              <div field="rpAmt" width="60" headerAlign="center" summaryType="sum" header="对账金额"  >
                              		<input property="editor" class="nui-textbox" onvaluechanged="" vtype="float"/>
                              </div>
                              <div field="voidAmt" width="60" headerAlign="center" summaryType="sum" header="优惠金额" >
                               		<input property="editor" class="nui-textbox" onvaluechanged="" vtype="float"/>
                              </div>
                              <div field="noStateAmt" width="60" headerAlign="center" summaryType="sum" header="未对账金额"></div>
                              <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
                              <div allowSort="true" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                              <div field="remark" width="120" headerAlign="center" header="备注"></div>
                              <div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
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
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">对账日期:</td>
                <td>
                    <input id="sOrderDate"
                    	   name="sCreateDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eOrderDate"
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
                <td class="title">审核日期:</td>
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
                    <span style="">往来单位:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择往来单位..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">对账单号:</td>
                <td colspan="3">
                    <textarea class="nui-textarea" emptyText="" width="100%" style="height: 60px;" id="serviceIdList" name="serviceIdList"></textarea>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
        </div>
    </div>
</div>


<div id="editFormPchsEnterDetail" style="display:none;">
      <div id="innerPchsEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjPchsOrderDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>

  <div id="editFormPchsRtnDetail" style="display:none;">
      <div id="innerPchsRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjSellOrderDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>

  <div id="editFormSellOutDetail" style="display:none;">
      <div id="innerSellOutGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjSellOrderDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="showPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="showFullName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="showOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="showBrandName" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="showCarModel" width="60" headerAlign="center" header="品牌车型"></di
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
              <div allowSort="true" datatype="float" field="showPrice" width="60" headerAlign="center" header="销售单价"></div>
              <div allowSort="true" datatype="float" field="showAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
              <!-- <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
              <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
              <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
              <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
              <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
              <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
              <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
              <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
              <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div> -->
          </div>
      </div>
  </div>

  <div id="editFormSellRtnDetail" style="display:none;">
      <div id="innerSellRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="pjEnterDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
              <div allowSort="true" datatype="float" field="rtnPrice" width="60" headerAlign="center" header="退货单价"></div>
              <div allowSort="true" datatype="float" field="rtnAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
              <!-- <div field="enterPrice" width="60" headerAlign="center" header="成本单价"></div>
              <div field="enterAmt" width="60" headerAlign="center" summaryType="sum" header="成本金额"></div>
              <div allowSort="true" type="checkboxcolumn" field="taxSign" width="40" headerAlign="center" header="是否含税" trueValue="1" falseValue="0"></div>
              <div allowSort="true" field="taxRate" width="40" headerAlign="center" header="税点"></div>
              <div field="taxPrice" width="60" headerAlign="center" header="含税单价"></div>
              <div field="taxAmt" width="60" headerAlign="center" summaryType="sum" header="含税金额"></div>
              <div field="noTaxPrice" width="60" headerAlign="center" header="不含税单价"></div>
              <div field="noTaxAmt" width="60" headerAlign="center" summaryType="sum" header="不含税金额"></div>
              <div allowSort="true" field="partId" width="40" summaryType="count" headerAlign="center" header="配件ID"></div> -->
          </div>
      </div>
  </div>

  <div id="editFormAllotEnterDetail" style="display:none;">
      <div id="innerAllotEnterGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="data"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="partCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="fullName" headerAlign="center" header="配件全称"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" datatype="float" field="applyQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>

  <div id="editFormAllotOutDetail" style="display:none;">
      <div id="innerAllotOutGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="data"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="partCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="fullName" headerAlign="center" header="配件全称"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" datatype="float" field="acceptQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>


</div>


<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>
            <td colspan="1" align="left">单号：</td>
            <td colspan="1" align="left"><span id="eServiceId"></span></td>
            <td colspan="1" align="left">备注：</td>
            <td colspan="1" align="left"><span id="eRemark"></span></td>
        </tr>
              
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div> 
</body>
</html>
