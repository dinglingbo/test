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
    <title>销售提成明细表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <%@include file="/common/commonRepair.jsp"%>
    <script src="<%=request.getContextPath()%>/repair/js/report/storeReport/salePerformanceDetail.js?v=1.0.0"></script>

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

                   			 <!--  <input class="nui-combobox" id="billTypeId" emptyText="综合开单" name="billTypeId" data="[{billTypeId:5,text:'全部工单'},{billTypeId:0,text:'综合开单'},{billTypeId:2,text:'洗美开单'},{billTypeId:4,text:'理赔开单'}]"
                          width="100px"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="5"/> -->
                    <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                    <a class="nui-button" plain="true" onclick="onSearch()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    <a class="nui-button" iconCls="" plain="true" onclick="onExport()" id="exportBtn"><span class="fa fa-level-up fa-lg"></span>&nbsp;导出</a>
    </div>


    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="list" allowcelledit="true" url="" allowcellwrap="true"                allowCellSelect="true"
               editNextOnEnterKey="true"
               allowCellWrap = "true"     pageSize="500" sortMode="client"
    			sizeList="[500,1000,2000]"
               showSummaryRow = "true" style="width:100%;height:100%;"
           		 totalField="page.count"> 
            		<div property="columns" >	
            		<div type="indexcolumn" header="序号" width="40px"></div>
		                    <div header="提成信息" headerAlign="center"> 
		                    <div property="columns" >	
					          <div field="worker" name="worker" headeralign="center" width="100" align="center" allowsort="true" >销售员</div>
					          <div field="deductWorkerValue" name="deductWorkerValue" headeralign="center" width="80" align="center" dataType="float" summaryType="sum" allowsort="true" >销售员提成</div>
					        </div>
				        </div>
				     	<div header="业务信息" headerAlign="center"> 
		                    <div property="columns" >   
					          <div field="serviceCode" name="serviceCode" headeralign="center" width="170" align="center" summaryType="count" allowsort="true" >工单号</div>
					          <div field="billTypeId" name="billTypeId" headeralign="center" width="80" align="center" allowsort="true" >工单类型</div>
					          <div field="serviceTypeId" name="serviceTypeId" headeralign="center" width="80" align="center" allowsort="true" >业务类型</div>
					          <div field="carNo" name="carNo" headeralign="center" width="80" align="center" allowsort="true" vistable="false" >车牌号</div>
					          <div field="recordDate" name="recordDate" headeralign="center" width="100" align="center" dateFormat="yyyy-MM-dd" allowsort="true" >结算日期</div>
					          <div field="orgid" name="orgid" width="130" headerAlign="center"  header="所属公司" allowsort="true"></div>
							</div>
						</div>

	 		</div>
        </div>
     </div>
<div id="exportDiv" style="display:none">  

</div> 
</body>

</html>