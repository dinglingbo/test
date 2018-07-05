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
<title>呆滞品统计分析</title>
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
                <td style="width:200;">
                    <span>统计范围</span>
                    <input class="nui-combobox" style="width:60%" data="data" value="1">
                </td>
                <td style="width:200px;">
                    <input class="nui-combobox" style="width:60%" data="data1" value="1">
                </td>
                <td>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">打印</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">导出</a>
                </td>
            </tr>
            <tr>
                <td style="width:200px;">
                    <input class="nui-combobox" style="width:60%" data="data3" value="1">
                </td>
            </tr>
            <tr>
                <td>
                    材料名称
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    材料编码
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    零件号
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    OE码
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
            </tr>
            <tr>
                <td>
                    材料分类
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                    品牌
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                    业务类型
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
                <td>
                    排序方式
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
            </tr>
            <tr>
                <td>
                    呆滞天数
                    <input class="nui-textbox" style="width:60%" data="" value="">
                </td>
                <td>
                    仓库
                    <input class="nui-combobox" style="width:60%" data="" value="">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">材料名称</div>
                <div field="" id="" name="" headeralign="center" align="center">材料编码</div>
                <div field="" id="" name="" headeralign="center" align="center">零件号</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌</div>
                <div field="" id="" name="" headeralign="center" align="center">规格型号</div>
                <div field="" id="" name="" headeralign="center" align="center">业务分类</div>
                <div field="" id="" name="" headeralign="center" align="center">材料分类</div>
                <div field="" id="" name="" headeralign="center" align="center">单位</div>
                <div field="" id="" name="" headeralign="center" align="center">仓库</div>
                <div field="" id="" name="" headeralign="center" align="center">数量</div>
                <div field="" id="" name="" headeralign="center" align="center">金额</div>
                <div field="" id="" name="" headeralign="center" align="center">呆滞天数</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "宝轩汽车" }];
    var data1 = [{ id: "1", text: "7天" }, { id: "2", text: "30天" },{ id: "3", text: "90天" },{ id: "4", text: "180天" },
    { id: "5", text: "360天" }];
     var data2 = [{ id: "1", text: "最近7天" }, { id: "2", text: "最近30天" }, { id: "3", text: "最近90天" }, , { id: "4", text: "最近180天" }];
     var data3 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>