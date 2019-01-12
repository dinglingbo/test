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
    <title>业务产值汇总表</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%=webPath + contextPath%>/repair/js/sell/businessOutputTotal.js?v=1.0.19"></script>

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

    <div class="nui-toolbar" style="padding:2px;" id="queryForm">
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
                                   nullItemText="请选择..."/>
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
                                   nullItemText="请选择..."/>
                    <a class="nui-button" plain="true" onclick="onSearch()" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div id="showDiv" class="tipStyle"></div>
    <div class="nui-fit">
        <div id="mainGrid" class="nui-datagrid" style="width:100%;height:100%;" selectOnLoad="true" showPager="false"
            pageSize="50" totalField="page.count" sizeList=[20,50,100,200] dataField="data" onrowdblclick=""
            allowCellSelect="true" editNextOnEnterKey="true" onshowrowdetail="onShowRowDetail" url="" allowCellWrap=true>
            <div property="columns">
                <div field="id" name="id" visible="false" width="100">id</div>
                <div field="ct" name="ct" width="100" headerAlign="center" align="center">单数</div>
                <div field="totalPrefAmt" name="totalPrefAmt" width="100" headerAlign="center" align="center">优惠合计&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" onmouseover="overShow(this,con8)"
                        onmouseout="outHide()"></span></div>
                <div field="allowanceAmt" name="allowanceAmt" width="100" headerAlign="center" align="center">结算优惠&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" onmouseover="overShow(this,con8)"
                        onmouseout="outHide()"></span></div>
                <div field="balaAmt" name="balaAmt" width="100" headerAlign="center" align="center">实收合计&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" onmouseover="overShow(this,con8)"
                        onmouseout="outHide()"></span></div>
                <div field="pkgAmt" name="pkgAmt" width="100" headerAlign="center" align="center">套餐金额</div>
                <div field="pkgPrefAmt" name="pkgPrefAmt" width="100" headerAlign="center" align="center">套餐优惠金额</div>
                 <div field="pkgSubtotal" name="pkgAmt" width="100" headerAlign="center" align="center">套餐小计</div>
                 <div field="itemTotalAmt" name="itemTotalAmt" width="100" headerAlign="center" align="center">项目金额</div>
                <div field="itemPrefAmt" name="itemPrefAmt" width="100" headerAlign="center" align="center">项目优惠金额</div>
                 <div field="itemSubtotal" name="itemSubtotal" width="100" headerAlign="center" align="center">项目小计</div>
                <div field="partTotalAmt" name="partTotalAmt" width="100" headerAlign="center" align="center">配件金额</div>
                <div field="partPrefAmt" name="partPrefAmt" width="100" headerAlign="center" align="center">配件优惠金额</div>
                 <div field="partSubtotal" name="partSubtotal" width="100" headerAlign="center" align="center">配件小计</div>
 				<div field="partTrueCost"  width="70" headerAlign="center" header="配件成本"></div>
                <div field="cardTimesAmt" name="cardTimesAmt" width="100" headerAlign="center" align="center">计次卡抵扣</div>       
                <div field="otherAmt" name="otherAmt" width="100" headerAlign="center" align="center">其他费用收入</div>
                <div field="otherCostAmt" name="other_cost_amt" width="100" headerAlign="center" align="center">其他费用成本</div>
                <div field="salesDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center">销售提成</div>
                <div field="techDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center">技师提成</div>
                <div field="advisorDeductValue" name="salesDeductValue" width="100" headerAlign="center" align="center">服务顾问提成</div>
                <div field="totalDeductAmt" name="salesDeductValue" width="100" headerAlign="center" align="center">总提成金额</div>
                <div field="netinAmt" name="netinAmt" width="100" headerAlign="center" align="center">营收金额</div>
                <div field="grossProfit" name="grossProfit" width="100" headerAlign="center" align="center">毛利&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" onmouseover="overShow(this,con8)"
                        onmouseout="outHide()"></span></div>
                <div field="grossProfitRate" name="grossProfitRate" width="100" numberFormat="p" headerAlign="center" align="center">毛利率&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;" onmouseover="overShow(this,con8)"
                        onmouseout="outHide()"></span></div>

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