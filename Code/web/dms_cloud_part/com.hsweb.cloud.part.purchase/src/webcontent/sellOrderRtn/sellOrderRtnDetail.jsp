<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

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
                	<li iconCls="" onclick="quickSearch(15)" id="type15">所有</li>
                    <li iconCls="" onclick="quickSearch(6)" id="type6">草稿</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已提交</li>
                     <li iconCls="" onclick="quickSearch(8)" id="type8">部分入库</li>
                    <li iconCls="" onclick="quickSearch(14)" id="type14">已入库</li>
                    <!-- <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(9)" id="type9">全部</li> -->
                </ul>

                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择客户..." visible="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <a class="nui-button" visible="false" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" visible="false"  id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;提交</a>
                <a class="nui-button" iconCls="" plain="true" onclick="auditToEnter()" visible="false"  id="auditToEnterBtn"><span class="fa fa-check fa-lg"></span>&nbsp;入库</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                <span id="status"></span>
                <!-- <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="unAudit()" id="uAuditBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返单</a> -->
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
        <div title="销售退货列表" class="nui-panel"
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
                      <div field="auditSign" width="55" headerAlign="center"visible="false" header="状态"></div>
                      <div field="billStatusId" width="55" headerAlign="center"  header="状态"></div>
                      <div field="guestFullName" width="140" headerAlign="center" header="客户"></div>
                      <div field="orderDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="退货日期"></div>
                      <div field="orderMan" width="60" headerAlign="center" header="退货员"></div>
                      <div field="serviceId" headerAlign="center" width="150" header="退货单号"></div>
                      <!-- <div field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd H:ss:mm"></div> -->
                      <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                      <div field="creator" width="60" headerAlign="center" header="建单人"></div>
                      <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                      <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                  </div>
              </div>
          </div>
      </div>
      <div showCollapseButton="false">
          
          <div class="nui-fit">
              <fieldset id="fd1" style="width:99.5%;height:100px;">
                  <legend><span>销售退货信息</span></legend>
                  <div class="fieldset-body">
                  
                      <div id="basicInfoForm" class="form" contenteditable="false">
                          <input class="nui-hidden" name="id"/>
                          <input class="nui-hidden" name="operateDate"/>
                          <input class="nui-hidden" name="versionNo"/>
                          <input class="nui-hidden" name="storeId" id="storeId"/>
                          <input class="nui-textbox" visible="false" id="codeId" name="codeId" width="100%">
                          <input class="nui-hidden" name="taxRate" id="taxRate"/>
                          <input class="nui-hidden" name="taxSign" id="taxSign"/>
                          <input class="nui-hidden" name="orderAmt" id="orderAmt"/>
                          <input class="nui-hidden" name="auditSign" id="auditSign"/>
                          <input class="nui-hidden" name="billStatusId" id="billStatusId"/>
                          <input class="nui-hidden" name="createDate"/>
                          <input class="nui-textbox" visible="false" width="100%" id="isInner" name="isInner"/>
                          <table style="width: 100%;">
                              <tr>
                                  <td class="title required">
                                      <label>客户：</label>
                                  </td>
                                  <td colspan="3">
                                      <input id="guestId"
                                             name="guestId"
                                            
                                             dataField="suppliers"
                                             textField="fullName"
                                             loadingText="查询中"
                                             valueField="id"
                                             class="nui-autocomplete"
                                             emptyText="请选择客户..."
                                             allowInput="true"
                                             onvaluechanged="onGuestValueChanged"
                                             popupEmptyText="未找到客户"
                                             url=""  searchField="key"
                                             width="87%"
                                             placeholder="请选择客户"
                                             selectOnFocus="true" />
                                         <a class="nui-button" iconCls="" plain="false" onclick="selectSupplier('guestId')" id="addBtn"><span class="fa fa-check fa-lg"></span></a>
