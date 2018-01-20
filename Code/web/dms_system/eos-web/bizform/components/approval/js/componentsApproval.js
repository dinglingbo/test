$(function(){
	
	bps = window['bps'] || {
		version: "1.0.0.0"
	};
	
	bps.ns("bps.components");
	
	/**
	 * 审批组件
	 */
	bps.components.reg({
		id:"approval",
		afterCreate: function(e){
			var instance = e.instance;	 //通过e.instance 访问当前组件的实例
			instance.superclass.afterCreate(e);
		},
		click: function(e){
			var instance = e.instance;
			var currentState = bps.components.core.getPageContext().workItem.currentState;
			if(currentState != 10) {
				alert(instance.approval.cannotSubmit);
			} else {
				//配置策略
				instance.data.isFinishWorkItem = false;//不完成工作项,交给提交组件做
				instance.data.isSaveFormData = false;//不保存表单数据,交给提交组件做
				
				var url = bps.components.core.getContextPath()+"/bizform/components/approval/addApproval.jsp";
				
				nui.open({
					url : url,
					title: instance.approval.title,
					width: 450,
					height: 300,
					onload: function(){
						var iframe = this.getIFrameEl();
						iframe.contentWindow.setData({workItemID: bps.components.core.getPageContext().workItemID,
							approvalMsg: instance.approvalMsg});
					},
					ondestroy: function(action){
						if(action == "ok"){
							var iframe = this.getIFrameEl();
							var data = iframe.contentWindow.getData();
							data = nui.clone(data);
							if(data){
								instance.approvalMsg = instance.approvalMsg || {};
								bps.apply(instance.approvalMsg, data);
								
								instance.superclass.click(e);
								
								//使用2次请求
								if(instance.approvalWay == "approvalAndSubmit"){//提交
									var submitComponents = bps.components.get("submit");
									submitComponents.click({
										instance: submitComponents
									});
								}
							}
						}
					}
				});
				
			
			}
		},
		beforeSubmitData: function(data){
			bps.apply(data,{
				"workItemID": bps.components.core.getPageContext().workItemID//提交工作项ID
			});
			bps.apply(data, {
				customSaveComponentsBiz:"org.gocom.bps.web.bizform.components.approval.approvalManager.addOrUpdateApprovalMsg.biz.ext"
			});
			if(this.approvalMsg){
				bps.apply(data.extData, this.approvalMsg);
			}
		},
		afterSubmitData: function(data){
			
		}
	});
	
    window['bps'] = bps;
});