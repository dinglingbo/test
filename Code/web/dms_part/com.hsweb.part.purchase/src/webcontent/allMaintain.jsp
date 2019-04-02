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
<title>全部工单明细表</title>
<script src="<%=webPath + contextPath%>/purchasePart/js/inventoryMgr/allMaintain.js?v=1.2.4"></script>
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

</style>

</head>
<body>

<div class="nui-fit">
    <div class="nui-toolbar" style="padding:2px;border-bottom:0;">
        <table class="table" id="table1">
            <tr>
                <td>
<!--     	<label style="font-family:Verdana;">快速查询：</label>
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
        <span class="separator"></span> -->
                             查询类型:<input class="nui-combobox" id="seachType"  name="seachType" data="[{seachType:0,text:'今日进厂'},{seachType:1,text:'今日结算车次'},{seachType:2,text:'今日在修车辆'}]"
                          width="100px"  onvaluechanged="doSearch('setInitData')" textField="text" valueField="seachType" value="0"/>
        <label style="font-family:Verdana;">进厂日期 从：</label>
        <input class="nui-datepicker" id="sEnterDate" name="sEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>
        <label style="font-family:Verdana;">至</label>
        <input class="nui-datepicker" id="eEnterDate" name="eEnterDate" allowInput="false" width="100px" format="yyyy-MM-dd"  showTime="false" showOkButton="false" showClearButton="false"/>
                     工单类型:<input class="nui-combobox" id="billTypeIdList" emptyText="综合开单" name="billTypeIdList" data="[{billTypeId:0,text:'综合开单'},{billTypeId:2,text:'洗美开单'},{billTypeId:4,text:'理赔开单'},{billTypeId:6,text:'波箱开单'}]"
                        width="100px"     multiSelect="true" textField="text" valueField="billTypeId" />
                          
                    维修进程:<input class="nui-combobox" id="statusId" emptyText="综合开单" name="statusId" data="[{billTypeId:999,text:'全部进程'},{billTypeId:0,text:'报价'},{billTypeId:1,text:'施工'},{billTypeId:2,text:'完工'}]"
                          width="100px"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="999"/>
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="carNoSearch"/>
                    审核状态:<input class="nui-combobox" id="auditSign"  name="auditSign" data="[{billTypeId:999,text:'全部'},{billTypeId:0,text:'未审核'},{billTypeId:1,text:'已审核'}]"
                          width="100px"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="999"/>
                    <br>
                    服务顾问：<input name="mtAdvisorId" id="mtAdvisorId" class="nui-combobox width1" textField="empName" valueField="empId"
                        emptyText="服务顾问" url=""  allowInput="true" showNullItem="false" width="90" valueFromSelect="true"/>
<!--             <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/> -->
 
<!--   进厂日期:
                    <input id="sEnterDate" name="sEnterDate" class="nui-datepicker"/>
至:
                    <input id="eEnterDate" name="eEnterDate" class="nui-datepicker"
                           format="yyyy-MM-dd"
                           timeFormat="H:mm:ss"
                           showTime="false"
                           showOkButton="false"
                           showClearButton="false"/> -->
                    <a class="nui-button" iconCls="" plain="true" onclick="onSearch"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
