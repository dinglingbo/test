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

                <a class="nui-menubutton " visible="false" menu="#popupMenuType" id="menunametype">未审</a>

                <ul id="popupMenuType" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(6)" id="type6">未审</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已审</li>
                    <!-- <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(9)" id="type9">全部</li> -->
                </ul>

                <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                	<li iconCls="" onclick="quickSearch(8)" id="type8">所有</li>
                    <li iconCls="" onclick="quickSearch(10)" id="type10">草稿</li>
                    <li iconCls="" onclick="quickSearch(14)" id="type14">已入库</li>
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
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <!-- <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editInbound()" id="editEnterMainBtn">修改</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <!-- <a class="nui-button" iconCls="icon-undo" plain="true" onclick="cancelEditInbound()" id="cancelEditEnterMainBtn">取消</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;入库</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                <span class="separator"></span>

                <a class="nui-menubutton " menu="#popupMenuPrint" id="menuprint"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入单据</a>

                <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="addPchsOrder('order')" id="addImp1"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入采购订单</li>
                    <li iconCls="" onclick="addPchsOrder('sell')" id="addImp2"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入销售单</li>
                </ul>

                <!-- <a class="nui-button" iconCls="" plain="true" onclick="addPchsOrder()" id="auditBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入单据</a> -->
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="addMorePart()" id="fastEnterBtn"><span class="fa fa-hand-o-right fa-lg"></span>&nbsp;快速录入配件</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
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
        <div title="采购入库列表" class="nui-panel"
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
                   dataField="pjPchsOrderMainList"
                   url="">
                  <div property="columns">
                    <div type="indexcolumn">序号</div>
                      <div field="auditSign" width="50" headerAlign="center" header="状态"></div>
                      <div field="guestFullName" width="120" headerAlign="center" header="供应商"></div>
                      <div field="orderDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="订单日期"></div>
                      <div field="orderMan" width="60" headerAlign="center" header="采购员"></div>
                      <div field="serviceId" headerAlign="center" width="150" header="入库单号"></div>
                      <!-- <div field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd H:ss:mm"></div> -->
                      <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                      <div field="creator" width="60" headerAlign="center" header="建单人"></div>
                      <div field="auditor" width="60" headerAlign="center" header="提交人"></div>
                      <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="入库日期"></div>
                  </div>
              </div>
          </div>
      </div>
      <div showCollapseButton="false">
          
          <div class="nui-fit">
              <fieldset id="fd1" style="width:99.5%;min-width:800px;height:100px;">
                  <legend><span>采购入库信息</span></legend>
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
                          <input class="nui-hidden" name="codeId" id="codeId"/>
                          <input class="nui-hidden" name="sourceType" id="sourceType"/>
                          <input class="nui-hidden" name="billStatusId" id="billStatusId"/>
                          <input class="nui-hidden" name="createDate"/>
                          <input class="nui-textbox" visible="false" width="100%" id="isInner" name="isInner"/>
                          <table style="width: 100%;">
                              <tr>
                                  <td class="title required">
                                      <label>供应商：</label>
                                  </td>
                                  <td colspan="3">
                                      <input id="guestId"
                                             name="guestId"
                                            
                                             dataField="suppliers"
                                             textField="fullName"
                                             loadingText="查询中"
                                             valueField="id"
                                             class="nui-autocomplete"
                                             emptyText="请选择供应商..."
                                             allowInput="true"
                                             onvaluechanged="onGuestValueChanged"
                                             popupEmptyText="未找到供应商"
                                             url=""  searchField="key"
                                             width="78%"
                                             placeholder="请选择供应商"
                                             selectOnFocus="true" />
                                        <a class="nui-button" iconCls="" plain="false" onclick="selectSupplier('guestId')" id="addBtn"><span class="fa fa-check fa-lg"></span></a>
