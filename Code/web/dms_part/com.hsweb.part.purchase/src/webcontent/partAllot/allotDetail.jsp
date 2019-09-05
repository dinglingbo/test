<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/common.jsp"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-02-23 14:18:46
  - Description:
-->
<head>
<title>调拨申请</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/partAllot/allotDetail.js?v=1.0.2"></script>
<style type="text/css">
.title {
  width: 70px;
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
body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}
.statusview{background:#78c800; color:#fff; padding:3px 20px; border-radius:20px;}
.nvstatusview{color: #5a78a0;padding:3px 20px; border-radius:20px;border: 1px solid;}
</style>
</head>
<body>

<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <span  id="bServiceId" style="">调拨单号：新调拨单</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save('0')" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="submit()" visible="true"  id="submitBtn"><span class="fa fa-check fa-lg"></span>&nbsp;提交</a>
                <a class="nui-button" iconCls="" plain="true" onclick="accept()" visible="true"  id="acceptBtn"><span class="fa fa-check fa-lg"></span>&nbsp;受理</a>
                <a class="nui-button" iconCls="" plain="true" onclick="refuse()" visible="true"  id="refuseBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;拒绝</a>
                <a class="nui-button" iconCls="" plain="true" onclick="inStock()" visible="true"  id="inStockBtn"><span class="fa fa-check fa-lg"></span>&nbsp;入库</a>
                <a class="nui-button" iconCls="" plain="true" onclick="outStock()" visible="true"  id="outStockBtn"><span class="fa fa-check fa-lg"></span>&nbsp;出库</a>
                <a class="nui-button" iconCls="" plain="true" onclick="del()" visible="true" id="delBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>
                <a class="nui-button" iconCls="" plain="true" onclick="delReturn()" visible="false" id="delReturnBtn"><span class="fa fa-reply fa-lg"></span>&nbsp;反作废</a>
                &nbsp;
                <label style="font-family:Verdana;"><span id="repairStatus" name="statusvi" class="nvstatusview" >草稿</span></label>
                <!-- <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a> -->
                <!-- <span id="status"></span> -->
            </td>
        </tr>
    </table>
</div>


  <div class="nui-fit">
             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:100px;">
                      <legend><span>调拨单信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-hidden" name="versionNo"/>
                              <input class="nui-hidden" name="status" id="status"/>
                              <input class="nui-hidden" name="stockStatus" id="stockStatus"/>
                              <input class="nui-hidden" name="enterGuestId" id="enterGuestId"/>
                              <input class="nui-hidden" name="isDisabled" id="isDisabled"/>
                              <input class="nui-hidden" name="guestOrgid" id="guestOrgid"/>
                               <input class="nui-hidden" name="orgid" id="orgid"/>
                              <input class="nui-hidden" name="auditSign"/>
                              <input name="partBrandId"id="partBrandId"  visible="false" class="nui-combobox" />
                              <table style="width: 100%;">
                                  <tr>
                                      <td class="title required">
                                          <label>调出门店：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
                                          <input id="guestId"
                                             name="guestId"
                                             dataField="suppliers"
                                             textField="fullName"
                                             loadingText="查询中"
                                             valueField="id"
                                             class="nui-autocomplete"
                                             emptyText="请选择调出机构..."
                                             allowInput="true"
                                             onvaluechanged="onGuestValueChanged"
                                             popupEmptyText="未找到调出机构"
                                             url=""  searchField="key"
                                             placeholder="请选择调出机构"
                                             selectOnFocus="true" />
                                           <a class="nui-button" iconCls="" plain="false" onclick="selectSupplier('guestId')" id="selectSupplierBtn"><span class="fa fa-check fa-lg"></span></a>
                                      </td>
                                      <td class="title required">
                                          <label>调出仓库：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
                                           <input name="outStoreId"
                                                 id="outStoreId"
                                                 class="nui-combobox"
                                                 textField="name"
                                                 valueField="id"
                                                 emptyText="请选择..."
                                                 url=""
                                                 allowInput="true"
                                                 showNullItem="false"
                                                 width="100%"
                                                 valueFromSelect="true"
                                                 onvaluechanged=""
                                                 nullItemText="请选择..."
                                                />
                                      </td>
                                      <td class="title required" style="width:120px">
                                          <label>申请到货日期：</label>
                                      </td>
                                      <td width="150" style="width:120px">
                                        <input name="planComeDate"
                                               id="planComeDate"
                                               width="100%"
                                               showTime="true"
                                               class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                      </td>
                                      <td class="title required" style="width:120px">
                                          <label>单据日期：</label>
                                      </td>
                                      <td width="150" style="width:120px">
                                        <input name="createDate"
                                               id="createDate"
                                               width="100%"
                                               showTime="true"
                                               class="nui-datepicker"  format="yyyy-MM-dd HH:mm"
                                               enabled="false"
                                           />
                                      </td>                         
                                  </tr>
                                  
                                  <tr>  
                                      <td class="title required">
                                          <label>调入门店：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
                                          <input id="guestId2"
                                             name="orgid"
                                             dataField="suppliers"
                                             textField="fullName"
                                             loadingText="查询中"
                                             valueField="id"
                                             class="nui-autocomplete"
                                             emptyText="请选择调出机构..."
                                             allowInput="true"
                                             onvaluechanged="onGuestValueChanged"
                                             popupEmptyText="未找到调出机构"
                                             url=""  searchField="key"
                                             placeholder="请选择调出机构"
                                             selectOnFocus="true" 
                                             enabled="false"
                                             />
                                      </td>
                                      <td class="title required">
                                          <label>调入仓库：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
                                           <input name="enterStoreId"
                                                 id="enterStoreId"
                                                 class="nui-combobox"
                                                 textField="name"
                                                 valueField="id"
                                                 emptyText="请选择..."
                                                 url=""
                                                 allowInput="true"
                                                 showNullItem="false"
                                                 width="100%"
                                                 valueFromSelect="true"
                                                 onvaluechanged=""
                                                 nullItemText="请选择..."
                                                />
                                                 <input name="storeId"
                                                 id="storeId"
                                                 class="nui-combobox"
                                                 textField="name"
                                                 valueField="id"
                                                 emptyText="请选择..."
                                                 url=""
                                                 allowInput="true"
                                                 showNullItem="false"
                                                 width="100%"
                                                 valueFromSelect="true"
                                                 onvaluechanged=""
                                                 nullItemText="请选择..."
                                                 visible="false"/>
                                      </td>
                                      <td class="title">
                                          <label>申请人：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
                                           <input class="nui-combobox" 
			                                      id="orderMan" 
			                                      name="orderMan" 
			                                      textField="empName"
			                                      valueField="empId"
			                                      emptyText="请选择..."
			                                      url=""
			                                      allowInput="true"
			                                      valueFromSelect="false"
			                                      width="100%">
                                      </td>  
                                      <td class="title">
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="remark" name="remark" enabled="true"/>
                                      </td>
                                  </tr>
                              </table>
                          </div>
                         
                      </div>
                  </fieldset>
                  <div class="nui-toolbar" style="padding:2px;border-left:0;">
                      <table style="width:100%;">
                          <tr>
                              <td style="white-space:nowrap;" style="width:120px;">
                                  <a class="nui-button" plain="true" iconCls="" onclick="addPart()" id="addPartBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a>
                                  <a class="nui-button" plain="true" iconCls="" onclick="deletePart()" id="deletePartBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                              </td>
                          </tr>
                      </table>
                  </div>
                  <div class="nui-fit">
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="pjAllotDetailList"
                           idField="id"
                           frozenStartColumn="0"
                           frozenEndColumn="3"
                           showSummaryRow="true"
                           ondrawcell="onRightGridDraw"
                           allowCellSelect="true"
                           allowCellEdit="true"
                           oncellcommitedit="onCellCommitEdit"
                           oncelleditenter=""
                           onselectionchanged=""
                           showModified="false"
                           editNextOnEnterKey="true"
                           allowCellWrap = "true"
                           url="">
                          <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div header="配件信息" headerAlign="center">
                                  <div property="columns">
                                    <div field="operateBtn" name="operateBtn" width="50" headerAlign="center" header="删除"></div>
                                      <div field="comPartCode" name="comPartCode" width="100" summaryType="count" headerAlign="center" header="配件编码">
                                          <input property="editor" class="nui-textbox" onenter="coverPart(e.value)" id="inputCode"/>
                                      </div>
                                      <div field="comPartName" visible="false" headerAlign="center" header="配件名称"></div>
                                      <div field="fullName"  width="200" headerAlign="center" header="配件全称"></div>
                                      <div field="comPartBrandId" visible="false"width="60" headerAlign="center" header="品牌"></div>
                                      <div field="enterId" visible="false"width="60" headerAlign="center" header="入库ID"></div>
                                  </div>
                              </div>
                             <!--  <div header="库存信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="storeStockQty" summaryType="sum"  width="60" headerAlign="center" header="库存">
                                      </div>
                                      <div field="upLimit" width="60" headerAlign="center" allowSort="false" header="库存上限">
                                      </div>
                                      <div field="downLimit" width="60" headerAlign="center" allowSort="false" header="库存下限">
                                      </div>
                                      <div field="upLimitWinter" width="80" headerAlign="center" allowSort="true" header="库存上限(冬季)">
                                      </div>
                                      <div field="downLimitWinter" width="80" headerAlign="center" allowSort="true" header="库存下限(冬季)">
                                      </div>
                                  </div>
                              </div>  -->
                              <div header="数量/价格信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="申请数量">
                                        <input property="editor" vtype="float" class="nui-textbox"/>
                                      </div>
                                      <div field="orderPrice" name="orderPrice" summaryType="sum" numberFormat="0.00" width="65" headerAlign="center" header="单价(出货方填写)">
                                        <input property="editor" vtype="float" id="orderPrice" class="nui-textbox" onvaluechanged="changeOrderPrice"/>
                                      </div>
                                      <div field="orderAmt" name="orderAmt" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="金额">
                                        <input property="editor" vtype="float" id="orderAmt" class="nui-textbox" onvaluechanged="changeOrderAmt"/>
                                      </div>
                                      <div field="remark" width="120" headerAlign="center" allowSort="true" header="备注">
                                        <input property="editor" class="nui-textbox"/>
                                      </div>
                                      <!-- <div field="remark" width="120" headerAlign="center" allowSort="true" header="备注" >
                                        <input property="editor" class="nui-textbox"/>
                                      </div> -->
                                  </div>
                              </div>
                              <div header="辅助信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="comApplyCarModel" width="80" headerAlign="center" header="品牌车型"></div>
                                      <div field="comUnit" name="comUnit" width="60" headerAlign="center" header="单位"></div>
                                      <div field="comOemCode" width="50" headerAlign="center" allowSort="true" header="OE码"></div>   
                                      <div field="comSpec" width="50" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                                                        
                                  </div>
                              </div>
                          </div>
                      </div>
                </div>
              </div>

</div>

<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:330px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
          <tr>
                <td class="title">创建日期:</td>
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
                    <span style="letter-spacing: 6px;">调出</span>方:
                </td>
                <td colspan="3">
                    <input id="advanceGuestId"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择调出方..."
                           onbuttonclick="selectSupplier('advanceGuestId')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">申请单号:</td>
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
     title="配件选择" style="width:430px;height:350px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
     <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="addBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="closeBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
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
               onrowdblclick="detailList"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="partCode" name="partCode" width="100" headerAlign="center" header="配件编码"></div>
                  <div field="comOemCode" name="comOemCode" width="100" headerAlign="center" header="OE码"></div>
                  <div field="comPartFullName" name="comPartFullName" width="200" headerAlign="center" header="配件全称"></div>
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

</body>
</html>
