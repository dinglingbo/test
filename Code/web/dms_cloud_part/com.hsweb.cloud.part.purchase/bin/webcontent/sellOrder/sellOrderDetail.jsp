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
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已提交</li>
                    <li iconCls="" onclick="quickSearch(11)" id="type11">已作废</li>
                    <li iconCls="" onclick="quickSearch(8)" id="type8">部分出库</li>
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
                <a class="nui-button" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button"  plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;提交</a>
                <a class="nui-button" visible="false" plain="true" onclick="auditToOut()" id="auditToOutBtn"><span class="fa fa-check fa-lg"></span>&nbsp;出库</a>
                <a class="nui-button"  plain="true" onclick="del()" id="delBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;作废</a>
                <a class="nui-button" visible="false" plain="true" onclick="packOut()" id="packOutBtn"><span class="fa fa-truck fa-lg"></span>&nbsp;发货</a>
                <a class="nui-button" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                <span class="separator"></span>
                <a class="nui-button" plain="true" onclick="unAudit()" id="unAuditBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返单</a>
                <a class="nui-button" plain="true" onclick="addMorePart()" id="fastEnterBtn"><span class="fa fa-hand-o-right fa-lg"></span>&nbsp;快速录入配件</a>
                <a class="nui-button" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
                <a class="nui-button" plain="true" onclick="chooseMember()" visible="false" id="chooseMemBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选择提成成员</a>
                <input class="nui-checkbox"  id="isBilling" trueValue="1" falseValue="0" text="是否开单" value="" oncheckedchanged="billingChange()"/>
                <input class="nui-checkbox"  id="isEditPart" trueValue="1" falseValue="0" text="是否修改配件" value="" oncheckedchanged="partChange()"/>
                <span id="status"></span>
                <span class="separator"></span>
           		<a onclick="showDueDetail()"  style="cursor:pointer"><span id="dueAmt">客户欠款：</span></a>
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
          <div title="销售订单列表" class="nui-panel"
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
                     sortMode="client"
                     url="">
                    <div property="columns">
                      <div type="indexcolumn">序号</div>
                        <div field="auditSign" width="55" visible="false" headerAlign="center" header="状态" allowSort="true" dataType="string"></div>
                        <div field="billStatusId" width="55" headerAlign="center" header="状态" allowSort="true" dataType="string"></div>
                        <div field="guestFullName" width="140" headerAlign="center" header="客户" allowSort="true" dataType="string"></div>
                        <div field="orderDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="订单日期" allowSort="true" dataType="date"></div>
                        <div field="orderMan" width="60" headerAlign="center" header="销售员" allowSort="true" dataType="string"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="订单号" allowSort="true" dataType="string"></div>
                        <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人" allowSort="true" dataType="string"></div>
                        <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期" allowSort="true" dataType="date"></div>
                        <div field="remark" width="120" headerAlign="center" header="备注" allowSort="true" dataType="string"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            

             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:130px;">
                      <legend><span>销售订单信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id" id="id"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-hidden" name="createDate"/>
                              <input class="nui-hidden" name="auditSign"/>
                              <input class="nui-hidden" name="orderAmt"/>
                              <input class="nui-hidden" name="billStatusId"/>
                              <input class="nui-combobox" visible="false" name="orgCarBrandId" id="orgCarBrandId"/>
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
                                             width="77%"
                                             placeholder="请选择客户"
                                             selectOnFocus="true" />
                                        <a class="nui-button" iconCls="" plain="false" onclick="selectSupplier('guestId')" id="selectSupplierBtn"><span class="fa fa-check fa-lg"></span></a>
