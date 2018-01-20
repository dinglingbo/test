/*
	activity-api.js 
	2007-11-23
	Version 1.0
	Author guoxiong guoxiong@primeton.com
	Copyright www.primeton.com
*/
var sUserAgent = navigator.userAgent ;
var isOpera = sUserAgent.indexOf("Opera") > -1 ;
var isIE = sUserAgent.indexOf("compatible") > -1 
		&& sUserAgent.indexOf("MSIE") > -1
		&& !isOpera ;
var isKHTML = sUserAgent.indexOf("KHTML") > -1
		&& sUserAgent.indexOf("Konqueror") > -1
		&& sUserAgent.indexOf("AppleWebKit") > -1 ;
var isMoz = sUserAgent.indexOf("Gecko") > -1
		&& !isKHTML ;
		
var labelFor ="htmlFor";

var CONTEXT_PATH;

if(isIE) {
	labelFor = "htmlFor" ;
} else if (isMoz) {
	labelFor = "for" ;
}

var actApplication =
{
	MANIPU_FIELDS:"_manipulateFields",
	MANIPU_FIELDS1:"_manipulateFields1",
	IGNORES_FIELDS:"_ignores",
	MANIPU_MODEL:"_model",
	MANIPU_MODEL_HID:"sh",     //show hidden
	MANIPU_MODEL_UNHID:"!sh",     //unhidden
	MANIPU_MODEL_DIS:"dis",     //disable
	MANIPU_MODEL_UNDIS:"!dis",     //undisable	
	labelFor:"htmlFor"
};

Datacell.prototype.syncRefresh=false;

window.onProcessBefore= window.onProcessBefore || function(field){ return true; };
		
window.onProcessAfter= window.onProcessAfter || function(field){ };

var activity = 
{
	'renderActivity' : function(actObject,doc) {
		//alert("render:"+actObject.toJSONString());
		var hideSplash = function()
		{
			// Fades-out the splash screen
			//FIXME: document.getElementById  --> $e
			var splash = $e('splash');
			if (splash != null)
			{
				try
				{
					mxUtils.release(splash);
					mxUtils.fadeOut(splash, 300, true);
				}
				catch (e)
				{
					splash.parentNode.removeChild(splash);
				}
			}
		}
		
		
		var encodeSpecCharacters = function (pss) {
			//if (pss && pss.replaceAll) {
				//replaceValue = pss.replaceAll("&quot;","\"") ;
				//replaceValue = pss.replaceAll("&apos;","'");
			//}
			
			
			//template FIXME :annotation
			replaceValue =	html_entity_decode(pss) ;
			return replaceValue ;
			//return pss;
		}
		
		var object = actObject ;		
		if (!object)
			return ;
		//render field ...
		var renderField = function(field) {
				//set a field value based upon its element type,now for only [text,textare,checkbox,radio,select-one or select-nultiple]
				value = jsonUtil.getJsonValueViaId(object,field.name);
				
				if(value =='undefined') {
					 value = "" ;
					}
			 	type = field.type ;
				if ((type == "text" || type == "textarea") ) {
					
					field.value = encodeSpecCharacters(value);
					(function(field){field.onblur =function() {
						jsonUtil.setJsonValueViaId(object,field.name,field.value);
					 }})(field);
				} 
				else if ((type == "checkbox" || type == "radio" ) //&& typeof value != object
						) {
						//if(!value)
							//return ;
						//field.checked = field.value == value.toString();
						field.checked = field.value == value || value == "true" || value == true;
						if(field.type == "checkbox") {
							checkBoxEditEvent(field,object,true);
						} else if(field.type == "radio") {
							radiosEditEvent(field,object,true);
						}
						//special process for particular field here...
						(function(_field){
							_field.onclick =function() {
								if(_field.type == "checkbox") {
									checkBoxEditEvent(_field,object);
								} else if(_field.type == "radio") {
									radiosEditEvent(_field,object);
								}
						  	}
						 })(field); 
				}
				else if (type == "select-one" //|| type == "select-multiple"
				) {
						
					legth = field.options.length ;
					if(legth == "undefined")
						throw new Error("No option provided") ;
					if(!value){
						value = field.options[0].value;
						jsonUtil.setJsonValueViaId(object,field.name,value);
					}
					for (var j = 0;j<legth;++j) {
						//if (field.options[j].value == value.toString()) {
						if (field.options[j].value == value) {
							field.options[j].selected = true ;
							break ;
						}
					}
					selectEditEvent(field,field.options[field.selectedIndex],true,object);//json与field的绑定
					(function(field){field.onchange =function() {        
							jsonUtil.setJsonValueViaId(object,field.name,field.options[field.selectedIndex].value);
							selectEditEvent(field,field.options[field.selectedIndex],false,object);
					  }})(field);
				}
				
			} ;
		var selectEditEvent = function(list,pass,isInit,activity) 
		{
			var extraAttribute = getExtraAttribute(list,actApplication.MANIPU_FIELDS);
			if(!extraAttribute)
				return null;
			var ignores = getExtraAttribute(list,actApplication.IGNORES_FIELDS);
			var	model = getExtraAttribute(list,actApplication.MANIPU_MODEL)==null?"sh":getExtraAttribute(list,actApplication.MANIPU_MODEL);
			var mulDiv ;
			var _extraAttribute = getExtraAttribute(pass,actApplication.MANIPU_FIELDS);
			var _model = getExtraAttribute(pass,actApplication.MANIPU_MODEL);
			if(extraAttribute == "options") {  //
				if(!_extraAttribute)
					mulDiv = pass.value ;
				else mulDiv = _extraAttribute ;
			} 
			else {
				if(!_extraAttribute)
					mulDiv = extraAttribute ;
				else mulDiv = _extraAttribute ;
			}
			model = _model == undefined ? model:_model;
			symode = "inject";
			if(model == actApplication.MANIPU_MODEL_HID) { //show hidden
				showHideDivInfo(mulDiv,true,ignores);
			} else if(model == actApplication.MANIPU_MODEL_UNHID) { //disable
				showHideDivInfo(mulDiv,false,ignores);
				symode = "clear";
			}else if(model == actApplication.MANIPU_MODEL_DIS) { //undisable
				disableDivFields(mulDiv,false,ignores);
			}else if(model == actApplication.MANIPU_MODEL_UNDIS) { //disable
				disableDivFields(mulDiv,true,ignores);
				symode = "clear" ;
			}
			if(!isInit) synchDivFieldsValueWithObject(mulDiv,symode,activity) ;
			
			var ListLen;
			ListLen = list.options.length;
			for(var k = 0; k < ListLen; k++)
			{
			
				//FIXME: () --> []
				if( list.options[k].value != pass.value)
				{
					tempAtt = getExtraAttribute(list.options[k],actApplication.MANIPU_FIELDS) ;
					tempModel = getExtraAttribute(list.options[k],actApplication.MANIPU_MODEL);
					_model = getExtraAttribute(list.options[k],actApplication.MANIPU_MODEL);
					ignores = getExtraAttribute(list.options[k],actApplication.IGNORES_FIELDS) ;
					var _mulDiv ;
					if(extraAttribute == "options") {  //
						if(!tempAtt)
							_mulDiv = list.options[k].value ;
						else _mulDiv = tempAtt ;
					} 
					else {
						if(!tempAtt)
							_mulDiv = extraAttribute ;
						else _mulDiv = tempAtt ;
					}
					if(_mulDiv == mulDiv)
						continue ;
					model = _model == undefined ? model:_model;
					symode = "inject";
					if(model == actApplication.MANIPU_MODEL_HID) { //show hidden
						showHideDivInfo(_mulDiv,false,ignores);
					} else if(model == actApplication.MANIPU_MODEL_UNHID) { //hidden
						showHideDivInfo(_mulDiv,true,ignores);
						symode = "clear";
					}else if(model == actApplication.MANIPU_MODEL_DIS) { //undisable
						disableDivFields(_mulDiv,true,ignores);
					}else if(model == actApplication.MANIPU_MODEL_UNDIS) { //disable
						disableDivFields(_mulDiv,false,ignores);
						symode = "clear" ;
					}					
					if(!isInit)synchDivFieldsValueWithObject(_mulDiv,symode,activity) ;
				}
			} 
		};	 
		var checkBoxEditEvent = function(checkboxObj,activity,isInit) {
			var value ="";
			var checked = checkboxObj.checked ;
			if (checked) {
				if (checkboxObj.value == "undefined" || checkboxObj.value == "true") {//if checkbox value is undefined then assume it's a boolean value by dufault.
					value = true ;  
				} else {
					value = checkboxObj.value ;
				}
			}
			else {
				//alert(checkboxObj.name+" "+checkboxObj.value)
				if (checkboxObj.value == "undefined" || checkboxObj.value == "true") {//if checkbox value is undefined then assume it's a boolean value by dufault.
					value = false; 
				} else {
					if(checkboxObj.value.isBooleanValue())
						value=!(checkboxObj.value.toBoolean()) ;
					else value = "" ;
				 }
			}
			if(activity) {
				jsonUtil.setJsonValueViaId(activity,checkboxObj.name,value);
			}
			
			extraAttribute = getExtraAttribute(checkboxObj,actApplication.MANIPU_FIELDS) ;
			if (extraAttribute) {  //if there is a extra attribute actApplication.MANIPU_FIELDS exist
				var model = getExtraAttribute(checkboxObj,actApplication.MANIPU_MODEL);
				ignores = getExtraAttribute(checkboxObj,actApplication.IGNORES_FIELDS) ;
				model = model == null?"dis":model; 
				if(model == actApplication.MANIPU_MODEL_HID) { //show hidden :sh
					showHideDivInfo(extraAttribute,checkboxObj.checked,ignores);
				}else if(model == actApplication.MANIPU_MODEL_UNHID) { //hidden :!sh
					showHideDivInfo(extraAttribute,!checkboxObj.checked,ignores);						
				}else if(model ==actApplication.MANIPU_MODEL_DIS) { //disable :dis
					if(!checkboxObj.disabled)
						disableDivFields(extraAttribute,!checkboxObj.checked,ignores);
				}else if(model == actApplication.MANIPU_MODEL_UNDIS) { //undisable :!dis
					if(!checkboxObj.disabled)
						disableDivFields(extraAttribute,checkboxObj.checked,ignores);						
				}	
				var symode ; 
				if(checkboxObj.checked)
				  symode="inject";
				else symode="clear";
				//if (!isInit) synchDivFieldsValueWithObject(extraAttribute,symode,object) ;
			}
		};
	function radiosEditEvent(radioObj,activity,isInit){
			if(!radioObj)
				return;
			if(!window.onProcessBefore(radioObj)) {
				return ;
			}
			
			var value ;
			if (radioObj.value == "undefined")	//if checkbox value is undefined then assume it's a boolean value by dufault.
				value = true ;  
			else {
				value = radioObj.value ;
			}
			
			if(!isInit) {
				jsonUtil.setJsonValueViaId(activity,radioObj.name,value);
			}
			
			var manipulateDivFields = function (radioObj,fdivs,activity,isInit) {
				model = getExtraAttribute(radioObj,actApplication.MANIPU_MODEL)==null?"dis":getExtraAttribute(radioObj,actApplication.MANIPU_MODEL);
				ignores = getExtraAttribute(radioObj,actApplication.IGNORES_FIELDS) ;
				symode=radioObj.checked?"inject":"clear";
				if(model == actApplication.MANIPU_MODEL_HID) { //show hidden
					showHideDivInfo(fdivs,radioObj.checked,ignores);
				}else if(model == actApplication.MANIPU_MODEL_UNHID) { //hidden :!sh
					showHideDivInfo(fdivs,!radioObj.checked,ignores);						
				}else if(model == actApplication.MANIPU_MODEL_DIS) { //disable
					disableDivFields(fdivs,!radioObj.checked,ignores);
				}else if(model == actApplication.MANIPU_MODEL_UNDIS) { //undisable
					disableDivFields(fdivs,radioObj.checked,ignores);						
				}	
				if(!isInit) synchDivFieldsValueWithObject(fdivs,symode,activity) ;
			}
			
			window.onProcessAfter(radioObj);
			
			//if there is a extra attribute actApplication.MANIPU_FIELDS exist
			radioObj = document.forms[0].elements[radioObj.name] ;
			var radioLength = radioObj.length;
			if(radioLength == undefined) {
				extraAttribute = getExtraAttribute(radioObj,actApplication.MANIPU_FIELDS) ;
				if (!extraAttribute) 
					return ;				
				manipulateDivFields(radioObj,extraAttribute,activity,isInit);
				return;
			}
			for(var i = 0; i < radioLength; ++i) {
				var extraAttribute = getExtraAttribute(radioObj[i],actApplication.MANIPU_FIELDS);
				if(extraAttribute)
					if(radioObj[i].checked){
						manipulateDivFields(radioObj[i],extraAttribute,activity,isInit);
					}
				var extraAttribute1 = getExtraAttribute(radioObj[i],actApplication.MANIPU_FIELDS1);
				if(extraAttribute1){
					if(radioObj[i].checked)
						disableDivFields(extraAttribute1,true,null);
				}
			}
			
		} ;
		
		//填充数据到页面上
		synchDivFieldsValueWithObject = function (fdivs,mode,activity) {
			if(!fdivs)
				return;
			divs = fdivs.split(",");
			for(var i=0;i<divs.length;++i) {
				div = divs[i] ;
				//FIXME: document.getElementById  --> $id
				var fieldsDiv = $id(div);
				var labels = fieldsDiv.getElementsByTagName("label") ;
				for (var j=0; j<labels.length;j++) {
					if (!labels[j].getAttribute(labelFor)) continue ;
					var id = labels[j].getAttribute(labelFor) ;
					var element = null ;
					element = getElementViaId(id) ;
					if (!element)
						continue ;
					var elValue ;
					if(mode == "inject") {  //get fields value to inject to json object
						elValue = element.value;
					} else if(mode == "clear") { //clear fields value in json object
						elValue = "" ;
					}
					if(element.type == "button")
						continue;
						
					jsonUtil.setJsonValueViaId(activity,element.name,elValue);
				}
			}
		}
		
		//FIXME: document.all --> $e()
		getElementViaId = function (id) {
			var element = null;
			if (id.indexOf(".") > 1) {
				if (!$e(id)) return false ;
				element = $e(id);
			}else {
			//FIXME: document.getElementById  --> $id
				if (!$id(id)) return false ;
				element = $id(id);
			}
			return element ; 
		};
		getExtraAttribute = function (el,att) {
			if (!el.getAttribute) return null ;
			nvalue  = el.getAttribute(att);
			return  nvalue;
		};
			
			
		if(!document.getElementsByTagName) return false ;
		
		
		if(!doc)
			var labels = document.getElementsByTagName("label") ; //get all label tags
		else if (typeof doc == "object") 
			var labels = doc.getElementsByTagName("label") ;
		
		for (var i=0; i<labels.length; i++) {
		
			//if (!labels[i][actApplication.labelFor]) continue ;
			//var id = labels[i].getAttribute(labelFor) ;
		    if (!labels[i][actApplication.labelFor]) continue ;
			var id = labels[i][actApplication.labelFor] ;
			var field = getElementViaId(id) ;
			
			//if(field.name=="btnExceptionAppConfg")
				//alert("type: "+field.type) ;
				
			if (!field || field.type == "button") {
				continue ;
			}
			
			
			renderField(field);
		}
		
		
		
		// Shows the application
		hideSplash();
	}
};

