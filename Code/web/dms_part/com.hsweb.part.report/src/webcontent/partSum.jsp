<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 15:29:13
  - Description:
-->
<head>
<title>Title</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
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
<div class="nui-fit">
    <div style="height: 100px;">
        <table>
            <tr>
                <td style="width:160px;">
                    <span>统计范围</span>
                    <input class="nui-combobox" style="width:60%" data="data" value="1">
                </td>
                <td style="width:160px;">
                    <span>汇总方式</span>
                    <input class="nui-combobox" style="width:60%" data="data1" value="1">
                </td>
                <td style="width:160px;">
                    <input class="nui-combobox" style="width:60%" data="data2" value="1">
                </td>
                <td>
                    <a class="nui-button" iconCls="icon-search" onclick="">查询</a>
                    <a class="nui-button" iconCls="icon-search" onclick="">导出EXCEL</a>
                </td>
            </tr>
            <tr>
                <td>
                    采购方式
                    <input class="nui-combobox" style="width:60%" data="data3" value="1">
                </td>
            </tr>
            <tr>
                <td>
                    <input class="nui-combobox" style="width:60%" data="data4" value="1">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">门店</div>
                <div field="" name="" headeralign="center" align="center">供应商名称</div>
                <div field="" id="" name="" headeralign="center" align="center">单据日期</div>
                <div field="" id="" name="" headeralign="center" align="center">单据编号</div>
                <div field="" id="" name="" headeralign="center" align="center">供应商单号</div>
                <div field="" id="" name="" headeralign="center" align="center">订单应付金额</div>
                <div field="" id="" name="" headeralign="center" align="center">订单优惠金额</div>
                <div field="" id="" name="" headeralign="center" align="center">订单结算金额</div>
                <div field="" id="" name="" headeralign="center" align="center">订单除税金额</div>
                <div field="" id="" name="" headeralign="center" align="center">订单税额</div>
                <div field="" id="" name="" headeralign="center" align="center">订单已付金额</div>
                <div field="" id="" name="" headeralign="center" align="center">订单未付金额</div>
                <div field="" id="" name="" headeralign="center" align="center">退货应收金额</div>
                <div field="" id="" name="" headeralign="center" align="center">退货免收金额</div>
                <div field="" id="" name="" headeralign="center" align="center">退货结算金额</div>
                <div field="" id="" name="" headeralign="center" align="center">退货除税金额</div>
                <div field="" id="" name="" headeralign="center" align="center">退货税额</div>
                <div field="" id="" name="" headeralign="center" align="center">退货已收金额</div>
                <div field="" id="" name="" headeralign="center" align="center">退货未收金额</div>
                <div field="" id="" name="" headeralign="center" align="center">税率</div>
                <div field="" id="" name="" headeralign="center" align="center">结算状态</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "1", text: "含税及除税金额" }, { id: "2", text: "含税金额" }];
    var data2 = [{ id: "1", text: "本月" }, { id: "2", text: "上月初至今" }, { id: "2", text: "上两月初至今" }];
    var data3 = [{ id: "1", text: "对外采购" }, { id: "2", text: "对内采购（调拨）" }, { id: "3", text: "所有" }];
    var data4 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>