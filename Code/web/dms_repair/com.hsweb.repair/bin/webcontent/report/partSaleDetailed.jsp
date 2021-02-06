<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 17:02:13
  - Description:
-->

<head>
    <title>配件销售明细表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%=request.getContextPath()%>/repair/js/report/storeReport/partSaleDetailed.js?v=1.0.4"></script>

    <link href="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.css" rel="stylesheet" type="text/css" />
    <script src="<%=webPath + contextPath%>/frm/js/finance/HeaderFilter.js" type="text/javascript"></script>
    
</head>
<style type="text/css">
    body {
        margin: 0;
        padding: 0;
        border: 0;
        width: 100%;
        height: 100%;
        overflow: hidden;
    }
</style>

<body>
    <input name="serviceTypeId" id="serviceTypeId" class="nui-combobox " textField="name" valueField="id" visible="false" />
    <div id="form1" class="mini-toolbar" style="padding:10px;">
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
                    结算日期:
                    <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    至
                    <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="onSearch()"/>
                            <input name="mtAdvisorId"
                                   id="mtAdvisorId"
                                   class="nui-combobox width1"
                                   textField="empName"
                                   valueField="empId"
                                   emptyText="销售员"
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100px"
                                   valueFromSelect="true"
                                   nullItemText="销售员" onenter="onSearch()" onvaluechanged="onSearch()"/>

                   			  <input class="nui-combobox" id="billTypeId" emptyText="综合开单" name="billTypeId" data="[{billTypeId:5,text:'全部工单'},{billTypeId:0,text:'综合开单'},{billTypeId:2,text:'洗美开单'},{billTypeId:4,text:'理赔开单'}]"
                          width="100px"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="5"/>
                    <a class="nui-button" plain="true" onclick="onSearch()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
    </div>

    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="list" allowcelledit="true" url="" allowcellwrap="true"                allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = "true"     pageSize="500"
    			sizeList="[500,1000,2000]"
               showSummaryRow = "true" style="width:100%;height:100%;"
           		 totalField="page.count"> 
            		<div property="columns" >	
            		<div type="indexcolumn" header="序号" width="40px"></div>
			            <div header="工单信息" headerAlign="center">
				             <div property="columns" >	
				                <div field="serviceCode" name="serviceCode" headeralign="center" width="170" align="center">工单号</div>
				                <div field="billTypeId" name="serviceTypeId" headeralign="center" width="80" align="center">工单类型</div>
				                <div field="guestName" name="guestName" headeralign="center" width="100" align="center">客户名称</div>
				                <div field="carNo" name="carNo" headeralign="center" width="80" align="center">车牌号</div>
				                <div field="carModel" name="carModel" headeralign="center" width="200" align="center" width="160">品牌车型</div>
							</div>
						</div>
	                
	                
 			            <div header="配件信息" headerAlign="center">
				             <div property="columns" >	   
				                <div field="partName" name="partName" headeralign="center" width="100" align="center">配件名称</div>                        
				          		<div field="partCode" name="partCode" headeralign="center" width="100" align="center">配件编码</div> 
				                <div field="qty" name="qty" headeralign="center" width="150" align="center" summaryType="sum">数量</div>
				                <div field="unitPrice" name="unitPrice" headeralign="center" width="80" align="center" summaryType="sum">销售单价</div>
				                <div field="amt" name="amt" headeralign="center" width="80" align="center" summaryType="sum">销售金额</div>
				                <div field="discountAmt" name="discountAmt" headeralign="center" width="80" align="center" summaryType="sum">优惠金额</div>
<!-- 				                <div field="partTrueCost" name="partTrueCost" headeralign="center" width="80" align="center" summaryType="sum">配件成本 </div> -->

				                <div field="subtotal" name="subtotal" headeralign="center" width="80" align="center" summaryType="sum">配件小计</div>
				                <div field="mtAdvisor" name="mtAdvisor" headeralign="center" width="100" align="center">服务顾问</div>
				                <div field="saleMan" name="saleMan" headeralign="center" width="100" align="center">销售员</div>
				                <div field="outDate" name="outDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd">结算日期</div>
							</div>
						</div>
	 		</div>
        </div>
     </div>
</body>

</html>