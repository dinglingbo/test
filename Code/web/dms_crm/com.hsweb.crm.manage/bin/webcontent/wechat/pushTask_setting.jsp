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
       <td>
        有效时间：<input class="nui-datepicker" name="" style="">
        至 <input class="nui-datepicker" name="" style="">
    </td>
</tr>
<tr>
    <td>
        提醒时间：<input class="nui-datepicker" name="" style="">
        至 <input class="nui-datepicker" name="" style="">
    </td>
</tr>
<tr>
    <td>
        任务运行间隔：<input class="nui-combobox" name="" data="tdate" textField="text" valueField="text" style="width:50px;">
        <input class="nui-textbox" name="" style="width:80px;">
    </td>
</tr>

<tr>
    <td>
        提醒参数：<input class="nui-textbox " name="" >
    </td>
</tr>
<tr>
    <td>
        提前提醒（到期类型提醒有效）：<input class="nui-combobox" name="" data="tdate" textField="text" valueField="text" style="width:50px;">
        <input class="nui-textbox" name="" style="width:80px;">
    </td>
</tr>

<tr>
    <td>
        提醒次数（对象为员工的有效）：
        <input class="nui-textbox" name="" style="width:50px;">
    </td>
</tr>
<tr>
    <td>
        提醒方式：
        <div id="" name="" class="mini-checkbox" readOnly="false" text="微信" onvaluechanged=""></div>
        <div id="" name="" class="mini-checkbox" readOnly="false" text="短信" onvaluechanged=""></div>
    </td>
</tr>



<tr>
    <td >是否启用：

        <input type="radio" name="colors" id="red">启用
        <input type="radio" name="colors" id="blue">不启用
    </td>
</tr>

</table>
</div>

<script type="text/javascript">
    var tdate=[{text:"年"},{text:"月"},{text:"日"},{text:"时"},{text:"分"},{text:"秒"}];
    nui.parse();
</script>
</body>
</html>