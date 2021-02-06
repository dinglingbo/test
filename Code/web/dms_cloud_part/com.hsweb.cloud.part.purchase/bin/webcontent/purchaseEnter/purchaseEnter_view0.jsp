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
<title>采购入库</title>
<script src="<%=webPath + contextPath%>/purchase/js/purchaseEnter/purchaseEnter.js?v=2.7.7"></script>
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

                <a class="nui-menubutton " visible="false" menu="#popupMenuType" id="menunametype">未审</a>

                <ul id="popupMenuType" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(6)" id="type6">未审</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已审</li>
                    <!-- <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(9)" id="type9">全部</li> -->
                </ul>

                <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">待收货</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(12)" id="type12">待收货</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">部分入库</li>
                    <li iconCls="" onclick="quickSearch(14)" id="type14">全部入库</li>
                    <li iconCls="" onclick="quickSearch(15)" id="type15">已退回</li>
                    <li iconCls="" onclick="quickSearch(16)" id="type16">已关闭</li>
                    <!-- <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(17)" id="type17">全部</li> -->
                </ul>

                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..." visible="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <a class="nui-button" visible="false" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <!-- <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editInbound()" id="editEnterMainBtn">修改</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <!-- <a class="nui-button" iconCls="icon-undo" plain="true" onclick="cancelEditInbound()" id="cancelEditEnterMainBtn">取消</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="auditToEnter()" id="auditToEnterBtn"><span class="fa fa-check fa-lg"></span>&nbsp;入库</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="unAudit()" id="uAuditBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返单</a>
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
        <div title="采购订单列表" class="nui-panel"
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
                   onbeforedeselect=""
                   dataField="pjPchsOrderMainList"
                   url="">
                  <div property="columns">
                    <div type="indexcolumn">序号</div>
                      <div field="auditSign" visible="false" width="35" headerAlign="center" header="状态"></div>
                      <div field="guestFullName" width="80" headerAlign="center" header="供应商"></div>
                      <div field="createDate" width="80" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="订单日期"></div>
                      <div field="billStatusId" width="60" headerAlign="center" header="状态"></div>
                      <div field="orderMan" width="60" headerAlign="center" header="采购员"></div>
                      <div field="serviceId" headerAlign="center" width="150" header="订单号"></div>
                      <!-- <div field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd H:ss:mm"></div> -->
                      <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                      <div field="creator" width="60" headerAlign="center" header="建单人"></div>
                      <div field="auditor" width="60" headerAlign="center" header="提交人"></div>
                      <div field="auditDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="提交日期"></div>
                  </div>
              </div>
          </div>
      </div>
      <div showCollapseButton="false">
          
          <div class="nui-fit">
              <fieldset id="fd1" style="width:95%;height:70px;">
                  <legend><span>采购订单信息</span></legend>
                  <div class="fieldset-body">
                  
                      <div id="basicInfoForm" class="form" contenteditable="false">
                          <input class="nui-hidden" name="id"/>
                          <input class="nui-hidden" name="operateDate"/>
                          <input class="nui-hidden" name="versionNo"/>
                          <input class="nui-hidden" name="storeId" id="storeId"/>
                          <input class="nui-hidden" name="taxRate" id="taxRate"/>
                          <input class="nui-hidden" name="taxSign" id="taxSign"/>
                          <input class="nui-hidden" name="orderAmt" id="orderAmt"/>
                          <input class="nui-hidden" name="auditSign" id="auditSign"/>
                          <input class="nui-hidden" name="billStatusId" id="billStatusId"/>
                          <input class="nui-textbox" visible="false" width="100%" id="isInner" name="isInner"/>
                          <table style="width: 100%;">
                              <tr>
                                  <td class="title required">
                                      <label>供应商：</label>
                                  </td>
                                  <td colspan="3">
                                      <input id="guestId"
                                             name="guestId"
                                             class="nui-buttonedit"
                                             emptyText="请选择供应商..."
                                             onbuttonclick="selectSupplier('guestId')"
                                             onvaluechanged="onGuestValueChanged"
                                             width="100%"
                                             placeholder="请选择供应商"
                                             selectOnFocus="true" />
                                  </td>
                                  <td class="title required">
                                      <label>采购员：</label>
                                  </td>
                                  <td colspan="1">
                                      <input class="nui-textbox" id="orderMan" name="orderMan" width="100%">
                                  </td>
                                  <td class="title required">
                                      <label>订货日期：</label>
                                  </td>
                                  <td width="120">
                                      <input name="createDate"
                                             id="createDate"
                                             width="100%"
                                             showTime="true"
                                             class="nui-datepicker" enabled="false" format="yyyy-MM-dd HH:mm"/>
                                  </td>
                                  <td class="title wide">
                                      <label>预计到货日期：</label>
                                  </td>
                                  <td width="160">
                                      <input name="planArriveDate"
                                             id="planArriveDate"
                                             width="100%"
                                             showTime="true"
                                             class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                  </td>
                              </tr>
                              <tr>
                                  <td class="title required">
                                      <label>票据类型：</label>
                                  </td>
                                  <td>
                                      <input name="billTypeId"
                                             id="billTypeId"
                                             class="nui-combobox width1"
                                             textField="name"
                                             valueField="customid"
                                             emptyText="请选择..."
                                             url=""
                                             allowInput="true"
                                             showNullItem="false"
                                             width="100%"
                                             valueFromSelect="true"
                                             onvaluechanged=""
                                             nullItemText="请选择..."
                                             onvalidation="onComboValidation"/>
                                  </td>
                                  <td class="title required">
                                      <label>结算方式：</label>
                                  </td>
                                  <td>
                                      <input name="settleTypeId"
                                             id="settleTypeId"
                                             class="nui-combobox width1"
                                             textField="name"
                                             valueField="customid"
                                             valueFromSelect="true"
                                             emptyText="请选择..."
                                             url=""
                                             allowInput="true"
                                             showNullItem="false"
                                             width="100%"
                                             nullItemText="请选择..."
                                             onvalidation="onComboValidation"/>
                                  </td>
                                  <td class="title">
                                      <label>备注：</label>
                                  </td>
                                  <td colspan="3">
                                      <input class="nui-textbox" width="100%" id="remark" name="remark"/>
                                  </td>
                                  <td class="title" width="120">
                                      <label>订单号：</label>
                                  </td>
                                  <td>
                                      <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新采购订单"/>
                                  </td>
                              </tr>
                          </table>
                      </div>
                     
                  </div>
                </fieldset>
                <div class="nui-fit">
                    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                         selectOnLoad="true"
                         showPager="false"
                         dataField="pjPchsOrderDetailList"
                         idField="id"
                         showSummaryRow="true"
                         frozenStartColumn="0"
                         frozenEndColumn="10"
                         ondrawcell="onRightGridDraw"
                         allowCellSelect="true"
                         allowCellEdit="true"
                         oncellcommitedit=""
                         oncelleditenter=""
                         ondrawsummarycell=""
                         showModified="false"
                         oncellbeginedit="OnrpMainGridCellBeginEdit"
                         showColumnsMenu="true"
                         onselectionchanged=""
                         editNextOnEnterKey="true"
                         sortMode="client"
                         url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div header="采购订单明细" headerAlign="center">
                                <div property="columns">
                                    <div field="operateBtn" name="operateBtn" width="50" headerAlign="center" header="操作"></div>
                                    <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                                    <div field="comPartName" headerAlign="center" header="配件名称">
                                        <!-- <input property="editor" class="nui-textbox" data="codeList" valueField="code" textField="code"/> -->
                                    </div>
                                    <div field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                                    <div field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                                    <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
                                </div>
                            </div>
                            <div header="数量金额信息" headerAlign="center">
                                <div property="columns">
                                    <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                    <div field="orderPrice" numberFormat="0.0000" width="60" headerAlign="center" header="单价"></div>
                                    <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额"></div>
                                    <div field="remark" width="100" headerAlign="center" allowSort="true">
                        备注<input property="editor" class="nui-textbox"/>
                        </div>
                                </div>
                            </div>
                            <div header="辅助信息" headerAlign="center">
                                <div property="columns">
                                    <div type="comboboxcolumn" field="storeId" width="60" headerAlign="center" allowSort="true">
                        仓库<input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" data="storehouse"
                                      url=""
                                      onvaluechanged="" emptyText=""  vtype="required"
                                      /> 
                        </div>
                        <div field="storeShelf" width="60" headerAlign="center" allowSort="true">
                              仓位
                              </div>  
                      <div field="comOemCode" allowSelect="false" width="60" headerAlign="center" allowSort="true" header="OE码"></div> 
                      <div field="comSpec" allowSelect="false" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                             
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
          </div>
              
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
            <tr>
                <td class="title">配件ID:</td>
                <td colspan="3">
                    <input id="partId"
                           name="partId"
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



</body>
</html>
