<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
    

<style type="text/css">

</style>
<div class="nui-toolbar" style="padding:2px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
<!--                 <span class="separator"></span> -->
        <span  id="bServiceId" style="">订单号：新采购订单</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <!-- <a class="nui-button" iconCls="icon-edit" plain="true" onclick="editInbound()" id="editEnterMainBtn">修改</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <!-- <a class="nui-button" iconCls="icon-undo" plain="true" onclick="cancelEditInbound()" id="cancelEditEnterMainBtn">取消</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;提交</a>
                <a class="nui-button" iconCls="" plain="true" onclick="auditToEnter()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;入库</a>
                
                <!-- <a class="nui-menubutton " menu="#popupMenuPrint" id="menuprint"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>

                <ul id="popupMenuPrint" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="onPrint(0)" id="type10"><span class="fa fa-print fa-lg"></span>&nbsp;打印订单</li>
                    <li iconCls="" onclick="onPrint(1)" id="type11"><span class="fa fa-print fa-lg"></span>&nbsp;打印进货单</li>
                </ul> -->

                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
                <a class="nui-button" iconCls="" plain="true" onclick="unAudit()" id="uAuditBtn"><span class="fa fa-mail-reply fa-lg"></span>&nbsp;返单</a>
                <span class="separator"></span>
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="addMorePart()" id="fastEnterBtn"><span class="fa fa-hand-o-right fa-lg"></span>&nbsp;快速录入配件</a> -->
                <a class="nui-button" plain="true" iconCls="" onclick="importPart()" id="importPartBtn"><span class="fa fa-level-down fa-lg"></span>&nbsp;导入</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>       
            </td>
        </tr>
    </table>
