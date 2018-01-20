(function(){
	
	//@Review BPS 改成 bps {wuyh} [yangyong]
	
	bps = window['bps'] || {
		version: "1.0.0.0"
	};

	/**
	 * 业务组件基础方法
	 */
	bps.ns("bps.components.core");
	
    bps.apply(bps.components.core, {
    	 /**
         * 类继承
         * clazz 子类
         * superClass 父类
         * overrides 覆盖的对象
         */
    	extend: function(subc, superc, overrides) {
            if (!superc||!subc) {
           	 return;
            }
            var F = function() {};
            F.prototype=superc.prototype;
            subc.prototype=new F();//子类能共享父类所有的实例方法
            subc.prototype.constructor=subc;//由于覆盖了子类原型，重写其构造函数，保证了通过实例访问构造函数的正确性
            subc.superclass=superc.prototype;//保存一个可以访问父类的属性，方法的指针，可以在子类
            subc.prototype.superclass=superc.prototype;//保存一个可以访问父类的属性，方法的指针，直接在子类实例就能访问父类属性和方法
            if (superc.prototype.constructor == Object.prototype.constructor) {
                superc.prototype.constructor=superc;
            }
        
            if (overrides) {
                for (var i in overrides) {
                    subc.prototype[i]=overrides[i];
                }

            }
         },
         /**
     	 * 不能使用这个函数复制自定义类型，只能使用这个函数复制浏览器的内置类型
     	 */
     	copy: function(obj){//copy数据，防止对象只复制引用
     		if(typeof obj == "function" || bps.components.core.isPrimitive(obj)){
     			return obj;//函数共享是最好的，不需要copy;基本数据类型自己会自动复制一个副本，直接返回即可
     		}
     		if(typeof obj == "object"){
     			if(obj == null){//obj为空的时候，typeof obj也返回object，排除这个特殊情况
     				return null;
     			}else if(bps.components.core.isArray(obj)){//复制数组
         			var arr = [];
         			for(var a in obj){
         				arr.push(arguments.callee(obj[a]));
         			}
         			return arr;
         		}else{
         			var o = {};
         			for(var p in obj){
         				o[p] = arguments.callee(obj[p]);
         			}
         		}
     			return o;
     		}
     		return obj;//基本数据类型
     	},
        isArray: function(arr){
       	 return arr instanceof Array;
        },
        isPrimitive: function(v){//不考虑包装类型
       	 return this.type(v) == "undefinded" || 
       	 this.type(v) == "null" || 
       	 this.type(v) == "boolean" || 
       	 this.type(v) == "number"|| 
       	 this.type(v)=="string";
        },
        type: function(v){
       	 return typeof v;
        },
        emptyFn: function(){},
        upperFirst: function(str){
        	if(this.type(str) == "string" && str.length>2){
        		str = String(str);
        		return String(str.charAt(0)).toUpperCase()+str.substring(1);
        	}
        	return str;
        }
    });
    
    /**
     * 表单框架配置
     */
    bps.apply(bps.components.core, {
    	_pageContext:null,
    	getTab : function(tabID){
    		return bps.BizForm.Core.getTab(tabID);
    	},
    	getFormTab: function(){
    		return bps.BizForm.Core.getTab(bps.components.config.formTabID);
    	},
    	getPageContext: function(){//页面对象，此对象和框架绑定，共享同一块内存实例；
    		if(this._pageContext){
    			return this._pageContext;
    		}
    		bps.BizForm.dataCache.pageContext = bps.BizForm.dataCache.pageContext ||{};
    		this._pageContext = bps.BizForm.dataCache.pageContext;
    		this._pageContext._components = this._pageContext._components || {};
    		return this._pageContext;
    	},
    	setContextPath : function(contextPath){
    		this.contextPath = contextPath;
    	},
    	getContextPath : function(){
    		return this.contextPath;
    	},
    	closeWindow: function(win,action){
    		if (win.CloseOwnerWindow) {
    			return win.CloseOwnerWindow(action);
    		} else {
    			win.close();
    		}
    	},
    	closeNuiWindowAlways: function(action){
    		var tempWin = self;
    		while(tempWin.parent != self && tempWin != top){//存在父窗口
    			tempWin = tempWin.parent;
    			if(tempWin.CloseOwnerWindow){
    				break;
    			}
    		}
    		return this.closeWindow(tempWin,action);
    	},
        getFormTabFunction: function(fnName){//获取表单tab页中的window对象中搜索函数
        	if (typeof fnName != "string") return null;
        	var win = this.getFormWindow();
            var names = fnName.split(".");
            var fn = null;
            for (var i = 0, l = names.length; i < l; i++) {
                var name = names[i];
                if (!fn) fn = win[name];
                else fn = fn[name];
                if (!fn) break;
            }
            return fn;
        },
        getFormWindow: function(){//获取表单tab页的window对象
        	var tab = this.getFormTab();
        	if(tab){
        		return tab._iframeEl.contentWindow;
        	}
        	return window;
        },
        loadEntity: function(entity){
        	var type = entity["__type"];
        	if(!type){
        		nui.alert("数据实体必须包含__type属性");
        		return;
        	}
        	if(type.indexOf("sdo:")==-1){
        		entity["__type"] = "sdo:"+type;//默认需要支持添加前缀
        	}
        	return bps.components.core.getAjaxData(
        			"org.gocom.bps.web.bizform.components.entityDASTemplate.getEntity.biz.ext",
        			{entity:entity},
        			"entity");
        },
        loadWorkItem: function(workItemID){
        	return bps.components.core.getAjaxData(
        			"org.gocom.bps.web.bizform.components.commonComponent.queryWorkItemDetail.biz.ext",
        			{workItemID:workItemID},
        			"workItem");
        },
        alert: function(content){
        	if(nui.showTips){
        		nui.showTips({
    			    content: content,    
    			    state: "info",      //default|success|info|warning|danger
    			    x: "center",          //left|center|right
    			    y: "center",          //top|center|bottom
    			    timeout: 3000     //自动消失间隔时间。默认2000（2秒）。
    			});
        	}else{
        		nui.alert(content);
        	}
        },
		getAjaxData: function(url, param, returnKey){
			var data = null;
			nui.ajax({
				url: url,
				type: "POST",
				contentType:"text/json",//不写这个是application/json提交格式
				data: param,
				async:false,//必须是同步请求
				cache: false,
				success: function(ret){
					if(ret.exception){
						nui.alert("load data error, url : "+url);
					}
					if(returnKey){
						data = nui.decode(ret)[returnKey];
					}
				},
				fail: function(ret){
					nui.alert("load data error, url : "+url);
				}
			});
			return data;//可能不需要返回值
		},
		selectResource: function(selfObj,otherParam, selectData, cb){
			
			var selfObjInner = {
				width: 800,
				height: 600
			};
			
			bps.apply(selfObjInner, selfObj);
			
			var otherParamInner = {
				commitParamObj : {},
				isNotAllowParentChild : false,
				loadUrl : contextPath +"/rest/services/bps/webcontrol/queryParticipants",
				selectableType : ",person,emp,role,organization,group,",
				colorMap : {
					"__type" : "java.util.HashMap",
					emp : '#008080',
					person : '#008080',
					role : '#d5d50c',
					organization : '#2b6da5'
				}
			};
			
			bps.apply(otherParamInner, otherParam);
			
			nui.open({
				//@Review 不能直接使用default
				url: contextPath+"/bps/web/control/html/resourceSelector.jsp",
				title: bps.components.Component.prototype.select + bps.components.Component.prototype.Participant,
				width: selfObjInner.width,
				height: selfObjInner.height,
				onload: function (){
					var iframe = this.getIFrameEl();
					var data = {
							otherParamObj : otherParamInner,
							title : selfObjInner.title,
							ids:"",
							texts:""
					};
					bps.apply(data, selectData);
					iframe.contentWindow.initData(data);
				},
				ondestroy: function (action){
					if (action == "ok") {
						var iframe = this.getIFrameEl();
						var data = iframe.contentWindow.returnData();
						data = nui.clone(data);
						bps.apply(selectData, data);
						if(cb){
							cb();//回调
						}
					}
				}
			});
		}
    });
    
    /**
	 * 业务组件开发 对外api
	 */
	bps.apply(bps.components, {
		/**
		 * config : {
		 * 	 id:"",
		 * 	 afterCreate: function(e){},
		 *   
		 * }
		 */
		reg: function(config){//注册一个组件
			if(typeof config == "object" && config){
				//如果已注册则不需要重新创建
				var componentID = config.id;
				if(this.get(componentID)){
					return;
				}
				
				var conFunc = bps.components.base.genConstructor(componentID);
				
				//调用继承方法
				bps.components.core.extend(conFunc, bps.components.Component);//继承Component
				
				this.base.reg(componentID, conFunc);//已注册，继承关系也建立好了
				
				//实例化
				this.base.create(conFunc, config);
			}
		},
		get:function(id){//获取一个组件
			return this.base._components[id];
		},
		unreg: function(id){//注销一个组件
			this.base.unreg(id);
		},
		bindEvent: function(e){//绑定事件
			var btnID = e.instance.id;
			bps.BizForm.Core.addBtnEventListener(btnID, this.base.btnClickDelegate);
		}
	});
	
    window['bps'] = bps;
})();
