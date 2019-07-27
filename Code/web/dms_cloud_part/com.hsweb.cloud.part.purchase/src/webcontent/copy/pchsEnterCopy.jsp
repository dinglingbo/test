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
<script src="<%=webPath + contextPath%>/purchase/copy/pchsEnterCopy.js?v=1.0.0"></script>
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

                <a class="nui-menubutton " menu="#popupMenuType" id="menunametype">未审</a>

                <ul id="popupMenuType" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(6)" id="type6">未审</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已审</li>
                    <li class="separator"></li>
                    <li iconCls="" onclick="quickSearch(9)" id="type9">全部</li>
                </ul>


                <label style="font-family:Verdana;">供应商：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择供应商..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a>
                
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> -->
            </td>
            <td style="width:100%;">
                <span class="separator"></span>
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="addPchsOrder()" id="importBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;订单入库</a>
                <a class="nui-button" iconCls="" plain="true" onclick="save()" id="saveBtn"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="audit()" id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="printBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印</a>
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
        <div size="300" showCollapseButton="true">
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
                     dataField="pjEnterMainList"
                     url="">
                    <div property="columns">
                    	<div type="indexcolumn">序号</div>
                        <div field="serviceId" headerAlign="center" width="150" header="采购单号"></div>
                        <!-- <div field="enterDate" width="80" headerAlign="center" header="入库日期" dateFormat="yyyy-MM-dd H:ss:mm"></div> -->
                        <div field="auditSign" width="35" headerAlign="center" header="状态"></div>
                        <div field="guestFullName" width="80" headerAlign="center" header="供应商"></div>
                        <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                        <div field="creator" width="60" headerAlign="center" header="创建人"></div>
                        <div field="createDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                        <div field="auditDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                    </div>
                </div>
                <!--footer-->
                <!-- <div property="footer">
                    <input type='nui-textbox' value='Footer' readonly="true" style='vertical-align:middle;'/>
                </div> -->
            </div>
        </div>
        <div showCollapseButton="false">
            <!-- <div title="订单信息" class="nui-panel"
                 style="width:100%;height: 130px;">
            
             -->

            <div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" allowResize="true">
              <!--上：辅助信息-->
              <div size="65%" showCollapseButton="false">
                 <div class="nui-fit">
                    <div class="nui-fit">
                      <div id="mainTabs" class="nui-tabs" name="mainTabs"
                           activeIndex="0" 
                           style="width:100%; height: auto;" 
                           plain="false" 
                           onactivechanged="ontopTabChanged">
                        <div title="采购入库信息" id="billmain" name="billmain" >
                          <div class="nui-fit">
                                 
                            <fieldset id="fd1" style="width:95%;height: 120px;">
                                <legend><span>采购入库信息</span></legend>
                                <div class="fieldset-body">
                                
                                    <div id="basicInfoForm" class="form" contenteditable="false">
                                        <input class="nui-hidden" name="id"/>
                                        <input class="nui-hidden" id="codeId" name="codeId"/>
                                        <input class="nui-hidden" id="name="codeId"" name="code"/>
                                        <input class="nui-hidden" name="operateDate"/>
                                        <input class="nui-hidden" name="versionNo"/>
                                        <input class="nui-hidden" id="enterTypeId" name="enterTypeId"/>
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
                                                <td class="title">
                                                    <label>默认仓库：</label>
                                                </td>
                                                <td>
                                                    <input id="storeId"
                                                           name="storeId"
                                                           class="nui-combobox width1"
                                                           textField="name"
                                                           valueField="id"
                                                           emptyText="请选择..."
                                                           url=""
                                                           valuefromselect="true"
                                                           allowInput="true"
                                                           selectOnFocus="true"
                                                           showNullItem="false"
                                                           width="100%"
                                                           nullItemText="请选择..."
                                                           />
                                                </td>
                                                <td class="title">
                                                    <label>采购单号：</label>
                                                </td>
                                                <td>
                                                    <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新采购订单"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title required">
                                                    <label>入库日期：</label>
                                                </td>
                                                <td width="120">
                                                    <input name="enterDate"
                                                           id="enterDate"
                                                           width="100%"
                                                           showTime="true"
                                                           class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                                </td>
                                                <!-- <td class="title wide">
                                                    <label>预计到货日期：</label>
                                                </td>
                                                <td width="160">
                                                    <input name="planArriveDate"
                                                           id="planArriveDate"
                                                           width="100%"
                                                           showTime="true"
                                                           class="nui-datepicker" enabled="true" format="yyyy-MM-dd HH:mm"/>
                                                </td> -->
                                                <td class="title">
                                                    <label>手工单号：</label>
                                                </td>
                                                <td colspan="1">
                                                    <input class="nui-textbox" id="code" name="code" width="100%">
                                                </td>
                                                <td class="title">
                                                    <label>采购员：</label>
                                                </td>
                                                <td colspan="1">
                                                    <input class="nui-textbox" id="orderMan" name="orderMan" width="100%">
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
                                                           onvaluechanged="onBillTypeIdChanged"
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
                                                <td class="title required">
                                                    <label>开票税点：</label>
                                                </td>
                                                <td>
                                                    <input class="nui-textbox" id="taxRate" name="taxRate" enabled="false" width="100%">
                                                </td>
                                                <td colspan="2">
                                                    <input id="taxSign" name="taxSign" enabled="false" class="mini-checkbox" text="是否开票" trueValue="1" falseValue="0" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="title">
                                                    <label>备注：</label>
                                                </td>
                                                <td colspan="3">
                                                    <input class="nui-textbox" selectOnFocus="true" width="100%" id="remark" name="remark"/>
                                                </td>
                                                <td class="title tip">
                                                    <label>添加配件：</label>
                                                </td>
                                                <td >
                                                    <input class="nui-textbox" selectOnFocus="true" width="100%" id="fastPartEntry" name="fastPartEntry"/>
                                                </td>
                                                <td class="title">
                                                    <label>总金额：</label>
                                                </td>
                                                <td colspan="1">
                                                    <input class="nui-textbox" width="100%" id="enterAmt" name="enterAmt" enabled="false" style="text-align: right;"/>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                   
                                </div>
                            </fieldset>
                          </div>
                        </div>
                        <div title="配件信息" id="partInfoTab" name="partInfoTab" url="" >
                          <!-- <div class="nui-fit">
                              <iframe id="formIframePart" src="" frameborder="0" scrolling="yes" height="height: 110px;" width="100%" noresize="noresize"></iframe>
                          </div> -->
                        </div> 
                        <!-- <div title="库存详情" name="purchaseAdvance" >
                          <div class="nui-fit">
                                <iframe id="formIframeStock" src="" frameborder="0" scrolling="yes" height="height: 110px;" width="100%" noresize="noresize"></iframe>
                          </div>
                        </div>  -->
                        <div title="采购车"  name="purchaseAdvanceTab" url="">
                          <!-- <div class="nui-fit">
                                <iframe id="formIframePchs" src="" frameborder="0" scrolling="yes" height="height: 110px;" width="100%" noresize="noresize"></iframe>
                          </div> -->
                        </div>   
                    </div>

                     <div class="nui-fit">
                          <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                               showPager="false"
                               dataField="pjEnterDetailList"
                               idField="id"
                               showSummaryRow="true"
                               frozenStartColumn="0"
                               frozenEndColumn="10"
                               ondrawcell="onRightGridDraw"
                               allowCellSelect="true"
                               allowCellEdit="true"
                               oncellcommitedit="onCellCommitEdit"
                               ondrawsummarycell="onDrawSummaryCell"
                               onselectionchanged="onRightGridSelectionChanged"
                               showModified="false"
                               editNextOnEnterKey="true"
                               url="">
                              <div property="columns">
                                  <div type="indexcolumn">序号</div>
                                  <div header="配件信息" headerAlign="center">
                                      <div property="columns">
                                        <div field="operateBtn" width="30" headerAlign="center" header="删除"></div>
                                        <div field="comPartCode" width="100" headerAlign="center" header="配件编码"></div>
                                        <div field="comPartName" headerAlign="center" header="配件名称"></div>
                                        <div field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                                        <div field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                                        <div field="comUnit" width="40" headerAlign="center" header="单位"></div>
                                      </div>
                                  </div>
                                  <div header="数量金额信息" headerAlign="center">
                                      <div property="columns">
                                          <div field="enterQty" name="enterQty" summaryType="sum" numberFormat="0.00" width="50" headerAlign="center" header="数量">
                                            <input property="editor" vtype="float" class="nui-textbox"/>
                                          </div>
                                          <div field="enterPrice" numberFormat="0.0000" width="50" headerAlign="center" header="单价">
                                            <input property="editor" vtype="float" class="nui-textbox"/>
                                          </div>
                                          <div field="enterAmt" summaryType="sum" numberFormat="0.0000" width="60" headerAlign="center" header="金额">
                                            <input property="editor" vtype="float" class="nui-textbox"/>
                                          </div>
                                          <div field="remark" width="80" headerAlign="center" allowSort="true">
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
                              仓位<input property="editor" class="nui-textbox"/>
                              </div>
                            <div field="comOemCode" width="60" headerAlign="center" allowSort="true" header="OE码"></div> 
                            <div field="comSpec" width="100" headerAlign="center" allowSort="true" header="规格/方向/颜色"></div>
                                        <div field="partId" summaryType="count" width="50" headerAlign="center" header="配件ID"></div>                               
                                      </div>
                                  </div>
                                  <div header="不含税信息" headerAlign="center">
                                      <div property="columns">
                                          <div field="noTaxPrice" width="50" headerAlign="center" header="单价"></div>
                                          <div field="noTaxAmt" summaryType="sum" numberFormat="0.0000" width="50" headerAlign="center" header="金额"></div>
                                      </div>
                                  </div>
                                  <div header="含税信息" headerAlign="center">
                                      <div property="columns">
                                          <div field="taxRate" width="50" headerAlign="center" header="税率"></div>
                                          <div field="taxPrice" width="50" headerAlign="center" header="单价"></div>
                                          <div field="taxAmt" summaryType="sum" numberFormat="0.0000" width="50" headerAlign="center" header="金额"></div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>

                  </div>
                </div>  
            </div>
            <!--下：采购订单-->
            <div showCollapseButton="false">
                <iframe id="formIframe" src="" frameborder="0" scrolling="yes" height="100%" width="100%" noresize="noresize"></iframe>
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
                <td class="title">入库日期:</td>
                <td>
                    <input name="sEnterDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input name="eEnterDate"
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
                    <span style="letter-spacing: 6px;">供应</span>商:
                </td>
                <td colspan="3">
                    <input id="btnEdit2"
                           name="guestId"
                           class="nui-buttonedit"
                           emptyText="请选择供应商..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">采购单号:</td>
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
