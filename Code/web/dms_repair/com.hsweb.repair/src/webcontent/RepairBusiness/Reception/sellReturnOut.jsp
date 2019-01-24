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
<title>退货归库</title>
<script src="<%=webPath + contextPath%>/repair/js/RepairBusiness/Reception/sellReturnOut.js?v=1.0.37"></script>
 <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" 
rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" 
type="text/javascript"></script>
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
a { 
    text-decoration: none;
}
 a#service{
	text-decoration:underline
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
                    
                    <a class="nui-menubutton " menu="#popupMenuDate" id="menunamedate">本月</a>

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
                
				<a class="nui-menubutton " menu="#popupMenuStatus" id="menubillstatus">待归库</a>

                <ul id="popupMenuStatus" class="nui-menu" style="display:none;">
                	<li iconCls="" onclick="quickSearch(14)" id="type14">所有</li>
                    <li iconCls="" onclick="quickSearch(12)" id="type12">待归库</li>
                    <li iconCls="" onclick="quickSearch(13)" id="type13">已归库</li>
                </ul>
                    
                    <span class="separator"></span>
                    <input class="nui-hidden" name="status" id="status"/>
                    <input class="nui-combobox" id="search-type" width="80" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120"/>
                    <label class="form_label">退货日期&nbsp;从：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"  allowInput="false" name="startDate" id = "sRecordDate" value=""/>
	                <label class="form_label">至：</label>
	                <input format="yyyy-MM-dd"  style="width:100px"  class="mini-datepicker"   allowInput="false" name="endDate" id = "eRecordDate" value=""/>
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>

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
                  <div type="indexcolumn" width="15">序号</div>
                  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div>
  	              <div field="status" name="status" width="50" headerAlign="center" header="状态"></div>
  	              <div field="serviceCode" name="serviceCode" width="110" headerAlign="center" header="工单号"></div>
                  <div field="guestFullName" name="guestFullName" width="55" headerAlign="center" header="客户姓名"></div>
<!--                   <div field="guestMobile" name="guestMobile" width="80" headerAlign="center" header="客户手机"></div> -->
                  <div field="carNO" name="carNO" width="80" headerAlign="center" header="车牌" visible="false"></div>           
                  <div field="carModel" name="carModel" width="180" headerAlign="center" header="品牌车型" visible="false"></div>
                  <div field="partAmt" name="partAmt" width="40" headerAlign="center" header="金额"></div>
                  <div field="isSettle" name="isSettle" width="50" headerAlign="center" header="结算状态"></div>
                  <div field="recorder" name="recorder" width="50" headerAlign="center" header="销售员"></div>   
	              <div field="recordDate" name="recordDate" width="100" headerAlign="center" header="退货日期" dateFormat="  yyyy-MM-dd HH:mm"></div>
	              <div field="remark"  width="170" headerAlign="center" header="备注" ></div>
	              <div field="action" name="action" width="40" headerAlign="center" header="操作" align="center" align="center"></div>
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
           <div headerAlign="center" type="indexcolumn" width="15">序号</div>
           <div field="partName" headerAlign="center" allowSort="false" visible="true" width="100" header="配件名称"></div> 
           <div field="partCode" headerAlign="center" allowSort="false"  width="80px" header="配件编码" align="center"></div>   
<!--            <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" header="业务类型" align="center"> </div> --> 
           <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="int" align="center" header="退货数量" name="partQty"> </div>
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