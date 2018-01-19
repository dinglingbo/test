<%@page pageEncoding="UTF-8"%>
<%@include file="/workflow/bps_composer/common/common_composer.jsp" %>
<html>
<!-- 
  - Author(s): Administrator
  - Date: 2009-07-27 09:58:22
  - Description:
-->
<head>
<title><b:message key="global_bizcalendar_list_jsp.global_work_cal_mgr"/></title><!-- 全局工作日历管理 -->
</head>
<body>
<h:form name="viewlist1" action="com.primeton.bps.web.composer.bizresouce.GlobalBizCalendarMgr.flow" method="post">
<input type="hidden" name="_eosFlowAction" value="init" >
<h:hiddendata property="queryViewObject" />
<h:hidden property="page/begin"/>
<h:hidden property="page/length"/>
<h:hidden property="page/count"/>
<h:hidden property="page/isCount"/>
<l:present property="ret/code">
	<l:notEqual property="ret/code" targetValue="1">
		<div id="ResponseMessage" class="response_message" onclick="hiddenResponseMessage(this)">&nbsp;&nbsp;<b:write property="ret/name"/>&nbsp;&nbsp;</div>
	</l:notEqual>
</l:present>
<div id="AlertMessage" class="response_message" style="display:none;" onclick="hiddenResponseMessage(this)"></div>
<table border="0" cellpadding="0" cellspacing="0" class="workarea" width="100%">
  <tr>
  	<td class="workarea_title" valign="middle"><h3><b:message key="global_bizcalendar_list_jsp.work_cal_list"/></h3></td><!-- 工作日历列表 -->
  </tr>
  <tr> 
   	<td width="100%" >
   	<table class="EOS_TABLE" width="100%" >
	   	<thead class="EOS_TABLE_HEAD">
	        <tr>
	          <th width="5%" style="white-space:nowrap"><h:checkbox name="chkall" onclick="list_selectAll()" /><b:message key="permission_common.select_all"/></th><!--  -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_cal"/></th><!-- 默认日历 -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.cal_name"/></th><!-- 日历名称 -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 1 - <b:message key="global_bizcalendar_list_jsp.start"/></th><!-- 默认时段1-始 -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 1 - <b:message key="global_bizcalendar_list_jsp.end"/></th><!-- 默认时段1-终 -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 2 - <b:message key="global_bizcalendar_list_jsp.start"/></th><!-- 默认时段2-始 -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 2 - <b:message key="global_bizcalendar_list_jsp.end"/></th><!-- 默认时段2-终 -->         
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 3 - <b:message key="global_bizcalendar_list_jsp.start"/></th><!-- 默认时段3-始 -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 3 - <b:message key="global_bizcalendar_list_jsp.end"/></th><!-- 默认时段3-终 -->       
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 4 - <b:message key="global_bizcalendar_list_jsp.start"/></th><!-- 默认时段4-始 -->
	          <th style="white-space:nowrap"><b:message key="global_bizcalendar_list_jsp.default_time"/> 4 - <b:message key="global_bizcalendar_list_jsp.end"/></th><!-- 默认时段4-终 -->
	        </tr>
		</thead>
        <w:checkGroup id="group1">
          <l:iterate property="bizviewobjs" id="id1">
            <tr class="<l:output evenOutput='EOS_table_row' />">
              <td align="center">
                <w:rowCheckbox>
                	<h:param name='selViewObject/calendarUUID' iterateId='id1' property='calendarUUID' indexed='true' />
                	<h:param name='selViewObject/calendarName' iterateId='id1' property='calendarName' indexed='true' />
                	<h:param name='selViewObject/isDefault' iterateId='id1' property='isDefault' indexed='true' />
                </w:rowCheckbox>
              </td>
              <td>
              	<l:equal iterateId="id1" property="isDefault" targetValue="1"><b:message key="global_bizcalendar_list_jsp.yes"/></l:equal><!-- 是 -->
              </td>
              <td>
                <a href="javascript:showDetail('<b:write iterateId="id1" property="calendarUUID"/>')"><b:write iterateId="id1" property="calendarName"/></a>
              </td>
              <td>
                <b:write iterateId="id1" property="period1Begin"/>
              </td>
              <td>
                <b:write iterateId="id1" property="period1End"/>
              </td>
              <td>
                <b:write iterateId="id1" property="period2Begin"/>
              </td>
              <td>
                <b:write iterateId="id1" property="period2End"/>
              </td>
              <td>
                <b:write iterateId="id1" property="period3Begin"/>
              </td>
              <td>
                <b:write iterateId="id1" property="period3End"/>
              </td>
              <td>
                <b:write iterateId="id1" property="period4Begin"/>
              </td>
              <td>
                <b:write iterateId="id1" property="period4End"/>
              </td>
            </tr>
          </l:iterate>
        </w:checkGroup>
        <tr>
          <td colspan="11" class="command_sort_area">
          <div id="listleft" style="white-space:nowrap">
            <input id="btnAdd" name="btnAdd" type="button" value='<b:message key="permission_common.btn_add"/>' onclick="addRecord();" class="button"><!-- 新增 -->
            <l:greaterThan property="page/count" targetValue="0" compareType="number">
              <input id="btnEdit" name="btnEdit" type="button" value='<b:message key="permission_common.btn_edit"/>' onclick="modiRecord();" class="button"><!-- 修改 -->
              <input id="btnDel" name="btnDel" type="button" value='<b:message key="permission_common.btn_del"/>' onclick="delRecord();" class="button"><!-- 删除 -->
              <input id="btnDetail" name="btnDetail" type="button" value='<b:message key="global_bizcalendar_list_jsp.btn_detail_def"/>' onclick="showDetailRecord();" class="button"><!-- 明细定义 -->
            </l:greaterThan>
          </div>
          <div id="listright" style="white-space:nowrap">
              <l:equal property="page/isCount" targetValue="true"><!-- 共 -->
                <b:message key="permission_common.page_info1"/>
                <b:write property="page/count"/><!-- 条记录 第 -->
                <b:message key="permission_common.page_info2"/>
                <b:write property="page/currentPage"/><!-- 页/ -->
                <b:message key="permission_common.page_info3"/>
                <b:write property="page/totalPage"/><!-- 页 -->
                <b:message key="permission_common.page_info4"/>
              </l:equal>
              <l:equal property="page/isCount" targetValue="false"><!-- 第 -->
                <b:message key="permission_common.page_info5"/>
                <b:write property="page/currentPage"/><!-- 页 -->
                <b:message key="permission_common.page_info6"/>
              </l:equal>
              <input id="btnFirst" name="btnFirst" type="button" onclick="firstPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_first"/>'  <l:equal property="page/first" targetValue="true">disabled</l:equal> ><!-- 首页 -->
              <input id="btnPrev" name="btnPrev" type="button" onclick="prevPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_prev"/>' <l:equal property="page/first" targetValue="true">disabled</l:equal> ><!-- 上页 -->
              <input id="btnNext" name="btnNext" type="button" onclick="nextPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_next"/>' <l:equal property="page/last" targetValue="true">disabled</l:equal> ><!-- 下页 -->
              <l:equal property="page/isCount" targetValue="true">
                <input id="btnLast" name="btnLast" type="button" onclick="lastPage('page', 'pageQuery', null, null, 'viewlist1');" value='<b:message key="permission_common.btn_last"/>' <l:equal property="page/last" targetValue="true">disabled</l:equal> ><!-- 尾页 -->
              </l:equal>
          </div>
          </td>
        </tr>
      </table>
  </td>
  </tr>