<!--                     <span class="separator"></span>
                    <a class="nui-button" iconCls="" plain="true" onclick="edit()" id="addBtn"><span class="fa fa-edit fa-lg"></span>&nbsp;查看</a>    -->         
                </td>
            </tr>
        </table>
    </div>


    <div class="nui-fit">
          <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;"
               selectOnLoad="true"
               pageSize="500"
               totalField="page.count"
               sizeList=[500,1000,2000]
               dataField="data"
               showModified="false"
               onrowdblclick=""
               allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = "true"
               showSummaryRow = "true"
               showPager = "false"
               sortMode="client"
               onshowrowdetail="onShowRowDetail"
               url="">
             	<div property="columns">
				<div type="indexcolumn" width="40" >序号</div>
                  <div header="工单信息" headerAlign="center">
                  	 <div property="columns" >
	                  <div type="checkcolumn" name="checkcolumn" visible="false"></div>  
	                  <div type="expandcolumn" width="20" ><span class="fa fa-plus fa-lg"></span></div> 
	                  <div field="serviceCode" name="serviceCode" width="170" headerAlign="center" header="工单号" summaryType="count" allowsort="true"></div>
	                  <div field="status" name="status" width="70px" headerAlign="center" header="进程" allowsort="true"></div> 
	                  <div field="serviceTypeName" name="serviceTypeName" width="120" headerAlign="center" header="业务类型" allowsort="true"></div>
	                  <div field="isSettle" name="isSettle" width="120" headerAlign="center" header="审核状态" allowsort="true"></div>
	                  <div field="mtAdvisor" name="mtAdvisor" width="100" headerAlign="center" header="服务顾问" allowsort="true"></div>
	                 </div>
                  </div>
                  <div header="客户/车辆信息" headerAlign="center">
	                  <div property="columns" >	                  
		                  <div field="guestFullName" name="guestFullName" width="110" headerAlign="center" header="客户名称" allowsort="true"></div>
		                  <div field="carNo" name="carNo" width="110" headerAlign="center" header="车牌号" allowsort="true"></div>
		                  <div field="carModel" name="carModel" width="120" headerAlign="center" header="品牌/车型" allowsort="true"></div>
		                  
		                  <div field="carVin" name="carVin" width="150" headerAlign="center" header="车架号(VIN)" allowsort="true"></div>
		                   
		                <!--   <div field="enterKilometers" name="enterKilometers" width="80" headerAlign="center" header="进厂里程" allowsort="true"></div> -->
		                  
<!-- 		                  <div field="guestMobile" name="guestMobile" width="90" headerAlign="center" header="客户手机" allowsort="true"></div> -->
	                  </div>
                  </div>
               
                  <div header="估算费用信息" headerAlign="center">
	                  <div property="columns" >	                  
		                  <div field="packageSubtotal" name="status" width="90" headerAlign="center" summaryType="sum" header="套餐销售小计" allowsort="true" dataType="int"></div>
		                  <div field="itemSubtotal" name="carNO" width="90" headerAlign="center" summaryType="sum" header="项目销售小计" allowsort="true" dataType="int"></div>
		                  <div field="partSubtotal" name="carBrandId" width="90" headerAlign="center" summaryType="sum"  header="配件销售小计" allowsort="true" dataType="int"></div>
		                  <div field="total" name="carBrandId" width="70" headerAlign="center" summaryType="sum"  header="合计" allowsort="true" dataType="int"></div>
	<!-- 	                  <div field="cardTimesAmt" name="cardTimesAmt" width="70" headerAlign="center" summaryType="sum"  header="预存抵扣" allowsort="true"></div>
		                  <div field="totalPrefAmt" name="carVin" width="70" headerAlign="center" summaryType="sum"  header="优惠金额" allowsort="true"></div>
		                  <div field="otherAmt" name="guestFullName" width="70" headerAlign="center" summaryType="sum"  header="其它费用收入" allowsort="true"></div>
		                  <div field="otherCostAmt" name="guestMobile" width="70" headerAlign="center" summaryType="sum"  header="其它费用支出" allowsort="true"></div> -->
	                  </div>
                  </div>
                  <div header="优惠信息" headerAlign="center">
	                  <div property="columns" >	 	                 
	                  	  <div field="packagePrefAmt" name="packagePrefAmt" width="70" headerAlign="center" allowsort="true" summaryType="sum" header="套餐优惠" dataType="float"></div>                 	                  
	                  	  <div field="itemPrefAmt" name="itemPrefAmt" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="项目优惠" dataType="float"></div> 	                  	
	                  	  <div field="partPrefAmt" name="partPrefAmt" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="配件优惠" dataType="float"></div>		                  

		              </div>
		           </div>      
