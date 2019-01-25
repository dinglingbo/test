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
                <div field="id" name="id" visible="false" width="100">id</div>
                <div  field="groupName" name="groupName"  width="100" headerAlign="center" header="业务类型"></div>
                <div field="ct" name="ct" width="100" headerAlign="center" align="center" summaryType="sum">单数</div>
                <div field="totalPrefAmt" name="totalPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">优惠合计&nbsp;</div>
                <div field="allowanceAmt" name="allowanceAmt" width="100" headerAlign="center" align="center" summaryType="sum">结算优惠&nbsp;</div>
                <div field="balaAmt" name="balaAmt" width="100" headerAlign="center" align="center" summaryType="sum">实收合计&nbsp;</div>
                <div field="pkgAmt" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum">套餐金额</div>
                <div field="pkgPrefAmt" name="pkgPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">套餐优惠金额</div>
                 <div field="pkgSubtotal" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum">套餐小计</div>
                 <div field="itemTotalAmt" name="itemTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum">项目金额</div>
                <div field="itemPrefAmt" name="itemPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">项目优惠金额</div>
                 <div field="itemSubtotal" name="itemSubtotal" width="100" headerAlign="center" align="center" summaryType="sum">项目小计</div>
                <div field="partTotalAmt" name="partTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum">配件金额</div>
                <div field="partPrefAmt" name="partPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum">配件优惠金额</div>
                 <div field="partSubtotal" name="partSubtotal" width="100" headerAlign="center" align="center" summaryType="sum">配件小计</div>
 				<div field="partTrueCost"  width="70" headerAlign="center" header="配件成本" summaryType="sum"></div>
                <div field="cardTimesAmt" name="cardTimesAmt" width="100" headerAlign="center" align="center" summaryType="sum">计次卡抵扣</div>       
                <div field="otherAmt" name="otherAmt" width="100" headerAlign="center" align="center" summaryType="sum">其他费用收入</div>
                <div field="otherCostAmt" name="other_cost_amt" width="100" headerAlign="center" align="center" summaryType="sum">其他费用成本</div>
                <div field="salesDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum">销售提成</div>
                <div field="techDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum">技师提成</div>
                <div field="advisorDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum">服务顾问提成</div>
                <div field="totalDeductAmt" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum">总提成金额</div>
                <div field="netinAmt" name="netinAmt" width="100" headerAlign="center" align="center" summaryType="sum">营收金额</div>
                <div field="grossProfit" name="grossProfit" width="100" headerAlign="center" align="center" summaryType="sum">毛利&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" onmouseover="overShow(this,con8)"
                        onmouseout="outHide()"></span></div>
                <div field="grossProfitRate" name="grossProfitRate" width="100" numberFormat="p" headerAlign="center" align="center" summaryType="sum">毛利率&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" onmouseover="overShow(this,con8)"
                        onmouseout="outHide()"></span></div>

            </div>
        </div>
    </div>
</body>

</html>