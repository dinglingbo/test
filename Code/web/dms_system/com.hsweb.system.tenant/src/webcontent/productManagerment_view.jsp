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
    <%@include file="/common/sysCommon.jsp"%>
	 <script src="<%= request.getContextPath() %>/tenant/js/productManagerment_view.js?v=1.0.1" type="text/javascript"></script>
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

    <div id="form1"  style="width:630px;height:auto;margin-top:15px;margin-left:auto; margin-right:auto;" class="nui-form" >
        <table style="margin-top:15px;left:0;right:0;margin:0 auto;"> 
            <tr> 
                <td class="tbtext">产品名称：</td>
                <td><input class="nui-textbox" style="width: 150px;" name="name"/></td>
                <td class="tbtext">产品类型：</td>
                <td ><input   name="type"  id="type" class="nui-combobox" style="width:100%" dataField="typeList" data="typeList"  class="nui-combobox" valueField="id" textField="name" value="0" onvaluechanged="typeChanged()" /></td>
                <td style="width: 100px;"></td>
                <td><input class="nui-textbox" style="width: 150px;" name="id" visible="false"/></td>
            </tr>
            <tr> 
                <td class="tbtext">接口地址：</td>
                <td colspan="3"><input class="nui-textbox" style="width:100%" name="remark"/></td>

            </tr>                
                <td class="tbtext">单次扣减链车币：</td>
                <td><input name="salesPrice1" class="nui-textbox" style="width: 150px;"/></td>
            <tr>
                <td class="tbtext">销售价：</td>
                <td><input name="consumptionTimes"  id="consumptionTimes" class="nui-textbox" style="width: 150px;"  enabled="false"/></td>
                <td class="tbtext">有效期：</td>
                <td><input name="cycle" class="nui-textbox" id="cycle" style="width: 150px;" enabled="false"/></td>
            </tr>
            <tr> 
                <td class="tbtext">产品描述：</td>
                <td colspan="3"><input class="nui-textbox" style="width:100%" name="remark"/></td>

            </tr>
 
            <tr>
                <td class="tbtext">是否禁用：</td>
                <td><input name="isRecommend" class="nui-combobox" style="width: 150px;" data="isTrue" idFeild="id" textFeild="text"/></td>

            </tr>

        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="onOk()" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>
   
    <script type="text/javascript">

    </script>
</body>
</html>