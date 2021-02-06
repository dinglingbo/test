<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 17:02:13
  - Description:
-->
<head>
<title>材料周转明细表</title>
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
                    <span>统计范围</span>
                    <input class="nui-combobox" style="width:60%" data="data" value="1">
                </td>
                <td style="width:200px;">
                	<input class="nui-combobox" style="width:30%" data="data1" value="1">
                </td>
                <td style="width:200px;">
                	 <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">导出EXCEL</a>
                </td>
                <td style="width:200px;"></td>
            </tr>
            <tr>
            	 <td style="width:300px;">
                    <input class="nui-combobox" style="width:30%" data="data3" value="1">
                </td>
            </tr>
            <tr>
                <td style="width:200px;">
                 	日期
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:100px" />
                </td>
                <td  style="width:200px;">
                    材料名称
                    <input class="nui-textbox">
                </td>
                <td>
                    材料编码
                    <input class="nui-textbox">
                </td>
                <td>
                    零件号
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td>
                    材料分类
                    <input class="nui-textbox">
                </td>
                <td>
                    品牌
                    <input class="nui-combobox" data="">
                </td>
                <td >
                    规格型号
                    <input class="nui-textbox">
                </td>
                <td>
                    供应商
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
            	<td>
            	 业务分类
                    <input class="nui-combobox" data="">
                </td>
                <td>
            	 排序方式
                    <input class="nui-combobox" data="">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">材料名称</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌</div>
                <div field="" id="" name="" headeralign="center" align="center">材料编码</div>
                <div field="" id="" name="" headeralign="center" align="center">零件号</div>
                <div field="" id="" name="" headeralign="center" align="center">供应商</div>
                <div field="" id="" name="" headeralign="center" align="center">材料分类</div>
                <div field="" id="" name="" headeralign="center" align="center">规格型号</div>
                <div field="" id="" name="" headeralign="center" align="center">期初库存数量</div>
                <div field="" id="" name="" headeralign="center" align="center">期初库存成本</div>
                <div field="" id="" name="" headeralign="center" align="center">期末库存数量</div>
                <div field="" id="" name="" headeralign="center" align="center">期末库存成本</div>
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
    var data1 = [{ id: "1", text: "最近7天" }, { id: "2", text: "最近30天" }, { id: "3", text: "最近90天" }, { id: "4", text: "最近180天" }];
    var data3 = [{ id: "1", text: "更多筛选" }];
    	nui.parse();
    </script>
</body>
</html>