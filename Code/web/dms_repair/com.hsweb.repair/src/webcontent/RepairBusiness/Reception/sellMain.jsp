<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false"%>
<%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-01-25 14:17:08
  - Description:
-->
<head>
<title>销售开单</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/sellMain.js?v=1.1.9"></script>
<style type="text/css">

.title {
  width: 60px;
  text-align: right;
}

.form_label {
	width: 72px;
	text-align: right;
}

.required {
	color: red;
}

.rmenu {
    font-size: 14px;
    /* font-weight: bold; */
    text-align: left;
    margin: 0;
    padding-left: 25px;
    height: 18px;
    color: #fff;
    width: auto;
    margin-left: 20px;
    margin-top: 20px;
    background-size: 50%;
}

</style>

</head>
<body>

<div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="table1">
            <tr>
                <td>
                    <label style="font-family:Verdana;">快速查询：</label>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(0)">草稿</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(1)">待出库</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(2)">已出库</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(3)">待结算</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="quickSearch(4)">已结算</a>
                	<a class="nui-button" iconCls="" plain="true" onclick="quickSearch(5)">全部</a>
                    
                    <span class="separator"></span>
                    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
                    <label class="form_label">开单日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="addSell()" id="addBtn" ><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="editSell()" id="editBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="out()" id="outBtn"><span class="fa fa-check fa-lg"></span>&nbsp;转出库</a> -->
                    <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="finish"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="sellBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;转结算</a>
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="50"
               totalField="page.count"
               sizeList=[20,50,100,200]
               dataField="list"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               allowCellEdit="true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                  <div field="guestFullName" name="guestFullName" width="55" headerAlign="center" header="客户姓名"></div>
                  <div field="guestMobile" name="guestMobile" width="80" headerAlign="center" header="客户手机"></div>
                  <div field="carNO" name="carNO" width="80" headerAlign="center" header="车牌"></div>           
                  <div field="carModel" name="carModel" width="180" headerAlign="center" header="车型"></div>
                  <div field="partAmt" name="partAmt" width="40" headerAlign="center" header="金额"></div>
                  <div field="isSettle" name="isSettle" width="50" headerAlign="center" header="结算状态"></div>
                  <div field="status" name="status" width="50" headerAlign="center" header="状态"></div>
                  <div field="recorder" name="recorder" width="50" headerAlign="center" header="销售员"></div>
	              <div field="serviceCode" name="serviceCode" width="110" headerAlign="center" header="工单号"></div>
	              <div field="recordDate" name="recordDate" width="100" headerAlign="center" header="开单日期" dateFormat="yyyy-MM-dd H:mm:ss"></div>
                 </div>
         </div>
      <div id="editFormDetail" style="display:none;padding:5px;position:relative;">
         <div id="innerPartGrid"
           dataField="list"
           class="nui-datagrid"
           style="width: 100%; height: 100px;"
           showPager="false"
           allowSortColumn="true">
        <div property="columns">
          <div headerAlign="center" type="indexcolumn" width="30">序号</div>
          <div field="partName" headerAlign="center" allowSort="true" visible="true" width="100">零件名称</div>
          <div field="receTypeId" headerAlign="center" allowSort="true" visible="true" width="80">收费类型</div>
          <div field="qty" headerAlign="center" allowSort="true" visible="true" width="80" datatype="int" align="right">数量</div>
          <div field="unitPrice" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">单价</div>
          <div field="amt" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right">金额</div>
          <div field="rate" headerAlign="center" allowSort="true" visible="true" width="80" datatype="float" align="right" numberFormat="p">优惠率</div>
          <div field="discountAmt" headerAlign="center" allowSort="true" visible="true" width="100" datatype="float" align="right">优惠金额</div>
          <div field="partCode" headerAlign="center" allowSort="true" visible="true" width="">零件编码</div>
       </div>
    </div>
   </div>
</div>

</div>
</body>
</html>