</div>

              <fieldset id="fd1" style="width:99.5%;">
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
                          <input class="nui-hidden" name="guestFullName" id="guestFullName"/>
                          <input class="nui-hidden" name="serviceId" id="serviceId"/>
                          <input class="nui-hidden" name="srmGuestId" id="srmGuestId"/>
                          <input class="nui-hidden" name="orderCode" id="orderCode"/>
                          <input class="nui-textbox" visible="false" width="100%" id="isInner" name="isInner"/>
                          <table style="width: 100%;">
                              <tr>
                                  <td class="title required">
                                      <label>供应商：</label>
                                  </td>
                                  <td colspan="3" style="width:38%">
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
                                  <td class="title required" style="width:6%">
                                      <label>票据类型：</label>
                                  </td>
                                  <td >
                                      <input name="billTypeId"
                                             id="billTypeId"
                                             class="nui-combobox width1"
                                             textField="name"
                                             valueField="customid"
                                             emptyText="请选择..."
                                             url=""
                                             allowInput="false"
                                             showNullItem="false"
                                             width="100%"
                                             valueFromSelect="true"
                                             onvaluechanged=""
                                             nullItemText="请选择..."
                                             onvalidation="onComboValidation"/>
                                  </td>
                                  <td class="title required" style="width:6%">
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
                                             allowInput="false"
                                             showNullItem="false"
                                             valueFromSelect="true"
                                             width="100%"
                                             nullItemText="请选择..."
                                             onvalidation="onComboValidation"/>
                                  </td>
                                  
                                  <td class="title required" style="width:8%;">
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
                                      <label>采购员：</label>
                                  </td>
                                  <td colspan="1" style="width:15%">
                                      <input class="nui-combobox" 
                                          id="orderMan" 
                                          name="orderMan" 
                                          textField="empName"
                                      valueField="empId"
                                      emptyText="请选择..."
                                      url=""
                                      required="true"
                                      allowInput="true"
                                      valueFromSelect="false"
                                          width="100%">
                                  </td>
                                  <td class="title">
                                      <label>创建日期：</label>
                                  </td>
                                  <td width="150">
                                      <input name="createDate"
                                             id="createDate"
                                             width="100%"
                                             showTime="true"
                                             class="nui-datepicker" enabled="false" format="yyyy-MM-dd HH:mm"/>
                                  </td>
                                  <td class="title">
                                      <label>状态：</label>
                                  </td>
                                  <td>
                                      <input allowInput="false" class="nui-textbox" width="100%" id="AbillStatusId" name="AbillStatusId"/>
                                  </td>
                                  <td class="title">
                                      <label>备注：</label>
                                  </td>
                                  <td colspan="3">
                                      <input class="nui-textbox" width="100%" id="remark" name="remark"/>
                                  </td>

                              </tr>
                          </table>
                      </div>
                     
                  </div>
                </fieldset>
   
                  <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
                    <a class="nui-button" plain="true" iconCls="" onclick="addPart()"><span class="fa fa-plus fa-lg"></span>&nbsp;添加配件</a>
                    </div>
                    <div class="nui-fit">
                    <div id="rightGrid" class="nui-datagrid" 
                         style="width:100%;height:100%;"
                         selectOnLoad="true"
                         showPager="false"
                         dataField="pjPchsOrderDetailList"
                         idField="id"
                         showSummaryRow="true"
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
                         editNextOnEnterKey="true"
                         url="">
                        <div property="columns">
                            <div type="indexcolumn">序号</div>
                            <div header="采购订单明细" headerAlign="center">
                                <div property="columns">
                                    <div field="operateBtn" name="operateBtn" align="center" width="50" headerAlign="center" header="操作"></div>
                                    <div field="comPartCode" name="comPartCode" width="180" headerAlign="center" header="配件编码">
                                        <input property="editor" class="nui-textbox" />
                                    </div>
                                    <div field="comPartName" headerAlign="center" header="配件名称">
                                        <!-- <input property="editor" class="nui-textbox" data="codeList" valueField="code" textField="code"/> -->
                                    </div>
                                    <div field="comPartBrandId" id="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                                    <div field="comApplyCarModel" id="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                                    <div field="comUnit" name="comUnit" width="40" headerAlign="center" header="单位"></div>
                                </div>
                            </div>
                            <div header="数量金额信息" headerAlign="center">
                                <div property="columns">
                                    <div field="orderQty" name="orderQty" summaryType="sum" numberFormat="0.00" width="60" headerAlign="center" header="数量">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                    <div field="orderPrice" numberFormat="0.0000" width="60" headerAlign="center" header="单价">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                    <div field="orderAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                    <div field="remark" width="100" headerAlign="center" allowSort="false">
                       				 备注<input property="editor" class="nui-textbox"/>
                       				</div>
                                    <div field="sellPrice" numberFormat="0.0000" width="60" headerAlign="center" header="建议售价">
                                      <input property="editor" vtype="float" class="nui-textbox"/>
                                    </div>
                                </div>
                            </div>
                            <div header="辅助信息" headerAlign="center">
                                <div property="columns">
                                  <div type="comboboxcolumn" field="storeId" width="60" headerAlign="center" allowSort="false">
                        仓库<input  property="editor" enabled="true"  id="storehouse" name="storehouse" dataField="storehouse" allowInput="false" class="nui-combobox" valueField="id" textField="name" data="storehouse"
                                      url=""
                                      onvaluechanged="" emptyText=""  vtype="required"
                                      /> 
                        </div>    
                        <div field="storeShelf" width="60" headerAlign="center" allowSort="false">
                              仓位<input id="storeShelf" name="storeShelf"  property="editor" class="nui-combobox" textField="name" valueField="name" dataField="storeShelfList" data="storeShelfList" onvaluechanged="" allowInput="true"/>
                              </div>  
                      <div field="comOemCode" allowSelect="false" width="60" headerAlign="center" allowSort="false" header="OEM码"></div> 
                      <div field="comSpec" allowSelect="false" width="100" headerAlign="center" allowSort="false" header="规格/方向/颜色"></div>                             
                                </div>
                            </div>
                        </div>
                    </div>
                    </div>



