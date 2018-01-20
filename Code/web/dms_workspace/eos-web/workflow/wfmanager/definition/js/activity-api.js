/*
	activity-api.js 
	2007-11-16
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

if(isIE) {
	labelFor = "htmlFor" ;
} else if (isMoz) {
	labelFor = "for" ;
}

var xmlHttp=false;

var elementType=
{
 ET_TEXT:1 ,
 ET_CHECK:2 ,
 ET_RADIO:3 ,
 ET_SELECT_ONE:4 ,
 ET_SELECT_MUL:5,
 ET_SPAN:6,
 ET_HREF:7 ,
 ET_BUTTON:8
}

var ExtraAttribute=
{
 MANIPU_FIELDS:"_manipulateFields",
 MANIPU_MODEL:"_model",
 MANIPU_MODEL_HID:"sh",     //show hidden
 MANIPU_MODEL_DIS:"dis"     //disable
};

//render manual activity
function renderManualActivity (activity) {
	
	fillActivityFieldsValues(activity);
	
	//button action creator
	var divs = document.getElementsByTagName("div");
	function buttonActionCreator(element,div,paraActivity) {
		return function() {
			exAction = getExtraAttribute(div,"action");
			return eval(exAction+"(activity)");
		}
	}
	for (var i = 0; i < divs.length; i++) {
		var div = divs[i];
		if (div.className == "editButton") {
			var button = div.getElementsByTagName("input")[0];
			if(getElementType(button) == elementType.ET_BUTTON) {
				button.onclick = buttonActionCreator(button,div);
			}
		}
	}
	//init organization data
	//FIXME:document.getElementById  --> $id
	orgDiv = document.getElementById("organization") ;
	var ul = orgDiv.appendChild(document.createElement('ul'));
	
	dataQuerys(activity,"organization");
	//alert(res[0].toJSONString());
	orgs = res[0] ;
	participants = orgs.participant;
	if (participants != "undefined") {
		if(participants instanceof Array) {
			for(var i=0;i<participants.length;++i) {
				 part = participants [i] ;
				 li = ul.appendChild(document.createElement('li')) ;
				 var orgElement = li.appendChild(document.createElement("div"))
				 	.appendChild(document.createElement("a"));
				 orgElement.href="#";
				 orgElement.innerHTML=part.id+"&nbsp;&nbsp;"+part.name+"&nbsp;&nbsp;"+part.type;
				 orgElement.style.color="#00CC00";
				 (function(part){orgElement.onclick =function() {
					//alert(part.id);
				  }})(part);
			}
		} else {
			//....
		}
	} 
	
	document.getElementById('activityApply').onclick=function(){
		alert(activity.toJSONString());	
	}
	document.getElementById('activityOK').onclick=function(){
		alert(activity.toJSONString());	
		top.close();
	}
}

//Fill activity fields values
function fillActivityFieldsValues (activity) {
	if(!document.getElementsByTagName) return false ;
	var labels = document.getElementsByTagName("label") ;
	for (var i=0; i<labels.length;i++) {
		if (!labels[i].getAttribute(labelFor)) continue ;
		var id = labels[i].getAttribute(labelFor) ;
		var element = null ;
		element = getElementViaId(id) ;
		if (!element)
			continue ;
		setElementValue(element,getJsonValueViaId(activity,element.name));
		initExtraAttributeAndEvent(element,activity);
		//register elementObj edit event
		var eleType =element.type ;
		var extraAttribute = getExtraAttribute(element,ExtraAttribute.MANIPU_FIELDS) ;
		if((eleType == "text" || eleType=="textarea") && !extraAttribute) {
				(function(element){element.onblur =function() {
					setJsonValueViaId(activity,element.name,element.value);
				  }})(element);
			} else if(eleType == "checkbox" && !extraAttribute){
						(function(element){element.onclick =function() {
							checkBoxEdit(element,activity);
						  }})(element); 
					} else if(eleType =="select-one" && !extraAttribute){
						(function(element){element.onchange =function() {
								setJsonValueViaId(activity,element.name,element.options[element.selectedIndex].value);
						  }})(element);
					} else if (eleType=="radio"&& !extraAttribute) {
						(function(element){element.onclick =function() {
							radiosEdit(element,activity);
						  }})(element); 
					}
	}
}

function radiosEdit(radioObj,activity) {
	
	if(!radioObj)
		return;
	radioObj = document.forms[0].elements[radioObj.name] ;
	var radioLength = radioObj.length;
	if(radioLength == undefined) {
		isChecked=radioObj.checked;
		if(isChecked) {
			if(isFloat(getJsonValueViaId(activity,radioObj.name))) {
				fvalue = checkboxObj.value ;//should to convert to number 
				if (!isNaN(fvalue*1)) 
				 	fvalue = fvalue*1;
					setJsonValueViaId(activity,radioObj.name,fvalue);
				} else {
					setJsonValueViaId(activity,radioObj.name,radioObj.value);
				}		
		}
		return;
	}
	for(var i = 0; i < radioLength; ++i) {
		isChecked = radioObj[i].checked;
 		if(isChecked) {
 			if(isNaN(getJsonValueViaId(activity,radioObj[i].name)*1)) {
				fvalue = radioObj[i].value ;//should to convert to number 
				if (!isNaN(fvalue*1)) 
				 	fvalue = fvalue*1;
					setJsonValueViaId(activity,radioObj[i].name,fvalue);
				} else {
					setJsonValueViaId(activity,radioObj[i].name,radioObj[i].value);
				}
 		} else {
 			if(radioObj[i].value.isBooleanValue()){
				setJsonValueViaId(activity,radioObj[i].name,"false");
			} else if(!radioObj[i].value.isBooleanValue()){
				setJsonValueViaId(activity,radioObj[i].name,"");
			} else if(isFloat(getJsonValueViaId(activity,radioObj[i].name))) {//number
				setJsonValueViaId(activity,radioObj[i].name,0);
			}
 		}
	}
}

function checkBoxEdit(checkboxObj,activity) {
	
	if(checkboxObj.checked ) {
		if(isNaN(getJsonValueViaId(activity,checkboxObj.name)*1)) {
			fvalue = checkboxObj.value ;//should to convert to number 
			if (!isNaN(fvalue*1)) 
			 	fvalue = fvalue*1;
			setJsonValueViaId(activity,checkboxObj.name,fvalue);
		} else {
			setJsonValueViaId(activity,checkboxObj.name,checkboxObj.value);
		}
	} else if(!checkboxObj.checked ) {
		if(checkboxObj.value.isBooleanValue()){
			setJsonValueViaId(activity,checkboxObj.name,"false");
		} else if(!checkboxObj.value.isBooleanValue()){
			setJsonValueViaId(activity,checkboxObj.name,"");
		} else if(isFloat(getJsonValueViaId(activity,checkboxObj.name))) {//number
			setJsonValueViaId(activity,checkboxObj.name,0);
		}
	}  
}

//ΪelementԪ������ֵ,��ݲ�ͬ�����ͣ���ֵ��ʽ��ͬ
function setElementValue (element,value) {
	//var type = getElementType(element) ;
	var type = element.type ;
	if(type == "text" || type == "textarea") {
		element.value = value;
	} else if (type == "checkbox") {
		setCheckboxEleValue(element,value);
	} else if (type == "radio") {
		setRadioEleValue(element,value);
	} else if (type == "select-one") {
		setSelectOneEleValue (element,value);
	}
	setCheckboxEleValue = function (checkboxObj,value) {
		if(!checkboxObj) return ;
		checkboxObj.checked = value.toBoolean() || checkboxObj.value == value ;
	}
	setRadioEleValue=function(radioObj,newValue) {
		if(!radioObj)
			return;
		var radioLength = radioObj.length;
		if(radioLength == undefined) {
			radioObj.checked = (radioObj.value == newValue.toString());
			return;
		}
		for(var i = 0; i < radioLength; i++) {
			radioObj[i].checked = false;
			if(radioObj[i].value == newValue.toString()) {
				radioObj[i].checked = true;
			}
		}
	}
	setSelectOneEleValue=function(selectOneObj,value) {
		if(!selectOneObj) return ;
		legth = selectOneObj.options.length ;
		for (var i = 0;i<legth;i++) {
			if (selectOneObj.options[i].value == value) {
				selectOneObj.options[i].selected = true ;
				showHideDivInfoWithSelect(selectOneObj.name,selectOneObj.options[selectOneObj.selectedIndex].value ,true); 
				break ;
			}
		}
	}
	/*
	setSelectMulEleValue=function (element,value) {
		if(!element) return ;
		if (value instanceof Array) {
			for(var i=0;i<value.length;i++) {
				setSelectOneEleValue(element,value[i]);
			}
		} else {
			setSelectOneEleValue(element,value);
		}
	}*/
}

