//检查流程是否处于运行状态
function checkProcessState(processInstID){
	var hs = new HideSubmit('com.primeton.workflow.manager.instance.ProcessInstanceManager.getProcessInstState.biz');
	hs.addParam('processInstID',processInstID);
	try{
		hs.submit();
	}catch(e){
		alert(bps_taglib_workflow_tag_error+hs.getExceptionMessage());//出错:
		enableButton();
		return false;
	}
	
	var currentState = hs.getProperty('currentState');		

	if(currentState != 2){
		alert(bps_taglib_workflow_tag_running_state);//流程必须处于 "运行" 状态
		enableButton();
		return false;
	}
	return true;
}

function enableButton(){
}

if (Function.extend){
	Function.extend({
		create:function(A){
			var B=this;
			var _merge=$merge||window.$merge;
			if (!_merge){
				function $merge(){
					var C={};
					for(var B=0;B<arguments.length;B++){
						for(var E in arguments[B]){
							var A=arguments[B][E];var D=C[E];
							if(D&&$type(A)=="object"&&$type(D)=="object"){
								C[E]=$merge(D,A);
							}else{
								C[E]=A;
							}
						}
					}
					return C;
				}
			}
			A=$merge({bind:B,event:false,"arguments":null,delay:false,periodical:false,attempt:false},A);
			if($chk && $chk(A.arguments)&& $type && $type(A.arguments)!="array"){
				A.arguments=[A.arguments];
			}
			return function(E){
				var C;if(A.event){E=E||window.event;C=[(A.event===true)?E:new A.event(E)];
					if(A.arguments){
						C.extend(A.arguments);}
					}else{
						C=A.arguments||arguments;
					}
					var F=function(){
						return B.apply($pick(A.bind,B),C);
						};
					if(A.delay){return setTimeout(F,A.delay);}
					if(A.periodical){return setInterval(F,A.periodical);}
					if(A.attempt){
						try{
							return F();
						}catch(D){
							return false;
						}
					}
				return F();
			};
	}
	});
}