<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!--
  - Author(s): Administrator
  - Date: 2018-05-04 14:17:55
  - Description:
-->
<head>    
    <title>产品管理-弹出窗</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/common/nui/date.js" type="text/javascript"></script>
    <link href="<%=request.getContextPath()%>/common/nui/themes/blue2010/skin.css" rel="stylesheet" type="text/css" />
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">
    html, body{
        margin:0px;padding:0px;border:0px;width:100%;height:100%;overflow:hidden;
    }

    .mini-grid-headerCell, .mini-grid-topRightCell
    {
        font-weight:bold;
    }
    .mini-panel-border {
        border-radius: 0px;
    }
    .tbtext{
        width: 100px;
        text-align: right;
    }
</style>
</head>
<body>

    <div id="form1"  style="width:630px;height:auto;margin-top:15px;margin-left:auto; margin-right:auto;" >
        <table style="margin-top:15px;left:0;right:0;margin:0 auto;"> 
            <tr> 
                <td class="tbtext">产品名称：</td>
                <td><input class="nui-textbox" style="width: 150px;"/></td>
                <td class="tbtext">产品类型：</td>
                <td><input class="nui-textbox" style="width: 150px;"/></td>
                <td style="width: 100px;"></td>
            </tr>
            <tr> 
                <td class="tbtext">产品描述：</td>
                <td colspan="3"><input class="nui-textbox" style="width:100%" /></td>

            </tr>
            <tr>
                <td class="tbtext">是否限定周期：</td>
                <td colspan="3"><input id="isLimitedCycle" class="nui-combobox" style="width:100%" data="isTrue" idFeild="id" textFeild="text" onvaluechanged="isLimitedCycleChanged"/></td>
            </tr>      
            <tr>
                <td class="tbtext">产品限定周期：</td>
                <td><input id="productLimitedCycle" class="nui-textbox" style="width: 150px;" enabled="false"/></td>
                <td class="tbtext">周期消费次数：</td>
                <td><input id="costNumCycle" class="nui-textbox" style="width: 150px;"  enabled="false"/></td>
            </tr>
 
            <tr>
                <td class="tbtext">原价：</td>
                <td><input class="nui-textbox" style="width: 150px;"/></td>
                <td class="tbtext">活动价：</td>
                <td><input class="nui-textbox" style="width: 150px;"/></td>

            </tr>

            <tr>
                <td class="tbtext">是否推荐：</td>
                <td><input class="nui-combobox" style="width: 150px;" data="isTrue" idFeild="id" textFeild="text"/></td>
                <td class="tbtext">排序号：</td>
                <td><input class="nui-textbox" style="width: 150px;"/></td>

            </tr>

        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="onOk()" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>
   
    <script type="text/javascript">
        var isTrue = [{id:1,text:"是"},{id:0,text:"否"}];
        var form = new nui.Form("#form1");
        nui.parse();
        var productLimitedCycle = nui.get("productLimitedCycle");//产品限定周期
        var costNumCycle = nui.get("costNumCycle");//周期消费次数
        var isLimitedCycle = nui.get("isLimitedCycle");//是否限定周期
        function isLimitedCycleChanged(){
            var isLimitedCycle_value = isLimitedCycle.value;
            if(isLimitedCycle_value == "0"){
                costNumCycle.disable();
                costNumCycle.setValue(null);
                costNumCycle.setRequired(false);
                costNumCycle.setIsValid(true);
                productLimitedCycle.disable();
                productLimitedCycle.setValue(null);
                productLimitedCycle.setRequired(false);
                productLimitedCycle.setIsValid(true);
            }
            if(isLimitedCycle_value == "1"){
                costNumCycle.enable();
                costNumCycle.setRequired(true);//设置为必填
                productLimitedCycle.enable();
                productLimitedCycle.setRequired(true);
            }
        }


        function saveData(){
            form.validate();
            //保存
            nui.alert("保存操作!");
        }


        function onOk(e) {
            saveData();
        }
        function onCancel(e) {
            if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
            else window.close();
        }
    </script>
</body>
</html>