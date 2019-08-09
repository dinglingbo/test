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
<title>调拨入库</title>
<script src="<%=webPath + contextPath%>/purchase/js/allotApply/allotApplyEnter.js?v=1.0.3"></script>
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

                <a class="nui-menubutton " menu="#popupMenuType" id="menunametype">所有</a>

                <ul id="popupMenuType" class="nui-menu" style="display:none;">
                  <li iconCls="" onclick="quickSearch(9)" id="type10">所有</li>
                  <span class="separator"></span>
                    <li iconCls="" onclick="quickSearch(6)" id="type6">草稿</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已入库</li>
                    <li iconCls="" onclick="quickSearch(8)" id="type8">已作废</li>
                </ul>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择调出机构..." visible="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                
                <a class="nui-button" iconCls="" visible="false" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
                <input name="billTypeId" id="billTypeId" class="nui-combobox width1" textField="name"
                       valueField="customid" visible="false" />
                <input name="settleTypeId" id="settleTypeId" class="nui-combobox width1" textField="name" valueField="customid" visible="false" />
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save('0')" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="submit()" visible="true"  id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;入库</a>
                <a class="nui-button" iconCls="" plain="true" onclick="del()" visible="true" id="delBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>
                <a class="nui-button" iconCls="" plain="true" onclick="del()" visible="false" id="undelBtn"><span class="fa fa-reply fa-lg"></span>&nbsp;反作废</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                <span id="status"></span>
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
          <div title="调拨申请列表" class="nui-panel"
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
                     dataField="pjAllotApplyMainList"
                     url="">
                    <div property="columns">
                      <div type="indexcolumn">序号</div>
                        <div field="status" width="60" headerAlign="center" header="状态"></div>
                        <div field="auditSign" width="65" visible="false" headerAlign="center" header="状态"></div>
                        <div field="guestFullName" width="120" headerAlign="center" header="调出方"></div>
                        <div field="orderDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
                        <div field="creator" width="60" headerAlign="center" header="申请人"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="入库单号"></div>
                        <div field="auditor" width="60" headerAlign="center" header="提交人"></div>
                        <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="提交日期"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            

             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:100px;">
                      <legend><span>调拨入库信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-hidden" name="versionNo"/>
                              <input class="nui-hidden" name="status" id="status"/>
                              <input class="nui-hidden" name="isDisabled" id="isDisabled"/>
                              <input class="nui-hidden" name="guestOrgid" id="guestOrgid"/>
                              <input class="nui-hidden" name="auditSign"/>
                              <input name="partBrandId"id="partBrandId"  visible="false"class="nui-combobox" />
                              <table style="width: 100%;">
                                  <tr>
                                      <td class="title required">
                                          <label>调出方：</label>
                                      </td>
                                      <td colspan="3">
                                          <input id="guestId" name="guestId" class="nui-buttonedit"
                                              emptyText="请选择调拨申请单..." visible="true" width="100%"
                                              onbuttonclick="selectApply()"  selectOnFocus="true" allowInput="false" />
                                      </td>
                                      <td class="title required">
                                          <label>调入仓库：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
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
                                                />
                                      </td>
                                      <td class="title required" style="width:120px">
                                          <label>调拨申请日期：</label>
                                      </td>
                                      <td width="150" style="width:120px">
                                        <input name="orderDate"
                                               id="orderDate"
                                               width="100%"
                                               showTime="true"
                                               class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                      </td>                         
                                  </tr>
                                  <tr>  
                                      <td class="title">
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="remark" name="remark" enabled="true"/>
                                      </td>
                                      <td class="title">
                                          <label>申请人：</label>
                                      </td>
                                      <td colspan="1" style="width:120px">
                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="orderMan" name="orderMan" enabled="true"/>
                                      </td>  
                                      <td class="title">
                                          <label>申请单号：</label>
                                      </td>
                                      <td style="width:180px">
                                          <input class="nui-textbox" width="100%" id="code" name="code" enabled="false" />
                                      </td>
                                      <td class="title">
                                          <label>入库单号：</label>
                                      </td>
                                      <td style="width:180px">
                                          <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新计划采购单"/>
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
                                  <a class="nui-button" plain="true" iconCls="" onclick="deletePart()" id="deletePartBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                              </td>
                          </tr>
                      </table>
                  </div>
                  <div class="nui-fit">
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="pjAllotApplyDetailList"
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
                           oncellbeginedit="OnrpMainGridCellBeginEdit"
                           showModified="false"
                           editNextOnEnterKey="true"
                           allowCellWrap = "true"
                           url="">
                          <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div header="配件信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="comPartCode" name="comPartCode" width="100" summaryType="count" headerAlign="center" header="配件编码">
                                      </div>
                                      <div field="comPartName" visible="false" headerAlign="center" header="配件名称"></div>
                                      <div field="fullName"  width="200" headerAlign="center" header="配件全称"></div>
                                      <div field="comPartBrandId" visible="false"width="60" headerAlign="center" header="品牌"></div>
                                  </div>
                              </div>
                              <div header="库存信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="storeStockQty" summaryType="sum"  width="60" headerAlign="center" header="库存">
                                      </div>
                                      <div field="upLimit" width="60" headerAlign="center" allowSort="true" header="库存上限">
                                      </div>
                                      <div field="downLimit" width="60" headerAlign="center" allowSort="true" header="库存下限">
                                      </div>
                                      <div field="upLimitWinter" width="80" headerAlign="center" allowSort="true" header="库存上限(冬季)">
                                      </div>
                                      <div field="downLimitWinter" width="80" headerAlign="center" allowSort="true" header="库存下限(冬季)">
                                      </div>
                                  </div>
                              </div>
                              <div header="数量信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="applyQty" name="applyQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="申请数量">
                                        <input property="editor" vtype="float" class="nui-textbox"/>
                                      </div>
                                      <div field="remark" width="120" headerAlign="center" allowSort="true" header="备注">
                                        <input property="editor" class="nui-textbox"/>
                                      </div>
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
                <td class="title">申请单号:</td>
                <td colspan="3">
                    <input id="applyCode"
                           name="applyCode"
                           class="nui-textbox" 
                           width="100%"/>
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
               onrowdblclick="addSelectPart"
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div field="code" name="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                  <div field="oemCode" name="comPartCode" width="100" headerAlign="center" header="OE码"></div>
                  <div field="fullName" name="comPartCode" width="200" headerAlign="center" header="配件全称"></div>
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
