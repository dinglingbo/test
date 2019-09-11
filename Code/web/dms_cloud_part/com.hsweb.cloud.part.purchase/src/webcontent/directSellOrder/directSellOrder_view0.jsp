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
<title>销售订单</title>
<script src="<%=webPath + contextPath%>/purchase/js/directSellOrder/directSellOrder.js?v=1.0.11"></script>
<style type="text/css">
.title {
	width: 70px;
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

body .mini-grid-row-selected{
    background:#89c3d6 !important; 
}

</style>
</head>
<body>


<div id="advancedSearchWin" class="nui-window"
     title="高级查询" style="width:416px;height:380px;"
     showModal="true"
     allowResize="false"
     allowDrag="true">
    <div id="advancedSearchForm" class="form">
        <table style="width:100%;">
        	<tr>
                <td class="title">订单日期:</td>
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
                           emptyText="请选择客户..."
                           onbuttonclick="selectSupplier('btnEdit2')"
                           width="100%"
                           selectOnFocus="true" />
                </td>
            </tr>
            <tr>
                <td class="title">订单号:</td>
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


<div id="advancedMorePartWin" class="nui-window"
     title="配件选择" style="width:650px;height:350px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     allowDrag="true">
     <div class="nui-toolbar" style="padding:2px;border-bottom:1;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <input class="nui-textbox" width="100px" id="morePartCode" name="morePartCode" enabled="true" emptyText="编码"/>
                    <input class="nui-textbox" width="100px" id="morePartName" emptyText="名称" selectOnFocus="true" name="morePartName"/>
                    <span class="separator"></span>
                    <input id="sortType" class="nui-combobox" width="100px" textField="text" valueField="id" emptyText="排序类型"
                           value="1"  required="true" allowInput="false" showNullItem="true" nullItemText="请选择..."/> 
                    <input class="nui-checkbox" id="showStock" trueValue="1" falseValue="0" text="库存数量>0"/>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="morePartSearch" id="saveBtn"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartTabs" class="nui-tabs" name="morePartTabs"
               activeIndex="0" 
               style="width:100%; height:100%;" 
               plain="false" 
               onactivechanged="onMoreTabChanged">
            <div title="批次选择" id="enterTab" name="enterTab" >
                <div id="enterGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     borderStyle="border:1;"
                     showPager="true"
                     pageSize="20"
                     sizeList=[20,50,100,200]
                     dataField="partlist"
                     url=""
                     sortMode="client"
                     ondrawcell=""
                     onrowdblclick=""
                     idField="id"
                     totalField="page.count"
                     allowCellSelect="true" allowCellEdit="false">
                    <div property="columns">
                        <div header="基础信息" headerAlign="center">
                            <div property="columns">
                                <div type="indexcolumn">序号</div>
                                <div field="partBrandId" width="70" headerAlign="center">品牌</div>
                                <div field="partCode" width="80" headerAlign="center" allowSort="true">配件编码</div>
                                <div field="name" width="80" headerAlign="center" allowSort="true">名称</div>
                                <div field="enterUnitId" width="30" headerAlign="center" allowSort="true">单位</div>
                            </div>
                        </div>
                        <div header="库存信息" headerAlign="center">
                            <div property="columns">   
                                <div field="stockQty" width="55px" headerAlign="center" allowSort="true">
                                库存数量
                                </div>   
                                <div field="preOutQty" width="55px" headerAlign="center" allowSort="true">
                                待出库数量
                                </div>
                                <div field="storeId" width="60" headerAlign="center" allowSort="true">仓库</div>
                    <div field="storeShelf" align="left" width="55px" headerAlign="center" allowSort="true">
                                仓位
                                </div>
                                <div field="auditDate" allowSort="true" dateFormat="yyyy-MM-dd HH:mm" width="120px" format="yyyy-MM-dd HH:mm" headerAlign="center" allowSort="true">
                                入库日期
                                </div>
                                <div field="guestName" width="150px" headerAlign="center" allowSort="true">
                                供应商
                                </div>  
                                <div field="enterPrice" width="55px" headerAlign="center" allowSort="true">
                                成本单价
                                </div>
                                <div field="enterCode" align="left" width="55px" headerAlign="center" allowSort="true">
                                入库单号
                                </div>
                            </div>
                        </div>
                        <div header="" headerAlign="center">
                            <div property="columns">
                                <div field="spec" width="60" headerAlign="center" allowSort="true">规格</div>

                                <div field="position_name" width="60" headerAlign="center" allowSort="true">型号</div>

                                <div field="carModelName" width="70" headerAlign="center" allowSort="true">品牌车型</div>
                                <div field="fullName" width="120" headerAlign="center" allowSort="true">全称</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div title="配件选择" id="partInfoTab" name="partInfoTab" url="" >
                <div id="morePartGrid" class="nui-datagrid" style="width:100%;height:100%;"
                   selectOnLoad="true"
                   borderStyle="border:1;"
                   showPager="true"
                   pageSize="20"
                   sizeList=[20,50,100,200]
                   dataField="parts"
                   sortMode="client"
                   frozenStartColumn="0"
                   frozenEndColumn="1"
                   onrowdblclick="addSelectPart"
                   totalField="page.count"
                   allowCellSelect="true"
                   editNextOnEnterKey="true"
                   url="">
                  <div property="columns">
                      <div type="indexcolumn">序号</div>
                      <div field="code" name="code" width="150" headerAlign="center" header="配件编码"></div>
                      <div field="oemCode" name="oemCode" width="200" headerAlign="center" header="OE码"></div>
                      <div field="name" name="name" width="120" headerAlign="center" header="配件名称"></div>
                      <div allowSort="true" datatype="float" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                      <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                      <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                      <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                      <div field="partBrandId" name="partBrandId" width="100" headerAlign="center" header="品牌"></div>
                      <div field="applyCarModel" name="applyCarModel" width="200" headerAlign="center" header="品牌车型"></div>
                      <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div>
                  </div>
                </div>
            </div> 
            
          </div>
          
    </div>
</div>

<div id="advancedMorePartWin2" class="nui-window"
     title="配件选择" style="width:700px;height:350px;"
     showModal="true"
     showHeader="false"
     allowResize="false"
     style="padding:2px;border-bottom:0;"
     allowDrag="true">
     <div class="nui-toolbar" >
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                    <a class="nui-button" iconCls="" plain="true" onclick="addSelectPart2" id="saveBtn"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onPartClose2" id="auditBtn"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
          <div id="morePartGrid2" class="nui-datagrid" style="width:100%;height:95%;"
               selectOnLoad="true"
               showPager="false"
               dataField=""
               onrowdblclick="addSelectPart2"
               onshowrowdetail=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               url="">
              <div property="columns">
                <div type="indexcolumn">序号</div>
<!--                 <div type="expandcolumn" width="50" >替换件</div> -->
                <div field="code" name="code" width="100" headerAlign="center" header="配件编码"></div>
                <div field="oemCode" name="oemCode" width="100" headerAlign="center" header="OE码"></div>
                <div field="name" name="name" width="100" headerAlign="center" header="配件名称"></div>
                <div field="partBrandId" name="partBrandId" width="100" headerAlign="center" header="品牌"></div>
                <div field="applyCarModel" name="applyCarModel" width="100" headerAlign="center" header="品牌车型"></div>
                <div allowSort="true" datatype="float" name="outableQty" field="outableQty" summaryType="sum" width="60" headerAlign="center" header="可售数量"></div>
                <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="开单数量"></div>
                <div allowSort="true" datatype="float" field="stockQty" summaryType="sum" width="60" headerAlign="center" header="库存数量"></div>
                <div allowSort="true" datatype="float" field="onRoadQty" summaryType="sum" width="60" headerAlign="center" header="在途数量"></div>
                <div field="fullName" name="fullName" width="200" headerAlign="center" header="配件全称"></div>
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

<div id="exportDiv" style="display:none">  
    <table id="tableExcel" width="100%" border="0" cellspacing="0" cellpadding="0">  
        <tr>
            <td colspan="1" align="left">单号：</td>
            <td colspan="1" align="left"><span id="eServiceId"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">客户名称：</td>
            <td colspan="1" align="left"><span id="eGuestName"></span></td>
        </tr>
        <tr>
            <td colspan="1" align="left">备注：</td>
            <td colspan="1" align="left"><span id="eRemark"></span></td>
        </tr>
        <tr>  
            <td colspan="1" align="center">配件编码</td>
            <td colspan="1" align="center">配件全称</td>
            <td colspan="1" align="center">品牌车型</td>
            <td colspan="1" align="center">单位</td>
            <td colspan="1" align="center">数量</td>
            <td colspan="1" align="center">单价</td>
            <td colspan="1" align="center">金额</td>
            <td colspan="1" align="center">备注</td>
        </tr>
        <tbody id="tableExportContent">
        </tbody>
    </table>  
    <a href="" id="tableExportA"></a>
</div> 


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
                     url="">
                    <div property="columns">
                      <div type="indexcolumn">序号</div>
                        <div field="auditSign" width="55" visible="false" headerAlign="center" header="状态"></div>
                        <div field="billStatusId" width="55" headerAlign="center" header="状态"></div>
                        <div field="guestFullName" width="140" headerAlign="center" header="客户"></div>
                        <div field="orderDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="订单日期"></div>
                        <div field="orderMan" width="60" headerAlign="center" header="销售员"></div>
                        <div field="serviceId" headerAlign="center" width="150" header="订单号"></div>
                        <div field="printTimes" width="60" headerAlign="center" header="打印次数"></div>
                        <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                        <div field="auditDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                    </div>
                </div>
            </div>
        </div>
        <div showCollapseButton="false">
            

             <div class="nui-fit">
                  <fieldset id="fd1" style="width:99.5%;height:100px;">
                      <legend><span>销售订单信息</span></legend>
                      <div class="fieldset-body">
                          <div id="basicInfoForm" class="form" contenteditable="false">
                              <input class="nui-hidden" name="id" id="id"/>
                              <input class="nui-hidden" name="operateDate"/>
                              <input class="nui-hidden" name="createDate"/>
                              <input class="nui-hidden" name="auditSign"/>
                              <input class="nui-hidden" name="orderAmt"/>
                              <input class="nui-hidden" name="directGuestId"/>
                              <input class="nui-textbox" visible="false" id="codeId" name="codeId" width="100%">
                              <table style="width: 100%;">
                                  <tr>
                                      <td class="title required">
                                          <label>客户：</label>
                                      </td>
                                      <td colspan="1">
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
                                             width="60%"
                                             placeholder="请选择客户"
                                             selectOnFocus="true" />
                                        <a class="nui-button" iconCls="" plain="false" onclick="selectSupplier('guestId')" id="addBtn"><span class="fa fa-check fa-lg"></span></a>
<!--                                       	<input id="btnEdit1" width="7.2%" class="mini-buttonedit"  onbuttonclick="selectSupplier('guestId')"/> -->
                                       	<a class="nui-button" iconCls="" plain="false" onclick="addGuest()" id="addBtn"><span class="fa fa-plus fa-lg"></span></a>
                                      </td>
                                      <td class="title required">
                                      <label>直发门店：</label>
	                                  </td>
	                                  <td colspan="1">
	                                     <input class="nui-combobox" id ="directOrgid" name="directOrgid" value="" allowInput="true" showNullItem="false" 
					                         valueFromSelect="true" nullitemtext="请选择..." emptyText="选择直发门店" data="" width="100%"
					                         textField="name" valueField="orgid" />
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
                                          <label>订单号：</label>
                                      </td>
                                      <td>
                                          <input class="nui-textbox" width="100%" id="serviceId" name="serviceId" enabled="false" placeholder="新销售订单"/>
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
                                       <div field="fullName"width="220"  headerAlign="center" header="配件全称"></div>
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
                                      <div type="comboboxcolumn" field="storeId" width="80" headerAlign="center" allowSort="true">
                                      	仓库<input  property="editor" enabled="true" name="storehouse" dataField="storehouse" class="nui-combobox" valueField="id" textField="name" 
                                              url="" data="storehouse"
                                              onvaluechanged="onStoreValueChange" emptyText=""  vtype="required"
                                              /> 
                                      </div>  
                                      
                                      <div type="comboboxcolumn" field="directStoreId" width="80" headerAlign="center" allowSort="true">
                                      	直发门店仓库<input  property="editor" enabled="true" name="directStoreId" dataField="directStoreHouse" class="nui-combobox" valueField="id" textField="name" 
                                              url="" data="directStoreHouse"
                                              onvaluechanged="" emptyText=""  vtype="required"
                                              /> 
                                      </div>  
                                      
                                       <div field="storeShelf" width="90" headerAlign="center" allowSort="true" header="仓位">
		                             	 仓位<input  property="editor" id="storeShelf" name='storeShelf'  class="nui-textbox"/>
		                          		</div>  
                                      <div field="stockOutQty" summaryType="sum" numberFormat="0.00" width="70" headerAlign="center" header="缺货数量">
                                      </div>
                                      <div type="checkboxcolumn" field="isMarkBatch" trueValue="1" falseValue="0" width="45" headerAlign="center" header="批次">
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
 

</body>
</html>
