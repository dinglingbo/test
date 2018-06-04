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
    <title>公共表格</title>
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
        width: 90px;
        text-align: right;
    }
</style>
</head>
<body>
    <div class="nui-fit">
        <div id="grid1" class="nui-datagrid" datafield=""  selectonrightclick="false" allowcellwrap="true" showpager="false"
        style="width:100%;height:100%;display:none" bodyStyle="padding:0;border:0;" allowcellselect="true" >
        <div property="columns">
            <div field="" name="" headeralign="center" align="center" width="70">产品名称</div>
            <div field="" name="" headeralign="center" align="center" width="70">产品类型</div>
            <div field="" name="" headeralign="center" align="center" width="70">开通时间</div>
            <div field="" name="" headeralign="center" align="center" width="70">结束时间</div>
            <div field="" name="" headeralign="center" align="center" width="70">用户数量</div>
            <div field="" name="" headeralign="center" align="center" width="70">赠送时长(月)</div>
        </div>
    </div>

    <div id="grid2" class="nui-datagrid" datafield=""  selectonrightclick="false" allowcellwrap="true" showpager="false"
    style="width:100%;height:100%;display:none" bodyStyle="padding:0;border:0;" allowcellselect="true" >
    <div property="columns">
        <div field="" name="" headeralign="center" align="center" width="70">订单单号</div>
        <div field="" name="" headeralign="center" align="center" width="70">订单时间</div>
        <div field="" name="" headeralign="center" align="center" width="70">产品ID</div>
        <div field="" name="" headeralign="center" align="center" width="70">产品名称</div>
        <div field="" name="" headeralign="center" align="center" width="70">产品类型</div>
        <div field="" name="" headeralign="center" align="center" width="70">开通时间</div>
        <div field="" name="" headeralign="center" align="center" width="70">结束时间</div>
        <div field="" name="" headeralign="center" align="center" width="70">是否付款</div>
        <div field="" name="" headeralign="center" align="center" width="70">付款时间</div>
        <div field="" name="" headeralign="center" align="center" width="70">付款方式</div>
        <div field="" name="" headeralign="center" align="center" width="70">订单状态</div>
        <div field="" name="" headeralign="center" align="center" width="70">是否生效</div>
    </div>
</div>

<div id="grid3" class="nui-datagrid" datafield=""  selectonrightclick="false" allowcellwrap="true" showpager="false"
style="width:100%;height:100%;display:none" bodyStyle="padding:0;border:0;" allowcellselect="true" >
<div property="columns">
    <div field="" name="" headeralign="center" align="center" width="70">订单单号</div>
    <div field="" name="" headeralign="center" align="center" width="70">产品ID</div>
    <div field="" name="" headeralign="center" align="center" width="70">产品名称</div>
    <div field="" name="" headeralign="center" align="center" width="70">付款方式</div>
    <div field="" name="" headeralign="center" align="center" width="70">付款金额</div>
    <div field="" name="" headeralign="center" align="center" width="70">付款时间</div>
    <div field="" name="" headeralign="center" align="center" width="70">是否已开票</div>
</div>
</div>

<div id="grid4" class="nui-datagrid" datafield=""  selectonrightclick="false" allowcellwrap="true" showpager="false"
style="width:100%;height:100%;display:none" bodyStyle="padding:0;border:0;" allowcellselect="true" >
<div property="columns">
    <div field="" name="" headeralign="center" align="center" width="70">开票时间</div>
    <div field="" name="" headeralign="center" align="center" width="70">票据类型</div>
    <div field="" name="" headeralign="center" align="center" width="70">发票抬头</div>
    <div field="" name="" headeralign="center" align="center" width="70">邮寄地址</div>
    <div field="" name="" headeralign="center" align="center" width="70">发票金额</div>
    <div field="" name="" headeralign="center" align="center" width="70">收件人姓名</div>
    <div field="" name="" headeralign="center" align="center" width="70">收件人电话</div>
</div>
</div>
<div id="form1"  style="width:500px;height:auto;left:0;right:0;margin:0 auto;display: none;">
    <table style="margin-top:15px;">
        <tr>
            <td class="tbtext">租户名称：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%" /></td>

        </tr>

        <tr>
            <td class="tbtext">省份：</td>
            <td><input class="nui-combobox" style="width: 150px;"/></td>
            <td class="tbtext">城市：</td>
            <td><input class="nui-combobox" style="width: 150px;"/></td>

        </tr>
        <tr>
            <td class="tbtext">管理员：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%"  /></td>
            </tr>        
            <tr>
            <td class="tbtext">联系电话：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%"  /></td>
            </tr>        
            <tr>
            <td class="tbtext">联系地址：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%"  /></td>
            </tr>        
            <tr>
            <td class="tbtext">业务员：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%"  /></td>
            </tr>         
            <tr>
            <td class="tbtext">推荐员：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%"  /></td>
            </tr>
        </table> 

        <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div>
    </div>
</div >
<script type="text/javascript">
  nui.parse();

  function ShowGrid(e){
    if(e == 1){
        document.getElementById("grid1").style.display = "block";
        nui.layout();
    }
    if(e == 2){
        document.getElementById("grid2").style.display = "block";
        nui.layout();
    }
    if(e == 3){
        document.getElementById("grid3").style.display = "block";
        nui.layout();
    }
    if(e == 4){
        document.getElementById("grid4").style.display = "block";
        nui.layout();
    }
    if(e == 5){
        document.getElementById("form1").style.display = "block";
        nui.layout();
    }
}

</script>
</body>
</html>