<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8" session="false" %>
<%@include file="/common/sysCommon.jsp"%>
<%@include file="/common/commonCloudPart.jsp"%>
  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2019-07-27 17:06:26
  - Description:
-->
<head>
<title>供应商直发受理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/purchase/js/allotApply/allotDirectPchsEnter.js?v=1.0.0"></script>
</head>
<body>
<div class="nui-fit">
  <div  class="nui-splitter" vertical="true" style="width:100%;height:100%;" style="border:0;" handlerSize="0">
        <div size="60%" showCollapseButton="false">
        
          <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
          <table style="width:100%;">
              <tr>
                  <td style="white-space:nowrap;">
                    <label style="font-family:Verdana;">快速查询：</label>
                     
                      <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">上周</a>
      
                      <ul id="popupMenuDate" class="nui-menu" style="display:none;">
                          <li iconCls="" onclick="quickSearch(2)" id="type2">本周</li>
                          <li iconCls="" onclick="quickSearch(3)" id="type3">上周</li>
                          <li class="separator"></li>
                          <li iconCls="" onclick="quickSearch(4)" id="type4">本月</li>
                          <li iconCls="" onclick="quickSearch(5)" id="type5">上月</li>
                          <li class="separator"></li>
                          <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                          <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
                      </ul>
      
                      <label style="font-family:Verdana;">提交日期 从：</label>
                      <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                      <label style="font-family:Verdana;">至</label>
                      <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                     
                      <input id="serviceId" width="100px" emptyText="订单号" class="nui-textbox"/>
                      <input class="nui-combobox" id ="status" name="status" value="" allowInput="true" showNullItem="false" 
                     valueFromSelect="true" nullitemtext="请选择..." emptyText="选择订单状态" data="" width="100px" data="statusList" dataField="statusList"
                     textField="name" valueField="id" onEnter="onSearch()" />
                   


  
                      <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                      <span class="separator"></span>
                      <input name="storeId"
                                                 id="storeId"
                                                 class="nui-combobox"
                                                 textField="name"
                                                 valueField="id"
                                                 emptyText="请选择受理仓库..."
                                                 url=""
                                                 allowInput="true"
                                                 showNullItem="false"
                                                 width="100px"
                                                 valueFromSelect="true"
                                                 onvaluechanged=""
                                                 nullItemText="请选择受理仓库..."
                                                />
                            <span class="separator"></span>                    
                      <a class="nui-button" iconCls="" plain="true" onclick="audit()" visible=""  id="auditBtn"><span class="fa fa-check fa-lg"></span>&nbsp;受理</a>

                      <input id="billTypeId" width="60px" emptyText="票据类型" textField="name" valueField="customid" class="nui-combobox" visible="false"/>
                      <input id="settleTypeId" width="60px" emptyText="结算方式" textField="name" valueField="customid" class="nui-combobox" visible="false"/>
                      
                  </td>
              </tr>
          </table>
      </div>
      
      <div class="nui-fit">
         <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
                  showPager="true"
                  dataField="detailList"
                  idField="detailId"
                  selectOnLoad="true"
                  ondrawcell="onDrawCell"
                  sortMode="client"
                  showModified="false"
                  onselectionchanged="onMainGridSelectionChanged"
                  url=""
                  multiSelect="true"
                  pageSize="50"
                  sizeList="[50,100,200]"
                  showSummaryRow="true">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div allowSort="true" summaryType="count" field="serviceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
                  <div field="fullName" width="150" headerAlign="center" header="供应商名称"></div>
                  <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
                  <div field="billTypeId" width="60" headerAlign="center" header="票据类型"></div>
                  <div field="settleTypeId" width="60" headerAlign="center" header="结算方式"></div>
                  <div allowSort="true"width="120" field="createDate" headerAlign="center" header="制单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                  <div field="isFinished" width="60" headerAlign="center" header="状态"></div>
                  <div field="auditor" width="60" headerAlign="center" header="审核人"></div>
                  <div allowSort="true" width="120"field="auditDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                  <div field="remark" width="120" headerAlign="center" header="备注"></div>
      
              </div>
          </div>
        </div>
      
        </div>
        
        <div size="40%" showCollapseButton="false">
        
          <div class="nui-fit">
                <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
                     showPager="false"
                     dataField="pjPchsOrderDetailList"
                     idField="detailId"
                     ondrawcell="onDrawCell"
                     sortMode="client"
                     url=""
                     showSummaryRow="true">
                    <div property="columns">
                        <div type="indexcolumn">序号</div>
                        
                        <div allowSort="true" field="comPartCode" width="60" headerAlign="center" header="配件编码" summaryType="count"></div>
                        <div allowSort="true" field="comPartName" headerAlign="center" header="配件名称"></div>
                        <div allowSort="true" field="comOemCode" headerAlign="center" header="OE码"></div>
                        <div allowSort="true" field="comPartBrandId" width="60" headerAlign="center" header="品牌"></div>
                        <div allowSort="true" field="comApplyCarModel" width="60" headerAlign="center" header="品牌车型"></div>
                        <div allowSort="true" field="enterUnitId" width="40" headerAlign="center" header="单位"></div>
                        <div allowSort="true" datatype="float" field="orderQty" summaryType="sum" width="60" headerAlign="center" header="订单数量"></div>
                        <div allowSort="true" datatype="float" field="adjustQty" summaryType="sum" width="60" headerAlign="center" header="调整数量"></div>
                        <div allowSort="true" datatype="float" field="orderPrice" width="60" headerAlign="center" header="单价"></div>
                        <div allowSort="true" datatype="float" field="orderAmt" summaryType="sum" width="60" headerAlign="center" header="金额"></div>
                        <div allowSort="true" field="remark" width="60" headerAlign="center" header="备注"></div>
                    </div>
                </div>                  
                      
                
          </div>
             
      </div>
</div>



  <script type="text/javascript">
      nui.parse();
    </script>
</body>
</html>