/*
*��ʼ���?�ֶ�)չ���Լ������¼�
*��Ϊָ�����¼��󶨷���������ض���hidden��disable����ֶ�
*���_model����Ϊhidden��������ָ����div�����ֵ4��_manipulateFields)չ���ԣ��ұ�����һ��div����
*���_model����disable����disable��ָ�����ֶλ�4��div�е������ֶ�
*_modelĬ��Ϊdisable�������Ҫ��_manipulateFields��_event���Ǳ����
*/
function initExtraAttributeAndEvent (element,activity) {                     
	var fdivs = getExtraAttribute (element,ExtraAttribute.MANIPU_FIELDS);
	if (fdivs == null)     //ֻ�е�ָ����_manipulateFields����ʱ����)չ���Բ���Ч
		return ;
	var model = getExtraAttribute(element,ExtraAttribute.MANIPU_MODEL);
	model = model == null?"dis":model;    //Ĭ��Ϊdisable״̬
	
	function checkboxActionCreator() {
		return function () {
			if(model == ExtraAttribute.MANIPU_MODEL_HID) { //show hidden
				showHideDivInfo(fdivs,element.checked);
			} else if(model ==ExtraAttribute.MANIPU_MODEL_DIS) { //disable
				disableDivFields(fdivs,!element.checked);
			}
			var symode ; 
			if(element.checked)
			  symode="inject";
			else symode="clear";
			checkBoxEdit(element,activity);
			synchDivFieldsValue(fdivs,symode,activity) ;
		}
	}
	function radioActionCreator(){
		return function() {
			return showHideDivInfoWithRadio(element,false,activity);	
		}
	}
	function selectOneActionCreator(){
		return function () {
			setJsonValueViaId(activity,element.name,element.options[element.selectedIndex].value);
			var pass = element.options[element.selectedIndex].value ;
			showHideDivInfoWithSelect(element.name,pass,false,activity);
		}
	}
	
	var type = getElementType(element);
	if(type == 2) {          //checkbox
		 element.onclick=checkboxActionCreator();
		 if(model == ExtraAttribute.MANIPU_MODEL_HID) { //show hidden
			showHideDivInfo(fdivs,element.checked);
		 } else if(model ==ExtraAttribute.MANIPU_MODEL_DIS) { //disable
			disableDivFields(fdivs,!element.checked);
		 }
	} else if(type == 3) {   //radio
		 element.onclick=radioActionCreator();
		 showHideDivInfoWithRadio(element,true);	
	} else if(type == 4) {   //select-one
		 element.onchange=selectOneActionCreator();
	} else {
		alert("unsupport this element type yet");
	}

}