<!-- 		           <div header="成本" headerAlign="center">
	                  <div property="columns" >	
	                  	  <div field="partTaxCost"  width="70" headerAlign="center" summaryType="sum" allowsort="true" header="配件含税成本" dataType="float"></div>
	                  	  <div field="partNoTaxCost"  width="70" headerAlign="center" summaryType="sum" allowsort="true" header="配件不含税成本" dataType="float"></div>
		                  <div field="partTrueCost"  width="70" headerAlign="center" summaryType="sum" allowsort="true" header="配件实际成本" dataType="float"></div>
		                  <div field="salesDeductValue" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="销售提成" dataType="float"></div>
		                  <div field="advisorDeductValue"  width="70" headerAlign="center" summaryType="sum" allowsort="true" header="服务顾问提成" dataType="float"></div>
		                  <div field="techDeductValue"  width="70" headerAlign="center"  summaryType="sum" allowsort="true" header="施工员提成" dataType="float"></div>
		                  <div field="otherCostAmt" name="guestMobile" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="其它费用支出" dataType="float"></div>
		                  <div field="expenditureTotal" name="expenditureTotal" width="70" headerAlign="center" allowsort="true" summaryType="sum" header="成本合计" dataType="float"></div>
		                  <div field="allowanceAmt" name="allowanceAmt" width="70" headerAlign="center" allowsort="true" summaryType="sum" header="其他优惠" dataType="float"></div>
		             
            		  </div>
		           </div>  --> 
		            <div header="结算信息" headerAlign="center">
	                  <div property="columns" >		
	                  		<div field="otherAmt" name="" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="其他费用收入" dataType="float"></div>
		                  <div field="incomeTotal" name="incomeTotal" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="收入合计" dataType="float"></div>
	                  	  <div field="netinAmt" name="netinAmt" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="营收金额" dataType="float"></div>	
		                  <div field="cardTimesAmt" name="cardTimesAmt" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="计次卡抵扣" dataType="float"></div>
	                  	  <div field="balaAmt" name="contactName" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="结算金额" dataType="float"></div>	
	                  	 <!--  <div field="totalPrefRate" name="totalPrefRate" width="70" headerAlign="center" summaryType="sum" allowsort="true" header="整单优惠率"></div> 	 -->                  	                 
		                 <!--  <div field="totalPrefAmt" name="totalPrefAmt" width="70" headerAlign="center" allowsort="true" header="整单优惠金额"></div> -->
		                  <div field="grossProfit"  width="70" headerAlign="center" summaryType="sum" allowsort="true" header="毛利" dataType="float"></div>
		                  <div field="grossProfitRate"  width="70" headerAlign="center" numberFormat="p" allowsort="true"  header="毛利率" dataType="float"></div>
		                  <div field="grossProfitRemark"  width="70" headerAlign="center" allowsort="true" header="毛利备注"></div>		                  
	                  </div>
                  </div>
                  
                   <div header="其他" headerAlign="center">
	                  <div property="columns" >
		                 <!--  <div field="carBrandId" name="carBrandId" width="60" headerAlign="center" header="品牌" allowsort="true"></div> 
		                  <div field="carVin" name="carVin" width="130" headerAlign="center" header="车架号(VIN)" allowsort="true"></div> -->
		                  <div field="enterDate" name="enterDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="进厂日期" allowsort="true"></div>
		                  <div field="checkDate" name="checkDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="完工日期" allowsort="true"></div>
		                  <div field="settleDate" name="settleRecordDate" width="120" headerAlign="center" dateFormat="yyyy-MM-dd HH:mm" header="结算日期" allowsort="true"></div>
		                  <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
	                  </div>
                  </div>
                  
              </div>
          </div>
    </div>
</div>

