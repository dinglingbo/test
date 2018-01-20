(function(){
	bps = window['bps'] || {};
	
	bps.ns("bps.components.config");
	
	//业务开发人员扩展配置对象
	bps.apply(bps.components.config, {
		tabList: ["flowForm", "approvalTrack", "approvalMsgList", "processMonitor"],//所有tabid列表
		activeTabID: "flowForm",//激活的tab页
		formTabID: "flowForm",//第一个表单需要提交数据
		flowForm: {dynamicUrl: function(){
				return "/bizform/forwardByWorkItem.jsp?workItemID="+bps.components.core.getPageContext().workItemID;
			}, 
			callback: function(){
				var tab = bps.components.core.getTab(bps.components.config.formTabID);
				if(bps.components.core.getPageContext().workItemID && 
						bps.components.core.getPageContext().processInstID){
					var e = {workItemID: bps.components.core.getPageContext().workItemID,
							processInstID: bps.components.core.getPageContext().processInstID};
					var workItem = bps.components.core.loadWorkItem(e.workItemID);
					e.workItem = workItem;
					//保存到公共数据区
					bps.components.core.getPageContext().workItem = workItem;
					bps.BizForm.Core.initData(tab, e);
				}else{
					bps.BizForm.Core.initData(tab, {});
				}
			}
		},
		approvalTrack: {url: "/bizform/approvalTrajectory.jsp"},
		approvalMsgList: {url: "/bizform/components/approval/approvalMsgList.jsp"},
		processMonitor: {url: "/bizform/processGraph.jsp"},
		"beforeSubmit":"beforeSubmit",//提交表单前用户扩展函数
		"getSubmitData":"getSubmitData",//获取用户提交表单函数
		"afterSubmit":"afterSubmit",//表单数据提交之后扩展函数
		"init":"initData",//用户表单页面页面初始化函数
		"getData":"getData"//框架页面关闭的时候获取数据函数
	});
	
})();