function showHideDivInfo(fdivs,showOrHid){
	if(!fdivs)
		return;
	var divs = fdivs.split(",");
	for (var i=0;i<divs.length;i++) {
		div = divs[i];
		//FIXME:document.getElementById  --> $id
		fieldsDiv = document.getElementById(div);
		if (fieldsDiv == null) return ;
		if (showOrHid) {
			showdiv(fieldsDiv);
		} else {
			hidediv(fieldsDiv);
		}
	}
}

function disableDivFields (fdivs,disabled) {
	if(!fdivs)
		return;
	var divs = fdivs.split(",");
	for (var i=0;i<divs.length;i++) {
		div = divs[i];
		//FIXME:document.getElementById  --> $id
		fieldsDiv = document.getElementById(div);
		if (fieldsDiv == null) return ;
		var labels = fieldsDiv.getElementsByTagName("label") ;
		for (var j=0; j<labels.length;j++) {
			if (!labels[j].getAttribute(labelFor)) continue ;
			var id = labels[j].getAttribute(labelFor) ;
			var element = null ;
			
			element = getElementViaId(id) ;
			if (!element)
				continue ;
			//alert(element.name+" dis "+disabled);
			element.disabled = disabled ;
		}
	}
}

function synchDivFieldsValue(fdivs,mode,activity){
	if(!fdivs)
		return;
	divs = fdivs.split(",");
	for(var i=0;i<divs.length;++i) {
		div = divs[i] ;
		//FIXME:document.getElementById  --> $id
		var fieldsDiv = document.getElementById(div);
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
			setJsonValueViaId(activity,element.name,elValue);
		}
	}
}

