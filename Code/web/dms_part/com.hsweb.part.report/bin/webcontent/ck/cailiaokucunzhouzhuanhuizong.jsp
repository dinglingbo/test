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
<title>材料库存周转汇总</title>
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
            <tr>
                <td style="width:400px;">
                    日期
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
                </td>
                <td>
                    排序方式
                    <input class="nui-combobox" style="width:60%" data="data4" value="1">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">业务分类</div>
                <div field="" id="" name="" headeralign="center" align="center">期初库存数量</div>
                <div field="" id="" name="" headeralign="center" align="center">期初库存成本</div>
                <div field="" id="" name="" headeralign="center" align="center"></div>
                <div field="" id="" name="" headeralign="center" align="center"></div>
                <div field="" id="" name="" headeralign="center" align="center">销售数量</div>
                <div field="" id="" name="" headeralign="center" align="center">销售总成本</div>
                <div field="" id="" name="" headeralign="center" align="center">库存周转天数</div>
                <div field="" id="" name="" headeralign="center" align="center">库存周转次数</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "1", text: "日期" }, { id: "2", text: "材料分类" },{ id: "3", text: "业务分类" },{ id: "4", text: "仓库" },
    { id: "5", text: "出入库方式（含税）" },{ id: "6", text: "出入库方式（除税" }];
     var data2 = [{ id: "1", text: "最近7天" }, { id: "2", text: "最近30天" }, { id: "3", text: "最近90天" }, , { id: "4", text: "最近180天" }];
     var data3 = [{ id: "1", text: "更多筛选" }];
     var data4 = [{ id: "1", text: "请选择" }, { id: "2", text: "库存周转天数" }, { id: "3", text: "库存周转次数" }, { id: "4", text: "销售数量" },
        { id: "5", text: "销售总成本" }];
    	nui.parse();
    </script>
</body>
</html>