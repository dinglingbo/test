<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp"%>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-27 16:00:32
  - Description:
-->
<head>
<title><b:message key="global_bizcalendar_info_jsp.work_cal_main"/></title><!-- 工作日历维护界面 -->
<script>
	function doSave(){
	 hiddenResponseMessage($id("AlertMessage"));
	  var frm = $name("dataform1");
	  if(!checkForm($name(frm))) {
		return false;
	  }
	  if(!f_check_pair()){
	  	return false;
	  }
      frm.submit();
	}
	
	function f_check_pair(){
		var b1 = $name("bizviewobj/period1Begin").value;
		var e1 = $name("bizviewobj/period1End").value;
		if(b1!=""&&e1!=""){
			if(e1<b1){
				showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair1"/>');//默认时段1的开始应该早与终止！
				return false;
			}
		}else if((b1!=""&&e1=="")||(b1==""&&e1!="")){
			showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair2"/>');//默认时段1的开始与终止应该成对出现！
			return false;
		}
		var b2 = $name("bizviewobj/period2Begin").value;
		var e2 = $name("bizviewobj/period2End").value;
		if(b2!=""&&e2!=""){
			if(e2<b2){
				showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair3"/>');//默认时段2的开始应该早与终止！
				return false;
			}
		}else if((b2!=""&&e2=="")||(b2==""&&e2!="")){
			showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair4"/>');//默认时段2的开始与终止应该成对出现！
			return false;
		}
		var b3 = $name("bizviewobj/period3Begin").value;
		var e3 = $name("bizviewobj/period3End").value;
		if(b3!=""&&e3!=""){
			if(e3<b3){
				showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair5"/>');//默认时段3的开始应该早与终止！
				return false;
			}
		}else if((b3!=""&&e3=="")||(b3==""&&e3!="")){
			showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair6"/>');//默认时段3的开始与终止应该成对出现！
			return false;
		}		
		var b4 = $name("bizviewobj/period4Begin").value;
		var e4 = $name("bizviewobj/period4End").value;
		if(b4!=""&&e4!=""){
			if(e4<b4){
				showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair7"/>');//默认时段4的开始应该早与终止！
				return false;
			}
		}else if((b4!=""&&e4=="")||(b4==""&&e4!="")){
			showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair8"/>');//默认时段4的开始与终止应该成对出现！
			return false;
		}
		if(b1==""&&b2==""&&b3==""&&b4==""){
			showMessage($id("AlertMessage"),'<b:message key="global_bizcalendar_info_jsp.check_pair9"/>');//至少要存在一对默认时段！
			return false;
		}		
		return true;
	}
	
	function f_check_timeinput(obj){
	    var str = obj.value;
        if(str.length!=8){
	        f_alert(obj,'<b:message key="global_bizcalendar_info_jsp.check_time_format1"/>');//长度不对，格式为HH:MM:SS！
			return false;
		}else{
            var reg = /^([0-1]\d|2[0-3]):[0-5]\d:[0-5]\d$/;
            if(!reg.test(str)){
                f_alert(obj,'<b:message key="global_bizcalendar_info_jsp.check_time_format2"/>');//格式不对，格式为HH:MM:SS！
                return false;
            }
        }
        return true;
    }
	
	function go2List(){
	  var frm = $name("dataform1");
	  frm.elements["_eosFlowAction"].value = "pageQuery";
      frm.submit();
	}
