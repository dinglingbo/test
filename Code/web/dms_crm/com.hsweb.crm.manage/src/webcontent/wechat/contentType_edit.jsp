<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-12-03 18:34:32
  - Description:
-->
<head>
    <title>添加活动</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }
    .tbtext {
        width: 70px;
        text-align: right;
    }
    .tbinput{
        width: 100%
    }
</style>
</head>
<body>

   <div class="nui-toolbar" style="padding:0px;">
    <table style="width:80%;">
        <tr>
            <td style="width:80%;">
                <a class="nui-button" iconCls="" plain="true" onclick="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" iconCls="" plain="true" onclick="onCancel"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit">
  <table style="width:100%;">
    <tr>
        <td class="tbtext"><label>上级：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>分类名称：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>是否显示：</label></td>
        <td>
            <input type="radio" name="colors" id="red">显示
            <input type="radio" name="colors" id="blue">不显示
        </td>
    </tr>
    <tr>
        <td class="tbtext"><label>略缩图：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
    <tr>
        <td class="tbtext"><label>预览：</label></td>
        <td><input class="nui-combobox tbinput" name="" style=""></td>
    </tr>
</table>
</div>

<script type="text/javascript">
   nui.parse();
</script>
</body>
</html>