function showHideDivInfoWithRadio(radioObj,isInit,activity) {
	var symode ;
	if(!radioObj)
		return;
	radioObj = document.forms[0].elements[radioObj.name] ;
	var radioLength = radioObj.length;

	if(radioLength == undefined) {
		var fdivs = getExtraAttribute(radioObj,ExtraAttribute.MANIPU_FIELDS);
		if(!fdivs) return ;
		var model = getExtraAttribute(radioObj,ExtraAttribute.MANIPU_MODEL)==null?"dis":getExtraAttribute(radioObj,ExtraAttribute.MANIPU_MODEL);
		symode=radioObj.checked?"inject":"clear";
		if(model == ExtraAttribute.MANIPU_MODEL_HID) { //show hidden
			showHideDivInfo(fdivs,radioObj.checked);
		} else if(model == ExtraAttribute.MANIPU_MODEL_DIS) { //disable
			disableDivFields(fdivs,radioObj.checked);
		}
		if(!isInit)  synchDivFieldsValue(fdivs,symode,activity) ;
		return;
	}
	for(var i = 0; i < radioLength; ++i) {
		isChecked = radioObj[i].checked;
		var fdivs = getExtraAttribute(radioObj[i],ExtraAttribute.MANIPU_FIELDS);
		if(!fdivs) continue ;
		var model = getExtraAttribute(radioObj[i],ExtraAttribute.MANIPU_MODEL)==null?"dis":getExtraAttribute(radioObj[i],ExtraAttribute.MANIPU_MODEL);
		symode=radioObj[i].checked?"inject":"clear";
		if(model == ExtraAttribute.MANIPU_MODEL_HID) { //show hidden
			showHideDivInfo(fdivs,radioObj[i].checked);
		} else if(model == ExtraAttribute.MANIPU_MODEL_DIS) { //disable
			disableDivFields(fdivs,!radioObj[i].checked);
		}
		if(!isInit) synchDivFieldsValue(fdivs,symode,activity) ;
	}
}

function showHideDivInfoWithSelect (list,pass,isInit,activity) 
{
	var browserType;
	if (document.layers) {browserType = "nn4"}
	if (document.all) {browserType = "ie"}
	if (window.navigator.userAgent.toLowerCase().match("gecko")) {
	   browserType= "gecko"
	}
	
	//FIXME:
	//var List = document.all(list);  --> $o
	var List = document.all(list);

	var ListLen;
	ListLen = List.options.length;
	
	var poppedLayer ;
	
	if (browserType == "nn4") {
		poppedLayer = document.layers[pass];
	} else {	
		//FIXME: document.getElementById  --> $id
		poppedLayer = document.getElementById(pass);
	}
	if(poppedLayer != null) {
		showHideDivInfo(pass,true);
		if(!isInit) synchDivFieldsValue(pass,"inject",activity) ;
	}
	
	for(i = 0; i < ListLen; i++)
	{
		//FIXME:()  --> []
		if( List.options[i].value != pass)
		{
			if (browserType == "nn4") {				
				poppedLayer = document.layers[List.options[i].value];
			} else {				
				poppedLayer = document.getElementById(List.options[i].value);
			}
			if(poppedLayer != null) {
				showHideDivInfo(List.options[i].value,false);
				if(!isInit)synchDivFieldsValue(List.options[i].value,"clear",activity) ;
			}
		}
	}
}

