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
<title>业务单选择</title>
<script src="<%=webPath + contextPath%>/settlement/js/expenseSelect.js?v=1.0.0"></script>
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


<div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
      <table style="width:100%;">
          <tr>
              <td style="white-space:nowrap;">
                  <label style="font-family:Verdana;">审单日期 从：</label>
                  <input class="nui-datepicker" id="sBillAuditDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>
                  <label style="font-family:Verdana;">至</label>
                  <input class="nui-datepicker" id="eBillAuditDate" allowInput="false" width="100px" format="yyyy-MM-dd" showTime="false" showOkButton="false" showClearButton="false"/>

                  <span class="separator"></span> 
                  <input id="searchBillGuestId" class="nui-buttonedit"
                         emptyText="请选择往来单位..." visible="false"
                         onbuttonclick="selectSupplier('searchBillGuestId')" selectOnFocus="true" />
                  <input id="billServiceId" width="120px" emptyText="业务单号" class="nui-textbox"/>
                  <input id="billServiceMan" width="60px" emptyText="业务员" class="nui-hidden"/>
                  <input id="orderTypeIdList" width="60px" emptyText="" class="nui-hidden"/>
                  <!-- <input id="searchGuestId" class="nui-buttonedit"
                         emptyText="请选择往来单位..."
                         onbuttonclick="selectSupplier('searchGuestId')" selectOnFocus="true" /> -->
                  <input class="nui-combobox" visible="false" name="accountSign" id="accountSign" value="0"
                       emptyText="单据状态" data="accountList" width="70px" />
                  <a class="nui-button" iconCls="" plain="true" onclick="searchBill()"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                  
                  <span class="separator"></span>
                  <a class="nui-button" iconCls="" plain="true" onclick="addStatement()"><span class="fa fa-check fa-lg"></span>&nbsp;选入</a>
                  <a class="nui-button" iconCls="" plain="true" onclick="onCancel()"><span class="fa fa-close fa-lg"></span>&nbsp;取消 </a>
				 
				  <span id ="sumAmt"></span>
				  &nbsp;
				  <span  id ="sumNoStateAmt"></span>
                  <input class="nui-combobox" name="billTypeId" id="billTypeId"
                       emptyText="票据类型" data="" width="60px" visible="false" />
                  <input class="nui-combobox" name="settleTypeId" id="settleTypeId" 
                       emptyText="结算方式" data="" width="60px" visible="false" />
              </td>
          </tr>
      </table>
  </div>
  <div class="nui-fit">
      
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
             showPager="true"
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
                <div type="indexcolumn" width="10">序号</div>
                <div type="checkcolumn" field="check" width="25"></div>
                <div field="fullName" summaryType="count" width="60" headerAlign="center" header="业务往来单位名称"></div>
                <div field="billServiceId" summaryType="count" width="120" headerAlign="center" header="业务单号"></div>
                <div field="expenseTypeCode" type="comboboxcolumn" width="50" headerAlign="center" header="费用类型"></div>
                <div field="expenseAmt" width="40" summaryType="sum" headerAlign="center" header="应付"></div>
                <div field="noStateAmt" width="50" summaryType="sum" headerAlign="center" header="未对账金额"></div>
                <div field="logisticsNo" width="80" headerAlign="center" header="物流单号"></div>
                <div field="remark" width="80" headerAlign="center" header="备注"></div>
                <div field="settleTypeId" type="comboboxcolumn" width="50" headerAlign="center" header="结算方式" visible="false"></div>
                <div allowSort="true" field="auditDate" width="60" headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="审核日期"></div>
                <div allowSort="true" field="auditor" width="60" headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="审核人"></div> 
                <div allowSort="true" field="createDate" width="60" headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="创建日期"></div>
                <div allowSort="true" field="creator" width="60" headerAlign="center" visible="true" dateFormat="yyyy-MM-dd HH:mm" header="创建人"></div>     
            </div>  
          
        </div>
  </div>
  

</div>


</body>
</html>
