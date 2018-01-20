<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file = "/workflow/statistics/common/common.jsp"%>

<head>
<script type="text/javascript">
	var isSucc=<b:write property="isSuccess" />
	if(!isSucc){	
		var ec='<b:write property="errorCode" />';
		var em='<b:write property="errorMessage" />';
		alert(ec+':'+em);
	}
	if(isSucc){	
		
		alert("<b:message key="data_collect_jsp.js.sucess"/>");
	}
</script>

<h:script src="/workflow/statistics/js/query-common.js"></h:script>

<script type="text/javascript">

var isInit=<b:write property="isInitHistoryData"/>

var etlMethod=<b:write property="etlMethod"/>

function autoSettingEnable(){
   var ti=document.getElementById("isAuto");
   var td= document.getElementById("triggerDay");
   var th=document.getElementById("triggerHour"); 
   if(ti.value=="true"){
	   $id("showConfig").style.display = 'none';
   }else{
	   $id("showConfig").style.display="";
   }
}
   
   function autoSettingConfirm(){
   
   	if(!isInit){
   alert("<b:message key="data_collect_jsp.js.uninit"/>");
   return;
   }
   var ts=document.getElementById("saveSetting");
   var ti=document.getElementById("isAuto");
   var td= document.getElementById("triggerDay");
   var th=document.getElementById("triggerHour"); 
   if(ti.value=="true"){
   var isCon = confirm("<b:message key="data_collect_jsp.js.timer_1"/>"+td.value+"<b:message key="data_collect_jsp.js.timer_2"/>"+th.value+"<b:message key="data_collect_jsp.js.timer_3"/>");
	if(isCon) {
	 document.forms['triggerForm'].submit(); 
	}   
   }else{
  var isCon = confirm("<b:message key="data_collect_jsp.js.timer_close"/>");
	if(isCon) {
	 document.forms['triggerForm'].submit();
	  showSettingLoading();
	}  
   }
  
   }
      
   function showSettingLoading(){
	var o=showOverlay();
	var l=showTips('<b:message key="data_collect_jsp.js.timer_saving"/>...');
	l.o=o;
	
	document.getElementById("queryResult").onload = function () {
		hideLoading(l);
		this.onload=undefined;
	}
}

function init1(){

var st=document.getElementById('fromYear');
	  if(!st){
		return;
		}
	   clearOptions(st);
	   var y=(new Date()).getFullYear();
	   for(var i=-10;i<1;i++){
	   createOp(y+i,st);
	   }
	   st.value=y;
	   st.style.width='60px';
}
  
  function init2(){
  
  var oy=document.getElementById('oneYear');
	  if(!oy){
		return;
		}
	   clearOptions(oy);
	    var y=(new Date()).getFullYear();
	   for(var i=-10;i<1;i++){
	   createOp(y+i,oy);
	   }
	   oy.value=y;
	   oy.style.width='60px';
  }
  
    function init3(){
	   
	   var om=document.getElementById('oneMonth');
	  if(!om){
		return;
		}
	   clearOptions(om);
	  
	    var mm=(new Date()).getMonth();
	     for(var i=1;i<mm+2;i++){
	     createOp(i,om);
	   }
	    if(mm<1){
	    mm=1
	    }
	  om.value=mm;	   
	   om.style.width='50px';
  }
  
  
    function init4(){
   
     var td=document.getElementById('triggerDay');
		if(!td){
		return;
		}
		clearOptions(td);
		 var mm=(new Date()).getMonth()+1;
		 var intYear=(new Date()).getFullYear();
		 var intday=29;
		 var arrayLookup = { '1' : 31,'3' : 31, '4' : 30,'5' : 31,'6' : 30,'7' : 31, '8' : 31,'9' : 30,'10' : 31,'11' : 30,'12' : 31};
		 if(arrayLookup[parseInt(mm)] != null) { 
         intday=arrayLookup[parseInt(mm)];
       } 
      if (mm-2 ==0) { 
       var booLeapYear = (intYear % 4 == 0 && (intYear % 100 != 0 || intYear % 400 == 0)); 
       if(booLeapYear){
       intday=29;
        }else{
       intday=28;
       }
      } 
	    for(var i=1;i<=intday;i++){
		createOp(i,td);
		 }
		td.value='<b:write property="ecm/triggerDay"/>';
		td.style.width='40px';	
  }
  
  function init5(){ 
  
  var th=document.getElementById('triggerHour');
		if(!th){
		return;
		}
		clearOptions(th);
		for(var i=0;i<24;i++){
		createOp(i,th);
		}
		th.value='<b:write property="ecm/trggerHour"/>';
		th.style.width='40px';
  }
 
 function changeDay(){
    var y=(new Date()).getFullYear();
   
    var om=document.getElementById('oneMonth');
    var cury=document.getElementById('oneYear').value;
    var curm=om.value;
	  if(!om){
		return;
		}
	     clearOptions(om);
	    var mm=(new Date()).getMonth();

	  if(y<=cury){
	   for(var i=1;i<mm+2;i++){
	   createOp(i,om);
	   }
	   if(mm<curm-1){
	   curm=mm+1;
	   }
	   }else{
	    for(var i=1;i<13;i++){
	   createOp(i,om);
	   }
	   }
	  
	   om.value=curm;	   
	   om.style.width='50px';
 
 }
      
