<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-12-24 11:02:48
  - Description:
-->

<head>
    <title>收入统计</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style>
        .titleTextDiv{
            border-bottom:1px solid #ccc;
            margin-top: 10px;
        }
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
    <div class="nui-fit">
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
                        <a class="nui-button" plain="true" onclick="" id="query" enabled="true"><span class="fa fa-search fa-lg"></span>&nbsp;查询</a>
                        <!-- <li class="separator"></li> -->
                    </td>
                </tr>
            </table>
        </div>

        <div class="titleTextDiv">
            <span class="titleText"> 销售报表</span>
        </div>
        <div id="t1" style="width: 100%; height: auto;padding:10px 0px 0px 0px;display: inline-block;">
            <div id="t2" style="float:left;width: 49.5%; height: 100%;">
                <div class="nui-toolbar" style="padding:2px;border-bottom:0px;color:#2d79aa;" id="queryForm">
                    工单统计&nbsp;<span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 5px;" 
                    onmouseover="overShow(this,con1)" onmouseout="outHide()""></span>
                </div>
                <div id="datagrid1" class="mini-datagrid" style="width:100%;height:auto" idField="id" allowResize="false"
                    showPager="false" showColumns="false">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
                        <div field="vala" width="120" headerAlign="center" align="center"></div>
                        <div field="" width="120" headerAlign="center" align="center"></div>
                    </div>
                </div>
            </div>
            <div id="t4" style="float:left;width: 1%; height: 100%;display: list-item;"></div>
            <div id="t3" style="float:left;width: 49.5%; height: 100%;">
                <div class="nui-toolbar" style="padding:2px;border-bottom:0px;color:#2d79aa;" id="queryForm">
                    销售优惠
                </div>
                <div id="datagrid2" class="mini-datagrid" style="width:100%;height:auto;" idField="id" allowResize="false"
                    showPager="false" showColumns="false" showSummaryRow="true">
                    <div property="columns">
                        <div type="indexcolumn" headerAlign="center" align="center">序号</div>
                        <div field="vala" width="120" headerAlign="center" align="center" summaryRenderer="ShowHJ"></div>
                        <div field="" width="120" headerAlign="center" align="center"></div>
                    </div>
                </div>
            </div>

            <div style="clear: both"></div>
            <!-- 注释：清除float产生浮动 -->
        </div>

        <div id="showDiv" class="tipStyle"></div>
        <div class="titleTextDiv">
            <span class="titleText"> 实收统计</span>
        </div>

        <div id="datagrid3" class="mini-datagrid" style="width:100%;height:auto;margin-top:10px;" idField="id"
            allowResize="false" showPager="false" showSummaryRow="true">
            <div property="columns">
                
                <div field="vala" width="100" headerAlign="center" align="center" summaryRenderer="ShowHJ">单据名称</div>
                <div field="" width="100" headerAlign="center" align="center">单数</div>
                <div field="" width="100" headerAlign="center" align="center">金额</div>
                <div field="" width="100" headerAlign="center" align="center">现金</div>
                <div field="" width="100" headerAlign="center" align="center">银行卡</div>
                <div field="" width="100" headerAlign="center" align="center">其他账户</div>
                <div field="" width="100" headerAlign="center" align="center">套餐预收</div>
                <div field="" width="100" headerAlign="center" align="center">充值预收</div>
                <div field="" width="100" headerAlign="center" align="center">优惠&nbsp;
                    <span class="fa fa-question-circle fa-lg iconStyle" style="margin-top: 3px;"
                    onmouseover="overShow(this,con8)" onmouseout="outHide()"></span></div>
                <div field="" width="100" headerAlign="center" align="center">记账</div>
                <div field="" width="100" headerAlign="center" align="center">赠送</div>
            </div>
        </div>



        <div class="titleTextDiv">
            <span class="titleText"> 支出统计</span>
        </div>

        <div id="datagrid4" class="mini-datagrid" style="width:100%;height:auto;margin-top:10px;" idField="id"
            allowResize="false" showPager="false" showSummaryRow="true">
            <div property="columns">
                <div field="vala" width="100" headerAlign="center" align="center" summaryRenderer="ShowHJ">单据名称</div>
                <div field="" width="100" headerAlign="center" align="center">单数</div>
                <div field="" width="100" headerAlign="center" align="center">金额</div>
                <div field="" width="100" headerAlign="center" align="center">现金</div>
                <div field="" width="100" headerAlign="center" align="center">银行卡</div>
                <div field="" width="100" headerAlign="center" align="center">其他账户</div>
                <div field="" width="100" headerAlign="center" align="center">余额支出</div>
                <div field="" width="100" headerAlign="center" align="center">优惠</div>
                <div field="" width="100" headerAlign="center" align="center">欠款</div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        nui.parse();
        var con1='工单+销售退货单';//工单统计
        var con2='销售金额-优惠金额';//实收金额
        var con3='现金+刷卡+其他支付（如：微信）';//现金银行
        var con4='含套餐预收和充值预收的支付';//预收支付
        var con5='包含备件成本和外包成本';//工单成本
        var con6='其他出库类型为“配件领料”的成本';//内部领料成本
        var con7='实收金额-工单配件成本-内部领料成本';//毛利
        var con8='包含折扣、优惠券、红包、积分套餐优惠和充值赠送的金额优惠';//优惠

        var grid1_list = [{
                vala: "工单数量"
            },
            {
                vala: "销售金额"
            },
            {
                vala: "销售优惠"
            },
            {
                vala: "实收金额" +
                    '&nbsp;<span class="fa fa-question-circle fa-lg iconStyle" onmouseover="overShow(this,con2)" onmouseout="outHide()"></span>'
            },
            {
                vala: "现金银行" + '&nbsp;<span class="fa fa-question-circle fa-lg iconStyle" onmouseover="overShow(this,con3)" onmouseout="outHide()"></span>'
            },
            {
                vala: "预收支付" + '&nbsp;<span class="fa fa-question-circle fa-lg iconStyle" onmouseover="overShow(this,con4)" onmouseout="outHide()"></span>'
            },
            {
                vala: "记账"
            },
            {
                vala: "工单成本" + '&nbsp;<span class="fa fa-question-circle fa-lg iconStyle" onmouseover="overShow(this,con5)" onmouseout="outHide()"></span>'
            },
            {
                vala: "内部领料成本" + '&nbsp;<span class="fa fa-question-circle fa-lg iconStyle" onmouseover="overShow(this,con6)" onmouseout="outHide()"></span>'
            },
            {
                vala: "毛利" + '&nbsp;<span class="fa fa-question-circle fa-lg iconStyle" onmouseover="overShow(this,con7)" onmouseout="outHide()"></span>'
            },
            {
                vala: "毛利率"
            },
        ];


        var grid2_list = [{
                vala: "整单折扣"
            },
            {
                vala: "额外优惠"
            },
            {
                vala: "优惠券"
            },
            {
                vala: "红包抵扣"
            },
            {
                vala: "积分抵扣"
            },
            {
                vala: "套餐优惠"
            },
            {
                vala: "充值赠送"
            }
        ];
        var grid3_list = [{
                vala: "工单"
            },
            {
                vala: "套餐销售单"
            },
            {
                vala: "充值单"
            },
            {
                vala: "收定金单"
            },
            {
                vala: "收款单"
            },
            {
                vala: "其他收入单"
            },
            {
                vala: "保险销售单"
            },
            {
                vala: "采购退货单"
            },
            {
                vala: "核销单"
            }
        ];

        var grid4_list = [{
                vala: "采购单"
            },
            {
                vala: "付款单"
            },
            {
                vala: "其他支出单"
            },
            {
                vala: "退款单"
            },
            {
                vala: "销售退货单"
            },
            {
                vala: "套餐撤销单"
            },
            {
                vala: "核销单"
            }
        ];
        var grid1 = nui.get("datagrid1");
        var grid2 = nui.get("datagrid2");
        var grid3 = nui.get("datagrid3");
        var grid4 = nui.get("datagrid4");

        grid1.setData(grid1_list);
        grid2.setData(grid2_list);
        grid3.setData(grid3_list);
        grid4.setData(grid4_list);
        var startDateEl = nui.get('startDate');
        var endDateEl = nui.get('endDate');
        var currType = 2;
        quickSearch(1);

        function quickSearch(type) {
            //var params = getSearchParams();
            var params = {};
            var queryname = "本日";
            switch (type) {
                case 0:
                    params.today = 1;
                    params.startDate = getNowStartDate();
                    params.endDate = addDate(getNowEndDate(), 1);
                    queryname = "本日";
                    break;
                case 1:
                    params.yesterday = 1;
                    params.startDate = getPrevStartDate();
                    params.endDate = addDate(getPrevEndDate(), 1);
                    queryname = "昨日";
                    break;
                case 2:
                    params.thisWeek = 1;
                    params.startDate = getWeekStartDate();
                    params.endDate = addDate(getWeekEndDate(), 1);
                    queryname = "本周";
                    break;
                case 3:
                    params.lastWeek = 1;
                    params.startDate = getLastWeekStartDate();
                    params.endDate = addDate(getLastWeekEndDate(), 1);
                    queryname = "上周";
                    break;
                case 4:
                    params.thisMonth = 1;
                    params.startDate = getMonthStartDate();
                    params.endDate = addDate(getMonthEndDate(), 1);
                    queryname = "本月";
                    break;
                case 5:
                    params.lastMonth = 1;
                    params.startDate = getLastMonthStartDate();
                    params.endDate = addDate(getLastMonthEndDate(), 1);
                    queryname = "上月";
                    break;

                case 10:
                    params.thisYear = 1;
                    params.startDate = getYearStartDate();
                    params.endDate = getYearEndDate();
                    queryname = "本年";
                    break;
                case 11:
                    params.lastYear = 1;
                    params.startDate = getPrevYearStartDate();
                    params.endDate = getPrevYearEndDate();
                    queryname = "上年";
                    break;
                default:
                    break;
            }
            currType = type;
            startDateEl.setValue(params.startDate);
            endDateEl.setValue(addDate(params.endDate, -1));
            var menunamedate = nui.get("menunamedate");
            menunamedate.setText(queryname);
            //doSearch(params);
        }


        function ShowHJ(e) {
            e.cellStyle = "text-align:center;";
            return "合计";
        }



        function overShow(e,con) {
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