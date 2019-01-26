<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
   <%@include file="/common/commonRepair.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-24 11:02:48
  - Description:
-->

<head>
    <title>项目销售明细表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%=webPath + contextPath%>/repair/js/sell/projectSaleReport.js?v=1.0.25"></script>
    <style>

        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
    </style>
</head>

<body>
  <div class="nui-toolbar" style="padding:2px;" id="form1">
        <table style="width:100%;">
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
                    结算日期:
                    <input class="nui-datepicker" id="startDate" name="startDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    至
                    <input class="nui-datepicker" id="endDate" name="endDate" dateFormat="yyyy-MM-dd" style="width:100px" />
                    <input class="nui-combobox" id="search-type" width="100" textField="name" valueField="id" value="0" data="statusList" allowInput="false"/>
                    <input class="nui-textbox" id="carNo-search" emptyText="输入查询条件" width="120" onenter="carNoSearch"/>
                            <input name="mtAdvisorId"
                                   id="mtAdvisorId"
                                   class="nui-combobox width1"
                                   textField="empName"
                                   valueField="empId"
                                   emptyText="服务顾问"
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100px"
                                   valueFromSelect="true"
                                   nullItemText="服务顾问" onenter="load()" onvaluechanged="load()"/>
                             <input name="mtAdvisorId"
                                   id="mtAdvisorId"
                                   class="nui-combobox width1"
                                   textField="empName"
                                   valueField="empId"
                                   emptyText="施工员"
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100px"
                                   valueFromSelect="true"
                                   nullItemText="施工员" onenter="load()" onvaluechanged="load()"/>
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
                                   nullItemText="销售员" onenter="load()" onvaluechanged="load()"/>
                             <input name="serviceTypeId"
                                   id="serviceTypeId"
                                   class="nui-combobox width1"
                                   textField="name"
                                   valueField="id"
                                   emptyText="项目类型"
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100px"
                                   valueFromSelect="true"
                                   nullItemText="项目类型" onenter="load()" onvaluechanged="load()"/>
                   			  <input class="nui-combobox" id="billTypeId" emptyText="综合开单" name="billTypeId" data="[{billTypeId:5,text:'全部工单'},{billTypeId:0,text:'综合开单'},{billTypeId:2,text:'洗美开单'},{billTypeId:4,text:'理赔开单'}]"
                          width="100px"  onvaluechanged="onSearch" textField="text" valueField="billTypeId" value="5"/>
                    <a class="nui-button" plain="true" onclick="onSearch()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="showDiv" class="tipStyle"></div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false"
            pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="data" onrowdblclick=""
            allowCellSelect="true" editNextOnEnterKey="true" onshowrowdetail="onShowRowDetail" url="" showSummaryRow="true" allowCellWrap=true>
            
            <div property="columns">
            	<div type="indexcolumn">序号</div>
	            	<div header="工单信息" headerAlign="center">
		                <div field="ct" name="ct" width="100" headerAlign="center" align="center" summaryType="sum">工单号</div>
		                <div field="totalPrefAmt" name="totalPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">车牌号</div>
		                <div field="allowanceAmt" name="allowanceAmt" width="100" headerAlign="center" align="center" summaryType="sum">工单类型</div>
		             </div>
		             <div header="项目信息" headerAlign="center">
		                <div field="balaAmt" name="balaAmt" width="100" headerAlign="center" align="center" summaryType="sum">业务类型</div>
		                <div field="pkgAmt" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum">项目名称</div>
		                <div field="pkgPrefAmt" name="pkgPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">工时 </div>
		                <div field="pkgSubtotal" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum">单价</div>
		                <div field="itemTotalAmt" name="itemTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum">优惠金额</div>
		                <div field="itemPrefAmt" name="itemPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">项目小计</div>
		                <div field="itemSubtotal" name="itemSubtotal" width="100" headerAlign="center" align="center" summaryType="sum">是否计次卡抵扣</div>
		             </div>
		                <div header="其他" headerAlign="center">
		                <div field="partTotalAmt" name="partTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum">进厂日期</div>
		                <div field="partPrefAmt" name="partPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">品牌车型</div>
		                <div field="partSubtotal" name="partSubtotal" width="100" headerAlign="center" align="center" summaryType="sum">服务顾问</div>
		 				<div field="partTrueCost"  width="70" headerAlign="center"  summaryType="sum">施工员</div>
		                <div field="cardTimesAmt" name="cardTimesAmt" width="100" headerAlign="center" align="center" summaryType="sum">销售员</div>       
					</div>
            </div>
        </div>
    </div>
</body>

</html>