function showHideDivInfo (fdivs,showOrHid,ignores) {
	if(!fdivs)
		return;
	var divs = fdivs.split(",");
	for (var i=0;i<divs.length;i++) {
		div = divs[i];
		//FIXME: document.getElementById  --> $id
		fieldsDiv = $id(div);
		if (fieldsDiv == null) return ;
		if (showOrHid) {
			showdiv(fieldsDiv);
		} else {
			hidediv(fieldsDiv);
		}
	}
	
	if(ignores != null) {
		showHideDivInfo(ignores,!showOrHid,null);
	}
}

function disableDivFields (fdivs,disabled,ignores) {
	if(!fdivs)
		return;
	
	var ignore = false ;  
	
	if(ignores != null) {
		var ignoresFieldNames = getIgnoresFieldNames(ignores);
		ignore = true ;
		}
	
	var divs = fdivs.split(",");
 	
	for (var i=0;i<divs.length;i++) {
		
		div = divs[i];
		//FIXME: document.getElementById  --> $id
		fieldsDiv = $id(div);
		if (fieldsDiv == null)
			 continue ;
		
		var labels = fieldsDiv.getElementsByTagName("label") ;
		
		for (var j=0; j<labels.length;j++) {
			
			if (!labels[j].getAttribute(labelFor)) 
				continue ;
				
			var id = labels[j].getAttribute(labelFor) ;
			
			var element = null ;
			element = getElementViaId(id) ;
			
			if (!element)
				continue ;
				
			if(disabled){        //禁用不忽略，启用忽略
				element.disabled = disabled ;
			}
			
			if(!disabled && (!ignore || ignoresFieldNames.indexOf(id) == -1)) 
				element.disabled = disabled ;
			//if(!ignore || ignoresFieldNames.indexOf(id) == -1) 
				//element.disabled = disabled ;
			
		}
		
		var datacells = fieldsDiv.getElementsByTagName("table");
		if(datacells&&datacells.length>0){
			for (var k=0; k<datacells.length;k++) {
				var dc = datacells[k]; 
				var cid = dc.id.substring(0,dc.id.lastIndexOf("_container_table"));
				var dataCell = $id(cid);
				if(dataCell){
					if(disabled){
						dataCell.beforeAdd=function(){
							return false;
						}
						dataCell.beforeDel=function(){
							return false;
						}
						dataCell.beforeEdit=function(){
							return false;
						}
					}else if(!disabled && (!ignore || ignoresFieldNames.indexOf(cid) == -1)){
						dataCell.beforeAdd=function(){
							return true;
						}
						dataCell.beforeDel=function(){
							return true;
						}
						dataCell.beforeEdit=function(){
							return true;
						}
					}
				}
			}
		}
		
	}
 
}

function getIgnoresFieldNames (ignores) {
	
	var fields = new Array() ;
	
	var divs = ignores.split(",");
	for (var i=0;i<divs.length;i++) {
		div = divs[i];
		//FIXME: document.getElementById  --> $id
		fieldsDiv = $id(div);
		if (fieldsDiv == null)
			 continue ;
		
		var labels = fieldsDiv.getElementsByTagName("label") ;		
		
		for (var j=0; j<labels.length;j++) {
			
			if (!labels[j].getAttribute(labelFor)) 
				continue ;
				
			var id = labels[j].getAttribute(labelFor) ;
			
			element = getElementViaId(id) ;
			
			if (!element)
				continue ;
			
			fields.push(id);
		}
	}
	
	return fields.toString();
}

var jsonUtil =
{
	'getJsonValueViaId' : function(jsonObject,ids) {
		
		if(!jsonObject || typeof ids  == "undefined") 
			return "" ;
			
		if (ids.indexOf(".") < 0) {
			if(jsonObject[ids] == undefined ||
				jsonObject[ids].toJSONString() == "{}")
				return "" ;
				
			return jsonObject[ids];
		}
		
		var pos = ids.indexOf(".");
		id = ids.substring(0,pos) ;
		
		if(jsonObject[id] == undefined ||
			typeof(jsonObject[id]) != "object")
			return "" ;
			
		return jsonUtil.getJsonValueViaId(jsonObject[id],ids.substring(pos+1,ids.length));
		
	},
	
	'setJsonValueViaId' : function(jsonObj,ids,value) {
		if(!jsonObj || typeof ids  == "undefined") 
			return null ;
		
		
		
		if (ids.indexOf(".") < 0) {
			if (jsonObj[ids] != "undefined") {
				jsonObj[ids] = value;
			}  
		}
		var pos = ids.indexOf(".");
		id = ids.substring(0,pos) ;
		//if (typeof(jsonObj[id]) == "object") {
		//if(!jsonObj[id]) {
			//jsonObj[id] = {} ;
			
		//}		
		//alert(ids.substring(pos+1,ids.length));
		return jsonUtil.setJsonValueViaId(jsonObj[id],ids.substring(pos+1,ids.length),value);
		//} 
	},
	
	'jsonQuery' : function(dist,data,query) {			
			if(query && query.indexOf('.') > 0) {
				var pos = query.indexOf(".");
				var arQuery = query.substring(0,pos) ;
			}
			
			for(var field in data) {
				if(!arQuery) {
					if (typeof(data[field]) == "object"  &&
						data[field] != 'undefined' && field != query) {
						jsonUtil.jsonQuery(dist,data[field],query);
					} else if( field == query ) {
						dist[field] = data[field];
						return ;
					}
				} else {
					if (typeof(data[field]) == "object" &&
						data[field] != 'undefined'  && field == arQuery) {
						var parData = data[field] ;
						var params = query.split(".");

						for (var i= 0;i<params.length-1;i++) {
							parData = parData[params[i+1]] ;
							if(!parData) {
								parData = null ;
								break ;
							}
						}
						dist[query] = parData ;
						return ;
					} 
					 else if(typeof(data[field]) == "object") {
						jsonUtil.jsonQuery(dist,data[field],query);
					}
				}
			}
		}
		
	 
} ;

