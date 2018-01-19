$(function(){
	
	bps = window['bps'] || {
		version: "1.0.0.0"
	};
	
	bps.ns("bps.components");
	
	bps.ns("bps.components.back.config");
	
	bps.apply(bps.components.back.config, {
		loadUrl: bps.components.core.getContextPath()+"/bizform/components/back/backActivity.jsp",
		width: 450,
		height: 300,
		one_step : {//单步回退
			width: 350,
			height:120
		},
		recent_manual: {//最近的人工活动
			width: 350,
			height:120
		},	
		simple_appoint: {//最近的人工活动
			width: 350,
			height:120
		}		
	});
	
	/**
	 * 回退组件
	 */
	bps.components.reg({
		id:"backActivity",
		afterCreate: function(e){
			var instance = e.instance;	 //通过e.instance 访问当前组件的实例
			instance.superclass.afterCreate(e);
			
			//配置窗口大小
			if(bps.components.back.config[instance.backWay]){
				bps.apply(bps.components.back.config, bps.components.back.config[instance.backWay]);//覆盖宽高
			}
		},
		click: function(e){
			var instance = e.instance;
			instance.showBackWindow(instance,function(){
				instance.superclass.click(e);
			}); //打开回退方式选择窗口
		},
		beforeSubmitData: function(data){
			var processInstID = bps.components.core.getPageContext().workItem.processInstID;
			var currentActInstID = bps.components.core.getPageContext().workItem.activityInstID;
			var currentActDefID = bps.components.core.getPageContext().workItem.activityDefID;
			var destActDefID = this.backData.destActDefID;
			var strategy = this.backData.strategy;
			var backSubmitWay = this.backSubmitWay; //需要修改
			data.isFinishWorkItem = false;
			bps.apply(data,{
				"workItemID": bps.components.core.getPageContext().workItemID//提交工作项ID
			});
			bps.apply(data, {
				//业务开发人员自定义的保存表单控件业务逻辑流；目前提交组件就是保存选择的参与者，选择的后继活动
				customSaveComponentsBiz:"com.primeton.bps.web.bizform.components.back.backComponents.backActivity.biz.ext"
			});
			if(this.backData){
				bps.apply(data.extData, {//参与者信息放到data.extData，extData只支持简单的数据结构
					"processInstID":processInstID, //当前流程实例ID
					"currentActInstID":currentActInstID,//当前活动实例ID
					"currentActDefID":currentActDefID, //当前活动定义ID
					"destActDefID":destActDefID, //目标活动定义ID
					"strategy":strategy, //回退模式
					"backSubmitWay":backSubmitWay //回退后的提交方式
				});
			}
			
			//是否记录日志
			if(bps.components.config.openLog){
				bps.apply(data.bizExtAttr, {
					"openLog":true//打开日志记录，默认是关闭的
				});
				if(this.backData && this.backData["backReason"]){
					bps.apply(data.bizExtAttr, {
						"backReason": this.backData["backReason"]
					});
				}
			}
		},
		afterSubmitData: function(data){
			
		},
		showBackWindow: function(instance,cb){
			nui.open({
				url : bps.components.back.config.loadUrl,
				title: this.back.title,
				width: bps.components.back.config.width,
				height: bps.components.back.config.height,
				onload: function(){
					var iframe = this.getIFrameEl();
					var backWay = instance.backWay;
					iframe.contentWindow.setData({
						workItemID: bps.components.core.getPageContext().workItemID,
						backWay:backWay,
						destActivityID: instance.destActivityID
					});
				},
				ondestroy: function(action){
					if(action=="ok"){
						var iframe = this.getIFrameEl();
						var data = iframe.contentWindow.getData();
						data = nui.clone(data);
						instance.backData = instance.backData || {};
						if(data){
							bps.apply(instance.backData, data);
						}
						if(cb){
							cb();
						}
					}
				}
			});
			
		}
	});
	
    window['bps'] = bps;
});