$(function(){
	
	bps = window['bps'] || {
		version: "1.0.0.0"
	};
	
	bps.ns("bps.components");
	
	/**
	 * 通知组件
	 */
	bps.components.reg({
		id:"notification",
		afterCreate: function(e){
			var instance = e.instance;	 //通过e.instance 访问当前组件的实例
			instance.superclass.afterCreate(e);
		},
		click: function(e){
			var instance = e.instance;
			
			var url = bps.components.core.getContextPath()+"/bizform/components/notification/addNotification.jsp";
			
			nui.open({
				url : url,
				title: instance.notification.title,
				width: 450,
				height: 300,
				onload: function(){
					var iframe = this.getIFrameEl();
					var notificationData = instance.notificationData;
					if(notificationData){
						iframe.contentWindow.setData(notificationData);
					}else{
						//首次进入
						var data = {
								workItemID: bps.components.core.getPageContext().workItemID,
								receiverStrategy: instance.notificationStrategy
						};
						iframe.contentWindow.setData(data);
					}
				},
				ondestroy: function(action){
					var iframe = this.getIFrameEl();
					var data = iframe.contentWindow.getData();
					if(data){
						data = nui.clone(data);
					}
					instance.notificationData = data;//保存数据
					if(action == "ok"){
						//发送通知
						instance.superclass.click(e);
					}
				}
			});
			
		},
		beforeSubmitData: function(data){
			bps.apply(data,{
				"workItemID": bps.components.core.getPageContext().workItemID//提交工作项ID
			});
			//发送通知不需要保存表单数据，不需要完成工作项
			data.isSaveFormData = false;
			data.isFinishWorkItem = false;
			bps.apply(data, {
				//业务开发人员自定义的保存表单控件业务逻辑流；目前提交组件就是保存选择的参与者，选择的后继活动
				customSaveComponentsBiz:"org.gocom.bps.web.bizform.components.notification.notificationManager.sendNotification.biz.ext"
			});
			if(this.notificationData){
				bps.apply(data.extData, this.notificationData);//通知数据
			}
		},
		afterSubmitData: function(data){
			
		}
	});
	
    window['bps'] = bps;
});