<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 16:09:31
  - Description:
-->
<head>
<title>安全库存预报</title>
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
    <div style="height: 10px" align='right'>
        <a class="nui-button" iconcls="" id="" name="" onclick="">查询</a>
    </div>
    <div style="height: 100px">
        <table>
            <tr>
                <td style="width: 200px">
                    材料名称
                    <input class="nui-textbox">
                </td>
                <td style="width: 200px">
                    分类
                    <input class="nui-textbox">
                </td>
                <td style="width: 200px">
                    规格型号
                    <input class="nui-textbox">
                </td>
            </tr>
            <tr>
                <td style="width: 200px">
                    材料编码
                    <input class="nui-textbox">
                </td>
                <td style="width: 200px">
                    零件号
                    <input class="nui-textbox">
                </td>
                <td>
                    品牌
                    <input class="nui-combobox" data="data1">
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">材料名称</div>
                <div field="" id="" name="" headeralign="center" align="center">材料编号</div>
                <div field="" id="" name="" headeralign="center" align="center">零件号</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌</div>
                <div field="" id="" name="" headeralign="center" align="center">规格型号</div>
                <div field="" id="" name="" headeralign="center" align="center">所属分类</div>
                <div field="" id="" name="" headeralign="center" align="center">单位</div>
                <div field="" id="" name="" headeralign="center" align="center">库存数量</div>
                <div field="" id="" name="" headeralign="center" align="center">安全库存</div>
            </div>
        </div>
    </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    </script>
</body>
</html>