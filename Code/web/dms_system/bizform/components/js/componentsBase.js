$(function(){//需要等页面加载完成才能加载
	bps = window['bps'] || {
		version: "1.0.0.0"
	};

	/**
	 * 业务组件基础框架内部方法
	 */
	//@Review 选流程的时候，只选当前流程的活动，其他的流程全部屏蔽；使用指派后继活动的控件  {liuxiang}
	bps.ns("bps.components.base");
	
	bps.apply(bps.components.base, {
		_components: bps.components.core.getPageContext()._components,//所有已注册的组件
		_compClass: {},
		reg: function(id, compClass){
			this._compClass[id] = compClass;
		},
		unreg: function(id){
			delete this._compClass[id];
			this._components[id] = null;
			delete this._components[id];
		},
		genConstructor: function(fName){
			var constructorName = bps.components.core.upperFirst(fName);
			constructorName = "bps.components."+constructorName;
			var con = [];
			var conFunc=null;
			
			con.push(constructorName+"=function (){");
			con.push(constructorName+".superclass.constructor.call(this, arguments);");//调用父类构造器
			con.push("};");
			con.push("conFunc = "+constructorName+";");
			
			eval(con.join(""));//执行
			
			return conFunc;
		},
		create: function(clazz, config){
			if(!clazz || typeof clazz != "function"){
				return;
			}
			var comp = new clazz();//调用其构造函数初始化
			comp.data = comp.data || {};//用户保存数据的区域，可能传输页面跳转之间的参数；这个数据最终会提交到后端
			
			//保存nui的button数据
			var nuiBtn = bps.BizForm.Core.getButton(config.id);
			if(nuiBtn){
				bps.apply(comp, nuiBtn.params);//将原来按钮的数据绑定到按钮上
			}
			
			if(config){
				bps.apply(comp, bps.components.core.copy(config));
			}
			var e = {
					instance: comp
			};
			if(comp.beforeCreate){
				comp.beforeCreate(e);
			}
			if(comp.id){
				if(comp.afterCreate){
					comp.afterCreate(e);
				}
				this._components[comp.id] = comp;
			}
		},
		destroy: function(){
			for(var id in this._components){
				if(this._components[id].destroy){
					this._components[id].destroy();
				}
				this._components[id] = null;
			}
		},
		btnClickDelegate: function(e){
			var nuiBtn = e.sender;
			if(nuiBtn){
				e.instance = bps.components.get(nuiBtn.id) || {};
				e.instance.click(e);
			}
		},
		ajax: function(url, data, suc, fail){
			nui.ajax({
				url:url,
				type: "POST",
				contentType:"text/json",//不写这个是application/json提交格式
				data: data,
				cache: false,
				success: suc,
				fail: fail
			});
		}
	});
	bps.components.Component = function(){
		//@Review boolean 类型的数据改成is开头 {wuyh} [yangyong]
		this.data = {//每个实例一份
				extAttr: {},//用户扩展数据，除了实体之外的扩展数据
				extData: {},//业务人员扩展数据区，通用
				bizExtAttr: {},//业务人员扩展数据区
				isCreateProcessInstance: false,//默认不需要创建流程，当工作项ID为空的时候，需要置为true
				processDefInfo: {//流程信息 
					processDefName: "",
					processInstName: "",
					processInstDesc: "",
					transcationSpan: false
				},
				processRelativeData: {},//流程启动相关数据
				isUseDisTransaction:false,//是否使用分布式事务
				isSaveFormData: true,//保存表单数据
				//@Review 自定义表单数据逻辑改名字， customSaveFormDataBiz {liuxiang} [yangyong]
				customSaveFormDataBiz: null,//保存表单数据URL，用户提供将调用用户的逻辑保存表单数据，不提供则走默认的保存表单数据逻辑
				customSaveComponentsBiz: null,//自定义保存业务组件方法的逻辑流，不提供将不调用
				isSaveRelativeData: true,//默认实现保存相关数据
				openLog: false,//是否记录日志
				isFinishWorkItem: true //默认完成工作项
		};
		this._callbacks = {};
		//@Review 逻辑流应该通用，可以让业务开发人员覆盖，业务开发人员只需要处理自己的流程逻辑流 {cuizc}
		//默认的后台逻辑流入口
		this.defaultSubmitBiz = "org.gocom.bps.web.bizform.components.commonComponent.commonDataSave.biz.ext";
	};
	
	bps.apply(bps.components.Component.prototype, {
		
		afterCreate: function(e){//组件实例化完成之后调用，用于给组件开发人员修改组件实例属性
			bps.components.bindEvent(e);
		},
		click: function(e){//组件点击事件触发
			
			var beforeSubmit = bps.components.core.getFormTabFunction(bps.components.config.beforeSubmit)||bps.components.core.emptyFn;
			
			e.submit = true;//默认是true
			beforeSubmit(e);
			
			if(!e.submit){
				return;
			}
			
			var getData = bps.components.core.emptyFn;
			var submitData = e.instance.data;//用户数据区
			var data = {};
			if(submitData.isSaveFormData){
				getData = bps.components.core.getFormTabFunction(bps.components.config.getSubmitData) || bps.components.core.emptyFn;
				data = getData(e);
				if(data && (data.entity || data.entities)){
					bps.apply(submitData,{
						"entity": data.entity,
						"entities": data.entities
					});
				}else{
					submitData.isSaveFormData = false;//用户未返回表单数据，不需要保存表单数据
					bps.apply(submitData,{
						"entity": {},
						"entities": []
					});
				}
			}
			
			e.instance.beforeSubmitData(submitData);
			
			var afterSubmit = bps.components.core.getFormTabFunction(bps.components.config.afterSubmit)||bps.components.core.emptyFn;
			
			//支持自定义的表单保存逻辑添加.biz.ext后缀
			if(submitData.customSaveFormDataBiz && submitData.customSaveFormDataBiz.lastIndexOf(".biz.ext")==-1){
				submitData.customSaveFormDataBiz = submitData.customSaveFormDataBiz +".biz.ext";
			}
			
			bps.components.base.ajax(e.instance.defaultSubmitBiz,submitData,function(ret){
				
				e.returnData = ret;
				
				if(ret.exception){
					window.top.nui.alert(e.instance.errorMessage);
				}
				
				submitData = bps.components.core.copy(submitData);
				submitData.returnData = ret;
				e.instance.afterSubmitData(submitData);
				
				afterSubmit(e);
				
			},function(ret){
				e.returnData = ret;
				window.top.nui.alert(e.instance.errorMessage);
				submitData = bps.components.core.copy(submitData);
				e.instance.afterSubmitData(submitData);
				
				afterSubmit(e);
			});
			
		},
		/**
		 * data 是需要提交到后台的数据
		 */
		beforeSubmitData: function(data){//组件开发人员
			
		},
		/**
		 * data 已经提交到后台的数据，同时包含从后台返回的数据
		 * 
		 */
		afterSubmitData: function(data){//组件开发人员接口
			
		},
		getCallbacks: function(){
			return this._callbacks;
		},
		getCallback: function(id){
			return this._callbacks[id];
		},
		addCallback: function(id,cb){
			this._callbacks[id] = cb;
		},
		removeCallback: function(id){
			delete this._callbacks[id];
		},
		destroy: function(){
			
		}
	});
	
    window['bps'] = bps;
});