function initEtlTime(){

		
   var ti=document.getElementById("isAuto");
   var td= document.getElementById("triggerDay");
   var th=document.getElementById("triggerHour"); 
   if(ti.value=="false"){
	    $id("showConfig").style.display = 'none';
   }else{
	   $id("showConfig").style.display = '';
   }
   
	if(isInit){	
	
		$id("hasInitHistoryData").style.display='none';
		$id("hasInitHistoryData2").style.display='none';
	}		
	
	if(etlMethod){
	$id("etlMethod1").checked=""
	$id("etlMethod2").checked="checked"
	
	}
	
	init1();
		init2();
		init3();
		init4();
		init5();
}
	
function SubmitOneMonthItem(){
	
	 if(!isInit){
   alert("<b:message key="data_collect_jsp.js.uninit"/>");
   return;
   }
	document.forms['etlOneMonthForm'].submit();
	showCollectLoading();
	
	}
 function SubmitEtlItem() {
	
	  var isOK=confirm("<b:message key="data_collect_jsp.js.his_init"/>");
	  
	  if(isOK){
	  document.forms['etlForm'].submit();
	showInitLoading();
	  } 
}

function showInitLoading(){
	var o=showOverlay();
	var l=showTips('<b:message key="data_collect_jsp.js.his_init_2"/>...');
	l.o=o;
	
	document.getElementById("queryResult").onload = function () {
		hideLoading(l);
		this.onload=undefined;
	}
}

	function SubmitEtlCurItem() {
	if(!isInit){
   alert("<b:message key="data_collect_jsp.js.uninit"/>");
   return;
   }
	document.forms['etlCurForm'].submit();
	showCollectLoading();
}

function SubmitUnlock(){
  var isOK=confirm("<b:message key="data_collect_jsp.js.unlock_note"/>");
	  
	  if(isOK){
	  document.getElementById("lockflag").value='true';
	  document.forms['lockForm'].submit();
	  }else{
	   document.getElementById("lockflag").value='false';
	  document.forms['lockForm'].submit();
	  } 
}

function showCollectLoading(){
	var o=showOverlay();
	var l=showTips('<b:message key="data_collect_jsp.js.collecting"/>...');
	l.o=o;
	
	document.getElementById("queryResult").onload = function () {
		hideLoading(l);
		this.onload=undefined;
	}
}


   </script>

</head>
<body onLoad="initEtlTime()" style="background:#FFFFFF;repeat-x;margin-top:0px;margin-left:0px;margin-buttom:0px;background:url(<%=request.getContextPath() %>/workflow/statistics/images/MainFrameBg.gif) repeat-x">

