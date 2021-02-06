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
<script src="<%=webPath + contextPath%>/purchase/js/packOut/packOut.js?v=1.1.12"></script>
<style type="text/css">
.title {
  width: 75px;
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
                
                <a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">所有</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                	<li iconCls="" onclick="quickSearch(9)" id="type9">所有</li>
                    <li iconCls="" onclick="quickSearch(6)" id="type6">未审</li>
                    <li iconCls="" onclick="quickSearch(7)" id="type7">已审</li>
                    <!-- <li iconCls="" onclick="quickSearch(12)" id="type12">已发货</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">已到货</li> -->
                    <!-- <li iconCls="" onclick="quickSearch(13)" id="type13">部分入库</li> -->
              

                </ul>

                <label style="font-family:Verdana;">客户：</label>
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择客户..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                       
                <!-- <input id="searchOrderMan" width="120px" emptyText="销售员" class="nui-textbox"/> -->
                <input id="searchServiceId" width="120px" emptyText="订单号" class="nui-textbox"/>
                <input id="selectStoreId" with="100px"  enabled="true" name="selectStoreId" dataField="storehouse"
 					class="nui-combobox" valueField="id" textField="name" data="storehouse"
                  onvaluechanged="search()" emptyText="选择仓库" allowInput="true" valueFromSelect="true" />
                
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
           		<!-- <a class="nui-button" iconCls="" plain="true" onclick="arrival()" id="arrivalBtn"><span class="fa fa-check fa-lg"></span>&nbsp;到货</a>
           		<a class="nui-button" iconCls="" plain="true" onclick="onPrint()" id="pritnBtn"><span class="fa fa-print fa-lg"></span>&nbsp;打印销售单</a> -->
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
          <div title="打包发货列表" class="nui-panel"
                 showFooter="true"
                 style="width:100%;height:100%;border: 0;">
                <div id="leftGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="true"
                     pageSize="50"
                     multiSelect="false"
                     allowUnselect="true"
                     sizeList=[20,50,100,200]
                     selectOnLoad="true"
                     showModified="false"
                     ondrawcell="onLeftGridDrawCell"
                     onrowdblclick=""
                     sortMode="client"
                     onselectionchanged="onLeftGridSelectionChanged"
                     onbeforedeselect="onLeftGridBeforeDeselect"
                     dataField="list"
                     url="">  
                    <div property="columns">
                      	<div type="indexcolumn">序号</div> 
						<div field="auditSign" width="55" headerAlign="center" header="状态"></div>
                        <div field="guestFullName" allowSort="true" width="140" headerAlign="center" header="客户"></div>
                   	    <div field="storeId" width="80" headerAlign="center"  header="仓库" allowSort="true" dataType="string"></div>
                        <div field="createDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
                        <div field="packMan" width="60" allowSort="true" headerAlign="center" header="发货员"></div>
                        <div field="serviceId" allowSort="true" headerAlign="center" width="170" header="发货单号"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                        <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            

             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:90px;">
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
                              <input name="settleTypeId" visible="false"
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
                              <input name="payType" visible="false"
                                           id="payType"
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
                                          <label>往来单位：</label>
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
	                                             width="80%"
	                                             placeholder="请选择客户"
	                                             selectOnFocus="true" />
	                                      <a class="nui-button"  iconCls="" plain="false" onclick="selectSupplier('guestId')" id="selectSupplierBtn"><span class="fa fa-check fa-lg"></span></a>
<!-- 	                                      <input id="btnEdit1" width="11%" class="mini-buttonedit"  onbuttonclick="selectSupplier('guestId')"/> -->
                                          <input class="nui-textbox" id="guestName" name="guestName" width="100%" visible="false">
                                      </td>
                                      <td class="title required">
                                          <label>发货员：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="packMan" name="packMan" width="100%" enabled="true">
                                      </td>
                                      <td class="title">
                                          <label>发货单号：</label>
                                      </td>
                                      <td>
                                          <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新发货单"/>
                                      </td>
                                      
                                  </tr>
                                  <tr>
                                      <td class="title required">
	                                      <label>打包类型：</label>
	                                  </td>
	                                  <td colspan="1">
	                                      <input width="100%" id="packType" name="packType"   value = 1                                
	                                       enabled="true"  dataField="PackTypeList" class="nui-combobox" valueField="id" textField="name"
	                                       data="PackTypeList" onvaluechanged="onPackTypeValueChange"/>
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
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="10">
                                          <input class="nui-textbox" selectOnFocus="true" width="100%" id="remark" name="remark"/>
                                      </td>
                                  </tr>
                                  <tr style="display:none">
                                      <td class="title required">
                                          <label>收货人：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-combobox" id="receiveMan" name="receiveMan" width="100%" textField="receiveMan"
                                           valueField="receiveMan" valuefromselect="false"
                                           onvaluechanged="onReceiveManChanged"
                                           allowInput="true" selectOnFocus="true">
                                      </td>
                                      <td class="title">
                                          <label>收货人电话：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="receiveManTel" name="receiveManTel" width="100%" enabled="">
                                      </td>
                                      <td class="title">
                                          <label>收货地址：</label>
                                      </td>
                                      <td colspan="3">
                                          <input class="nui-textbox" id="address" name="address" width="100%" enabled="">
                                      </td>
                                      <td class="title">
                                          <label>收货单位：</label>
                                      </td>
                                      <td colspan="3">
                                          <input class="nui-textbox" id="receiveCompName" name="receiveCompName" width="100%" enabled="">
                                          <input class="nui-textbox" id="provinceId" name="provinceId" width="100%" visible="false">
                                          <input class="nui-textbox" id="cityId" name="cityId" width="100%" visible="false">
                                          <input class="nui-textbox" id="countyId" name="countyId" width="100%" visible="false">
                                          <input class="nui-textbox" id="streetAddress" name="streetAddress" width="100%" visible="false">
                                      </td>
                                  </tr>
                                  <tr style="display:none">
                                      <td class="title">
                                          <label>代收货款：</label>
                                      </td>
                                      <td colspan="1">
                                           <input class="nui-textbox" id="collectMoney" name="collectMoney" width="100%"  selectOnFocus="true">
                                      </td>
                                      <td class="title">
                                          <label>保价声明：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-textbox" id="valuationStatement" name="valuationStatement" width="100%"  selectOnFocus="true">
                                      </td>
                                      <td class="title required">
                                          <label>出发城市：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-combobox" data="cityList" textField="name" valueField="name" allowInput="true" id="senderCity" name="senderCity" width="100%"  enabled="true">
                                      </td>
                                      <td class="title required">
                                          <label>目的站：</label>
                                      </td>
                                      <td colspan="1">
                                          <input class="nui-combobox" data="cityList" textField="name" valueField="name" allowInput="true" id="destinationStation" name="destinationStation" width="100%">
                                      </td>
                                      <td class="title">
                                          <label>备注：</label>
                                      </td>
                                      <td colspan="3">
                                          <input class="nui-textbox" id="remark" name="remark" width="100%" enabled="true">
                                      </td>
                                  </tr>
                                  <tr style="display:none">
                                      <td class="title required">
                                          <label>发货员：</label>
                                      </td>
                                      <!--<td colspan="1">
                                          <input class="nui-textbox" id="packMan" name="packMan" width="100%" enabled="true">
                                      </td>-->
                                      <td class="title required">
                                          <label>发件人电话：</label>
                                      </td>
                                      <td colspan="1">
                                           <input class="nui-textbox" id="senderPhone" name="senderPhone" width="100%"  selectOnFocus="true">
                                      </td>
                                      <td class="title required">
                                          <label>发件人地址：</label>
                                      </td>
                                      <td colspan="3">
                                          <input class="nui-textbox" id="senderAddress" name="senderAddress" width="100%"  selectOnFocus="true">
                                      </td>
                                      <td class="title required">
                                          <label>身份证号：</label>
                                      </td>
                                      <td colspan="3">
                                          <input class="nui-textbox" id="idNo" name="idNo" width="100%" enabled="true">
                                      </td>
                                  </tr>
                              </table>
                          </div>
                         
                      </div>
                  </fieldset>
                  
                  <div class="nui-fit">
	                  <div style="float:left;width:50%">
		                    <div title="打包单据" class="nui-panel"
		                        showFooter="true"
		                        style="width:99%;height:100%;border: 0;">
		                        
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
					                      <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;border: 1px;"
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
					                              <div type="checkcolumn" width="20" ></div>
					                              <div type="expandcolumn" width="20" >#</div>
					                              <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
					                              <div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="订单号"></div>
					                              <!-- 
					                              <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div> -->
					                              <div allowSort="true" width="120" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
					                              <div field="remark" width="120" headerAlign="center" header="备注"></div>
					                          </div>
					                      </div>
					                	</div>
		                        
		                    </div>
		                </div>
						<div style="float:left;width:50%">
		                    <div title="发货物流" class="nui-panel"
		                        showFooter="true"
		                        style="width:100%;height:100%;border: 0;">
		                        
									    <div class="nui-toolbar" style="padding:2px;border-left:0;">
					                      <table style="width:100%;">
					                          <tr>
					                              <td style="white-space:nowrap;">
					                                  <a class="nui-button" iconCls="" plain="true" onclick="addNewRow()" id="addBtn"><span class="fa fa-save fa-lg"></span>&nbsp;添加</a>
					                                    <a class="nui-button" plain="true" iconCls="" onclick="deleteRow()" id="deleteRowBtn"><span class="fa fa-remove fa-lg"></span>&nbsp;删除</a>
					                              </td>
					                          </tr>
					                      </table>
					                     </div>
									    
									     <div class="nui-fit">
									        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
									             showPager="false"
									             dataField="list"
									             ondrawcell="onDrawCell"
									             idField="id"
									             showSummaryRow="true"
									             allowCellSelect="true"
									             allowCellEdit="true"
									             oncellcommitedit="onCellCommitEdit"
									             showModified="false"
									             multiSelect="true"
									             pageSize="1000"
									             sizeList="[500,1000,2000]"
									             oncellbeginedit="OnrpMainGridCellBeginEdit"
									             url="">
									            <div property="columns">
									                <div type="indexcolumn" >序号</div>
									                <div type="checkcolumn" field="check" width="20" ></div>
									                <div field="guestId" width="50" headerAlign="center" visible="false"></div>
									                <div field="billDc" width="50" headerAlign="center" visible="false"></div>
									                <div field="fullName" summaryType="count"  headerAlign="center" header="往来单位名称"></div>
									                <div field="settleTypeId" type="comboboxcolumn"  headerAlign="center" header="结算方式">
									                    <input  property="editor" enabled="true" id="customid" name="name" data="settTypeIdList" dataField="settTypeIdList" class="nui-combobox" valueField="customid" textField="name" url="" emptyText=""  vtype="required"/> 
									                </div>
									                <div field="expenseTypeCode" type="comboboxcolumn"  headerAlign="center" header="费用类型">
									                    <input  property="editor" enabled="true" id="expenseTypeCode" name="list" data="incomeList" dataField="incomeList" class="nui-combobox" onvaluechanged="" valueField="id" textField="name" url="" emptyText=""  vtype="required"/> 
									                </div>
									                <div field="expenseAmt"  summaryType="sum" headerAlign="center" header="应付金额">
									                  <input property="editor" vtype="range:0,15000"  class="nui-textbox"/>
									                </div>
									                <div field="logisticsNo"  headerAlign="center" header="物流单号">
									                    <input property="editor" class="nui-textbox"/>
									                </div>
									                <div field="remark"  headerAlign="center" header="备注">
									                    <input property="editor" class="nui-textbox"/>
									                </div>
									                <div allowSort="true" field="createDate"  headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
									                <div allowSort="true" field="creator"  headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="创建人"></div>     
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
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="销售数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="销售单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="销售金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  
  <div id="editFormPchsRtnDetail" style="display:none;">
      <div id="innerPchsRtnGrid" class="nui-datagrid" style="width:100%;height:150px;"
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
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="退货数量"></div>
              <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="退货单价"></div>
              <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="退货金额"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  
  <div id="editFormShiftDetail" style="display:none;">
      <div id="innerShiftGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="detailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="partCode" width="120" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="fullName" width="120"headerAlign="center" header="配件名称"></div>
              <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
              <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  
  <div id="editFormCheckDetail" style="display:none;">
      <div id="innerCheckGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="detailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="comPartCode" width="120" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
              <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
              <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
              <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
              <div allowSort="true" field="outUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="storeId" width="120" headerAlign="center" header="仓库"></div>
              <div allowSort="true" field="dc" width="60" headerAlign="center" header="状态"></div>
              <div allowSort="true" datatype="float" field="exhibitQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  
  <div id="editFormCheckPYDetail" style="display:none;">
      <div id="innerCheckPYGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="detailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="partCode" width="120" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="fullName" width="120"headerAlign="center" header="配件全称"></div>
              <div allowSort="true" datatype="float" field="enterQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="enterPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="float" field="enterAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
              <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  
  <div id="editFormCheckPKDetail" style="display:none;">
      <div id="innerCheckPKGrid" class="nui-datagrid" style="width:100%;height:150px;"
           showPager="false"
           dataField="detailList"
           idField="detailId"
           ondrawcell="onDrawCell"
           sortMode="client"
           url=""
           showSummaryRow="true">
          <div property="columns">
              <div type="indexcolumn">序号</div>
              <div allowSort="true" field="partCode" width="120" headerAlign="center" header="配件编码"></div>
              <div allowSort="true" field="fullName" width="120"headerAlign="center" header="配件名称"></div>
              <div allowSort="true" datatype="float" field="sellQty" summaryType="sum" width="60" headerAlign="center" header="数量"></div>
              <div allowSort="true" datatype="float" field="sellPrice" width="60" headerAlign="center" header="单价"></div>
              <div allowSort="true" datatype="float" field="sellAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
              <div allowSort="true" field="systemUnitId" width="40" headerAlign="center" header="单位"></div>
              <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
          </div>
      </div>
  </div>
  
  

</div>


</body>
</html>
