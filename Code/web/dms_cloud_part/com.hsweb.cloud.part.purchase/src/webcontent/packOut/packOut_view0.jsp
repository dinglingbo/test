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
<title>打包发货</title>
<script src="<%=webPath + contextPath%>/purchase/js/packOut/packOut.js?v=1.0.1"></script>
<style type="text/css">
.title {
  width: 60px;
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

                <label style="font-family:Verdana;">客户：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择客户..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
           
            </td>
        </tr>
    </table>
</div>


<div class="nui-fit">
    <div class="nui-splitter"
         id="splitter"
         allowResize="true"
         handlerSize="6"
         style="width:100%;height:100%;">
        <div size="220" showCollapseButton="true">
          <div title="打包列表" class="nui-panel"
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
                        <div field="guestName" width="80" headerAlign="center" header="客户"></div>
                        <div field="createDate" width="150" headerAlign="center" dateFormat="yyyy-MM-dd H:mm:ss" header="打包日期"></div>
                        <div field="stateMan" width="60" headerAlign="center" header="打包员"></div><div field="auditSign" width="35" headerAlign="center" header="状态"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="单号"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                        <div field="auditDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd H:mm:ss" header="审核日期"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            

             <div class="nui-fit">
                  <fieldset id="fd1" style="width:95%;height:90px;">
                      <legend><span>打包发货信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-textbox" id="serviceId" name="serviceId" width="100%" enabled="true" visible="false">
                              <input name="billTypeId" visible="false"
                                           id="billTypeId"
                                           class="nui-combobox width1"
                                           textField="name"
                                           valueField="customid"
                                           enabled="true"
                                           valuefromselect="true"
                                           allowInput="true"
                                           selectOnFocus="true"
                                           showNullItem="false"
                                           width="100%"/>
                              <table style="width: 100%;">
                                  <tr>
                                      <td class="title required">
                                          <label>客户：</label>
                                      </td>
                                      <td colspan="3">
                                          <input id="guestId"
                                                 name="guestId"
                                                 class="nui-buttonedit"
                                                 emptyText="请选择客户..."
                                                 onvaluechanged="onGuestValueChanged"
                                                 onbuttonclick="selectSupplier('guestId')"
                                                 width="100%"
                                                 placeholder="请选择客户"
                                                 selectOnFocus="true" />
                                          <input class="nui-textbox" id="guestName" name="guestName" width="100%" visible="false">
                                      </td>
                                      <td class="title required">
                                          <label>物流公司：</label>
                                      </td>
                                      <td colspan="1">
                                          <input id="logisticsGuestId"
                                                 name="logisticsGuestId"
                                                 class="nui-buttonedit"
                                                 allowInput="false"
                                                 emptyText="请选择物流公司..."
                                                 onbuttonclick="selectLogisticsSupplier('logisticsGuestId')"
                                                 width="100%"
                                                 placeholder="请选择物流公司"
                                                 selectOnFocus="true" />
                                          <input class="nui-textbox" id="logisticsName" name="logisticsName" width="100%" visible="false">
                                      </td>
                                      <td class="title required">
                                          <label>物流单号：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="logisticsNo" name="logisticsNo" width="100%" enabled="true">
                                      </td>
                                      <td class="title required">
                                          <label>发货员：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="packMan" name="packMan" width="100%">
                                      </td>
                                      <td class="title required">
                                          <label>发货日期：</label>
                                      </td>
                                      <td width="120">
                                          <input name="createDate"
                                                 id="createDate"
                                                 width="100%"
                                                 enabled="false"
                                                 showTime="true"
                                                 class="nui-datepicker" enabled="false" format="yyyy-MM-dd H:mm:ss"/>
                                      </td>
                                  </tr>
                                  <tr>
                                      <td class="title required">
                                          <label>收货人：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-combobox" id="receiveMan" name="receiveMan" width="100%" textField="receiveMan"
                                           valueField="receiveMan" valuefromselect="true"
                                           onvaluechanged="onReceiveManChanged"
                                           allowInput="true" selectOnFocus="true">
                                      </td>
                                      <td class="title">
                                          <label>联系方式：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="receiveManTel" name="receiveManTel" width="100%" enabled="false">
                                      </td>
                                      <td class="title">
                                          <label>收货地址：</label>
                                      </td>
                                      <td colspan="3">
                                          <input class="nui-textbox" id="address" name="address" width="100%" enabled="false">
                                      </td>
                                      <td class="title">
                                          <label>收货单位：</label>
                                      </td>
                                      <td colspan="3">
                                          <input class="nui-textbox" id="receiveCompName" name="receiveCompName" width="100%" enabled="false">
                                          <input class="nui-textbox" id="provinceId" name="provinceId" width="100%" visible="false">
                                          <input class="nui-textbox" id="cityId" name="cityId" width="100%" visible="false">
                                          <input class="nui-textbox" id="countyId" name="countyId" width="100%" visible="false">
                                          <input class="nui-textbox" id="streetAddress" name="streetAddress" width="100%" visible="false">
                                      </td>
                                  </tr>
                                  <tr>
                                      <td class="title required">
                                          <label>结算方式：</label>
                                      </td>
                                      <td colspan="1">
                                          <input name="settleTypeId" 
                                           id="settleTypeId"
                                           class="nui-combobox width1"
                                           textField="name"
                                           valueField="customid"
                                           enabled="true"
                                           valuefromselect="true"
                                           allowInput="true"
                                           selectOnFocus="true"
                                           showNullItem="false"
                                           width="100%"/>
                                      </td>
                                      <td class="title required">
                                          <label>总包数：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="packItem" name="packItem" width="100%" vtype="float" selectOnFocus="true">
                                      </td>
                                      <td class="title required">
                                          <label>运费：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="truePayAmt" name="truePayAmt" width="100%" vtype="float" enabled="true">
                                      </td>
                                      <td class="title">
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="5">
                                          <input class="nui-textbox" id="remark" name="remark" width="100%" enabled="true">
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
                              <div field="orderMan" width="60" headerAlign="center" header="业务员"></div><!-- 
                              <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div> -->
                              <div allowSort="true" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
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
     title="高级查询" style="width:416px;height:220px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
            <tr>
                <td class="title">发货日期:</td>
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
                    <span style="letter-spacing: 6px;">客户:
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
                <td class="title">发货单号:</td>
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
              <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OEM码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="60" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="销售单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>

</div>


</body>
</html>