<table  border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="data_collect_jsp.data_collect"/></td><%-- 数据汇总 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
						<div id="hasInitHistoryData" style="margin: 0">
						  <form id="etlForm" name="etlForm" action="com.primeton.bps.web.statistics.etl.etlCollect.flow?_eosFlowAction=collectHistoryData" method="post" >
						   <h:hidden name="locale" property="locale" scope="session"/>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
                             
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.history"/></td><%-- 汇总历史数据 --%>
								<td height="26" nowrap="nowrap" width="85%">
									<b:message key="data_collect_jsp.his_1"/><select name="fromYear" id="fromYear"></select><b:message key="data_collect_jsp.his_2"/> 
									<input type="button" class="button" value=<b:message key="data_collect_jsp.execute"/> onclick="SubmitEtlItem();">
								</td>
							</tr>  
						</table>
						</form>
						</div>
						   <form id="etlCurForm" name="etlCurForm" action="com.primeton.bps.web.statistics.etl.etlCollect.flow?_eosFlowAction=collectCurrentMonth" method="post" >
						   <h:hidden name="locale" property="locale" scope="session"/>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table" >
								<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.month"/></td><%-- 汇总本月数据 --%>
								<td height="26" nowrap="nowrap"><b:message key="data_collect_jsp.month_note"/> <input type="button" class="button" value=<b:message key="data_collect_jsp.execute"/> onclick="SubmitEtlCurItem()"></td>
							</tr>
							
						</table>
						</form>
						 <form id="etlOneMonthForm" name="etlOneMonthForm" action="com.primeton.bps.web.statistics.etl.etlCollect.flow?_eosFlowAction=collectOneMonth" method="post" >
						   <h:hidden name="locale" property="locale" scope="session"/>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table" >
								<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.anyMonth"/></td><%-- 汇总任一月数据 --%>
								<td height="26" nowrap="nowrap"><b:message key="data_collect_jsp.anyMonth_1"/><select name="oneYear" id="oneYear" onchange="changeDay();"></select><b:message key="data_collect_jsp.anyMonth_2"/>
								  <select name="oneMonth" id="oneMonth"></select><b:message key="data_collect_jsp.anyMonth_3"/> 
								  <input type="button" class="button" value=<b:message key="data_collect_jsp.execute"/> onclick="SubmitOneMonthItem();"></td>
							</tr>
							
						</table>
						</form>
						<div id="hasInitHistoryData2" >
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							 <tr>
								<td height="26"  class="EOS_table_row" width="15%" rowspan="2" colspan="2" align="left">&nbsp;&nbsp;<b:message key="data_collect_jsp.his_note"/></td>
							</tr>
						
						</table>
						</div>				
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>


