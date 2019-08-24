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
	 <script src="<%= request.getContextPath() %>/tenant/js/productManagerment_view.js?v=1.0.2" type="text/javascript"></script>
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
	     <div class="nui-toolbar" style="padding:0px;">
            <table style="width:80%;">
                <tr>
                <td style="width:80%;">
                            <a class="nui-button" onclick="save()" plain="true" ><span class="fa fa-save fa-lg"></span>&nbsp;保存 </a>
                            <a class="nui-button" onclick="onClose()" plain="true" ><span class="fa fa-close fa-lg"></span>&nbsp;取消 </a>
                  </td>
                </tr>
            </table>
            </div> 
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
                <td class="tbtext" ><span id="proUrlAll">接口地址：</span></td>
                <td colspan="3"><input class="nui-textbox" style="width:100%" name="proUrl" id="proUrl" style="display:none" /></td>

            </tr>                
                <td class="tbtext" ><span id="callNeedCoinAll">单次扣减链车币：</span></td>
                <td><input name="callNeedCoin" id="callNeedCoin" class="nui-textbox" style="width: 150px;" vtype="float" style="display:none" /></td>
            <tr>
                <td class="tbtext" ><span id="sellPriceAll">销售价：</span></td>
                <td><input name="sellPrice"  id="sellPrice" class="nui-textbox" style="width: 150px;" vtype="float"  style="display:none" /></td>
                <td class="tbtext" ><span id="periodValidityAll">有效期(天)：</span></td>
                <td><input name="periodValidity" id="periodValidity" class="nui-textbox" id="cycle" vtype="float" style="width: 150px;"  style="display:none" /></td>
            </tr>
            <tr> 
                <td class="tbtext">产品描述：</td>
                <td colspan="3"><input class="nui-textbox" style="width:100%" name="remark"/></td>

            </tr>
 
            <tr>
                <td class="tbtext">是否禁用：</td>
                <td><input name="isDisabled" id="isDisabled" class="nui-combobox" style="width: 150px;" value="0" data="isTrue" idFeild="id" textFeild="text"/></td>

            </tr>

        </table> 
    </div>
   
    <script type="text/javascript">

    </script>
</body>
</html>