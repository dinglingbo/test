<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/bps/wfclient/common/common.jsp"%>
<html>
<head>
<title><%=I18nUtil.getMessage(request,"bps.wfclient.notification.NoticeList")%></title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body style="width: 98%" class="body-font">
	<div id="queryform" class="nui-from" align="center">	
		<table id="table1" style="width: 100%;height:72px;" align="center" >
			<tr>
				<td  width="70"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.NoticeID")%></td>
				<td><input class="nui-textbox" name="notificationID" width="200px">
				</td>
				<td  width="70"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.Title")%>:</td>
				<td><input class="nui-textbox" name="title" width="200px">
				</td>
				<td  align="right" rowspan="2">
					<a class="nui-button grayBtn" onclick="search"><%=I18nUtil.getMessage(request, "bps.wfclient.common.Query")%></a>
				</td>
			</tr>
				<tr>
				<td  width="70"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.Message")%>:</td>
				<td><input class="nui-textbox" name="message" width="200px">
				</td>
				<td  width="70"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.TimeOutFlag")%>:</td>
				<td><input id="timeOutFlag" class="nui-combobox" name="timeOutFlag" showNullItem="false" value="" 
				data="[{id:'',text:'<%=I18nUtil.getMessage(request, "bps.wfclient.bizdict.All")%>'},
					{id:'Y',text:'<%=I18nUtil.getMessage(request, "bps.wfclient.bizdict.Yes")%>'},
					{id:'N',text:'<%=I18nUtil.getMessage(request, "bps.wfclient.bizdict.No")%>'}]" width="200px"/>
				</td>	
			</tr>			
		</table>	
	</div>
	<div id="notificationListId" class="nui-datagrid bpsDatagrid"
		style="margin-top:15px;width: 100%;" dataField="notificationList"
		url="org.gocom.bps.wfclient.task.business.notice.queryNotificationList.biz.ext"
		allowAlternating="true" pageSize="10" showPager="true" >
		<div property="columns">
			<div name="action" headerAlign="center" align="center" renderer="onActionRenderer" cellStyle="padding:0;" width="100"><%=I18nUtil.getMessage(request, "bps.wfclient.common.Operation")%></div>
			<div field="notificationID" headerAlign="center" align="center" width="60"><%=I18nUtil.getMessage(request,"bps.wfclient.notification.NoticeID")%></div>
			<div field="title" headerAlign="center" align="center" width="65"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.Title")%></div>
			<div field="message" headerAlign="center" align="center" width="75"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.Message")%></div>
			<div field="sender" headerAlign="center" align="center" width="60"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.Sender")%></div>
			<div field="workItemID" headerAlign="center" align="center" width="65"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.WorkItemID")%></div>
			<div field="createTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd hh:MM" width="130"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.CreateTime")%></div>
			<div field="remindTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd hh:MM" width="130"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.RemindTime")%></div>
			<div field="finalTime" headerAlign="center" align="center" dateFormat="yyyy-MM-dd hh:MM" width="130"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.OutTime")%></div>
			<div field="timeOutFlag" headerAlign="center" align="center" renderer="doChangetimeOutFlag" width="40"><%=I18nUtil.getMessage(request, "bps.wfclient.notification.TimeOutFlag")%></div>
		</div>
	</div>
	<!-- for integration coframe
	<div class="pager" style="height:30px;width:100%">
		<div id="pager" class="nui-bpspager"  datagridId="notificationListId"></div>
	</div>
	 -->
	<script type="text/javascript">
    	nui.parse();
		var grid =nui.get("notificationListId");
		var combox=nui.get("timeOutFlag");
		combox.select(0);
		var data = {};
		var state='<%=request.getParameter("state")%>';
		data.state = state;
		grid.load(data);
		//var pager = nui.get("pager");
		//pager.setDatagridParams(data);
		
    	
		resizeDatagridHeight();
    	$(window).bind("resize", resizeDatagridHeight);
    	// 自动调整datagrid的外部高度,撑满屏幕
    	function resizeDatagridHeight(){
    		var realheight = window.innerHeight || (document.documentElement && document.documentElement.clientHeight) || document.body.clientHeight;
    		if((navigator.userAgent.indexOf('Firefox') >= 0 || navigator.userAgent.indexOf('Chrome') >= 0)){
				realheight  -= 25;
			}
	    	realheight = realheight - 125 - 20  + "px";
	    	var datagridObj = document.getElementById("notificationListId");
	    	datagridObj.style.height=realheight;
    	}

		function onActionRenderer(e) {
			var s = "";
			if (state == "UNVIEWED") {
				s = s + '<a class="dgBtn" href="javascript:confirm(' + e.rowIndex + ')"><%=I18nUtil.getMessage(request, "bps.wfclient.common.Confirm")%></a> ';
			}
			s = s + '<a class="dgBtn" href="javascript:doShowNotificationDetail(' + e.rowIndex + ')"><%=I18nUtil.getMessage(request, "bps.wfclient.common.View")%></a> ';
			return s;
		}
			
		function doShowNotificationDetail(rowIndex) {
			var row = grid.getRow(rowIndex);
			nui.open({
				url : contextPath+ "/bps/wfclient/task/showNotificationDetail.jsp",
				title : "<%=I18nUtil.getMessage(request, "bps.wfclient.notification.ShowNoticeDetail")%>",
				width : 850,
				height : 360,
				onload : function() {
					var iframe = this.getIFrameEl();
					if (iframe.contentWindow.initData) {
						iframe.contentWindow.initData(row, state);
					}
				},
				ondestroy : function(action) {
					if (action == "ok") {
						grid.reload();
					}
				}
			});
		}

		function confirm(rowIndex) {
			var row = grid.getRow(rowIndex);
			var data = {
				notificationID : row.notificationID
			};
			var json = nui.encode(data);//将数据转换成json格式		    	
			nui.ajax({
					url : "org.gocom.bps.wfclient.task.business.notice.confrimNotification.biz.ext",
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						grid.reload();
					}
			});
		}

		function search(e) {
			var form = new nui.Form("#queryform");
			var json = form.getData(false, false);
			json.search = "search";
			json.state = state;
			grid.load(json);//grid查询
			//pager.setDatagridParams(json);
		}
		//超时
        var timeFlag={
        	"Y":"<%=I18nUtil.getMessage(request, "bps.wfclient.bizdict.Yes")%>",
        	"N":"<%=I18nUtil.getMessage(request, "bps.wfclient.bizdict.No")%>"
        };
		function doChangetimeOutFlag(e) {
			return timeFlag[e.value];
		}
	</script>
</body>
</html>