<table  border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="data_collect_jsp.timer"/></td><%-- 数据定时汇总配置 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
                     <form id="triggerForm"  name="triggerForm" action="com.primeton.bps.web.statistics.etl.etlCollect.flow?_eosFlowAction=autoCollect" method="post" >
						<h:hidden name="locale" property="locale" scope="session"/>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.timer_setting"/></td><%--启用定时汇总功能 --%>
								<td height="26" nowrap="nowrap" width="85%">
									
                                  <h:switchCheckbox  id="isAuto" property="ecm/openEtl" checkedValue="true" uncheckedValue="false" onclick="autoSettingEnable()"/><b:message key="data_collect_jsp.timer_setting_on"/>

								</td>
							</tr>
						</table>
						<div id="showConfig" style="margin: 0">
						<table id="etlConfig" width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table" >
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.timer_date"/></td><%--定时汇总数据日期 --%>
								<td height="26" nowrap="nowrap"><b:message key="data_collect_jsp.timer_date_1"/><select name="ecm/triggerDay" id="triggerDay" ></select><b:message key="data_collect_jsp.timer_date_2"/></td>
							</tr>
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.timer_time"/></td><%--定时汇总数据时间 --%>
								<td height="26" nowrap="nowrap"><b:message key="data_collect_jsp.timer_time_1"/><select name="ecm/trggerHour" id="triggerHour" ></select><b:message key="data_collect_jsp.timer_time_2"/></td>
							</tr>
							<tr>
							</tr>
						</table>
						</div>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%" class="form_bottom" colspan="2">
								<input id="saveSetting" name="saveSetting" type="button" class="button" value="<b:message key="data_collect_jsp.save"/>" onclick="autoSettingConfirm()"></td>
							</tr>
							
						</table>
                    </form>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table  border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="data_collect_jsp.procedure"/></td><%-- 数据汇总方式配置 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
                     <form  name="procForm" action="com.primeton.bps.web.statistics.etl.etlCollect.flow?_eosFlowAction=saveEtlMethod" method="post" >
						<h:hidden name="locale" property="locale" scope="session"/>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.proc_method"/></td>
								<td height="26" nowrap="nowrap" width="85%">
                              <input type="radio" name="etlMethod" id="etlMethod1" value="false"  checked="checked"/><b:message key="data_collect_jsp.proc_method1"/> &nbsp;&nbsp;&nbsp;&nbsp;
                              <input type="radio" name="etlMethod" id="etlMethod2" value="true"  /><b:message key="data_collect_jsp.proc_method2"/>
								</td>
							</tr>
						</table>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%" class="form_bottom" colspan="2">
								<input id="saveEtlMethod" name="saveEtlMethod" type="submit" class="button" value="<b:message key="data_collect_jsp.save"/>"></td>
							</tr>
							
						</table>
                    </form>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table  border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="data_collect_jsp.email"/></td><%-- etlEmail配置 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
                     <form id="emailForm"  name="emailForm" action="com.primeton.bps.web.statistics.etl.etlCollect.flow?_eosFlowAction=saveEtlEmail" method="post" >
						<h:hidden name="locale" property="locale" scope="session"/>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.email_addr"/></td>
								<td height="26" nowrap="nowrap" width="85%">
                                    <input name="etlEmail" id="etlEmail" value="<b:write property="etlEmail"/>" size="50" maxlength="250">&nbsp;&nbsp;&nbsp;&nbsp;<b:message key="data_collect_jsp.email_note"/>
								</td>
							</tr>
						</table>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%" class="form_bottom" colspan="2">
								<input id="saveSetting" name="saveSetting" type="submit" class="button" value="<b:message key="data_collect_jsp.save"/>"></td>
							</tr>
							
						</table>
                    </form>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table  border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
	<tr>
		<td class="workarea_title" valign="middle"><b:message key="data_collect_jsp.lock"/></td><%-- etl解锁 --%>
	</tr>
	<tr>
		<td width="100%" valign="top">
		<table cellpadding="0" width="100%" cellspacing="0" border="0">
			<tr>
				<td>
				<table border="0" class="EOS_panel_body" width="100%">
					<tr>
						<td width="100%">
                     <form id="lockForm"  name="lockForm" action="com.primeton.bps.web.statistics.etl.etlCollect.flow?_eosFlowAction=lockConfig" method="post" >
						<h:hidden name="locale" property="locale" scope="session"/>
						<input type="hidden" id="lockflag" name="lockflag" value="true"/>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							<tr>
								<td height="26" nowrap="nowrap" class="EOS_table_row" width="15%"><b:message key="data_collect_jsp.unlock"/></td>
								<td height="26" nowrap="nowrap" width="85%">
                                   <input type="button" class="button" value=<b:message key="data_collect_jsp.execute"/> onclick="SubmitUnlock();">
                                  &nbsp;&nbsp;&nbsp;&nbsp;<b:message key="data_collect_jsp.unlock_note"/>
								</td>
							</tr>
						</table>
						<table width="100%" height="20%" border="0" cellpadding="0" cellspacing="0" align="center" class="form_table">
							
							<tr>
								<td colspan="2" class="form_bottom"></td>
							</tr>
						</table>
                    </form>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

</body>