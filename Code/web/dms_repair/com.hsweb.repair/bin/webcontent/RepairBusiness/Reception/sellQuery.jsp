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
<title>销售开单查询</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/sellQuery.js?v=1.0.0"></script>
<link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
<script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
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
 #wechatTag1{
    color:#ccc;
    }
#wechatTag{
    color:#62b900;
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
		                    <li iconCls="" onclick="quickSearch(10)" id="type10">本年</li>
		                    <li iconCls="" onclick="quickSearch(11)" id="type11">上年</li>
		                </ul>
                    <span class="separator"></span>
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="carNoSearch"/>
                    <input class="nui-textbox" id="partCode" emptyText="配件编码" width="120" onenter="carNoSearch"/>
                    <input class="nui-textbox" id="partName" emptyText="配件名称" width="120" onenter="carNoSearch"/>
                    <label class="form_label">结算日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
	                <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                     <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a> 
<!--                     <span class="separator"></span> -->
<!--                     <a class="nui-button" iconCls="" plain="true" onclick="addSell()" id="addBtn" ><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a> -->
<!--                     <a class="nui-button" iconCls="" plain="true" onclick="editSell()" id="editBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;查看</a> -->
<!-- <!--                <a class="nui-button" iconCls="" plain="true" onclick="out()" id="outBtn"><span class="fa fa-check fa-lg"></span>&nbsp;转出库</a>  --> 
<!--                     <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="finish"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a> -->
<!--                     <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="sellBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;转结算</a> -->
                </td>
            </tr>
        </table>
    </div>

    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               showPager="true"
               pageSize="500"
               totalField="page.count"
               sizeList=[500,1000,2000]
               dataField="list"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               onshowrowdetail="onShowRowDetail"
               allowCellEdit="true"
               allowCellWrap = "false"
               sortMode="client"
               showSummaryRow = "true"
               url="">
              <div property="columns">
                  <div type="indexcolumn" width="20">序号</div>
                  <div header="客户车辆信息" headerAlign="center">
                      <div property="columns" >	
		               <!--  <div field="id" headeralign="center" allowsort="true" visible="false" >主键</div> -->
		                <div field="contactName" name="contactName" headeralign="center" allowsort="false" visible="true" >客户名称</div>
		                <div field="contactMobile" headeralign="center" allowsort="false" visible="true" >客户手机</div>
		                <div field="carNo" name="carNo" headeralign="center" allowsort="false" visible="true" >车牌号</div>
		              <!--   <div field="carModel" name="carModel" headeralign="center" allowsort="false" visible="false">品牌车型</div> -->
		                <div field="carVin" headeralign="center" allowsort="true" visible="true">车架号(VIN)</div>
                      </div>
                    </div>
                   <div header="工单信息" headerAlign="center">
                      <div property="columns" >	
                          <div field="serviceCode" name="serviceCode" width="140" headerAlign="center" header="工单号"></div> 
                          <div field="recordDate" name="recordDate" width="100" headerAlign="center" header="开单日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                          <div field="partAmt" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="结算金额" dataType="floa"> </div>
                          <div field="outDate" name="outDate" width="100" headerAlign="center" header="结算日期" dateFormat="yyyy-MM-dd HH:mm"></div>
                          <div field="mtAdvisor" name="mtAdvisor" width="50" headerAlign="center" header="销售员"></div>
                          <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
                      </div>
                   </div>
                   <div header="配件信息" headerAlign="center">
                      <div property="columns" >	
                         <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div>
                         <div field="partCode" headerAlign="center" allowSort="false"  width="80px" header="配件编码" align="center"></div>
                         <!-- <div field="partCodel" headerAlign="center" allowSort="false" visible="false" width="80px" header="配件类型" align="center"></div> -->
                         <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="数量" name="partQty" summaryType="sum" > </div>
                         <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="销售单价" name="partUnitPrice" dataType="float"> </div>
                		 <div allowSort="true" summaryType="sum" allowSort="true" field="amt"   width="60"headerAlign="center" header="销售金额" dataType="float" align="left"></div>
               		     <div allowSort="true" summaryType="sum" allowSort="true" field="discountAmt"   width="60"headerAlign="center" header="优惠金额" dataType="float" align="left"></div>
               			 <div allowSort="true" summaryType="sum" allowSort="true" field="subtotal"   width="60"headerAlign="center" header="小计" dataType="float" align="left"></div>
<!--                          <div field="camt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center" header="成本" summaryType="sum" dataType="float"> </div>
                         <div field="mamt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center" header="毛利" summaryType="sum" dataType="float"> </div> -->
                      </div>
                   </div>
                 </div>
         </div>
  <div id="editFormDetail" style="display:none;padding:5px;position:relative;">
       <div id="innerPartGrid"
       dataField="data"
       class="nui-datagrid"
       style="width: 100%; height: 100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
           <div headerAlign="center" type="indexcolumn" width="20">序号</div>
           <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div> 
           <div field="partCode" headerAlign="center" allowSort="false"  width="80px" header="配件编码" align="center"></div>   
<!--            <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center"> </div> --> 
           <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="数量" name="partQty"> </div>
           <div field="unitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" header="单价" name="partUnitPrice"> </div>
	       <div field="amt" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center" header="金额"> </div>
	       <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
	       <div field="saleManId" headerAlign="center"  allowSort="false" visible="false" width="80" header="销售员" align="center"></div> 
      </div>
  </div>
</div>
</div>
<div id="exportDiv" style="display:none">  

</div>
</body>
</html>