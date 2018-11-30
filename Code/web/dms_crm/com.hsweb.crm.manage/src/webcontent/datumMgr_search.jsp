<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2018-11-29 14:11:16
  - Description:
-->
<head>
    <title>高级查询</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <%@include file="/common/commonRepair.jsp"%>
    
</head>
<body>
   <div class="nui-toolbar" style="padding:0px;border-bottom:0;">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button"  plain="true" onclick="CloseWindow('ok')" id="add" enabled="true"><span class="fa fa-check fa-lg"></span>&nbsp;确定</a>
                <a class="nui-button" iconCls="" plain="true" onclick="CloseWindow('no')"><span class="fa fa-close fa-lg"></span>&nbsp;取消</a>
            </td>
        </tr>
    </table>
</div>
<div class="nui-fit" id="form1">
    <table style="width:100%;">
        <tr>
            <td style="width: 70px;">客户名称：</td>
            <td style=""><input class="nui-textbox" name="guestName"id="guestName" style="width: 100%"></td>
            <td style="width: 80px;">手机号：</td>
            <td style=""><input class="nui-textbox" name="mobile" style="width: 100%"></td>
        </tr>

        <tr>
            <td style="width: ;">品牌：</td>
            <td style=""><input class="nui-textbox" name="carBrandId" style="width: 100%"></td>
            <td style="width: ;">车架号(VIN)：</td>
            <td style=""><input class="nui-textbox" name="vin" style="width: 100%"></td>
        </tr>
        <tr>
            <td style="width: ;">车型：</td>
            <td style=""><input class="nui-textbox" name="carModel" style="width: 100%"></td>
            <td style="width: ;">发动机号：</td>
            <td style=""><input class="nui-textbox" name="engineNo" style="width: 100%"></td>
        </tr>
        <tr>
            <td style="width: ;">地址：</td>
            <td colspan="3" style=""><input class="nui-textbox" name="address" style="width: 100%"></td>
        </tr>
    </table>

</div>

<script type="text/javascript">
    nui.parse();
    var form = new nui.Form("#form1");


    nui.get("guestName").focus();
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27)) { //ESC
            onClose();
        }
    };

    function getData(){
        var data = form.getData();
        return  data;
    }


    function CloseWindow(action) {
        if (action == "close") {
        } else if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
        else
            return window.close();
    }

    function onClose(){
        window.CloseOwnerWindow(); 
    }
</script>
</body>
</html>