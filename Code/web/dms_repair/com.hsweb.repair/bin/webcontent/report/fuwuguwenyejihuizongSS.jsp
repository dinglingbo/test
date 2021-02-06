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
<title>服务顾问业绩汇总表</title>
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
    <div style="height: 120px;">
        <table>
            <tr>
                <td style="width:300px;">
                    <span>统计范围</span>
                    <input class="nui-combobox" style="width:60%" data="data" value="1">
                </td>
                <td style="width:200px;">
                    <span>汇总方式</span>
                    <input class="nui-combobox" style="width:60%" data="data1" value="1">
                </td>
                <td style="width:200px;">
                    <input class="nui-combobox" style="width:60%" data="data2" value="1">
                </td>
                <td>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">导出文件</a>
                </td>
            </tr>
            <tr>
                <td style="width:200px;">
                    <input class="nui-combobox" style="width:60%" data="data3" value="1">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">服务顾问</div>
                <div field="" id="" name="" headeralign="center" align="center">工单台次</div>
                <div field="" id="" name="" headeralign="center" align="center">项目工时</div>
                <div field="" id="" name="" headeralign="center" align="center">工时收入</div>
                <div field="" id="" name="" headeralign="center" align="center">材料收入</div>
                <div field="" id="" name="" headeralign="center" align="center">附加费</div>
                <div field="" id="" name="" headeralign="center" align="center">工单收入</div>
                <div field="" id="" name="" headeralign="center" align="center">材料成本</div>
                <div field="" id="" name="" headeralign="center" align="center">毛利</div>
                <div field="" id="" name="" headeralign="center" align="center">毛利率</div>
                <div field="" id="" name="" headeralign="center" align="center">工单收现</div>
                <div field="" id="" name="" headeralign="center" align="center">工时收现</div>
                <div field="" id="" name="" headeralign="center" align="center">材料收现</div>
                <div field="" id="" name="" headeralign="center" align="center">附加费收现</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "1", text: "服务顾问" }];
    var data2 = [{ id: "1", text: "今天" }, { id: "2", text: "上周末" }, { id: "3", text: "上月末" }];
    var data3 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>