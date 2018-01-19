<%@page import="com.eos.data.datacontext.IMUODataContext"%>
<%@page import="com.primeton.ext.data.datacontext.http.MUODataContext"%>
<%@page import="com.eos.data.datacontext.IUserObject"%>
<%@page import="com.eos.data.datacontext.DataContextManager"%>
<%@page import="com.primeton.bps.web.control.I18nUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@page import="com.eos.workflow.api.BPSServiceClientFactory"%>
<%@page import="com.eos.workflow.data.WFWorkItem"%>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): wujun
  - Date: 2014-12-25 17:40:19
  - Description:
-->
<head>
<%@include file="/bizform/bizformCommon.jsp" %>
<title><%=I18nUtil.getMessage(request, "bps.bizform.BizformFramework") %></title>
	<script type="text/javascript">
		<%
// 		    Long workItemID = (Long)request.getAttribute("workItemID");
		    Long workItemID = Long.parseLong(request.getParameter("workItemID"));
			WFWorkItem workItem = BPSServiceClientFactory.getDefaultClient().getWorkItemManager().queryWorkItemDetail(workItemID);
			IMUODataContext cxt = DataContextManager.current().getMUODataContext();
			String participantID = null;
			if(cxt != null){
				IUserObject userObject = cxt.getUserObject();
				if(userObject != null){
					participantID = userObject.getUserId();
				}
			}
		%>
		bps.components.core.getPageContext().workItemID=<%=workItem.getWorkItemID()%>;
		bps.components.core.getPageContext().processInstID=<%=workItem.getProcessInstID()%>;
		bps.components.core.getPageContext().participantID="<%=participantID%>";
		bps.components.core.setContextPath(contextPath);
	</script>
</head>
<body style="padding:5px;">
<div class="nui-fit" style="padding:5px;">
	<div id="btn">
	</div>
	<div id="tab" style="height:90%;"></div>
</div>
</body>
<script type="text/javascript">
	nui.parse();
	
	bps.BizForm.config.btnCols = 4;
	//@Review render 改成bind {wuyh}
	bps.BizForm.Core.renderBtnsTo("btn");
	bps.BizForm.Core.renderTabsTo("tab");
	//@Review ajax提交需要制定个标准。
	nui.ajax({
        url: "org.gocom.bps.web.bizform.bizformcomponent.getDataByWorkItemId.biz.ext",
 		 type:'POST',
  		 cache:false,
  		async: false,
        data:{
        	workItemId:bps.components.core.getPageContext().workItemID
		},
        success:function(data) {
        	data = nui.decode(data)["data"];
        	if(!data || !data.buttons || !data.tabs){
        		tfcToast.take("<%=I18nUtil.getMessage(request, "bps.bizform.LoadControlFail") %>");
        		return ;
        	}
        	debugger;
        	var btns = data.buttons;
        	var tabs = data.tabs;
			bps.BizForm.Core.renderBtns(btns);
			bps.BizForm.Core.renderTabs(tabs);
			
			//@Review 配置信息统一抽出一个js文件，业务开发人员方便扩展button, tab页，同时需要考虑url, jsp的扩展，替换 {liuxiang}	
			//支持扩展加载
			for(var i=0,len = bps.components.config.tabList.length;i<len;i++){
				(function(){
					var tabID = bps.components.config.tabList[i];
					var tab = bps.components.core.getTab(tabID);
					var tabURL = bps.components.config[tabID].url;
					if(!tabURL && bps.components.config[tabID].dynamicUrl){//支持动态URL，为了传递参数
						tabURL = bps.components.config[tabID].dynamicUrl();
					}
					if(tab && tabURL){
						if(tab && bps.components.config[tabID].callback){//支持回调
							 bps.BizForm.Core.setTabUrl(tab, bps.components.core.getContextPath()+tabURL, function(){
								if(tab && bps.components.config[tabID].callback){//支持回调
									bps.components.config[tabID].callback();
								}
							 });
						}else{
							bps.BizForm.Core.setTabUrl(tab, bps.components.core.getContextPath()+tabURL);
						}
					}
				})();
			}
			
			//默认激活某个tab页
			var activeTabID = bps.components.config.activeTabID; 
			if(activeTabID){
				var activeTab = bps.components.core.getTab(activeTabID);
				if(activeTab){
					bps.BizForm.tabs.activeTab(activeTab);
				}
			}
		}
	});
	
</script>
</html>