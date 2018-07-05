<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-03 20:59:11
  - Description:
-->
<head>
<title>材料采购统计表</title>
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
    <div>
        <input class="nui-combobox" style="width:10%" data="data" value="1">
        <span>金额合计</span>&nbsp;
        <span>666</span>
    </div>
    <div style="height: 80px;">
        <table>
            <tr>
                <td>
                    品牌
                    <input class="nui-combobox">
                </td>
                <td >
                    日期
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" /> 至
                    <input class="nui-datepicker" id="" name="" dateFormat="yyyy-MM-dd" style="width:120px" />
                </td>
                <td>
                    材料名称
                    <input class="nui-textbox">
                </td>
                <td>
                    材料编码
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td>
                    零件号
                    <input class="nui-textbox">
                </td>
                <td>
                    业务分类
                    <input class="nui-combobox" data="data1">
                </td>
                <td>
                    <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">材料名称</div>
                <div field="" id="" name="" headeralign="center" align="center">业务分类</div>
                <div field="" id="" name="" headeralign="center" align="center">材料编号</div>
                <div field="" id="" name="" headeralign="center" align="center">规格型号</div>
                <div field="" id="" name="" headeralign="center" align="center">供应商名称</div>
                <div field="" id="" name="" headeralign="center" align="center">单位</div>
                <div field="" id="" name="" headeralign="center" align="center">采购数量</div>
                <div field="" id="" name="" headeralign="center" align="center">采购均价</div>
                <div field="" id="" name="" headeralign="center" align="center">采购总金额</div>
                <div field="" id="" name="" headeralign="center" align="center">采购金额占比</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
    var data = [{ id: "1", text: "今天" }, { id: "2", text: "三个月" }, { id: "3", text: "六个月" }, { id: "4", text: "九个月" }
            , { id: "5", text: "一年" }, { id: "6", text: "一年以上" }];
    var data1 = [{ id: "", text: "请选择" }, { id: "1", text: "维修" }, { id: "2", text: "保养" }, { id: "3", text: "美容" }, { id: "4", text: "钣喷" }
            , { id: "5", text: "轮胎" }, { id: "6", text: "洗车" }, { id: "7", text: "精品" }, { id: "8", text: "其他" }, { id: "9", text: "零售" }];
    	nui.parse();

    </script>
</body>
</html>