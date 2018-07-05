<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 16:32:23
  - Description:
-->
<head>
<title>零售业务统计分析</title>
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
    <div style="height: 150px;">
        <table>
            <tr>
                <td style="width:300px;">
                    <input class="nui-combobox" style="width:60%" data="data" value="1">
                </td>
                <td style="width:300px;">
                    <input class="nui-textbox" style="width:50%" emptytext="请输入材料名或规格型号">
                    <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">导出EXCEL</a>
                </td>
            </tr>
            <tr>
                <td style="width:200px;">
                    <input class="nui-combobox" style="width:60%" data="data3" value="1">
                </td>
            </tr>
            <tr>
                <td>
                     交易日期
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" />
                </td>
                <td>
                    材料分类
                    <input class="nui-combobox" style="width:60%"  value="1">
                </td>
                <td>
                    业务分类
                    <input class="nui-combobox" style="width:60%" value="1">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">排名</div>
                <div field="" id="" name="" headeralign="center" align="center">材料名称</div>
                <div field="" id="" name="" headeralign="center" align="center">材料分类</div>
                <div field="" id="" name="" headeralign="center" align="center">业务分类</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌</div>
                <div field="" id="" name="" headeralign="center" align="center">数量</div>
                <div field="" id="" name="" headeralign="center" align="center">单价</div>
                <div field="" id="" name="" headeralign="center" align="center">金额</div>
                <div field="" id="" name="" headeralign="center" align="center">成本</div>
                <div field="" id="" name="" headeralign="center" align="center">除税成本</div>
                <div field="" id="" name="" headeralign="center" align="center">利润（含税）</div>
                <div field="" id="" name="" headeralign="center" align="center">销售人员</div>
                <div field="" id="" name="" headeralign="center" align="center">客户</div>
                <div field="" id="" name="" headeralign="center" align="center">零售订单号</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "材料汇总" }, { id: "2", text: "客户汇总" }, { id: "1", text: "销售人员汇总" }];
     var data2 = [{ id: "1", text: "今天" }, { id: "2", text: "本周" }, { id: "3", text: "本月" }, { id: "4", text: "本季度" }, { id: "5", text: "本年" }];
     var data3 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>