<!--                                       	<input id="btnEdit1" width="7.2%" class="mini-buttonedit"  onbuttonclick="selectSupplier('guestId')"/> -->
                                  </td>
                                  <td class="title required">
                                      <label>退货员：</label>
                                  </td>
                                  <td colspan="1">
                                      <input class="nui-textbox" id="orderMan" name="orderMan" width="100%">
                                  </td>
                                  <td class="title required">
                                      <label>退货日期：</label>
                                  </td>
                                  <td width="120">
                                      <input name="orderDate"
                                             id="orderDate"
                                             width="100%"
                                             showTime="true"
                                             class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                  </td>
                                  <td class="title">
                                      <label>往来单号：</label>
                                  </td>
                                  <td colspan="1">
                                      <input class="nui-textbox" id="code" name="code" width="100%">
                                  </td>
                              </tr>
                              <tr>
                                  <td class="title required">
                                      <label>退货原因：</label>
                                  </td>
                                  <td>
                                      <input name="rtnReasonId"
                                             id="rtnReasonId"
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
                                             nullItemText="请选择..."/>
                                  </td>
                                  <td class="title required" style="display:none;">
                                      <label>票据类型：</label>
                                  </td>
                                  <td style="display:none;">
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
                                             nullItemText="请选择..."/>
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
                                             nullItemText="请选择..."/>
                                  </td>
                                  <td class="title">
                                      <label>备注：</label>
                                  </td>
                                  <td colspan="3">
                                      <input class="nui-textbox" width="100%" id="remark" name="remark"/>
                                  </td>
                                  <td class="title" width="120">
                                      <label>退货单号：</label>
                                  </td>
                                  <td>
                                      <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false"/>
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
                                <a class="nui-button" plain="true" iconCls="" onclick="addPart()" id="addPartBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;选择销售出库单</a>
                                <a class="nui-button" plain="true" iconCls="" onclick="deletePart()" id="deletePartBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="nui-fit">
                    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                         selectOnLoad="true"
                         showPager="false"
                         dataField="pjPchsOrderDetailList"
                         idField="id"
                         showSummaryRow="true"
                         frozenStartColumn=""
                         frozenEndColumn=""
                         ondrawcell="onRightGridDraw"
                         allowCellSelect="true"
                         allowCellEdit="true"
                         oncellcommitedit="onCellCommitEdit"
                         oncelleditenter="onCellEditEnter"
                         ondrawsummarycell=""
                         showModified="false"
                         oncellbeginedit="OnrpMainGridCellBeginEdit"
                         showColumnsMenu="true"
                         onselectionchanged=""
                         editNextOnEnterKey="true"
                         allowCellWrap = true
                         url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div header="销退订单明细" headerAlign="center">
                                <div property="columns">
                                    <div field="operateBtn" name="operateBtn" width="50" headerAlign="center" header="操作"></div>
                                    <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码">
                                        <input property="editor" class="nui-textbox" />
                                    </div>
                                    <div field="comPartName" visible="false" headerAlign="center" header="配件名称">
                                    </div>
                                     <div field="fullName"width="270" headerAlign="center" header="配件全称"></div>
                                    <div field="comPartBrandId" visible="false" width="60" headerAlign="center" header="品牌"></div>
                                    <div field="comApplyCarModel" width="80" headerAlign="center" header="品牌车型"></div>
                                    <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
                                </div>
                            </div>
                            <div header="数量金额信息" headerAlign="center">
                                <div property="columns">
                                    <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                    <div field="orderPrice" numberFormat="0.0000" width="90" headerAlign="center" header="单价">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                    <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="95" headerAlign="center" header="金额">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                    <div field="remark" width="30" headerAlign="center" allowSort="true">
                        备注<input property="editor" class="nui-textbox"/>
                        </div>
                                </div>
                            </div>
                            <div header="辅助信息" headerAlign="center">
                                <div property="columns">
                                    <div type="comboboxcolumn" field="storeId" width="30" headerAlign="center" allowSort="true">
                        仓库<input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" data="storehouse"
                                      url=""
                                      onvaluechanged="onStoreValueChange" emptyText=""  vtype="required"
                                      /> 
                        </div>
                           <div field="storeShelf" width="20" headerAlign="center" allowSort="true" header="仓位">
                             	 仓位<input id="storeShelf" name='storeShelf' property="editor" class="nui-textbox"/>
                          </div>  
                      <div field="comOemCode" allowSelect="false" width="30" headerAlign="center" allowSort="true" header="OE码"></div> 
                      <div field="comSpec" allowSelect="false" width="30" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                             
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
          </div>
              
      </div>
  </div>


</div>