//表单数据页面
var formFieldsData = 
{	
	'renderField' : function (fieldAttributes) {
		//if (!fieldAttributes)
			//return ;
		var dcell ;
		if (!fieldAttributes || fieldAttributes.toJSONString() == "{}") {
			dcell = createDCell('datacell2',null);
			var jsonDt = {"option" : "","value" : "" } ;
			var entitySty = Json2Entity(jsonDt) ;
			dcell.styleEntity=  entitySty ;
		} else {
			var fatts = fieldAttributes.toJSONString().split(";");
			var formFields = [] ;
			
			for(var i=0;i<fatts.length;++i) {
				
				var fatt = fatts[i] ;
				
				fatt = fatt.replaceAll('\"','');
				optionValue =fatt.split(',');
				
				var formFieldsOptions = {
					"option" : "",
					"value" : "" 
				}
				
				formFieldsOptions.option = optionValue[0];
				if(trim(formFieldsOptions.option)!=''){//过滤key为空字符串
					formFieldsOptions.value = optionValue[1];
					formFields.push(formFieldsOptions);					
				}	
				 
			}
			dcell = createDCell('datacell2',formFields);
		}
		
		//FIXME: document.getElementById  --> $id
		$id('activityOK').onclick=function(){
			tfields = Dataset2Json(dcell.dataset) ;
			var fieldAttributeData = "";
			var isAddSuffix = false;
 			var temp ="";
 			var x=0;
			for(var i=0;i<tfields.length;++i) {
				fieldAtt = tfields[i] ;			
				if(trim(fieldAtt.option)==''){//过滤key为空字符串
					continue;
				}	
				if(fieldAtt.option.indexOf(',')!=-1||fieldAtt.value.indexOf(',')!=-1){
					alert(fieldAtt);//属性中包含,号
					return;
				}	
				tempField = '' ;
				tempField =fieldAtt.option+","+fieldAtt.value ;							
				if(i==0){
					temp = fieldAtt.option;
				} else{
					temp =temp +","+fieldAtt.option;
				}
				
				if(tfields.length>1 && i != tfields.length-1) 
					isAddSuffix = true ;
				else 
					isAddSuffix = false ;
					
				if(isAddSuffix) {
					fieldAttributeData += tempField+";"
				} else {
					fieldAttributeData += tempField ;
				}
			}			
			var a =temp.split(",").sort();
			function compare(a,b){  
				if(a==b){x=1;}   
				return 0;  
			}     
			a.sort(compare);   
			if(x==1){
				alert(reAttr);//具有重复的属性
				return;
			} 		
			//fields.fieldAttribute = fieldAttributeData ;
			returnValue = fieldAttributeData ;
			window.close() ;
		}
		
		//FIXME: document.getElementById  --> $id
		$id('activityCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}
};

//Edit 应用配置 edit_config_info.jsp
var AppConfiguration = 
{
	'renderAppConfg' : function (appInfo) {
		//保证错误消息层开始总是隐藏的
		poppedLayer = getdiv('errorMsg');
		hidediv(poppedLayer);
		
		//FIX:bug,11188
		//var infoStr = appInfo.toJSONString() ;
		//alert(appInfo);
		//var oldAppInfo = appInfo.clone(true) ;
		var oldAppInfo = eval('(' + appInfo + ')');
		activity.renderActivity(oldAppInfo) ;
		
		deepEntity(true);
		//应用配置 - 参数配置表
		var configParamdist = {} ;
		//alert(appInfo.toJSONString());
		jsonUtil.jsonQuery(configParamdist,oldAppInfo,'parameters.parameter');
		configParamdata = configParamdist['parameters.parameter'] ;
		//alert(configParamdata.toJSONString());
		var dcellConfigParam = createDCell('dataCellConfigParams',configParamdata); 
		//alert("!!!!!!!")
		//FIXME: document.getElementById  --> $name
		$name('activityOK').onclick=function(){
		    if(!isClassPath(oldAppInfo.applicationUri)) {
		   		showdiv(poppedLayer);
		   		return false ;
		    }
			hidediv(poppedLayer);
			
			var parametersData = Dataset2Json(dcellConfigParam.dataset);  //返回参数数据
			
			/*
			fixBug :11192
			if (parametersData == "") {
				alert ("流程参数不能为空!") ;
				return ;
			}
			*/
			//oldAppInfo = eval('(' + oldAppInfo + ')');
			oldAppInfo.parameters.parameter=[] ;
			oldAppInfo.parameters.parameter=parametersData ;
			//appInfo = oldAppInfo ;
			//alert(oldAppInfo.toJSONString()) ;
			var returnStrValue = oldAppInfo.toJSONString() ;
			
			
			
			
			returnValue = returnStrValue;
			//alert('window: '+window.returnValue) ;
			window.close();
		}
		//FIXME: document.getElementById  --> $id
		$id('activityCancel').onclick=function(){
			returnValue = appInfo ;
			window.close() ;
		}
	}
}

/*
var triggerEvents = 
{
	renderTriggerEvent :function(triggerEvent) {
		activity.renderActivity(triggerEvent) ;
		deepEntity(true);
		//render parameter dcell
		var parametersdist = {} ;
		jsonUtil.jsonQuery(parametersdist,triggerEvent,'applicationInfo.application.parameters.parameter');
		parameters = parametersdist['applicationInfo.application.parameters.parameter'] ;
		//parameters = triggerEvent.applicationInfo.application.parameters.parameter ;
		var dcell = createDCell('triggerParamsDcell',parameters);
		
		document.getElementById('activityOK').onclick=function(){
			var parametersData = Dataset2Json(dcell.dataset);  //返回参数数据
			triggerEvent.applicationInfo.application.parameters.parameter = [] ;
			triggerEvent.applicationInfo.application.parameters.parameter = parametersData ;
			returnValue = triggerEvent ;
			window.close() ;
		}
		
		document.getElementById('activityCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}

}*/

//创建DataCell
function createDCell (cell,data,callback) {
	var dtaCell = $o(cell);
	
	if (!dtaCell || dtaCell == null) return null;
	
	dtaCell.showIndex = false ;
	if (data) {
		var tmp=data.toJSONString();
		tmp=tmp.replaceAll("\{\}","\"\"");
		//alert("cccc:"+tmp);
		eval(" tmp="+tmp);
		data=tmp;
		dtaCell.setJsonDataset(data);
		if(isFF) dtaCell.reload();
		
	}
	
	if (!data || data.toJSONString() == "{}") {
		if(callback)
			callback(dtaCell) ;
	}
	
	return dtaCell ;
	
}

//流程信息
var processRender =
{
	'renderProcess' : function (process) {		
		if (!process) {
			throw new Error("process is null");
			return ;
		}
		activity.renderActivity(process);
		deepEntity(true);
		
		//render trigger events 触发事件
		var triggerEventdt = process.triggerEvents.triggerEvent;
		dcelltrgrEvent = createDCell('dataCellTrgEvnts',triggerEventdt);
		
	    //render process participant 流程参与者
	    var parts = process.procStarterLists.procStarter ;
	    dcellParticipant = createDCell('dataCellOrg',parts,function (dtcell){
		  	  var dataStructrue = {} ;
			  var entitySty = Json2Entity(dataStructrue) ;
			  dtcell.styleEntity=  entitySty ;
		 });
			
		 dcellParticipant.afterInit=function(){
			dcellParticipant.setCustomTool('<a href="javascript:addMultpRowOfOrgpart();"><div style="background-image:url('+CONTEXT_PATH+'/workflow/wfmanager/definition/js/grid_tool_add.gif);"></div></a>'); 
		 }
		  
		  var argument = new DataCatchMgr().getDataCatch('processActOrgSelect') ;
		  
		   addMultpRowOfOrgpart = function() {
		   
		  	 var orgParticipants = Dataset2Json(dcellParticipant.dataset)
		  	 for(var i=0;i<orgParticipants.length;++i) {
		  		argument.push(orgParticipants[i]) ;
		  	 }
		  	
		  	showModalCenter(contextPath+"/workflow/wfcomponent/web/selectParticipants.jsp",argument,function (returnValue) {
		  		if (argument.length > 0 && returnValue != null ) 
			 	{
					argument.splice(0,argument.length) ;
				}
				if (returnValue != null && returnValue.length >=0) {
					
					allRows = dcellParticipant.getAllRows() ;
					for(var k=0;k<allRows.length;++k) {
						dcellParticipant.deleteRow(allRows[k]);
					}
					for(var i=0;i<returnValue.length-1;++i) {
						var partObj = returnValue[i] ;
						//argument.push(partObj);
						var entity = Json2Entity(partObj);
						row = dcellParticipant.addRow(entity);	
						dcellParticipant.refreshRow(row);				
					}
				}
		  	},430,500,selectParticipants); //选择参与者
		  }
	    
		//render process relativedata 相关数据
		var relativeDatas = process.dataFields.dataField;
		dcellRelativedat = createDCell('dataCellRelativeDt',relativeDatas);
		//alert(relativeDatas.toJSONString()) ;
		//render process preferences 流程参数
		var parameters = process.parameters.parameter;
		dcellParamterdt = createDCell('dataCellProcessParams',parameters);	
		
		//button action
		//FIXME: document.getElementById  --> $id
		$id('processOK').onclick=function(){
			
			process.dataFields.dataField = Dataset2Json(dcellRelativedat.dataset);
			dataFields= process.dataFields.dataField ;
			var relDataPathArray = new Array() ;
			for (var j=0;j<dataFields.length; ++j) {
				relDataPathArray.push(dataFields[j].name) ;
			}
			if(validateRelativedatPath(relDataPathArray)) {
				alert (validateRelativedatPath);//相关数据路径名不能相同!
				return ;
			}
			
			process.parameters.parameter = Dataset2Json(dcellParamterdt.dataset);
			//alert(process.parameters.parameter.toJSONString())
			process.triggerEvents.triggerEvent = Dataset2Json(dcelltrgrEvent.dataset);
			
			if(process.procStarterLists.processStarterType == 'organization-list') {
				process.procStarterLists.procStarter = Dataset2Json(dcellParticipant.dataset);
			} else {
				process.procStarterLists.procStarter = [];
			}
			
			if(process.timeLimit.isTimeLimitSet == "true" ||
				process.timeLimit.isTimeLimitSet == true) {
				
				//validate
				var errorMsg = "";
				if (process.timeLimit.timeLimitInfo.timeLimitStrategy == "limit_strategy_designate") {
					d = process.timeLimit.timeLimitInfo.day;
					h = process.timeLimit.timeLimitInfo.hour;
					m = process.timeLimit.timeLimitInfo.minute;
					errorMsg = validateLimitedTime(d,h,m,timeLimit) ;//时间限制
				}
				if (process.timeLimit.remindInfo.remindStrategy == "remind_strategy_designate") {
					d = process.timeLimit.remindInfo.day1;
					h = process.timeLimit.remindInfo.hour1;
					m = process.timeLimit.remindInfo.minute1;
					errorMsg += validateLimitedTime(d,h,m,reminderTime) ;//提醒时间
				}
				if(errorMsg!=""){
					alert(errorMsg);
					return false ;
				}
				
				process.timeLimit.timeLimitInfo.remindType="email";
				process.timeLimit.remindInfo.remindType="email";
			}
			
			var radioObj = document.forms[0].elements['timeLimit.timeLimitInfo.timeLimitStrategy'] ;
			var radioLength = radioObj.length;
			if(radioLength != undefined) {
				for (var i=0;i<radioLength;++i) {
					if(radioObj[i].checked) {
							process.timeLimit.timeLimitInfo.timeLimitStrategy = radioObj[i].value ;
							break ;
						}
				}
			}
			radioObj = document.forms[0].elements['timeLimit.remindInfo.remindStrategy'] ;
			radioLength = radioObj.length;
			if(radioLength != undefined) {
				for (var j=0;j<radioLength;++j) {
					if(radioObj[j].checked) {
							process.timeLimit.remindInfo.remindStrategy = radioObj[j].value ;
							break ;
						}
				}
			}
			
			returnValue = process ;
			window.close() ;
		}
		
		//FIXME: document.getElementById  --> $id
		$id('processCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}
	 
}

function validateRelativedatPath(relArray) {
		if(relArray.length > 1) {
			var temp = relArray[0] ;
		} else {
			return false ;
		}
		for (var i=1;i<relArray.length; ++i) {
			if (temp == relArray[i])	
				return true ;
		}
		return validateRelativedatPath(relArray.splice(0,1));
}

//结束活动
var finishActivity =
{ 
	'finishSubActivity' : function (actObject) {
		if (!actObject) {
			throw new Error('finish activity is null');
			return ;
			}
		activity.renderActivity(actObject);
		
		//FIXME: document.getElementById  --> $id
		$id('btnActivateRuleConfig').onclick=function(){
			if(actObject.activateRule == null) {
				actObject.activateRule = {
					applicationInfo : {
						actionType : "" ,
						application : {
							parameters : {
								parameter : []
							}
						}
					}
				}
			} else if (!actObject.activateRule.applicationInfo) {
				actObject.activateRule.applicationInfo = {
					actionType : "" ,
					application : {
						parameters : {
								parameter : []
							}
					}
				}
			} else if (!actObject.activateRule.applicationInfo.application) {
				actObject.activateRule.applicationInfo.application = {
					parameters : {
								parameter : []
							}
				}
			}
			
			data = actObject.activateRule.applicationInfo.application;
			strData = data.toJSONString();
			showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
				if(!rvalue) return ;
				objRValue = eval('('+rvalue+')');
				actObject.activateRule.applicationInfo.application = objRValue;
				actObject.activateRule.applicationInfo.actionType = objRValue.actionType ;
				if(objRValue.applicationUri != undefined)
					// FIXME:document.all --> $e
					$e("activateRule.applicationInfo.application.applicationUri").value = objRValue.applicationUri ;
			},520,350,startPolicy) ;//启动策略应用配置
			
		}
		
		//button action
		//FIXME: document.getElementById  --> $id
		$id('activityOK').onclick=function(){
		
			//validate activity name
			activityName=actObject.activityName;
			if(activityName==""){
				alert(basicInfo);//基本信息:活动名称不能为空
				return false;
			}
			var patrn=/#|@|~|`|\$|&/;
			if(patrn.test(activityName)){
				alert(basicInfo2);//基本信息:活动名称不能包含非法字符如'`~!@#$%^&*()'等
				return false;
			}
			if(actObject.activateRule != null &&
				 actObject.activateRule.activateRuleType != "startStrategybyApp" )  
					actObject.activateRule.applicationInfo = {} ;
			
			returnValue = actObject ;
			//alert(actObject.toJSONString()) ;
			window.close() ;
		}
		
		//FIXME: document.getElementById  --> $id
		$id('activityCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}
}

//路由活动
var routeActivity =
{
	'renderRouteActivity' : function (actObject) {
		if (!actObject) {
			throw new Error('start activity is null');
			return ;
			}
		var sact = actObject ;
		activity.renderActivity(sact);
 		//FIXME: document.getElementById  --> $id
		$id('activityOK').onclick=function(){
			returnValue = actObject ;
			window.close() ;
		}
		//FIXME: document.getElementById  --> $id
		$id('activityCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}
}

//子流程活动
var subActivity = 
{
	'renderSubActivity' : function (actObject) {
		if (!actObject) {
			throw new Error('start activity is null');
			return ;
			}
		activity.renderActivity(actObject);
		deepEntity(true);
		//保证错误消息层开始总是隐藏的
		poppedLayer = getdiv('errorMsg');
		hidediv(poppedLayer);
		//render datacell...
		//回退 - 参数配置表
		//var rollbackParamdt = actObject.implementation.subActivity.rollBack.applicationInfo.application.parameters.parameter ;
		var rollbackParamdt = {} ;
		jsonUtil.jsonQuery(rollbackParamdt,actObject,'rollBack.applicationInfo.application.parameters.parameter');
		rollbackParaData = rollbackParamdt['rollBack.applicationInfo.application.parameters.parameter'] ;
		dcellRollbackParam = createDCell('dataCellRollBackParams',rollbackParaData);
		//触发事件
		var triggerEventdt =  actObject.implementation.subActivity.triggerEvents.triggerEvent;
		dcelltrgrEvent = createDCell('dataCellTrigger',triggerEventdt);
	    //FIXME: document.getElementById  --> $id
	    $id('btnActivateRuleConfig').onclick=function(){
			var dists = {};
			jsonUtil.jsonQuery(dists,actObject,'activateRule.applicationInfo.application');
			data = dists['activateRule.applicationInfo.application'] ;
			if(data == null) {
				data = {
		 			parameters : {
		 				parameter : []
		 				}
				} ;
			}
			
			strData = data.toJSONString();
			showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
				if(!rvalue) return ;
				
				objRValue = eval('('+rvalue+')');
				actObject.activateRule.applicationInfo.application = objRValue;
				actObject.activateRule.applicationInfo.actionType = objRValue.actionType ;
				if(objRValue.applicationUri != undefined)
				//FIXME: document.all ---> $e
					$e("activateRule.applicationInfo.application.applicationUri").value = objRValue.applicationUri ;
			},520,350,startPolicy) ;  
			
		}
		
		//子流程参数选项卡 - 参数配置表
		var subFlowParamsdt = actObject.implementation.subActivity.parameters.parameter ;
		dcellSubFlowParams = createDCell('dataCellSubflowParams',subFlowParamsdt);
		//FIXME: document.getElementById  --> $id
		$id('activityOK').onclick=function(){
		
		
			//validate activity name
			activityName=actObject.activityName;
			if(activityName==""){
				alert(basicInfo);//基本信息:活动名称不能为空
				return false;
			}
			var patrn=/#|@|~|`|\$|&/;
			if(patrn.test(activityName)){
				alert(basicInfo2);//基本信息:活动名称不能包含非法字符如'`~!@#$%^&*()'等
				return false;
			}
		
			if(!isClassPath(actObject.implementation.subActivity.subProcess)) {
		   		showdiv(poppedLayer);
		   		return false ;
		    }
			hidediv(poppedLayer);
			
			//回退参数
			var rollbackParamdt = Dataset2Json(dcellRollbackParam.dataset);  
			if(actObject.implementation.subActivity.rollBack.applicationInfo) {
			} else {
				actObject.implementation.subActivity.rollBack.applicationInfo = {
					actionType : "" ,
					application : {
						actionType : "",
						invokePattern : "synchronous" ,
						transactionType : "join" ,
						exceptionStrategy : "rollback" ,
						applicationUri : "" ,
						parameters : {
							parameter : [] 
						}
					}
				} ;
			}
			
			//FIXME: document.getElementById  --> $id
			acttypeValue = $id('implementation.subActivity.rollBack.applicationInfo.application.actionType').value;
			actObject.implementation.subActivity.rollBack.applicationInfo.application.actionType=acttypeValue ;
			actObject.implementation.subActivity.rollBack.applicationInfo.actionType=acttypeValue ;
			appuriValue = $id('implementation.subActivity.rollBack.applicationInfo.application.applicationUri').value;
			actObject.implementation.subActivity.rollBack.applicationInfo.application.applicationUri=appuriValue;
			actObject.implementation.subActivity.rollBack.applicationInfo.application.parameters.parameter = [] ;
			actObject.implementation.subActivity.rollBack.applicationInfo.application.parameters.parameter = rollbackParamdt ;
			//触发事件
			var triggerEventsdt = Dataset2Json(dcelltrgrEvent.dataset) ;
			actObject.implementation.subActivity.triggerEvents.triggerEvent = [];
			actObject.implementation.subActivity.triggerEvents.triggerEvent = triggerEventsdt ;
			//子流程参数
			var subflowParamdt = Dataset2Json(dcellSubFlowParams.dataset) ;
		    actObject.implementation.subActivity.parameters.parameter = [] ;
		    actObject.implementation.subActivity.parameters.parameter = subflowParamdt ;
			//启动策略
			if(actObject.activateRule.activateRuleType != "startStrategybyApp" )  
					actObject.activateRule.applicationInfo = {} ;
					
			returnValue = actObject ;
			//alert(actObject.toJSONString());
			window.close() ;
		}
		//FIXME: document.getElementById  --> $id
		$id('activityCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}
}

//自动活动
var autoActivity  =
{
	'renderAutoActivity' : function (actObject) {
		if (!actObject) {
			throw new Error('start activity is null');
			return ;
			}
		var sact = actObject ;
		activity.renderActivity(sact);
		deepEntity(true);
		
		/*render datacell*/
		//回退 - 参数配置表
		  var rollbackParmdist = {} ;
		  jsonUtil.jsonQuery(rollbackParmdist,actObject,'applicationInfo.application.parameters.parameter') ;
		  rollbackParam = rollbackParmdist['applicationInfo.application.parameters.parameter'];
		  dcellRollbackParam = createDCell('dataCellRollBackParams',rollbackParam);
		
		//触发事件
		var triggerEvents = actObject.implementation.autoActivity.triggerEvents.triggerEvent ;
		dcelltrgrEvent = createDCell('dataCellTrgEvnts',triggerEvents);
		 //FIXME: document.getElementById  --> $id
		$id('btnConfiguration').onclick=function(){
			if(actObject.implementation.autoActivity.taskApplication.applicationInfo.application == undefined) {
				actObject.implementation.autoActivity.taskApplication.applicationInfo.application = {
					parameters : {
						parameter : []
					}
				}
			}
			data = actObject.implementation.autoActivity.taskApplication.applicationInfo.application ;
			strData = data.toJSONString() ;
			showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
				if(!rvalue) return ;
				
				objRValue = eval('('+rvalue+')');
				//FIXME: document.all --> $e
				$e("implementation.autoActivity.taskApplication.applicationInfo.application.applicationUri").value = objRValue.applicationUri ;
				actObject.implementation.autoActivity.taskApplication.applicationInfo.actionType = objRValue.actionType ;
				actObject.implementation.autoActivity.taskApplication.applicationInfo.application = objRValue ;
			},520,350,appSet) ;//应用设置
		}
		
		//自动执行规则逻辑  点击
		//FIXME: document.getElementById  --> $id
		$id('btnExceptionAppConfg').onclick=function(){
			if(actObject.implementation.autoActivity.taskApplication.exceptionApp == undefined) {
			//定义了这样类型的对象
				actObject.implementation.autoActivity.taskApplication.exceptionApp = {
					actionType : "" ,
					application : {
						parameters : {
							parameter : []
						}
					}
				}
			}
			
			if(actObject.implementation.autoActivity.taskApplication.exceptionApp.application == undefined) {
				actObject.implementation.autoActivity.taskApplication.exceptionApp.application = {
					parameters : {
						parameter : [] 
					}
				}
			}
			
			data = actObject.implementation.autoActivity.taskApplication.exceptionApp.application ;
			strData = data.toJSONString() ;		
			showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
				if(!rvalue) return ;
				
				objRValue = eval('('+rvalue+')');
				//FIXME:document.all --> $e
				$e("implementation.autoActivity.taskApplication.exceptionApp.application.applicationUri").value = objRValue.applicationUri ;
				actObject.implementation.autoActivity.taskApplication.exceptionApp.actionType = objRValue.actionType ;
				actObject.implementation.autoActivity.taskApplication.exceptionApp.application = objRValue ;
			},520,350,autoExecuteRule) ;//自动执行规则逻辑
		}
		
		 //启动策略
		 //FIXME: document.getElementById  --> $id
	   $id('btnActivateRuleConfig').onclick=function(){
			var dists = {};
			jsonUtil.jsonQuery(dists,actObject,'activateRule.applicationInfo.application');
			data = dists['activateRule.applicationInfo.application'] ;
			if(data == null) {
				if(actObject.activateRule.applicationInfo == null) {
					actObject.activateRule.applicationInfo = {} ;
				}
				data = {
		 			parameters : {
		 				parameter : []
		 				}
				} ;
			}
			
			strData = data.toJSONString();
			showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
				if(!rvalue) return ;
				
				objRValue = eval('('+rvalue+')');
				actObject.activateRule.applicationInfo.application = objRValue;
				actObject.activateRule.applicationInfo.actionType = objRValue.actionType ;
				if(objRValue.applicationUri != undefined)
					// FIXME : document.all --->$e
					$e("activateRule.applicationInfo.application.applicationUri").value = objRValue.applicationUri ;
			},520,350,startPolicy);//启动策略应用配置
		}
		
		/*$id('description').onblur=function(){
			var description =$id('description');
			checkInput(description);
		}*/
		
		
		//button action creator
		//FIXME: document.getElementById  --> $id
		$id('activityOK').onclick=function(){
			
			//validate activity name
			activityName=actObject.activityName;
			if(activityName==""){
				alert(basicInfo);//基本信息:活动名称不能为空
				return false;
			}
			var patrn=/#|@|~|`|\$|&/;
			if(patrn.test(activityName)){
				alert(basicInfo2);//基本信息:活动名称不能包含非法字符如'`~!@#$%^&*()'等
				return false;
			}
			//回退 - 参数配置表
			var rollbackParamdt = Dataset2Json(dcellRollbackParam.dataset);  
			if(actObject.implementation.autoActivity.rollBack.applicationInfo) {

			} else {
				actObject.implementation.autoActivity.rollBack.applicationInfo = {
					actionType : "" ,
					application : {
						actionType : "",
						invokePattern: "synchronous",
						exceptionStrategy: "ignore",
						transactionType: "suspend",
						applicationUri : "" ,
						parameters : {
							parameter : [] 
						}
					}
				} ;	
			}
			//FIXME: document.getElementById  --> $id
			actypeValue = $id('implementation.autoActivity.rollBack.applicationInfo.application.actionType').value;
			actObject.implementation.autoActivity.rollBack.applicationInfo.actionType=actypeValue;
			actObject.implementation.autoActivity.rollBack.applicationInfo.application.actionType=actypeValue;
			appuriValue = $id('implementation.autoActivity.rollBack.applicationInfo.application.applicationUri').value;
			actObject.implementation.autoActivity.rollBack.applicationInfo.application.applicationUri=appuriValue;
			actObject.implementation.autoActivity.rollBack.applicationInfo.application.parameters.parameter = [] ;
			actObject.implementation.autoActivity.rollBack.applicationInfo.application.parameters.parameter = rollbackParamdt ;
			//config
			
			//回滚异常
			exStrategy = actObject.implementation.autoActivity.taskApplication.applicationInfo.application.exceptionStrategy ;
			
			//自动路由到其它活动，活动终止
			if(exStrategy != 'auto-freejump') {
				actObject.implementation.autoActivity.taskApplication.destActivityInException = "" ;
			}
			//自动执行规则逻辑
			if(exStrategy != 'auto-application') {
				actObject.implementation.autoActivity.taskApplication.exceptionApp = {} ;
			}
			//激活策略
			if(actObject.activateRule != undefined && 
					actObject.activateRule.activateRuleType != "startStrategybyApp") {
				actObject.activateRule.applicationInfo = {} ;
			}
			//触发事件
			var triggerEventdt = Dataset2Json(dcelltrgrEvent.dataset);  
			actObject.implementation.autoActivity.triggerEvents.triggerEvent = [] ;
			actObject.implementation.autoActivity.triggerEvents.triggerEvent = triggerEventdt ;
			
			returnValue = actObject ;
			window.close() ;
		}
		//FIXME: document.getElementById  --> $id
		$id('activityCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}
}

//开始活动
var startActivity =
{
	'renderStartActivity' : function (actObject) {
		
		if (!actObject) {
			throw new Error('start activity is null');
			return ;
			}
		var sact = actObject ;
		activity.renderActivity(sact);
		
		//render formdata datacell
		var formfields = actObject.implementation.startActivity.formFields ;
		var dists = {};
		jsonUtil.jsonQuery(dists,actObject,'formFields');
		var data ;
		if(dists.formFields){
			data = dists.formFields.formField ?  dists.formFields.formField : null;
		}
		var dcell = createDCell('datacell1',data);
		if(!data) {
			 var dataStructrue = {} ;
			 var entitySty = Json2Entity(dataStructrue) ;
			 dcell.styleEntity=  entitySty ;
		}
		//button action creator
		//FIXME: document.getElementById  --> $id
		$id('activityOK').onclick=function(){
			//validate activity name
			activityName=actObject.activityName;
			if(activityName==""){
				alert(basicInfo);//基本信息:活动名称不能为空
				return false;
			}
			var patrn=/#|@|~|`|\$|&/;
			if(patrn.test(activityName)){
				alert(basicInfo2);//基本信息:活动名称不能包含非法字符如'`~!@#$%^&*()'等
				return false;
			}
			var startForm = Dataset2Json(dcell.dataset);  //返回启动表单数据
			actObject.implementation.startActivity.formFields.formField=[];
			actObject.implementation.startActivity.formFields.formField=startForm;	
			returnValue = actObject ;
			
			window.close() ;
		}
		//FIXME: document.getElementById  --> $id
		$id('activityCancel').onclick=function(){
			returnValue = null;
			window.close() ;
		}
	}
}

//人工活动
var manualActivity =
{
	'renderManualActivity' : function(actObject){
		//alert(actObject.activity.description.toJSONString());
		var manualActObj = actObject.activity ;
		if (!manualActObj) {
			throw new Error('manual activity is null');
			return ;
			}
			
		deepEntity(true);
		
		// render manual activity base info (string type)
		activity.renderActivity(manualActObj) ;
		//render organization
		  var dists = {};
		  jsonUtil.jsonQuery(dists,manualActObj,'organization');
		  var partParam = null ;
		  if (dists.organization && dists.organization.participant) {
		  	partParam =  dists.organization.participant ;
		  } 
		  dcell = createDCell('dataCellOrg',partParam,function (dtcell){
		  	  var dataStructrue = {} ;
			  var entitySty = Json2Entity(dataStructrue) ;
			  dtcell.styleEntity=  entitySty ;
		  });
			
		  dcell.afterInit=function(){
			dcell.setCustomTool('<a href="javascript:addMultpRowOfOrgpart();"><div style="background-image:url('+CONTEXT_PATH+'/workflow/wfmanager/definition/js/grid_tool_add.gif);"></div></a>'); 
		  }
		  
		  var argument = new DataCatchMgr().getDataCatch('manualActOrgSelect') ;
		  
		   addMultpRowOfOrgpart = function() {
		  	 var orgParticipants = Dataset2Json(dcell.dataset)
		  	 for(var i=0;i<orgParticipants.length;++i) {
		  		argument.push(orgParticipants[i]) ;
		  	 }
		  	 	//showModalCenter(contextPath+"/workflow/wfcomponent/web/selectParticipantsWithJoint.jsp",argument,function (returnValue) {
			  	var action = 'com.primeton.eos.tag.selectParticipant.flow?_eosFlowAction=action0';
		  		showModalCenter(action,argument,function (returnValue) {
		  		if (argument.length > 0 && returnValue != null ) 
			 	{
					argument.splice(0,argument.length) ;
				}
				if (returnValue != null && returnValue.length >=0) {					
					allRows = dcell.getAllRows() ;
					for(var k=0;k<allRows.length;++k) {
						dcell.deleteRow(allRows[k]);
					}
					for(var i=0;i<returnValue.length-1;++i) {
						var partObj = returnValue[i] ;
						//argument.push(partObj);
						var entity = Json2Entity(partObj);
						//alert(entity.toJSONString()) ;
						row = dcell.addRow(entity);	
						dcell.refreshRow(row);				
					}
				}
		  	},'340','450',selectParticipants);//选择参与者
		  }

		  //render trigger events
		   var trgEvnts = {} ;
		   jsonUtil.jsonQuery(trgEvnts,manualActObj,'manualActivity.triggerEvents');
			//alert(trgEvnts['manualActivity.triggerEvents'].triggerEvent.toJSONString());
			dcell2 = createDCell('dataCellTrgEvnts',trgEvnts['manualActivity.triggerEvents'].triggerEvent,function(dtcell){
				  var dataStructrue = {
				  	actionType : "" ,
				  	eventType : "" ,
				  	description : "" ,
				  	applicationInfo : {
				  		actionType : "" ,
						application : {
							actionType : "",
							invokePattern : "" ,
							transactionType : "" ,
							exceptionStrategy : "" ,
							applicationUri : "" ,
							parameters : {
								parameter : [] 
							}
						}
					}
				  } ;
				  var entitySty = Json2Entity(dataStructrue) ;
				  dtcell.styleEntity=  entitySty ;
			});
		  
		   //NextFreeActivity  dataCellFreeActivities
		   if(manualActObj.implementation.manualActivity.freeFlowRule.nextFreeActivities == null) {
		   	  manualActObj.implementation.manualActivity.freeFlowRule.nextFreeActivities = {
		   	  	freeActivity : [] 
		   	  }
		   }
		   nextActivities = manualActObj.implementation.manualActivity.freeFlowRule.nextFreeActivities.freeActivity;
		   var nextActsDtcell = createDCell('dataCellFreeActivities',nextActivities);
		   
		    //启动策略:规则逻辑
		    //FIXME: document.getElementById  --> $id
		   $id('btnActivateRuleConfig').onclick=function(){
				var dists = {};
				jsonUtil.jsonQuery(dists,manualActObj,'activateRule.applicationInfo.application');
				data = dists['activateRule.applicationInfo.application'] ;
				if(data == null) {
					if(manualActObj.activateRule.applicationInfo == null) {
						manualActObj.activateRule.applicationInfo = {} ;
					}
					data = {
			 			parameters : {
			 				parameter : []
			 				}
					} ;
				}
				
				strData = data.toJSONString();
				showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
					if(!rvalue) return ;
					
					objRValue = eval('('+rvalue+')');
					manualActObj.activateRule.applicationInfo.application = objRValue;
					manualActObj.activateRule.applicationInfo.actionType = objRValue.actionType;
					if(objRValue.applicationUri != undefined)
						// FIXME:document.all -->$e
						$e("activateRule.applicationInfo.application.applicationUri").value = objRValue.applicationUri ;
				},520,350,startPolicy);//启动策略应用配置
			}
			
		   //FIXME: document.getElementById  --> $id
		   $id('btnParticipantRuleConfig').onclick=function(){
				
				if(manualActObj.implementation.manualActivity.participants.regularApp == undefined) {
					manualActObj.implementation.manualActivity.participants.regularApp = {
						actionType : "" ,
						application : {
							parameters : {
								parameter : []
							}
						}
					}
				}
				var data = manualActObj.implementation.manualActivity.participants.regularApp.application ;
				if (data == undefined) {
					data = {
						parameters : {
							parameter : []
						}
					}
				}
				strData = data.toJSONString();
				showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
					if(!rvalue) return ;
					objRValue = eval('('+rvalue+')');
					manualActObj.implementation.manualActivity.participants.regularApp.application = objRValue ;
					manualActObj.implementation.manualActivity.participants.regularApp.actionType = objRValue.actionType ;
					if(objRValue.applicationUri != undefined)
						//FIXME: document.all --> $e
						$e("implementation.manualActivity.participants.regularApp.application.applicationUri").value = objRValue.applicationUri ;
						
				},520,350,participantInfo);//参与者信息规则逻辑获取
			}
			
		   //render formData 
			var formFields = {} ;
			jsonUtil.jsonQuery(formFields,manualActObj,'formFields') ;
			dcell3 = createDCell('dataCellFormdata',formFields.formFields.formField);
		
		   //render rollback params
			var rollbackPams = {} ;
			jsonUtil.jsonQuery(rollbackPams,manualActObj,'rollBack.applicationInfo.application.parameters.parameter') ;
			dcell4 = createDCell('dataCellRBackParams',rollbackPams['rollBack.applicationInfo.application.parameters.parameter']);
 			
			// button action creator ..
			//FIXME: document.getElementById  --> $id
			$id('activityOK').onclick=function(){
				//validate activity name
				activityName=manualActObj.activityName;
				if(activityName==""){
					alert(basicInfo);//基本信息:活动名称不能为空
					return false;
				}
				var patrn=/#|@|~|`|\$|&/;
				if(patrn.test(activityName)){
					alert(basicInfo2);//基本信息:活动名称不能包含非法字符如'`~!@#$%^&*()'等
					return false;
				}
				//validate custom url
				urlType = manualActObj.implementation.manualActivity.customURL.urlType;
				urlInfo = manualActObj.implementation.manualActivity.customURL.urlInfo;
				
				specifyUrl = manualActObj.implementation.manualActivity.customURL.isSpecifyURL;
				
				if(specifyUrl == false) {
					manualActObj.implementation.manualActivity.customURL.urlType = "";
					manualActObj.implementation.manualActivity.customURL.urlInfo = "";
				} else {
					
					if(urlType == "") {
						alert(basicInfoExtensionAttr);//基本信息:扩展属性:请选择URL类型
						return false;
					}
				
					if(trim(urlInfo) == "") {
						alert(basicInfoExtensionAttr2);//基本信息:扩展属性:调用URL不能为空
						return false;
					}
					/*fixbug 10957
					indx = urlInfo.lastIndexOf(".");
					suffix = urlInfo.substring(indx+1,urlInfo.length);
									
					if(urlType == "pageflow"){
						if(!(isPageflowPath(v))) {
							alert("[基本信息] 自定义URL不是一个页面流") ;
							return false;
						}
							
					} else if (urlType == "webpage") {
						
						if (suffix != "jsp" || suffix != "html" || suffix != "htm") {
							alert("[基本信息] 自定义URL不是一个JSP或HTML页面") ;
							return false;
						}
					}*/
				}
				
				//参与者表格
				var partType = manualActObj.implementation.manualActivity.participants.participantType ;
				if(partType== "organization-list") {
					var orgParticipants = Dataset2Json(dcell.dataset);  
					if(manualActObj.implementation.manualActivity.participants.organization) {
						manualActObj.implementation.manualActivity.participants.organization.participant=[];
					} else {
						manualActObj.implementation.manualActivity.participants.organization = {
							isAllowAppointParticipants : "",
							participant : [] 
						} ;
					}
					if(orgParticipants && orgParticipants!= "") {
					//FIXME: document.getElementById  --> $id
						cvalue = $id('implementation.manualActivity.participants.organization.isAllowAppointParticipants').checked ;
						manualActObj.implementation.manualActivity.participants.organization.isAllowAppointParticipants = cvalue;
						manualActObj.implementation.manualActivity.participants.organization.participant=orgParticipants;
					}
				} else {
					if(manualActObj.implementation.manualActivity.participants != null &&
							manualActObj.implementation.manualActivity.participants.organization != null) {
							manualActObj.implementation.manualActivity.participants.organization.isAllowAppointParticipants = 'false';
							manualActObj.implementation.manualActivity.participants.organization.participant = [] ;
						}
				} 
				
				if (partType != 'rulelogic'){
					manualActObj.implementation.manualActivity.participants.regularApp = {} ;
				}
				if (partType != 'relevantdata'){
					manualActObj.implementation.manualActivity.participants.specialPath = "" ;
				}
				if (partType != 'act-executer'){
					manualActObj.implementation.manualActivity.participants.specialActivityID = "" ;
				}
				
				//FreeActivities
				freeStrategy = manualActObj.implementation.manualActivity.freeFlowRule.freeRangeStrategy ;
				if(freeStrategy == 'freeWithinActivityList') {
					var nxtActsDat = Dataset2Json(nextActsDtcell.dataset) ;
					manualActObj.implementation.manualActivity.freeFlowRule.nextFreeActivities.freeActivity = nxtActsDat ;
				} else {
					manualActObj.implementation.manualActivity.freeFlowRule.nextFreeActivities = {} ;
				}
				//启动策略
				if(manualActObj.activateRule != undefined && 
						manualActObj.activateRule.activateRuleType != "startStrategybyApp") {
					manualActObj.activateRule.applicationInfo = {} ;
				}
				
				//validate  resetUrl
				resetUrlType=manualActObj.implementation.manualActivity.resetUrl.urlType;
				resetUrlInfo=manualActObj.implementation.manualActivity.resetUrl.urlInfo;
				resetUrlSpecifyURL=manualActObj.implementation.manualActivity.resetUrl.isSpecifyURL;
				if(resetUrlSpecifyURL == false) {
					manualActObj.implementation.manualActivity.resetUrl.urlType="";
					manualActObj.implementation.manualActivity.resetUrl.urlInfo="";
				} else {				
					if(resetUrlType == "") {
							alert(startPolicyRestart);//启动策略:重新启动规则:请选择URL类型
							return false;
						}
					
					if(trim(resetUrlInfo) == "") {
							alert(startPolicyRestart2);//启动策略:重新启动规则:调用URL不能为空
							return false;
					}
				}
			
				
				//表单数据表格
				var formFieldsDt = Dataset2Json(dcell3.dataset);   
				manualActObj.implementation.manualActivity.formFields.formField = [] ;
				manualActObj.implementation.manualActivity.formFields.formField = formFieldsDt ;
				//触发事件表格 
				var trggerEvnts = Dataset2Json(dcell2.dataset);   
				manualActObj.implementation.manualActivity.triggerEvents.triggerEvent = [] ;
				manualActObj.implementation.manualActivity.triggerEvents.triggerEvent = trggerEvnts ;
				//回退信息表格 
				var rollbackParameterDt = Dataset2Json(dcell4.dataset);	
				rollBack = manualActObj.implementation.manualActivity.rollBack ;
				
				appInfo = {
						actionType : "" ,
						application : {
							actionType : "" ,
							invokePattern: "synchronous",
							exceptionStrategy:"ignore",
							transactionType:"suspend",
							applicationUri : "" ,
							parameters : {
								parameter : []
							}
						}
					} ;
				//FIXME: document.all -->$e
				actionTypeVue = $e('implementation.manualActivity.rollBack.applicationInfo.actionType').value;
				appInfo.actionType = actionTypeVue ;	
				appInfo.application.actionType = actionTypeVue ;
				//FIXME: document.all -->$e()
				appInfo.application.applicationUri = $e('implementation.manualActivity.rollBack.applicationInfo.application.applicationUri').value ;
				appInfo.application.parameters.parameter = rollbackParameterDt ;
				
				if(appInfo.application.applicationUri != "") {
					rollBack.applicationInfo = appInfo;
				} else {
					rollBack.applicationInfo = {};
				}
				
				//alert(manualActObj.implementation.manualActivity.timeLimit.isTimeLimitSet);
				if(manualActObj.implementation.manualActivity.timeLimit.isTimeLimitSet == "true" ||
				 	manualActObj.implementation.manualActivity.timeLimit.isTimeLimitSet == true) {
					//validate
					//alert(manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy);
					//alert(manualActObj.implementation.manualActivity.timeLimit.remindInfo.remindStrategy);
					var errorMsg = "";
					if (manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy == "limit_strategy_designate") {
						d = manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.day;
						h = manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.hour;
						m = manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.minute;
						errorMsg = validateLimitedTime(d,h,m,timeLimitPolicy);//时间限制设置策略:时限
						
					}
					if (manualActObj.implementation.manualActivity.timeLimit.remindInfo.remindStrategy == "remind_strategy_designate") {
						d = manualActObj.implementation.manualActivity.timeLimit.remindInfo.day1;
						h = manualActObj.implementation.manualActivity.timeLimit.remindInfo.hour1;
						m = manualActObj.implementation.manualActivity.timeLimit.remindInfo.minute1;
						errorMsg += validateLimitedTime(d,h,m,timeLimitPolicy2) ;//提醒时间限制设置策略:提前
						
					}
					// 第一次加在页面也要判断
					if (manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy == "limit_strategy_reldata") {
						if(isNull(manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.relevantData)){
							alert(timeLimitRelevantData);//时间限制:相关数据:不能为空值
							return false;
						}
						
					}
					// 第一次加在页面也要判断
					if (manualActObj.implementation.manualActivity.timeLimit.remindInfo.remindStrategy == "remind_strategy_reldata") {
						if(isNull(manualActObj.implementation.manualActivity.timeLimit.remindInfo.remindRelevantData)){
							alert(timeLimitRelevantData);//提醒时间:相关数据:不能为空值
							return false;
						}
						
					}
					if(errorMsg!=""){
						alert(errorMsg);
						return false ;
					}
					
					manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.remindType="email";
					manualActObj.implementation.manualActivity.timeLimit.remindInfo.remindType="email";
				}

				if(manualActObj.implementation.manualActivity.multiWorkItem.isMulWIValid == "true" ||
					manualActObj.implementation.manualActivity.multiWorkItem.isMulWIValid == true){					
					var errorMsg = "";									
					if (manualActObj.implementation.manualActivity.multiWorkItem.finishRule == "specifyNum") {
						worknum = manualActObj.implementation.manualActivity.multiWorkItem.finishRquiredNum;
									
						errorMsg += validateWorkItemNum(worknum,mutiWorkitemSet);//多工作项设置:完成个数
						
					}
					//alert(manualActObj.implementation.manualActivity.multiWorkItem.finishRule);
					if (manualActObj.implementation.manualActivity.multiWorkItem.finishRule == "specifyPercent") {
							workper = manualActObj.implementation.manualActivity.multiWorkItem.finishRequiredPercent;
						
					    errorMsg += validateWorkPer(workper,mutiWorkitemSet2);//多工作项设置:完成百分比
							
					}					
					if(errorMsg!=""){					
							alert(errorMsg);
							return false ;
					}	
					
				}
				
				
				
				var radioObj = document.forms[0].elements['implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy'] ;
				var radioLength = radioObj.length;
				if(radioLength != undefined) {
					for (var i=0;i<radioLength;++i) {
						if(radioObj[i].checked) {
								manualActObj.implementation.manualActivity.timeLimit.timeLimitInfo.timeLimitStrategy = radioObj[i].value ;
								break ;
							}
					}
				}
				radioObj = document.forms[0].elements['implementation.manualActivity.timeLimit.remindInfo.remindStrategy'] ;
				radioLength = radioObj.length;
				if(radioLength != undefined) {
					for (var j=0;j<radioLength;++j) {
						if(radioObj[j].checked) {
								manualActObj.implementation.manualActivity.timeLimit.remindInfo.remindStrategy = radioObj[j].value ;
								break ;
							}
					}
				}
				//alert(manualActObj.toJSONString());
				returnValue = manualActObj;
				window.close() ;
			}
			//FIXME: document.getElementById  --> $id
			$id('activityCancel').onclick=function(){
				returnValue = null;
				window.close() ;
			}
	} 
};

