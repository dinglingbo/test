<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>月结对账</title>
<script src="<%=webPath + contextPath%>/manage/settlement/js/billStatementDetail.js?v=1.1.8"></script>
<style type="text/css">
.title {
  width: 80px;
  text-align: right;
}

.title.required {
  color: red;
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
</style>
</head>
<body>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
           <td style="width:100%;">
            <span  id="bServiceId" style="">订单号：新对账单</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
            <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
            <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
            <span class="separator"></span>
            <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="printBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
        </td>
      </tr>
    </table>
</div>
 <div class="nui-fit">
      <fieldset id="fd1" style="width:99.9%;height:120px;">
      <legend><span>对账单信息</span></legend>
      <div class="fieldset-body">
          <div id="basicInfoForm" class="form" contenteditable="false">
              <input class="nui-hidden" name="id"/>
               <input class="nui-hidden" name="auditSign"/>
              <input class="nui-hidden" name="settleTypeId"/>
              <input class="nui-hidden" name="operateDate"/>
              <input class="nui-hidden" name="guestName" id="guestName"/>
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
                      <td class="title required" style="width:62px;">
                          <label>往来单位：</label>
                      </td>
                      <td colspan="3">
                          <input id="guestId"
                                 name="guestId"
                                 class="nui-buttonedit"
                                 emptyText="请选择往来单位..."
                                 onvaluechanged="onGuestValueChanged"
                                 onbuttonclick="selectSupplier('guestId')"
                                 width="100%"
                                 placeholder="请选择往来单位"
                                 selectOnFocus="true" />
                      </td>
                      <td class="title required">
                          <label>对账员：</label>
                      </td>
                      <td colspan="1">
                          <input class="nui-textbox" id="stateMan" name="stateMan" width="100%">
                      </td>
                      <td class="title required" style="width:72px">
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
                      <td class="title" style="width:72px">
                          <label>对账单号：</label>
                      </td>
                      <td colspan="1">
                          <input class="nui-textbox" id="serviceId" name="serviceId" width="100%" enabled="false">
                      </td>
                  </tr>
                  <tr>
                      <td class="title required" >
                          <label>对账金额：</label>
                      </td>
                      <td colspan="1">
                          <input class="nui-textbox" id="rpAmt" name="rpAmt" width="100%" enabled="false">
                      </td>
                      <td class="title required" style="width:72px">
                          <label>优惠金额：</label>
                      </td>
                      <td colspan="1">
                          <input class="nui-textbox" id="voidAmt" name="voidAmt" width="100%" vtype="float" selectOnFocus="true">
                      </td>
                      <td class="title required" style="width:72px">
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
                      <td class="title">
                          <label>备注：</label>
                      </td>
                      <td colspan="5">
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
               frozenStartColumn="0"
               frozenEndColumn="10"
               ondrawcell="onRightGridDraw"
               allowCellSelect="true"
               allowCellEdit="false"
               oncellcommitedit=""
               ondrawsummarycell=""
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
                  <div field="typeCode" width="60" headerAlign="center" header="业务类型"></div>
                  <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
                  <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
                  <div allowSort="true" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                  <div field="remark" width="120" headerAlign="center" header="备注"></div>
                  <div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
              </div>
          </div>
    </div>
  </div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">对账日期:</td>
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
                    <span style="letter-spacing: 6px;">往来单位:
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

<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>
            <td colspan="1" align="left">单号：</td>
            <td colspan="1" align="left"><span id="eServiceId"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">往来单位：</td>
            <td colspan="1" align="left"><span id="eGuestName"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">备注：</td>
            <td colspan="1" align="left"><span id="eRemark"></span></td>
        </tr>
        <tr>  
            <td colspan="1" align="center">业务类型</td>
            <td colspan="1" align="center">金额</td>
            <td colspan="1" align="center">业务员</td>
            <td colspan="1" align="center">审核日期</td>
            <td colspan="1" align="center">备注</td>
            <td colspan="1" align="center">业务单号</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
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
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
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
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
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
           dataField="pjSellOutDetailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
              <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="销售单价"></div>
              <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
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
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
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
</body>
</html>