<div id="editFormDetail" style="display:none;padding:5px;position:relative;">

  <div  id="innerpackGrid" class="nui-datagrid"
	    style="width:1000px;height:100px;"
	    dataField="data"
	    showPager="false"
	    showModified="false"
	    allowSortColumn="false" >
      <div property="columns">
    	   <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
           <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
           <div field="prdtName" headerAlign="center" allowSort="false" visible="true" width="100" header="套餐名称"></div>
           <div field="type" headerAlign="center" allowSort="false" visible="true" width="60" header="项目类型" align="center"></div>    
           <div field="serviceTypeId" headerAlign="center" name="pkgServiceTypeId" allowSort="false" visible="true" width="50" header="业务类型" align="center"> </div>
           <div field="subtotal" headerAlign="center" name="pkgSubtotal" allowSort="false" visible="true" width="60" header="套餐金额" align="center" ></div>
           <div field="rate" headerAlign="center" name="pkgRate" allowSort="false" visible="true" width="60" header="优惠率" align="center"></div>
           <div field="amt" headerAlign="center" name="pkgAmt"  allowSort="false" visible="true" width="60" header="原价" align="center"></div>
           <div field="workers" headerAlign="center"  allowSort="false" visible="true" width="60" header="施工员" align="center" name="workers"></div>
           <div field="workerIds" headerAlign="center" allowSort="false" visible="false" width="80" header="施工员" align="center"></div>  
           <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
           <div field="saleManId" headerAlign="center" allowSort="false" visible="false" width="80" header="销售员" align="center"></div>
     </div>
   </div>
   <div id="innerItemGrid"
       borderStyle="border-bottom:0;"
       class="nui-datagrid"
       dataField="data"
       style="width: 1000px;height:100px;"
       showPager="false"
       allowSortColumn="true">
      <div property="columns">
           <div type="indexcolumn" headerAlign="center" name="index" visible="false">序号</div>
           <div headerAlign="center" field="orderIndex" width="25" align="right" name="num">序号</div>
           <div field="prdtName" headerAlign="center" allowSort="false" visible="true" width="100">项目名称</div>
	       <div field="serviceTypeId" headerAlign="center" allowSort="false" visible="true" width="60" align="center">业务类型 </div>
	       <div field="qty" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" name="itemItemTime">工时/数量 </div>
	       <div field="unitPrice" name="itemUnitPrice" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center">单价 </div>
	       <div field="rate" name="itemRate" headerAlign="center" allowSort="false" visible="true" width="60" datatype="float" align="center" >优惠率</div>            
	       <div field="subtotal"  name="itemSubtotal" headerAlign="center" allowSort="false" visible="true" width="70" datatype="float" align="center">金额</div>          
	       <div field="amt"  name="amt" headerAlign="center" allowSort="false" visible="false" width="70" datatype="float" align="center">总金额 </div>           
           <div field="workers" headerAlign="center" allowSort="false" visible="true" width="80" header="施工员" name="workers"  align="center"></div>
	       <div field="workerIds" headerAlign="center"  allowSort="false" visible="false" width="80" header="施工员" align="center"></div>  
	       <div field="saleMan" headerAlign="center" allowSort="false" visible="true" width="50" header="销售员" align="center" name="saleMan"></div>
	       <div field="saleManId" headerAlign="center"   allowSort="false" visible="false" width="80" header="销售员" align="center"></div> 
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
            
            <input name="carBrandId"
                id="carBrandId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
           <input name="serviceTypeId"
                id="serviceTypeId" visible="false"
                class="nui-combobox"
                textField="name"
                valueField="id"/>
            <tr>
                <td class="title">创建日期:</td>
                <td>
                    <input id="sRecordDate"
                           name="sRecordDate"
                           width="100%"
                           class="nui-datepicker"/>
                </td>
                <td class="">至:</td>
                <td>
                    <input id="eRecordDate"
                           name="eRecordDate"
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
                <td class="title">业务类型:</td>
                <td colspan="3">
                    <div id="serviceTypeIds" name="serviceTypeIds" class="nui-checkboxlist" repeatItems="5" 
                    repeatLayout="flow"  value="" 
                    textField="name" valueField="id" ></div>
                </td>
            </tr>
        </table>
        <div style="text-align:center;padding:10px;">
            <a class="nui-button" onclick="onAdvancedSearchCancel" style="width:60px;">取消</a>
            <a class="nui-button" onclick="onAdvancedSearchOk" style="width:60px;margin-right:20px;">确定</a>
        </div>
    </div>
</div>

</body>
</html>