function validateWorkPer(num,prefix){
	var errorMsg = "";
	if(isNull(num)|| trim(num) ==""){
		errorMsg = prefix+mustFill ;//必须填写! \n
		return errorMsg;
	}
	if(!isNumber(num,true)){
		errorMsg = prefix+mustInteger ;//必须为整数! \n
		return errorMsg;
	}
	if( num <0 ){
		errorMsg = prefix+mustPositive ;//必须为正数! \n
		return errorMsg;
	}
	if( num >100){
		errorMsg = prefix+canNotExceed100 ;//不能大于100! \n
		return errorMsg;
	}
	return errorMsg;
}

function validateWorkItemNum(num,prefix){
	var errorMsg = "";
	if(isNull(num)|| trim(num) ==""){
		errorMsg = prefix+mustFill ;//必须填写! \n
		return errorMsg;
	}
	if(!isNumber(num,true)){
		errorMsg = prefix+mustInteger ;//必须为整数! \n
		return errorMsg;
	}
	if( num >0x7fffffff){
		errorMsg = prefix+java ;//不能超出Java整型的最大值! \n
		return errorMsg;
	}
	return errorMsg;
}

function validateLimitedTime (d,h,m,prefix) {
	var errorMsg = "" ;
	
	if(d == '' && h == '' && m == '') 
	{
		errorMsg = prefix+validateLimitedTime ;//项至少有一项不为空! \n
		return errorMsg;
	}  
	
	if (!isNumber(d,true)) {
		errorMsg += prefix+validateLimitedTime1 ;//天必须为整数 \n
	}
	
	if (!isNumber(h,true)) {
		errorMsg += prefix+validateLimitedTime2 ;//小时必须为整数 \n
	}
	
	if (!isNumber(m,true)) {
		errorMsg += prefix+validateLimitedTime3 ;//分钟必须为整数 \n
	}
	
	if(d<0 || d>3650) {
		errorMsg += prefix+validateLimitedTime4;//天数值必须在0~3650之间 \n
	}
	
	if(h<0 || h>23) {
		errorMsg += prefix+validateLimitedTime5;//小时数值必须在0~23之间 \n
	}
	if(m<0 || m>59){
		errorMsg += prefix+validateLimitedTime6 ;//分钟数值必须在0~59之间 \n
	}

	return errorMsg ;
}