<!--                                       	<input id="btnEdit1" width="8.2%" class="mini-buttonedit"  onbuttonclick="selectSupplier('guestId')"/> -->
                                       	<a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn"><span class="fa fa-plus fa-lg"></span></a>
                                  </td>
                                  <td class="title required">
                                      <label>采购员：</label>
                                  </td>
                                  <td colspan="1">
                                      <input class="nui-textbox" id="orderMan" name="orderMan" width="100%">
                                  </td>
                                  <td class="title required">
                                      <label>订单日期：</label>
                                  </td>
                                  <td width="120">
                                      <input name="orderDate"
                                             id="orderDate"
                                             width="100%"
                                             showTime="true"
                                             class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                  </td>
                                  <td class="title" width="120">
                                      <label>入库单号：</label>
                                  </td>
                                  <td>
                                      <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新采购入库"/>
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
                                      <label>往来单号：</label>
                                  </td>
                                  <td>
                                      <input class="nui-textbox" width="100%" id="code" name="code" enabled="false" placeholder="往来单号"/>
                                  </td>
                              </tr>
                          </table>
                      </div>
                     
                  </div>
                </fieldset>
                <div class="nui-fit"> 
                    <div id="rightGrid" class="nui-datagrid" 
                         style="width:100%;height:100%;"
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
                         ondrawsummarycell="onDrawSummaryCell"
                         showModified="false"
                         oncellbeginedit="OnrpMainGridCellBeginEdit"
                         showColumnsMenu="true"
                         onselectionchanged=""
                         sortMode="client"
                         editNextOnEnterKey="true"
                         allowCellWrap = true
                         url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div header="采购入库明细" headerAlign="center">
                                <div property="columns">
                                    <div field="operateBtn" name="operateBtn" align="center" width="50" headerAlign="center" header="操作"></div>
                                    <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码">
                                        <input property="editor" class="nui-textbox" />
                                    </div>
                                    <div field="comPartName" visible="false" headerAlign="center" header="配件名称">
                                        <!-- <input property="editor" class="nui-textbox" data="codeList" valueField="code" textField="code"/> -->
                                    </div>
                                    <div field="fullName" width="220"headerAlign="center" header="配件全称"></div>
                                    <div field="comPartBrandId" visible="false" width="60" headerAlign="center" header="品牌"></div>
                                    <div field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
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
                                    <div field="remark" width="40" headerAlign="center" allowSort="true">
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
                        <div field="storeShelf" width="30" headerAlign="center" allowSort="true">
                              仓位<input property="editor" class="nui-textbox"/>
                              </div>
                      <div field="comOemCode" allowSelect="false" width="30" headerAlign="center" visible="false" allowSort="true" header="OE码"></div> 
                      <div field="comSpec" allowSelect="false" width="30" headerAlign="center"  visible="false" allowSort="true" header="规格/方向/颜色"></div>
                      <div field="sourceMainId" allowSelect="false" width="100" headerAlign="center"  visible="false" allowSort="true" header="来源主表ID"></div>
                      <div field="sourceDetailId" allowSelect="false" width="100" headerAlign="center"  visible="false" allowSort="true" header="来源明细ID"></div>                             
                      <div field="sellUnitPrice" name="sellUnitPrice" allowSelect="false" width="20" headerAlign="center" visible="true" allowSort="true" header="统一售价">
                      	<input property="editor" class="nui-textbox"/>
                      </div>
                      <div field="price1" name="price1" allowSelect="false" width="20" headerAlign="center" visible="false" allowSort="" header="">
                      	<input property="editor" class="nui-textbox"/>
                      </div>
                      <div field="price2" name="price2" allowSelect="false" width="20" headerAlign="center" visible="false" allowSort="" header="">
                      	<input property="editor" class="nui-textbox"/>
                      </div>
                      <div field="price3" name="price3" allowSelect="false" width="20" headerAlign="center" visible="false" allowSort="" header="">
                      	<input property="editor" class="nui-textbox"/>
                      </div>
                      <div field="price4" name="price4" allowSelect="false" width="20" headerAlign="center" visible="false" allowSort="" header="">
                      	<input property="editor" class="nui-textbox"/>
                      </div>
                      <div field="price5" name="price5" allowSelect="false" width="20" headerAlign="center" visible="false" allowSort="" header="">
                      	<input property="editor" class="nui-textbox"/>
                      </div>
                      <div field="price6" name="price6" allowSelect="false" width="20" headerAlign="center" visible="false" allowSort="" header="">
                      	<input property="editor" class="nui-textbox"/>
                      </div>
                      <div field="price7" name="price7" allowSelect="false" width="20" headerAlign="center" visible="false" allowSort="" header="">
                      	<input property="editor" class="nui-textbox"/>
                      </div>   
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
          </div>
              
      </div>
  </div>


</div>


