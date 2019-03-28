<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/commonPart.jsp"%>
<html>
<!-- 
  - Author(s): chenziming
  - Date: 2018-02-01 17:11:06
  - Description:
-->
<head>
<title>月结对账</title>
<script src="<%=webPath + contextPath%>/manage/settlement/js/billStatement.js?v=1.1.3"></script>
		    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">
.title {
	width: 90px;
	text-align: right;
}

.title.required {
	color: red;
}

.mini-panel-border {
	/*border-right: 0;*/
	
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

<!-- 				<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(12)">草稿</a> -->
<!-- 				<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(13)">待发货</a> -->
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(14)">待收货</a> -->
<!--                 <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(15)">已入库</a> -->
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
                    <li class="separator"></li>
                    <!-- <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
                    <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li> -->
                </ul>
                
				<a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">未审</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                    <li iconCls="" onclick="quickSearch(12)" id="type12">未审</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">已审</li>
                    <!-- <li iconCls="" onclick="quickSearch(15)" id="type15">已入库</li> -->
                </ul>


				<label style="font-family:Verdana;">创建日期 从：</label>
                <input class="nui-datepicker" id="beginDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <label style="font-family:Verdana;">至</label>
                <input class="nui-datepicker" id="endDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                <span class="separator"></span> 

<!--                 <input id="partNameAndPY" width="100px" emptyText="配件名称/拼音" class="nui-textbox"/> -->
<!--                 <label style="font-family:Verdana;">配件编码：</label> -->
<!--                 <input id="partCode" width="100px" emptyText="配件编码" class="nui-textbox"/> -->
                <!-- <label style="font-family:Verdana;">订单单号：</label> -->
                 <input id="serviceId" width="100px" emptyText="对账单号" class="nui-textbox"/>
                 <input id="billServiceId" width="100px" emptyText="业务单号" class="nui-textbox"/>
                <!-- <label style="font-family:Verdana;">供应商：</label> -->
                <input id="searchGuestId" class="nui-buttonedit"
                       emptyText="请选择往来单位..."
                       onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" />
                <!-- <a class="nui-button" iconCls="icon-search" plain="true" onclick="onSearch()">查询</a>
                <span class="separator"></span>

                <a class="nui-button" plain="true" onclick="advancedSearch()">更多</a> --> 
                 <label style="font-family:Verdana;">对账类型：</label>
                 <input class="nui-combobox" id="settleTypeId" emptyText="应付月结" name="settleTypeId" data="[{settleTypeId:'020501',text:'应付现结'},{settleTypeId:'020502',text:'应付月结'}]"
                          width="80px"  onvaluechanged="onSearch" textField="text" valueField="settleTypeId" value="020502"/>          
                      <input name="serviceTypeId"
                                   id="serviceTypeId"
                                   class="nui-combobox width1"
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择业务类型..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="130px" 
                                   valueFromSelect="true"
                                   nullItemText="请选择..."
                                    visible="false"
                                   />
                <a class="nui-button" iconCls="" plain="true" onclick="onSearch()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                <span class="separator"></span>
<!--                 <a class="nui-button" plain="true" onclick="advancedSearch()"><span class="fa fa-ellipsis-h fa-lg"></span>&nbsp;更多</a> -->
                <a class="nui-button" iconCls="" plain="true" onclick="add()" id="addBtn"><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>

            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
    <input class="nui-hidden" name="auditSign" id="auditSign"/>
	<input class="nui-hidden" name="billStatusId" id="billStatusId"/>
    <div id="rightGrid" class="nui-datagrid" style="width:100%;height:100%;"
         showPager="true"
         dataField="list"
         idField="detailId"
         ondrawcell="onDrawCell"
         sortMode="client"
         url=""
         pageSize="10000"
         sizeList="[1000,5000,10000]"
         selectOnLoad="true"
         onshowrowdetail="onShowRowDetail"
         allowCellWrap = true
         showSummaryRow="true">
        <div property="columns"> 
                <div type="indexcolumn">序号</div>
                <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                <div field="guestName" name="guestName" width="150" headerAlign="center" header="往来单位"></div>
                <div field="settleTypeId" name="settleTypeId" width="60" headerAlign="center" header="对账类型"></div>
                <div field="createDate" width="60px" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="对账日期"></div>
                <div field="stateMan" name="stateMan" width="60" headerAlign="center" header="对账员"></div><div field="auditSign" width="35" headerAlign="center" header="状态"></div>
                <div field="serviceId" headerAlign="center" width="150" header="对账单号"></div>
                <div field="auditor" name="auditor" width="60" headerAlign="center" header="审核人"></div>
                <div field="auditDate" width="60" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
        </div>
      </div>
 </div> 


<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

   <div id="innerPartGrid"
       dataField="detailList"
       allowCellWrap = true
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
          <div type="indexcolumn">序号</div>
          <div type="checkcolumn" width="20"></div>
          <div field="typeCode" width="60" headerAlign="center" header="业务类型"></div>
          <div field="billAmt" width="60" headerAlign="center" summaryType="sum" header="金额"></div>
          <div field="orderMan" width="60" headerAlign="center" header="业务员"></div>
          <div allowSort="true" field="billDate" headerAlign="center" header="审核日期" dateFormat="yyyy-MM-dd HH:mm"></div>
          <div field="remark" width="120" headerAlign="center" header="备注"></div>
          <div allowSort="true" summaryType="count" field="billServiceId" width="150" summaryType="count" headerAlign="center" header="业务单号"></div>
      </div>
   </div>
</div>

</body>
</html>