function isNumber(objNo,ignoreblank) {
	if(ignoreblank && objNo == ''){
		return true;
	}
	return((/^[0-9]+$/).test(objNo));
}	 

String.prototype.toBoolean=function(){
	if(this == "true") return true ;
	else if(this == "false")  return false ;
	else return this;
};

String.prototype.isBooleanValue=function(){
	if(this == "true" ||this =="false")
		return true;
	return false ;
};

String.prototype.replaceAll = function(strTarget, strSubString){
 var strText = this;
 var intIndexOfMatch = strText.indexOf( strTarget );
  
 while (intIndexOfMatch != -1){

	 strText = strText.replace( strTarget, strSubString )
	  
	 intIndexOfMatch = strText.indexOf( strTarget );
 }
  
 return( strText );
}

function dataTableObject(id) {
	var headingLabs = new Array();
	var oRow, oCell,entBox,oTable,oTableBuf,oTableBox,oBody,toolBox;
	var oTHead ;
	var delimiter = ",";
	this.selectedRow = new Array(0);
	if(!id)
		throw new Error('id is requeried');
		//FIXME: document.getElementById  --> $id
	dataContainer = $id(id);
	
	oTable = document.createElement("TABLE") ;
	oTable.border="1";
	oTable.cellSpacing = 0;
    oTable.cellPadding = 0;
    oTable.style.width = "100%";
    oTable.style.tableLayout = "fixed";
    
    oTableBuf = document.createElement("DIV");
    oTableBuf.appendChild(oTable);
    
    oTableBox = document.createElement("DIV");
    oTableBox.style.width = "100%";
    //oTableBox.style.height = "";
    oTableBox.style.overflow = "auto";
    oTableBox.style.position = "relative";
    oTableBox.appendChild(oTableBuf);
    //oTableBox.className = "";
    toolBox = document.createElement("DIV");
    
    html = "<table cellpadding='0' cellspacing='0' height='28'>" +
			"<tr>" +
			"		<td><div logic='action' action='"+id+"AddRow' class='editButton'><img id='"+id+"_add' src='"+CONTEXT_PATH+"/workflow/wfmanager/definition/js/grid_tool_add.gif' style='cursor:pointer' alt='Add a row' title='Add' /></div></td>" +
			"		<td><div logic='action' action='"+id+"EditRow' class='editButton'><img id='"+id+"_edit' src='"+CONTEXT_PATH+"/workflow/wfmanager/definition/js/edit.gif'  style='cursor:pointer'  alt='Edit this row' title='Edit' /></div></td>" +
			"		<td><div logic='action' action='"+id+"DeleteRow' class='editButton'><img id='"+id+"_delete' src='"+CONTEXT_PATH+"/workflow/wfmanager/definition/js/delete.png'  style='cursor:pointer'  alt='Delete this row' title='Delete' /></div></td>" +
			"</tr>" +
			"</table>"  
    
    
    toolBox.innerHTML=html ;
    //toolBox.style.paddingLeft="330px";
    
    dataContainer.appendChild(toolBox);
    dataContainer.appendChild(oTableBox);
    oTHead = oTable.createTHead();
    
    this.setHeader = function(hdrStr) {
    	if (typeof(hdrStr)!="object")
	      var hdrLaps = this._eSplit(hdrStr);
	    else hdrLaps=[].concat(hdrStr);
 
	    headingLabs = hdrLaps ; 
	    //insert a row into the header.
	    var arRow = oTHead.insertRow(-1);
	    oTHead.setAttribute("bgColor","lightskyblue");
	    
	    var hdrLength = headingLabs.length ;
	    if (hdrLength == undefined)
	    	return ;
	    for(var i=0;i<hdrLength;++i) {
	    	arCell = arRow.insertCell(-1);
	    	arCell.align = "center" ;
	    	arCell.style.fontWeight = "bold" ;
	    	arCell.innerHTML = headingLabs[i];
	    }
    }
    
    this.loadJsonData = function(data,fieldStr,clear) {
    	var obj = this ;
    
    	if(clear) {
	    	this._clearTbody(this.oBody);
    	} 
    	
   		if(!data || typeof(data)!="object") {
   			return  ;
   			}

   		if (fieldStr && typeof(fieldStr)!="object") 
	      	var dtFields = this._eSplit(fieldStr);
	      
   		if(!(data instanceof Array)) {
   			data = transform2Array(data) ;
   		}
   		
   		if(!this.oBody)
   			this.oBody = document.createElement("TBODY");
   		//this.oBody.id= "dTBody" ;
		for(var i=0;i<data.length ;++i) {
			dataObj = data[i] ;
			oRow = document.createElement("TR") ;
			oRow.style.cursor="pointer";
			oRow.style.backgroundColor="white";
			//注册事件
			(function(oRow){oRow.onmouseover =function() {
				if(oRow.style.backgroundColor != "#ccd6d0")
					 oRow.style.backgroundColor="#ced6de";
				  }})(oRow);
			(function(oRow){oRow.onmouseout =function() {
					if(oRow.style.backgroundColor != "#ccd6d0")
					 	oRow.style.backgroundColor="white";
				  }})(oRow);
			(function(obj,oRow,dataObj){oRow.onclick =function() {
					 obj._onRowClick(oRow,dataObj);
				  }})(obj,oRow,dataObj);
				  
				  
			this.oBody.appendChild(oRow);
						
			if(dtFields == undefined) {
				for(field in dataObj) {
					if (typeof(dataObj[field]) != "object" &&
						 typeof(dataObj[field]) != "function") {
						oCell = document.createElement("TD");
						oCell.align = "center" ;
	      				oCell.innerHTML = dataObj[field] ;
	      				oRow.appendChild(oCell);
					}  
				}
			}
			else {
				dtFldLength = dtFields.length ;
				for(var j = 0;j< dtFldLength; j ++) {
					var dis = {} ;
					jsonUtil.jsonQuery(dis,dataObj,dtFields[j]);
					oCell = document.createElement("TD");
					oCell.align = "center" ;
      				oCell.innerHTML = "&nbsp;"+dis[dtFields[j]];
      				oRow.appendChild(oCell);
				}
			}
		}
		
		oTable.appendChild(this.oBody);
    }
    
    this.addRow = function (data,fieldStr) {
    	if(!data)
    		return ;
    	this.loadJsonData(data,fieldStr);
    }
    
    this.editRow = function () {
    }
    
    this.deleteRow = function (){
    }
    
    this._eSplit=function(str){
		if (![].push) return str.split(delimiter);
	 	var a="r"+(new Date()).valueOf();
	 	var z=delimiter.replace(/([\|\+\*\^])/g,"\\$1")
   		return (str||"").replace(RegExp(z,"g"),a).replace(RegExp("\\\\"+a,"g"),delimiter).split(a); 
	}
    
}