</script>
</head>
<body>
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
</l:present>
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<form name="dataform1" action="com.primeton.bps.web.composer.bizresouce.GlobalBizCalendarMgr.flow" target="_self" method="post">
	<input type="hidden" name="_eosFlowAction" value="save" />
	<h:hiddendata property="page" />
	<h:hiddendata property="queryViewObject" />
	<h:hidden property="bizviewobj/calendarUUID" />
	<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle">
		<l:empty property="bizviewobj/calendarUUID"><h3><b:message key="global_bizcalendar_info_jsp.add_work_cal"/></h3></l:empty><!-- 新增工作日历 -->
		<l:notEmpty property="bizviewobj/calendarUUID"><h3><b:message key="global_bizcalendar_info_jsp.edit_work_cal"/></h3></l:notEmpty><!-- 修改工作日历 -->
    	</td>
  	</tr>
  	<tr> 
    	<td width="100%">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" class="form_table">
			<tr>
				<td class="form_label" width="20%"><b:message key="global_bizcalendar_info_jsp.work_cal_name"/></td><!-- 工作日历名称 -->
				<td width="30%"><h:text property="bizviewobj/calendarName" onblur="checkInput(this)" validateAttr="allowNull=false;maxLength=40" size="32"/></td>
				<td class="form_label" width="20%"><b:message key="global_bizcalendar_info_jsp.is_default_cal"/></td><!-- 是否默认日历 -->
				<td width="30%">
					<input type="radio" name="bizviewobj/isDefault" value="1" <l:equal property="bizviewobj/isDefault" targetValue="1">checked</l:equal>><b:message key="global_bizcalendar_list_jsp.yes"/><!-- 是 -->
					<input type="radio" name="bizviewobj/isDefault" value="0" <l:equal property="bizviewobj/isDefault" targetValue="1">disabled</l:equal> <l:equal property="bizviewobj/isDefault" targetValue="0">checked</l:equal> <l:notPresent property="bizviewobj/isDefault">checked</l:notPresent>><b:message key="global_bizcalendar_list_jsp.no"/><!-- 否 -->
				</td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 1 - <b:message key="global_bizcalendar_list_jsp.start"/></td><!-- 默认时段1-始 -->
				<td><h:text property="bizviewobj/period1Begin" size="8" onblur="checkInput(this)" validateAttr="type=timeinput"/></td>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 1 - <b:message key="global_bizcalendar_list_jsp.end"/></td><!-- 默认时段1-终 -->
				<td><h:text property="bizviewobj/period1End" size="8" onblur="checkInput(this)" validateAttr="type=timeinput"/></td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 2 - <b:message key="global_bizcalendar_list_jsp.start"/></td><!-- 默认时段2-始 -->
				<td><h:text property="bizviewobj/period2Begin" size="8" onblur="checkInput(this)" validateAttr="type=timeinput"/></td>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 2 - <b:message key="global_bizcalendar_list_jsp.end"/></td><!-- 默认时段2-终 -->
				<td><h:text property="bizviewobj/period2End" size="8" onblur="checkInput(this)" validateAttr="type=timeinput"/></td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 3 - <b:message key="global_bizcalendar_list_jsp.start"/></td><!-- 默认时段3-始 -->
				<td><h:text property="bizviewobj/period3Begin" size="8" onblur="checkInput(this)" validateAttr="type=timeinput"/></td>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 3 - <b:message key="global_bizcalendar_list_jsp.end"/></td><!-- 默认时段3-终 -->
				<td><h:text property="bizviewobj/period3End" size="8" onblur="checkInput(this)" validateAttr="type=timeinput" /></td>
			</tr>
			<tr>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 4 - <b:message key="global_bizcalendar_list_jsp.start"/></td><!-- 默认时段4-始 -->
				<td><h:text property="bizviewobj/period4Begin" size="8" onblur="checkInput(this)" validateAttr="type=timeinput"/></td>
				<td class="form_label"><b:message key="global_bizcalendar_list_jsp.default_time"/> 4 - <b:message key="global_bizcalendar_list_jsp.end"/></td><!-- 默认时段4-终 -->
				<td><h:text property="bizviewobj/period4End" size="8" onblur="checkInput(this)" validateAttr="type=timeinput"/></td>
			</tr>						
			<tr>
				<td class="form_label"><b:message key="global_bizcalendar_info_jsp.desc"/></td><!-- 描述 -->
				<td colspan="3"><h:textarea property="bizviewobj/remark" style="width:80%" rows="3" validateAttr="maxLength=170" onblur="checkInput(this)"/></td>
			</tr>
			<tr>
				<td colspan="4">
					<!-- 注1:默认时段必须成对出现。默认时段是指当没有设置日历明细时，工作日所使用的工作时段。 -->
					<font><b:message key="global_bizcalendar_info_jsp.note1"/></font><br/>
					<!-- 注2：时间的格式为HH:MM:SS。 -->
					<font><b:message key="global_bizcalendar_info_jsp.note2"/></font><br/>
					<!-- 注3：修改日历时间后，必须重启服务才能生效。 -->
					<font><b:message key="global_bizcalendar_info_jsp.note3"/></font>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<input id="btnSave" name="btnSave" type="button" value='<b:message key="permission_common.btn_save"/>' class="button" onclick="doSave()"><!-- 保存 -->
					<input id="btnBack" name="btnBack" type="button" value='<b:message key="permission_common.btn_back"/>' onclick="go2List();" class="button"><!-- 返回 -->
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>
</form>
</body>
</html>
