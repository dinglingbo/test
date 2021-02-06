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
<title>材料出入库汇总表</title>
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
    <div style="height: 60px;">
        <table>
            <tr>
                <td style="width:200;">
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
                <div field="" name="" headeralign="center" align="center">日期</div>
                <div field="" id="" name="" headeralign="center" align="center">期初数量</div>
                <div field="" id="" name="" headeralign="center" align="center">期初含税库存总额</div>
                <div field="" id="" name="" headeralign="center" align="center">期初除税库存总额</div>
                <div field="" id="" name="" headeralign="center" align="center">出库成本</div>
                <div field="" id="" name="" headeralign="center" align="center">入库成本</div>
                <div field="" id="" name="" headeralign="center" align="center">含税入库金额</div>
                <div field="" id="" name="" headeralign="center" align="center">除税入库金额</div>
                <div field="" id="" name="" headeralign="center" align="center">期末数量</div>
                <div field="" id="" name="" headeralign="center" align="center">期末含税库存总额</div>
                <div field="" id="" name="" headeralign="center" align="center">期末除税库存总额</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "1", text: "日期" }, { id: "2", text: "材料分类" },{ id: "3", text: "业务分类" },{ id: "4", text: "仓库" },
    { id: "5", text: "出入库方式（含税）" },{ id: "6", text: "出入库方式（除税" }];
     var data2 = [{ id: "1", text: "今天" }, { id: "2", text: "本周" }, { id: "3", text: "本月" }];
     var data3 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>