dataTableObject.prototype._clearTbody = function (tbody) {
 	//clear the tbody 
   if(!tbody) return ;
   while (tbody.childNodes.length > 0) {
      tbody.removeChild(tbody.firstChild);
   }
   //clear the selected row array data
   this.selectedRow = new Array(0);
   return tbody ;
}

dataTableObject.prototype._onRowClick = function (oRow,dataObj) {
	if(oRow.style.backgroundColor != "#ccd6d0") {
	 	oRow.style.backgroundColor="#ccd6d0";
	 	this.selectedRow[this.selectedRow.length] = dataObj ;
	 }
	 else { 
	 	oRow.style.backgroundColor="white";
		for (var i=0;i<this.selectedRow.length;i++) {
			if (this.selectedRow[i] == dataObj) {
				this.selectedRow.splice(i,1);
				return;
			}
		}
	 }
}

function dtableEvent(el,event,handler){
    if (el.addEventListener)
		el.addEventListener(event,handler,false);
	else if (el.attachEvent)
		el.attachEvent("on"+event,handler);
}

function buttonActionCreator (divs,object,tag) {
		if(!tag)
			tag = "input" ;
		btnCreator = function (div) {
			return function() {
				exAction = getExtraAttribute(div,"action");
				return eval(exAction+"(object)");
			}
		 }
		 
		 for (var i = 0; i < divs.length; i++) {
			var div = divs[i];
			if (div.className == "editButton") {
				var button = div.getElementsByTagName(tag)[0];
				if(button) { 
					(function(button){
							button.onclick =btnCreator(div,object);
						})(button); 
				}	
			}
		}
}

