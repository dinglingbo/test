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
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/sellMain.js?v=1.4.4"></script>
 <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
 <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
<style type="text/css">

.title {
  width: 60px;
  text-align: right;
}

.form_label {
	width: 72px;
	text-align: right;`
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
                    <a class="nui-menubutton " menu="#popupMenuStatus" id="menunamestatus">全部</a>
                    <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                        <li iconCls="" onclick="quickSearch(5)" id="type0">全部</li>
                        <li iconCls="" onclick="quickSearch(0)" id="type0">草稿</li>
                        <li iconCls="" onclick="quickSearch(1)" id="type0">待出库</li>
                        <li iconCls="" onclick="quickSearch(2)" id="type1">已出库</li>
                        <li iconCls="" onclick="quickSearch(3)" id="type2">待结算</li>
                        <li iconCls="" onclick="quickSearch(4)" id="type0">已结算</li>
                    </ul>
                    <span class="separator"></span>
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onenterCarNo(this.value)"/>
                    <label class="form_label">开单日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="addSell()" id="addBtn" ><span class="fa fa-plus fa-lg"></span>&nbsp;新增</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="editSell()" id="editBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;修改</a>
<!--                <a class="nui-button" iconCls="" plain="true" onclick="out()" id="outBtn"><span class="fa fa-check fa-lg"></span>&nbsp;转出库</a>  -->
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="finish()" id="finish"><span class="fa fa-check fa-lg"></span>&nbsp;审核</a> -->
                    <!-- <a class="nui-button" iconCls="" plain="true" onclick="pay()" id="sellBtn"><span class="fa fa-dollar fa-lg"></span>&nbsp;结算</a> -->
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
               allowCellWrap = "true"
               url="">
              <div property="columns">
                  <div type="indexcolumn">序号</div>
                  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
                  <div field="status" name="status" width="50" headerAlign="center" header="状态"></div>
                  <div field="serviceCode" name="serviceCode" width="130" headerAlign="center" header="工单号"></div>
                  <div field="contactName" name="contactName" width="80px" headerAlign="center" header="联系人姓名"></div>
                  <div field="contactMobile" name="contactMobile" width="100px" headerAlign="center" header="联系人手机"></div>
                  <div field="recordDate" name="recordDate" width="100" headerAlign="center" header="开单时间" dateFormat="  yyyy-MM-dd HH:mm"></div>
                  <div field="carNo" name="carNo" width="80" headerAlign="center" header="车牌号" ></div>
                  <div field="carVin" name="carVin" width="80" headerAlign="center" header="车架号(VIN)" ></div>
                  <div field="mtAdvisor" name="mtAdvisor" width="50" headerAlign="center" header="服务顾问"></div>
                  <div field="mtAdvisorId" name="mtAdvisorId" width="50" headerAlign="center" header="服务顾问" visible="false"></div>
                  <div field="partAmt" name="partAmt" width="40" headerAlign="center" header="结算金额"></div>
                  <div field="isSettle" name="isSettle" width="50" headerAlign="center" header="结算状态"></div>
	              <div field="remark" name="remark" width="100" headerAlign="center" header="备注" ></div>
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
</body>
</html>