function getExtraAttribute (el,att) {
	if (!el.getAttribute) return null ;
	nvalue  = el.getAttribute(att);
	return  nvalue;
}

//����element������
function getElementType (element) {
	var type =  element.type ;
	if (type == "text")  {
		return elementType.ET_TEXT ;
	} else  if (type == "checkbox")  {
		return elementType.ET_CHECK;
	} else  if (type == "radio") {
		return elementType.ET_RADIO;
	} else  if (type == "select-one") {
		return elementType.ET_SELECT_ONE;
	} else  if (type == "select-multiple")  {
		return elementType.ET_SELECT_MUL;
	} else if (type=="button") {
		return elementType.ET_BUTTON;
	}
}

/*
���ַ�ת��Ϊboolanֵ
����ӵĹ���:����쳣���?���ַ���һ��"true"��"false"
ʱ�׳��쳣
*/
String.prototype.toBoolean=function(){
	if(this == null)
		return null ;
	if(this == "true")
		return true ;
	else if(this == "false") 
		return false ;
	else 
		return this;
}

String.prototype.isBooleanValue=function(){
	if(this == "true" ||this =="false")
		return true;
	return false ;
}

//
var setApplication=function (activity) {
	alert(activity.activityName);
}

var setActivityExecutor=function(activity) {
	alert(activity.activityId);
}

function getJsonValueViaId (jsonObj,ids) {
	if(jsonObj == null) return null ;
	if(typeof(jsonObj) != "object") return null ;
	if(ids==null||ids == "") return null ;
	
	if (ids.indexOf(".") < 0) {
		value = jsonObj[ids];
		try {
			value.toString() ;
		} catch (err) {
			return "" ;
		}
		return value;
	}
	
	var pos = ids.indexOf(".");
	id = ids.substring(0,pos) ;
	var subObj = jsonObj[id] ;
	
	if (subObj != null) {
		return getJsonValueViaId(subObj,ids.substring(pos+1,ids.length));
	}
}

function setJsonValueViaId(jsonObj,ids,value) {
	if(jsonObj == null) return false ;
	if(typeof(jsonObj) != "object") return false ;
	if(ids==null||ids == "") return false ;
	
	if (ids.indexOf(".") < 0) {
		if (jsonObj[ids] == "undefined"){
			//&& typeof(jsonObj[ids]) == "object") {
			return false;
		}
		jsonObj[ids] = value;
		return true ;
	}
	
	var pos = ids.indexOf(".");
	id = ids.substring(0,pos) ;
	var subObj = jsonObj[id] ;
	
	if (subObj != null) {
		return setJsonValueViaId(subObj,ids.substring(pos+1,ids.length),value);
	}
}

var res=[];
function dataQuerys (data,node) {
	for(var field in data) {
		if (typeof(data[field]) == "object"
			&& typeof(data[field] != "undefined")
			&& data[field].toJSONString() != "{}"
			&& field != node) {
			value = dataQuerys(data[field],node);
		} else if( field == node ) {
			res.push(data[field]);
		}
	}
}

function getElementViaId (id) {
	var element ;
	if (id.indexOf(".") > 1) {
		if (!document.all(id)) return false ;
		element = document.all(id);
	}else {
		if (!document.getElementById(id)) return false ;
		//FIXME:document.getElementById  --> $id
		element = document.getElementById(id);
	}
	return element ; 
}