function transform2Array (data) {
	if (!(data instanceof Array)) {
		temp = new Array() ;
  		temp.push(data);
   		data = temp ;
	}
	return data ;
}

function jump(msg)
{
	if(confirm(msg))
	{
		return true;
	}
}

function clone (obj,deepClone) {
  var result = new obj.constructor() ;
  for (var property in obj) {
    if (deepClone && typeof(obj[property]) == 'object') {
    
      result[property] = clone(obj[property],deepClone) ;
      
    } else {
      result[property] = obj[property] ;
    }
  }
  return(result) ;
}


function isClassPath(str) {
	//var patrn = /^\w+(.\w+)*$/;
	//return patrn.test(str) ;
	//不做校验
	return true;
}

function isWorkflowPath(str) {
	var patrn = /^\w+(.\w+)(workflow)/;
	return patrn.test(str) ;
}

function isPageflowPath(str){
    //var patrn = /^[\/]*([^\/\\ \:\*\?"\<\>\|\.][^\/\\\:\*\?\"\<\>\|]{0,63}\/)*[^\/\\ \:\*\?"\<\>\|\.][^\/\\\:\*\?\"\<\>\|]{0,63}$/ ;
	//var patrn = /^[\/]\w+([\/]\w+)(flowx)/ ;
	var patrn = /^\/+$/;
	return patrn.test(str);
	
}

///参数表格相关方法
function setCheckboxValue (value,entity,rowIndex,colIndex) {
			
	var funcName='fillBack_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('fillBack',''+this.checked);
	} );
	
	var _v=''+value;
	var ckox = '<input onclick="$function(\''+funcName+'\',this,['+colIndex+'])" type=checkbox ' + (_v=="true"?'checked':'')  +">" ;
	return ckox ;
	
}

function setIsArrayValue (value,entity,rowIndex,colIndex) {
			
	var funcName='isArray_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('isArray',''+this.checked);
	} );
	
	var _v=''+value;
	var ckox = '<input onclick="$function(\''+funcName+'\',this,['+colIndex+'])" type=checkbox ' + (_v=="true"?'checked':'')  +">" ;
	return ckox ;
	
}


function setSelectBoxValue (value,entity,rowIndex,colIndex) {
//alert("xxx"+entity.setProperty)
	var funcName='mode_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		var idx=this.selectedIndex<0?0:this.selectedIndex;
		entity.setProperty('mode',''+this.options[ idx ].value);
		
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="parameter" selected>input</option>';//输入
	sbox+='<option value="result"'+(_v =="result"?'selected' : '') + '>output</option>';//输出
	sbox += '</select>';
 
	if(_v == "") {
		entity.setProperty('mode','parameter' );
	}
	else {
		entity.setProperty('mode',_v );
	}
	return sbox;
}

