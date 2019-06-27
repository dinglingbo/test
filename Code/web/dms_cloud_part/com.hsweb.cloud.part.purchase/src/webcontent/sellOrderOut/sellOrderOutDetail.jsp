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
                	<li iconCls="" onclick="quickSearch(10)" id="type10">所有</li>
                    <li iconCls="" onclick="quickSearch(6)" id="type6">草稿</li>
                    <li iconCls="" onclick="quickSearch(9)" id="type9">已出库</li>
                </ul>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择客户..." visible="false"
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <span class="separator"></span>
                
                <a class="nui-button" iconCls="" visible="false" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;出库</a>
                <a class="nui-button" plain="true" style="display:none;" onclick="packOut()" id="auditBtn"><span class="fa fa-truck fa-lg"></span>&nbsp;发货</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="addPchsEnter()" id="fastEnterBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入采购</a>
                <a class="nui-button" iconCls="" plain="true" onclick="addMorePart()" id="fastEnterBtn"><span class="fa fa-hand-o-right fa-lg"></span>&nbsp;快速录入配件</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                <span id="status"></span>
       		 	<span class="separator"></span>
           		<span id="dueAmt"></span>
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
          <div title="销售出库列表" class="nui-panel"
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
                     dataField="pjSellOrderMainList"
                     url="">
                    <div property="columns">
                      <div type="indexcolumn">序号</div>
                      	<div field="auditSign" width="55" headerAlign="center" header="状态"></div>
                        <div field="guestFullName" width="140" headerAlign="center" header="客户"></div>
                        <div field="orderDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="订单日期"></div>
                        <div field="orderMan" width="60" headerAlign="center" header="销售员"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="出库单号"></div>
                        <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                        <div field="auditor" width="60" headerAlign="center" header="出库人"></div>
                        <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="出库日期"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            

             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:100px;">
                      <legend><span>销售出库信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id" id="id"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-hidden" name="auditSign"/>
                              <input class="nui-hidden" name="orderAmt"/>
                              <input class="nui-hidden" name="createDate"/>
                              <input class="nui-textbox" visible="false" id="codeId" name="codeId" width="100%">
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
                                             width="78%"
                                             placeholder="请选择客户"
                                             selectOnFocus="true" />
                                      	 <input id="btnEdit1" width="7.2%" class="mini-buttonedit"  onbuttonclick="selectSupplier('guestId')"/>
                                       	 <a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn"><span class="fa fa-plus fa-lg"></span></a>
                                      </td>
                                      <td class="title required">
                                          <label>销售员：</label>
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
                                      </td><!-- 
                                      <td class="title wide">
                                          <label>预计到货日期：</label>
                                      </td>
                                      <td width="160">
                                          <input name="planSendDate"
                                                 id="planSendDate"
                                                 width="100%"
                                                 showTime="true"
                                                 class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                      </td> -->
                                      <td class="title">
                                          <label>往来单号：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="code" name="code" width="100%">
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
                                                 valuefromselect="true"
                                                 allowInput="true"
                                                 selectOnFocus="true"
                                                 showNullItem="false"
                                                 width="100%"
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
                                                 emptyText="请选择..."
                                                 url=""
                                                 valuefromselect="true"
                                                 allowInput="true"
                                                 selectOnFocus="true"
                                                 showNullItem="false"
                                                 width="100%"
                                                 nullItemText="请选择..."/>
                                      </td>
                                      <td class="title">
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="2">
                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="remark" name="remark"/>
                                      </td>
                                      <td colspan="1" class="required">
                                          <input id="isNeedPack" name="isNeedPack" class="nui-checkbox" text="需要打包发货" onvaluechanged="onValueChanged" trueValue="1" falseValue="0">
                                      </td>
                                      <td class="title">
                                          <label>出库单号：</label>
                                      </td>
                                      <td>
                                          <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新销售出库"/>
                                      </td>
                                  </tr>
                              </table>
                          </div>
                         
                      </div>
                  </fieldset>
                  <div class="nui-fit">
                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                           showPager="false"
                           dataField="pjSellOrderDetailList"
                           idField="id"
                           showSummaryRow="true"
                           frozenStartColumn="0"
                           frozenEndColumn="10"
                           ondrawcell="onRightGridDraw"
                           allowCellSelect="true"
                           allowCellEdit="true"
                           oncellcommitedit="onCellCommitEdit"
                           oncelleditenter="onCellEditEnter"
                           ondrawsummarycell=""
                           onselectionchanged=""
                           oncellbeginedit="OnrpMainGridCellBeginEdit"
                           showModified="false"
                           editNextOnEnterKey="true"
                           allowCellWrap = true
                           url="">
                          <div property="columns">
                              <div type="indexcolumn">序号</div>
                              <div header="配件信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="operateBtn" name="operateBtn" width="50" headerAlign="center" header="操作" align="center"></div>
                                      <div field="comPartCode" name="comPartCode" width="100" headerAlign="center" header="配件编码">
                                          <input property="editor" class="nui-textbox" />
                                      </div>
                                      <div field="comPartName" visible="false" headerAlign="center" header="配件名称"></div>
                                      <div field="fullName"  width="230" headerAlign="center" header="配件全称"></div>
                                      <div field="comPartBrandId" visible="false" width="60" headerAlign="center" header="品牌"></div>
                                      <div field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                                      <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
                                  </div>
                              </div>
                              <div header="数量金额信息" headerAlign="center">
                                  <div property="columns">
                                      <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
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
                                      仓库<input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" 
                                              url="" data="storehouse"
                                              onvaluechanged="onStoreValueChange" emptyText=""  vtype="required"
                                              /> 
                                      </div>  
                                       <div field="storeShelf" width="30" headerAlign="center" allowSort="true">
		                              		仓位<input property="editor" class="nui-textbox"/>
		                              </div> 
                                      <div field="stockOutQty" summaryType="sum" numberFormat="0.00" width="25" headerAlign="center" header="缺货数量">
                                      </div>
                                      <div type="checkboxcolumn" field="isMarkBatch" trueValue="1" falseValue="0" width="15" headerAlign="center" header="批次">
                                      </div>
                                      <div field="occupyQty" visible="false" width="60" headerAlign="center" allowSort="true" header="占用数量"></div>
                                      <div field="comOemCode" width="40" headerAlign="center" allowSort="true" header="OEM码"></div>   
                                      <div field="comSpec" width="30" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                                                        
                                  </div>
                              </div>
                          </div>
                      </div>
                </div>
              </div>



                

        </div>
    </div>
</div>



