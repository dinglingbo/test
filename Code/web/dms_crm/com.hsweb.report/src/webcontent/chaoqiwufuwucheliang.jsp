<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): localhost
  - Date: 2018-07-04 20:47:35
  - Description:
-->
<head>
<title>超期无服务车辆</title>
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
                <td style="width:250px;">
                    <input class="nui-combobox" style="width:60%" data="data" value="1">
                </td>
                <td style="width:200px;">
                    <a class="nui-button" iconcls="" id="" name="" onclick="">导出</a>
                </td>
            </tr>
        </table>
    </div>
    <div class="nui-fit">
        <div id="grid" class="nui-datagrid" datafield="" allowcelledit="true" url="" allowcellwrap="true" style="width:100%;height:100%;">
            <div property="columns">
                <div field="" name="" headeralign="center" align="center">车牌号</div>
                <div field="" id="" name="" headeralign="center" align="center">VIN</div>
                <div field="" id="" name="" headeralign="center" align="center">品牌车型</div>
                <div field="" id="" name="" headeralign="center" align="center">客户名称</div>
                <div field="" id="" name="" headeralign="center" align="center">手机号</div>
                <div field="" id="" name="" headeralign="center" align="center">上次服务时间</div>
                <div field="" id="" name="" headeralign="center" align="center">维修类型</div>
                <div field="" id="" name="" headeralign="center" align="center">未到店天数</div>
                <div field="" id="" name="" headeralign="center" align="center">车辆登记门店</div>
            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">
     var data = [{ id: "1", text: "一个月" }, { id: "2", text: "三个月" }, { id: "3", text: "六个月" }, { id: "4", text: "九个月" }, { id: "5", text: "一年" }];
     var data1 = [{ id: "1", text: "按次数" }, { id: "2", text: "按客户单价" }];
    	nui.parse();
    </script>
</body>
</html>