function setSelectBoxValue2 (value,entity,rowIndex,colIndex) { 
	var funcName='typeClass_'+rowIndex;
	//alert("refresh:"+entity.setProperty)

	
	$setFunction(funcName , function(cidx){
	
		entity.setProperty('dataType/typeClass',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="primitive" selected>basicType</option>';//基本类型
	sbox+='<option value="sdo"'+(_v =="sdo"?'selected' : '') + '>SDO</option>';
	sbox+='<option value="pojo"'+(_v =="pojo"?'selected' : '') + '>POJO</option>';
	sbox += '</select>';
	
	if(_v == "") {
		entity.setProperty('dataType/typeClass','primitive' );
	}
	else {
		entity.setProperty('dataType/typeClass',_v );
	}
	//alert("entity:"+entity);
	
	return sbox;
}

///触发事件数据表格相关方法
function setEventTypeValue (value,entity,rowIndex,colIndex) {
	var funcName='eventType_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('eventType',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="before-start-act" selected>before-start-act</option>';//活动启动前
	sbox+='<option value="after-start-act"'+(_v =="after-start-act"?'selected' : '') + '>after_start_act</option>';//活动启动后
	sbox+='<option value="before-finish-act"'+(_v =="before-finish-act"?'selected' : '') + '>before_finish_act</option>';//活动完成前
	sbox+='<option value="after-finish-act"'+(_v =="after-finish-act"?'selected' : '') + '>after_finish_act</option>';//活动完成后
	sbox+='<option value="after-resume-act"'+(_v =="after-resume-act"?'selected' : '') + '>after_resume_act</option>';//活动恢复后
	sbox+='<option value="after-suspend-act"'+(_v =="after-suspend-act"?'selected' : '') + '>after_suspend_act</option>';//活动挂起后
	sbox += '</select>';
	if(_v == "") {
		entity.setProperty('eventType','before-start-act' );
	}
	else {
		entity.setProperty('eventType',_v );
	}
	return sbox;
}

function setProcessEventTypeValue (value,entity,rowIndex,colIndex) {
	var funcName='eventType_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('eventType',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="before-start-proc" selected>before_start_proc</option>';//流程启动前
	sbox+='<option value="after-start-proc"'+(_v =="after-start-proc"?'selected' : '') + '>after_start_proc</option>';//流程启动后
	sbox+='<option value="before-finish-proc"'+(_v =="before-finish-proc"?'selected' : '') + '>before_finish_proc</option>';//流程完成前
	sbox+='<option value="after-finish-proc"'+(_v =="after-finish-proc"?'selected' : '') + '>after_finish_proc</option>';//流程完成后
	sbox+='<option value="after-resume-proc"'+(_v =="after-resume-proc"?'selected' : '') + '>after_resume_proc</option>';//流程恢复后
	sbox+='<option value="after-suspend-proc"'+(_v =="after-suspend-proc"?'selected' : '') + '>after_suspend_proc</option>';//流程挂起后
	sbox+='<option value="after-timeout-proc"'+(_v =="after-timeout-proc"?'selected' : '') + '>after_timeout_proc</option>';//流程超时后
	sbox+='<option value="after-remind-proc"'+(_v =="after-remind-proc"?'selected' : '') + '>after_remind_proc</option>';//流程提醒后
	sbox += '</select>';
	
	if(_v == "") {
		entity.setProperty('eventType','before-start-proc' );
	}
	else {
		entity.setProperty('eventType',_v );
	}

	return sbox;
}

//同步、异步填充值
function setInvokePatternValue(value,entity,rowIndex,colIndex){
	var funcName='invokePattern_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('applicationInfo/application/invokePattern',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="synchronous" selected>synchronous</option>';//同步
	sbox+='<option value="asynchronous"'+(_v =="asynchronous"?'selected' : '') + '>asynchronous</option>';//异步
	sbox += '</select>';
	if(_v == "") {
		entity.setProperty('applicationInfo/application/invokePattern','synchronous' );
	}
	else {
		entity.setProperty('applicationInfo/application/invokePattern',_v );
	}

	return sbox;
}

function setApplicationUriLink(value,entity,rowIndex,colIndex){
	var funcName='applicationUr_'+rowIndex;
	
	$setFunction(funcName , function(cidx){

		var jsonData = Entity2Json(entity);
		data = jsonData.applicationInfo.application
		 
		if(data == null) {
			data = {
				parameters : {
					parameter : [] 
				 }
			} ;
		} else if (data.parameters == null) {
			data.parameters={
				parameter : [] 
			}
		}
		
		strData = data.toJSONString();
		
		showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_config_info.jsp",strData,function (rvalue) {
			if(!rvalue) 
				return ;
			var objValue = eval('(' + rvalue + ')');
			//alert(rvalue);
			entity.setProperty('applicationInfo/application/actionType',objValue.actionType) ;
			entity.setProperty('applicationInfo/actionType',objValue.actionType) ;
			entity.setProperty('applicationInfo/application/applicationUri',objValue.applicationUri) ;
			entity.setProperty('applicationInfo/application/parameters/parameter',objValue.parameters.parameter) ;
		},520,350,eventAction);//事件动作
	} );
	
	if(value == undefined || value == 'undefined' || value == null || value == '' || value.toString().match("</applicationUri>") != null)
		 value = setEventAction;//设置事件动作
		
	var _v=''+value;
		
	var link = '<a href="#" onclick="javascript:$function(\''+funcName+'\',this,['+colIndex+']);return false;">' ;
	link+=value;
	link+='</a>' ;
	return link;
}

function setTransactionTypeValue(value,entity,rowIndex,colIndex){
	var funcName='transactionType_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('applicationInfo/application/transactionType',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="suspend" selected>Suspend</option>';
	sbox+='<option value="join"'+(_v =="join"?'selected' : '') + '>Join</option>';
	sbox += '</select>';
	if(_v == "") {
		entity.setProperty('applicationInfo/application/transactionType','join' );
	}
	else {
		entity.setProperty('applicationInfo/application/transactionType',_v );
	}
	return sbox;
}

function setExceptionStrategyValue(value,entity,rowIndex,colIndex){
	var funcName='exceptionStrategy_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('applicationInfo/application/exceptionStrategy',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="ignore" selected>ignore</option>';//忽略
	sbox+='<option value="rollback"'+(_v =="rollback"?'selected' : '') + '>rollback</option>';//回滚
	sbox += '</select>';
	if(_v == "") {
		entity.setProperty('applicationInfo/application/exceptionStrategy','ignore' );
	}
	else {
		entity.setProperty('applicationInfo/application/exceptionStrategy',_v );
	}
	return sbox;
}

//表单数据表格相关方法
function setFormDataTypeValue (value,entity,rowIndex,colIndex) {
	var funcName='dataType_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		
		var selectedIndex=this.selectedIndex;
		var selectedValue = this.options[this.selectedIndex].value ;
		//$id('formDataTypeSelect').options[0].selected=true;	
		//$id('formDataTypeSelect').options[selectedIndex].selected=true;
		if(selectedValue == "sltSelect" || selectedValue == "sltRadio") {
			
			var jsonData = Entity2Json(entity);
			//alert(jsonData.toJSONString());
			var argument = jsonData['fieldAttribute'] ;
			var	dataType = jsonData['dataType'];
			var dtCatchMgr = new FastDataCatchMgr() ;
			if(argument && jsonData['dataType'] != selectedValue)  {
				if(dtCatchMgr.get(dataType) == null) {
					dtCatchMgr.create(dataType,argument) ;
					argument = null ;
				}
			}
			
			if(dtCatchMgr.get(selectedValue) == null) {
				dtCatchMgr.create(selectedValue,argument) ;
			}
			showModalCenter(CONTEXT_PATH+"/workflow/wfmanager/definition/processdef_detail/edit_startActForm.jsp",dtCatchMgr.get(selectedValue),function (rvalue){
				if(!rvalue) {
					entity.setProperty('dataType',''+jsonData['dataType']);
					return ;
				}
				
				dtCatchMgr.set(selectedValue,rvalue)
				entity.setProperty('fieldAttribute',''+rvalue.toJSONString().replaceAll('\"',''));
				entity.setProperty('dataType',''+selectedValue);
				//alert(''+rvalue.toJSONString().replaceAll('\"',''));
				if(dtCatchMgr.get(jsonData['dataType']) == null) {
					dtCatchMgr.create(jsonData['dataType'],argument) ;
				}
			
			},280,300,setProperty);//设置属性
			return ;
		}
		entity.setProperty('dataType',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select id="formDataTypeSelect" onselect="$function(\''+funcName+'\',this,['+colIndex+'])"  onChange="$function(\''+funcName+'\',this,['+colIndex+'])"  style="width:98">' ;
	sbox+='<option value="textInput" selected>textInput</option>';//字符串
	sbox+='<option value="longTextInput"'+(_v =="longTextInput"?'selected' : '') + '>longTextInput</option>';//长字符串
	sbox+='<option value="numberInput"'+(_v =="numberInput"?'selected' : '') + '>numberInput</option>';//编号
	sbox+='<option value="checkbox"'+(_v =="checkbox"?'selected' : '') + '>boolean</option>';//布尔型
	sbox+='<option value="date"'+(_v =="date"?'selected' : '') + '>date</option>';//日期
	sbox+='<option value="email"'+(_v =="email"?'selected' : '') + '>email</option>';//电子邮件
	sbox+='<option value="user"'+(_v =="user"?'selected' : '') + '>user</option>';//用户
	sbox+='<option value="sltSelect"'+(_v =="sltSelect"?'selected' : '') + '>sltSelect</option>';//选项列表
	sbox+='<option value="sltRadio"'+(_v =="sltRadio"?'selected' : '') + '>sltRadio</option>';//单选钮列表
	sbox += '</select>';
	if(_v == "") {
		entity.setProperty('dataType','textInput' );
	}
	else {
		entity.setProperty('dataType',_v );
	}
	return sbox;
						
}

function setFormAccessTypeValue (value,entity,rowIndex,colIndex) {
	var funcName='accessType_'+rowIndex;
	$setFunction(funcName , function(cidx){
		entity.setProperty('accessType',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="read-write" selected>read_write</option>';//读写
	sbox+='<option value="read"'+(_v =="read"?'selected' : '') + '>read</option>';//只读
	sbox += '</select>';
	
	if(_v == "") {
		entity.setProperty('accessType','read-write' );
	}
	else {
		entity.setProperty('accessType',_v );
	}
	return sbox;
}

function setFormRequiredValue (value,entity,rowIndex,colIndex) {

	var funcName='required_'+rowIndex;
	
	$setFunction(funcName , function(cidx){
		entity.setProperty('required',''+this.checked);
	} );
	
	var _v=''+value;
	var ckox = '<input onclick="$function(\''+funcName+'\',this,['+colIndex+'])" type=checkbox ' + (_v=="true"?'checked':'')  +">" ;
	return ckox ;

}

function setValueType (value,entity,rowIndex,colIndex) {
	var funcName='valueType_'+rowIndex;

	$setFunction(funcName , function(cidx){
		//alert(this.options[this.selectedIndex].value) ;
		entity.setProperty('valueType',''+this.options[this.selectedIndex].value);
	} );
	
	var _v=''+value;
	var sbox = '<select onchange="$function(\''+funcName+'\',this,['+colIndex+'])" style="width:98">' ;
	sbox+='<option value="variable" selected>variable</option>';//变量
	sbox+='<option value="constant"'+(_v =="constant"?'selected' : '') + '>constant</option>';//常量
	sbox += '</select>';
	if(_v == "") {
		entity.setProperty('valueType','variable' );
	}
	else {
		entity.setProperty('valueType',_v );
	}
	return sbox;
}

String.prototype.replaceAll = stringReplaceAll; 
function  stringReplaceAll(AFindText,ARepText){
  raRegExp = new RegExp(AFindText,"g");
  return this.replace(raRegExp,ARepText);
}


function html_entity_decode(s) {

		var span = document.createElement('SPAN');
		
		//Firefox不支持InnerText需要用textContent代替
		if(window.isFF){
			span.innerHTML = s;
			return span.textContent;
		}
		else{
			var aaa = new String (s);
			aaa = aaa.replaceAll("\r","<br>");
			span.innerHTML = aaa.replaceAll("&#13;","<br>");
			return span.innerText;
		}

}

//Firefox不支持InnerText需要用textContent代替
function ie_innerText_hack(span,value) {
	if(document.all){
		return span.innerText = value;
	}else{
		return span.textContent = value;
	}
}




