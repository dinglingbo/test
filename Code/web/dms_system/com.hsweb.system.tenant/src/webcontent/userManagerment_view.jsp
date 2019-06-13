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
     <%@include file="/common/sysCommon.jsp"%>

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
<div class="nui-toolbar" style="padding:0px;border-bottom:0;display:none" id="showSave">
    <table style="width:100%;">
        <tr>
            <td style="width:100%;">
                <a class="nui-button" onclick="onOk()" plain="true" style="width: 60px;" id="onOk"><span class="fa fa-save fa-lg"></span>&nbsp;保存</a>
                <a class="nui-button" onclick="onCancel" plain="true" style="width: 60px;"><span class="fa fa-remove fa-lg"></span>&nbsp;取消</a>
            </td>
        </tr>
    </table>
</div>
  <div id="form1" class="nui-form" style="width:500px;height:auto;left:0;right:0;margin:0 auto;display: none;">
    <table style="margin-top:15px;">
         <input id="tenantId" name="tenantId" class="nui-hidden" />
        <tr>
            <td class="tbtext">租户名称：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%" name="tenantName"  id="tenantName" /></td>
			<td><input class="nui-textbox" style="width:100%" name="tenantId"  id="tenantId" visible="false" /></td>
	        </tr>
        <tr>
            <td class="tbtext">管理员：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%" id="manager" name="manager" /></td>
            </tr>        
            <tr>
            <td class="tbtext">联系电话：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%"  id="mobile" name="mobile"/></td>
            </tr>        
            <tr>
            <td class="tbtext">联系地址：</td>
            <td colspan="3"><input class="nui-textbox" style="width:100%"  id="address" name="address"/></td>
            </tr>        
            <tr>
            <td class="tbtext">业务员：</td>
            <td colspan=""><input class="nui-textbox" style="width:100%" id="salesMan" name="salesMan"/></td>
            <td class="tbtext">推荐员：</td>
            <td colspan=""><input class="nui-textbox" style="width:100%" id="referee" name="referee" /></td>
            </tr>  
            <tr>
            <td class="tbtext">省份：</td>
            <td><input class="nui-combobox" style="width: 150px;" id="provinceId" name="provinceId" onvaluechanged="onProvinceChange" textField="name" valueField="code" width="100%" popupHeight="100%"/></td>
            <td class="tbtext">城市：</td>
            <td><input class="nui-combobox" style="width: 150px;" id="cityId" name="cityId" textField="name"  valueField="code" width="100%" popupHeight="100%"/></td>
           </tr>       
            <tr>
             <td class="tbtext">开通时间：</td>
            <td>
              <input width="100%" id="startDate" name="startDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm"
									 showTime="true" showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"   />
            
            </td>
            <td class="tbtext">结束时间：</td>
            <td>
                <input width="100%" id="endDate" name="endDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm"
									 showTime="true" showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"   />
	        </td>
         
            </tr>
            
            <tr>
            
            <td class="tbtext">首次付费金额：</td>
            <td>
                <input class="nui-textbox" name="firstPayAmt" width="100%" maxlength="20" vtype="float"/>
	        </td>
            <td class="tbtext">是否付费：</td>
            <td>
             <input name="isPay" class="nui-checkbox" trueValue="1" falseValue="0" width="30%"/>
            </td>
            </tr>
            
            <tr>
             <td class="tbtext">下次续费时间：</td>
            <td>
              <input width="100%" id="nextRenewDate" name="nextRenewDate" class="nui-datepicker" value="" nullValue="null" format="yyyy-MM-dd HH:mm"
									 showTime="true" showOkButton="false" showClearButton="true" timeFormat="HH:mm:ss" width="100%"   />
            
            </td>
            <td class="tbtext">下次续费金额：</td>
            <td>
                <input class="nui-textbox" name="nextRenewAmt" width="100%" maxlength="20" vtype="float"/>
	        </td>
         
            </tr>
            
        </table> 

        <!-- <div style="text-align: center; padding: 10px;">
            <a class="nui-button" onclick="onOk()" style="margin-right: 20px;"><i class="fa fa-save"></i>&nbsp;保存</a> 
            <a class="nui-button" onclick="onCancel()"><i class="fa fa-times"></i>&nbsp;取消</a>
        </div> -->
    </div>
</div >
<script type="text/javascript">
  nui.parse();
  var form1;
  var provinceCode;
$(document).ready(function(v) {
	getProvince(function(data) {
        var list = data.rs;
        nui.get("provinceId").setData(list);

	});

});
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
        document.getElementById("showSave").style.display = "block";
        nui.layout();
    }
}

function SetInitData(data) {
    var form = new nui.Form("#form1");
    form.setData(data);   
}
var baseUrl = apiPath + sysApi + "/";
var updateUrl=baseUrl + "com.primeton.tenant.comTenant.updateComTenant.biz.ext";
function onOk(){
     var form = new nui.Form("#form1");
     var s=form.getData();
     if(s.startDate) {
		s.startDate = format(s.startDate, 'yyyy-MM-dd HH:mm:ss');
	}
    if(s.endDate) {
    	s.endDate = format(s.endDate, 'yyyy-MM-dd HH:mm:ss');
	}
	if(s.nextRenewDate) {
    	s.nextRenewDate = format(s.nextRenewDate, 'yyyy-MM-dd HH:mm:ss');
	}
	 nui.ajax({
        url: updateUrl,
        type: 'post',
        data: nui.encode({
        	params:s
        }),
        cache: false,
        success: function (data) {
            if (data.errCode == "S"){
           	 closeWindow("ok");
             }else {
            showMsg("修改失败","E");
                /* nui.alert("失败！"); */
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            nui.alert(jqXHR.responseText);
        }
	});
}
function onProvinceChange(e){
    var se = e.selected;
    provinceCode = se.code;
    getProvince(function(data) {
    	  nui.get("cityId").setData(data.rs);
    });
}
var queryUrl = baseUrl + "com.hs.common.region.getRegin.biz.ext";
function getProvince(callback) {

    nui.ajax({
        url : queryUrl,
        data : {
        	parentId:provinceCode,
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.rs) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
           console.log(jqXHR.responseText);
        }
    });
}
</script>
</body>
</html>