<!--                                       	<input id="btnEdit1" width="7.2%" class="mini-buttonedit"  onbuttonclick="selectSupplier('guestId')"/> -->
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
                                                 onvaluechanged="onSettleTypeIdValueChanged"
                                                 width="100%"
                                                 nullItemText="请选择..."/>
                                      </td>
                                      <td class="title required">
	                                      <label>仓库：</label>
	                                  </td>
	                                  <td colspan="1">
	                                      <input width="100%" id="storeId" name="storeId"                                   
	                                       enabled="true"  dataField="storehouse" class="nui-combobox" valueField="id" textField="name"
	                                       data="storehouse" onvaluechanged="onStoreIdValueChange"/>
	                                  </td>
	                                   <td class="title">
	                                      <label></label>
	                                  </td>
                                      <td colspan="1" class="required">
                                          <input id="isNeedPack"  name="isNeedPack" class="nui-checkbox" text="需要打包发货" onvaluechanged="onValueChanged" trueValue="1" falseValue="0">
                                      </td>
                                      <td class="title">
                                          <label>订单号：</label>
                                      </td>
                                      <td>
                                          <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新销售订单"/>
                                      </td>
                                  </tr>
                                  <tr>
                                  	  <td class="title required">
                                          <label>销售类型：</label>
                                      </td>
                                      <td>
                                          <input name="businessTypeId"
                                                 id="businessTypeId"
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
                                                 nullItemText="请选择..."
                                                 onvaluechanged="onBusinessTypeIdValueChanged"/>
                                      </td>
                                  	  <td id="settleGuestTitle" class="title required" style="display:none">
                                          <label>结算单位：</label>
                                      </td>
                                      <td id="settleGuest" style="display:none">
                                      	  <input class="nui-textbox" id="settleGuestId" name="settleGuestId" visible="false" />
                                          <input id="settleGuestName" class="nui-buttonedit" name="settleGuestName"
						                       emptyText="请选择客户..." visible="true" width="100%" allowInput="false" enabled="false"
						                       onbuttonclick="selectSupplier('settleGuestName')" selectOnFocus="true" />
                                      </td>
                           			  <td class="title">
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="10">
                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="remark" name="remark"/>
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
                           frozenEndColumn="11"
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
                           sortMode="client"
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
                                      <div field="fullName"width="150"  headerAlign="center" header="配件全称"></div>
                                      <div field="orgCarBrandId" width="60" headerAlign="center" header="厂牌"></div>
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
                                     
                                      <div field="remark" width="50" headerAlign="center" allowSort="true">
                                     	 备注<input property="editor" class="nui-textbox"/>
                                      </div>
                                  </div>
                              </div>
                              
                              <div header="开单信息" headerAlign="center" visible="false">
                                  <div property="columns">
                                   
                                       <div field="showPrice" name="showPrice" numberFormat="0.0000" width="90" headerAlign="center" header="开单单价">
                                          <input property="editor" vtype="float" class="nui-textbox"/>
                                      </div>
                                      <div field="showAmt"name="showAmt" summaryType="sum" numberFormat="0.0000" width="95" headerAlign="center" header="开单金额">
                                          <input property="editor" vtype="float" class="nui-textbox"/>
                                      </div>
                                     
                                  </div>
                              </div>
                              
                              <div header="辅助信息" headerAlign="center">
                                  <div property="columns">
                                      <div visible="false" type="comboboxcolumn" field="storeId" width="90" headerAlign="center" allowSort="true">
                                      	仓库<input  property="editor" enabled="false" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" 
                                              url="" data="storehouse"
                                              onvaluechanged="onStoreValueChange" emptyText=""  vtype="required"
                                              /> 
                                      </div>  
                                       <div field="storeShelf" width="80" headerAlign="center" allowSort="true" header="仓位">
		                             	 仓位<input  property="editor" id="storeShelf" name='storeShelf'  class="nui-textbox"/>
		                          		</div>  
                                      <div field="stockOutQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="缺货数量">
                                      </div>
                                      <div type="checkboxcolumn" field="isMarkBatch" trueValue="1" falseValue="0" width="35" headerAlign="center" header="批次">
                                      </div>
                                      <div field="occupyQty" visible="false" width="70" headerAlign="center" allowSort="true" header="占用数量"></div>
                                      <div field="comOemCode" width="70" headerAlign="center" allowSort="true" header="OE码"></div>   
                                      <div field="comSpec" width="70" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>                                                        
                                  </div>
                              </div>
                              
                              <div header="修改的配件信息" headerAlign="center" visible="false">
                                  <div property="columns">
                                  	  <div field="showPartId" name="showPartId" width="100" visible="false" headerAlign="center" header="配件编码"></div>
                                      <div field="showPartCode" name="showPartCode" width="100" headerAlign="center" header="配件编码">
                                          <input property="editor" class="nui-textbox" />
                                      </div>
                                       <div field="showFullName"width="220"  headerAlign="center" header="配件全称"></div>
                                      <div field="showBrandName" visible="false" width="60" headerAlign="center" header="品牌"></div>
                                      <div field="showCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                            		  <div field="showOemCode" width="60" headerAlign="center" header="oem码" visible="false"></div>
                            		  <div field="showSpec" width="60" headerAlign="center" header="规格" visible="false"></div>
                                  </div>
                              </div>
                              
                          </div>
                      </div>
                </div>
              </div>



                

        </div>
    </div>
</div>



