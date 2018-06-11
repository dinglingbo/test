<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<html>
<!-- 
  - Author(s): Guine
  - Date: 2018-04-23 11:00:21
  - Description:
-->
<%
	//String contextPath = request.getContextPath();
%>
<head>
<title>提醒设置</title>
<%@include file="/common/sysCommon.jsp"%>


</head>
<body>
	<div style="border: solid 1px black; width: 40%; margin-left: 30%; margin-top: 5%;" class="nui-form" id="form1">

    <div title="修改密码" >
    <table style="border-spacing:0px 20px;">
    <tr>
    <td  style="width:30%; text-align: right; ">
    	<div style="margin-right: 10px;">距离车辆下次保养日期前后</div>
   	</td>
   	<td style="width:5%; ">
   	<div class="nui-textbox" style="width: 100%; " name="param1"></div>
    </td>
    <td  style="width:30%;">
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
    <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">车辆保养周期</div>
   	</td>
   	<td >
   	<div class="nui-textbox" style="width: 100%" name="param2"></div>
    </td>
      <td>
    	<div style=" margin-left: 5%;">月提醒</div>
   	</td>
    </tr>
      <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离车辆保险到期日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param3"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
     <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离驾照年审日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param4"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离车辆年检日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param5"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离卡到期日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param6"> </div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">月提醒</div>
   	</td>
    </tr>
    <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离客户生日日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param7"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离员工生日日期</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param8"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">天提醒</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">当客户连续</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param9"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">月未到店服务则视为流失客户</div>
   	</td>
    </tr>
         <tr>
    <td  style="text-align: right; ">
    	<div style="margin-right: 10px;">距离采购订单到货时间</div>
   	</td>
   	<td>
   	<div class="nui-textbox" style="width: 100%" name="param10"></div>
    </td>
    <td>
    	<div style=" margin-left: 5%;">小时提醒</div>
   	</td>
    </tr>
    <tr>
    <td colspan="3" align="center">
    <a class="nui-button" onclick="onOk"> 提交</a>
    </td></tr>
    </table>
    </div>
 </div>

	
</body>
 <script type="text/javascript">
    baseUrl = apiPath + sysApi + "/"; 
    var form;
		
	$(document).ready(function(v) {
		
	
		
	});

	var alarmUrl = baseUrl + "com.hsapi.system.confi.alarmSet.saveAlarmSet.biz.ext";
	function onOk(){
	
	form=new nui.Form('#form1');
	var formData=form.getData();
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存提醒设置中...'
    });
	nui.ajax({
		url:alarmUrl,
		type:"post",
		data:{
			params:formData
		},
		success: function (data) {
               if (data.errCode == "S"){
               	nui.unmask(document.body);
               	nui.alert("保存成功！");
               	}
				else{
				nui.unmask(document.body);
               	nui.alert("保存失败！");
               	}
       
           },
           error: function (jqXHR, textStatus, errorThrown) {
               nui.alert(jqXHR.responseText);
           }
	
	});
	}
      
       
  </script>
</html>