</table>
</h:form>
  <script>
  	function showDetailRecord(){
  		hiddenResponseMessage($id("AlertMessage"));
  		var g = $id("group1");
      	if (g.getSelectLength() != 1) {
        	showMessage($id("AlertMessage"),Alert_Message_SelectOne);
        	return;
      	}
      	var calendarID = g.getSelectParams("selViewObject/calendarUUID");
      	showDetail(calendarID)
  	}
  	
    function addRecord() {
	    hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      var frm = $name("viewlist1");
      frm.elements["_eosFlowAction"].value = "addRecord";
      frm.submit();
    }
    function modiRecord() {
    	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() != 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectOne);
        return;
      }
      var frm = $name("viewlist1");
      frm.elements["_eosFlowAction"].value = "modiRecord";
      frm.submit();
    }
    function delRecord() {
    	hiddenResponseMessage($id("AlertMessage"));
      var g = $id("group1");
      if (g.getSelectLength() < 1) {
        showMessage($id("AlertMessage"),Alert_Message_SelectMore);
        return;
      }
      var params = g.getSelectParams("selViewObject/isDefault");
      for(i=0;i<params.length;i++){
      	var t = params[i];
      	if(t=="1"){
      		showMessage($id("AlertMessage"),Alert_Message_CannotDelDefaultCal);
      		return;
      	}
      }
	  var names = g.getSelectParams("selViewObject/calendarName");
      var nameStr = "";
      for(i=0;i<names.length;i++){
        	nameStr += names[i]+";";
      }
      var argument = new Array(2);
      //"确定要删除["+nameStr+"]("+i+"个)工作日历吗?"
	  argument[0]='<b:message key="global_bizcalendar_list_jsp.confirm_del_tip1"/>'+nameStr+']('+i+'<b:message key="global_bizcalendar_list_jsp.confirm_del_tip3"/>';
	  showModalCenter("<%=request.getContextPath()%>/workflow/bps_composer/common/ConfirmWin.jsp",argument,callBack4Del,'300','125','<b:message key="permission_common.confirm_dialog"/>');//确认框
    }
    
    function callBack4Del(value){
    	if(value==""){
			return;
		}
        if(value[0]=="Y"){
            var frm = $name("viewlist1");
      		frm.elements["_eosFlowAction"].value = "delRecord";
      		frm.submit();
        }
    }
    
    var locale ='<b:write property="language" scope="session"/>';
    
    function showDetail(id){
    	//alert(locale);
    	hiddenResponseMessage($id("AlertMessage"));
    	var pageURL = "<%=request.getContextPath()%>/workflow/bps_composer/flex/bizCalendarEditor.jsp?locale="+locale+"&calendarUUID="+id;
        window.open(pageURL,'<b:message key="permission_common.cal_detail"/>',"");//日历明细
    }
  </script>
</body>
</html>