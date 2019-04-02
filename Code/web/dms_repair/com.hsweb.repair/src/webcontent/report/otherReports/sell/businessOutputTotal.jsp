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
    <title>已结算工单汇总表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/sell/businessOutputTotal.js?v=1.0.33"></script>

    <style>

        .titleText{
            font-weight: 400;
            font-size: 18px;
            color: #666;
            border-bottom: 2px solid #23c0fa;
            display: inline-block;
            line-height: 35px;
        }
        .iconStyle{
            font-size: 14px;
            margin-top: 2px;
            position: absolute;
            color:#f0ce25;
        }
        .tipStyle{
            position: absolute; 
            background-color: #595959; 
            color:#fff;
            border-radius: 4px;
            padding:5px 10px 5px 10px;
            opacity:0.9;
            font-size:14px;
            display: none;
            z-index:999;
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
                    <label>&nbsp;&nbsp;&nbsp;服务顾问：</label>
                                                <input name="mtAdvisorId"
                                   id="mtAdvisorId"
                                   class="nui-combobox width1"
                                   textField="empName"
                                   valueField="empId"
                                   emptyText="请选择..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100px"
                                   valueFromSelect="true"
                                   nullItemText="请选择..." onenter="load()" onvaluechanged="load()"/>
                                   <label>&nbsp;&nbsp;&nbsp;&nbsp;业务类型：</label>
                                                <input name="serviceTypeId"
                                   id="serviceTypeId"
                                   class="nui-combobox width1"
                                   textField="name"
                                   valueField="id"
                                   emptyText="请选择..."
                                   url=""
                                   allowInput="true"
                                   showNullItem="false"
                                   width="100px"
                                   valueFromSelect="true"
                                   nullItemText="请选择..." onenter="load()" onvaluechanged="load()"/>
                                   <input name="orgids" id="orgids" class="nui-combobox width1" textField="name" valueField="orgid"
                        emptyText="公司选择" url=""  allowInput="true" showNullItem="false" width="130" valueFromSelect="true"/>
                           是否包含未收款：<div  class="nui-checkbox" id="isCollectMoney" name="isCollectMoney" value="1" onclick="onSearch" trueValue="1" falseValue="0"></div>
                    <a class="nui-button" plain="true" onclick="onSearch()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                    </br>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="load(0)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按日期汇总</a>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="load(3)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按业务类型汇总</a>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="load(4)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按工单类型汇总</a>
  					<a class="nui-button" iconcls=""  name="" plain="true" onclick="load(1)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按服务顾问汇总</a>
     				<a class="nui-button" iconcls=""  name="" plain="true" onclick="load(2)"><span class="fa fa-navicon fa-lg"></span>&nbsp;按品牌车型汇总</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="showDiv" class="tipStyle"></div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false"
            pageSize="500" totalField="page.count" sizeList=[500,1000,2000] dataField="data" onrowdblclick=""
            allowCellSelect="true" editNextOnEnterKey="true" onshowrowdetail="onShowRowDetail" url="" showSummaryRow="true" allowCellWrap=true  sortMode="client">
            <div property="columns">
            	<div type="indexcolumn">序号</div>
                <div field="id" name="id" visible="false" width="100">id</div>
                <div  field="groupName" name="groupName"  width="100" headerAlign="center" header="业务类型" allowsort="true" ></div>
                <div field="ct" name="ct" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">单数</div>
                <div field="totalPrefAmt" name="totalPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">优惠合计&nbsp;
</div>
                <div field="allowanceAmt" name="allowanceAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float"> 结算优惠&nbsp;
</div>
                <div field="balaAmt" name="balaAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">实收合计&nbsp;
</div>
                <div field="pkgAmt" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">套餐销售金额</div>
                <div field="pkgPrefAmt" name="pkgPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">套餐优惠金额</div>
                 <div field="pkgSubtotal" name="pkgAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">套餐销售小计</div>
                 <div field="itemTotalAmt" name="itemTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">项目销售金额</div>
                <div field="itemPrefAmt" name="itemPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">项目优惠金额</div>
                 <div field="itemSubtotal" name="itemSubtotal" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">项目销售小计</div>
                <div field="partTotalAmt" name="partTotalAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">配件销售金额</div>
                <div field="partPrefAmt" name="partPrefAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">配件优惠金额</div>
                 <div field="partSubtotal" name="partSubtotal" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">配件销售小计</div>
 				<div field="partTrueCost"  width="70" headerAlign="center" header="配件成本" summaryType="sum" allowsort="true" ></div>
                <div field="cardTimesAmt" name="cardTimesAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">计次卡抵扣</div>       
                <div field="otherAmt" name="otherAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">其他费用收入</div>
                <div field="otherCostAmt" name="other_cost_amt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">其他费用成本</div>
                <div field="salesDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">销售提成</div>
                <div field="techDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">技师提成</div>
                <div field="advisorDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">服务顾问提成</div>
                <div field="totalDeductAmt" name="salesDeductValue" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">总提成金额</div>
                <div field="netinAmt" name="netinAmt" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">营收金额</div>
                <div field="grossProfit" name="grossProfit" width="100" headerAlign="center" align="center" summaryType="sum" allowsort="true" dataType="float">毛利&nbsp;</div>
                <div field="allowanceAmt" name="allowanceAmt" width="70" headerAlign="center" allowsort="true" summaryType="sum" header="其他优惠" dataType="float"></div>
                <div field="grossProfitRate" name="grossProfitRate" width="100" numberFormat="p" headerAlign="center" align="center"  allowsort="true" dataType="float">毛利率&nbsp;</div>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        nui.parse();
        var con8 = '这是一个提示';






        function overShow(e, con) {
            var showDiv = document.getElementById('showDiv');
            var pos = e.getBoundingClientRect();
            $("#showDiv").css("top", pos.bottom); //设置提示div的位置
            $("#showDiv").css("left", pos.right);
            showDiv.style.display = 'block';
            showDiv.innerHTML = con;
        }

        function outHide() {
            var showDiv = document.getElementById('showDiv');
            showDiv.style.display = 'none';
            showDiv.innerHTML = '';
        }
    </script>
</body>

</html>