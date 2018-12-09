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
    <style type="text/css">
    .form_table{
        width:100%;
        table-layout: fixed;
        border-right : 15px;
    }

    .form_table tr{
        height:30px; 
    }

    .tbtext{
        text-align: right;
        width:80px;
    }

</style>
</head>
<body>
 <div class="nui-toolbar" style="padding:0px;">
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
    <table class="form_table">
        <tr>
            <td class="tbtext">客户名称：</td>
            <td  ><input class="nui-textbox nui-form-input" name="guestName"id="guestName" style="width: 100%"></td>
            <td class="tbtext">手机号：</td>
            <td ><input class="nui-textbox" name="mobile" style="width: 100%"></td>
        </tr>

        <tr class="odd">
            <td class="tbtext">品牌：</td>
            <td ><input class="nui-combobox" id="carBrandId" name="carBrandId"  textField="nameCn"
               valueField="nameCn" popupheight="100px;" style="width: 100%" allowInput="true"></td>
               <td class="tbtext">车架号(VIN)：</td>
               <td ><input class="nui-textbox" name="vin" style="width: 100%"></td>
           </tr> 
           <tr>
            <td class="tbtext">品牌车型：</td>
            <td ><input class="nui-textbox" name="carModel" style="width: 100%"></td>
            <td class="tbtext">发动机号：</td>
            <td ><input class="nui-textbox" name="engineNo" style="width: 100%"></td>
        </tr>
        <tr>
            <td class="tbtext">地址：</td>
            <td colspan="3" ><input class="nui-textbox" name="address" style="width: 100%"></td>
        </tr>
    </table> 

</div>

<script type="text/javascript">
    nui.parse();
    var form = new nui.Form("#form1");

    initCarBrand("carBrandId");//车辆品牌s
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