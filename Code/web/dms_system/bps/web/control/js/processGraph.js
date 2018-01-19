nui.bps = nui.bps || {};
nui.bps.ProcessGraph = function () {
	nui.bps.ProcessGraph.superclass.constructor.call(this)
}

nui.extend(nui.bps.ProcessGraph, nui.Control, {
	uiCls: 'nui-bps-processgraph',
	procInstID:"",
	procDefID:"",
	showParticipants:"false",
	partiName:"参与者",
	startTime:"开始时间",
	endTime:"结束时间",
	timeOut:"超时",
	activityState:"活动状态",
	activityType: "活动类型",
	Y:"是",
	N:"否",
	procDefName:"",
	timeOutFlag:"流程已经超时！",
	fontSize:"9",
	zoomQuotiety:"1",
	arrowAngle:"40",
	arrowLength:"10",
	width:"100%",
	height:"100%",
	showZoomCombo:"true",
	zoomOptions:[{text:"40%",value:0.4},
				  {text:"55%",value:0.55},
				  {text:"70%",value:0.7},
				  {text:"85%",value:0.85},
				  {text:"100%",value:1},
				  {text:"150%",value:1.5},
				  {text:"200%",value:2}
				],
	load: function () {
		var _this = this;
		nui.ajax({
            url: bootPATH + "../../rest/services/bps/webcontrol/getProcessGraph",
            type: "POST",
            data: { procInstID:_this.procInstID,
            		procDefID:_this.procDefID,
            		procDefName:_this.procDefName
		        },
            success: function (data) {
            	var html = _this._draw(data.result, _this, data.result.imgPath);
            	var innerHTML = '<div style="position:relative;width:' + _this.width + ';height:' +  _this.height+ ';overflow:auto">' ;
            	if(_this.showZoomCombo == "true"){
            		innerHTML += '<select onchange="__cg('+'this,'+_this.id+')"  style="margin-top:10px;z-index:100;position:absolute;width:60px;right:20px">';
                	var zoomOptions = _this.zoomOptions;
                	for (var i = 0, l = zoomOptions.length; i < l; i++) {
                		var optStr = '<option ' + (zoomOptions[i].value==_this.zoomQuotiety?'selected="selected"':'') +' value="' 
                					+ zoomOptions[i].value +'">' 
                					+ zoomOptions[i].text + '</option>'
                		innerHTML += optStr;			
                	};
    				innerHTML += '</select>'
            	}
				innerHTML += '<div style="position:relative;width:'+ _this.width +';height:'+ _this.height +';overflow:auto">'
				innerHTML += 		html  
				innerHTML += '</div>' ;
				_this.el.style.height=_this.height;
				_this.el.style.width=_this.width;
				_this.el.innerHTML = innerHTML;
            },
            error: function () {
            }
        });
	},
	_draw:function (data, context, imgPath) {
		var result = "";
		var imgTemplate = '<IMG id="{id}"' +
						  ' SRC="{imgPath}/{pic}.gif"' +
						  ' style="position:absolute;border:0;left:{left}px;top:{top}px;width:{width}px;height:{height}px; cursor:pointer"' +
						  ' activityDefID="{activityDefID}"'+
						  ' processDefId="{processDefId}"'+
						  ' {extendAttribute}' +
						  ' onmousemove="showParticipantList(\'{sid}\')"' +
						  ' onmouseout="hideParticipantList(\'{hid}\')"' +
						  ' />';
		var participantsListTemplate = '<div id="{id}" style="display:none;position:absolute;left:{left};top:{top};background-color:white;z-index:1000">' + 
									   '{content}' +
									   '</div>';

		imgTemplate = imgTemplate.replace('{imgPath}', imgPath);			  
		var states = data.states;
    	var activities = data.activities;
    	var transaction = data.transaction;
    	var participants = data.participants;
    	/*
    	var isTimeOut = data.isTimeOut;
    	if(isTimeOut == "Y"){
    		result += drawTimeOutFlag(context.timeOutFlag);
    	}
    	*/
    	result += drawStates(states, participants, context,imgTemplate,participantsListTemplate);
    	result += drawLines(states, transaction, context);
    	return result;
	},
	_create: function () {
		nui.bps.ProcessGraph.superclass._create.call(this);
	},

	render: function(p) {
		nui.bps.ProcessGraph.superclass.constructor.call(this, p);
	},
	getAttrs: function (el) {
        var attrs = nui.bps.ProcessGraph.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);
        nui._ParseString(el, attrs,
            ["Y","N","timeOut","timeOutFlag","endTime","startTime","partiName","showParticipants","procInstID","procDefID","procDefName", "showZoomCombo","height", "width", "fontSize", "arrowAngle", "arrowLength", "zoomQuotiety", "zoomOptions"]
        );
        return attrs;
    },
    setProcInstID: function (procInstID) {
	    this.procInstID = procInstID;     
	},
	getProcInstID: function () {
	    return this.procInstID;     
	},
	setPartiName: function (partiName) {
	    this.partiName = partiName;     
	},
	getPartiName: function () {
	    return this.partiName;     
	},
	setStartTime: function (startTime) {
	    this.startTime = startTime;     
	},
	getStartTime: function () {
	    return this.startTime;     
	},
	setEndTime: function (endTime) {
	    this.endTime = endTime;     
	},
	getEndTime: function () {
	    return this.endTime;     
	},
	setProcDefID: function (procDefID) {
	    this.procDefID = procDefID;     
	},
	getProcDefID: function () {
	    return this.procDefID;     
	},
	setProcDefName: function (procDefName) {
	    this.procDefName = procDefName;     
	},
	getProcDefName: function () {
	    return this.procDefName;     
	},
	setFontSize: function (fontSize) {
	    this.fontSize = fontSize;     
	},
	getFontSize: function () {
	    return this.fontSize;     
	},
	setTimeOut: function (timeOut) {
	    this.timeOut = timeOut;     
	},
	getTimeOut: function () {
	    return this.timeOut;     
	},
	setShowParticipants: function (showParticipants) {
	    this.showParticipants = showParticipants;     
	},
	getShowParticipants: function () {
	    return this.showParticipants;     
	},
	setZoomQuotiety: function (zoomQuotiety) {
	    this.zoomQuotiety = zoomQuotiety;     
	},
	getZoomQuotiety: function () {
	    return this.zoomQuotiety;     
	},
	setY: function (Y) {
	    this.Y = Y;     
	},
	getY: function () {
	    return this.Y;     
	},
	setN: function (N) {
	    this.N = N;     
	},
	getN: function () {
	    return this.N;     
	},
	setArrowAngle: function (arrowAngle) {
	    this.arrowAngle = arrowAngle;     
	},
	getArrowAngle: function () {
	    return this.arrowAngle;     
	},
	setTimeOutFlag: function (timeOutFlag) {
	    this.timeOutFlag = timeOutFlag;     
	},
	getTimeOutFlag: function () {
	    return this.timeOutFlag;     
	},
	setArrowLength: function (arrowLength) {
	    this.arrowLength = arrowLength;     
	},
	getArrowLength: function () {
	    return this.arrowLength;     
	},
	setZoomOptions: function (zoomOptions) {
	    this.zoomOptions = nui.decode(zoomOptions);     
	},
	getZoomOptions: function () {
	    return nui.decode(this.zoomOptions);     
	},
	setWidth: function (width) {
		if(isNaN(width)){
	    	this.width = width;
		}else{
			this.width = width + "px"
		}
	},
	getWidth: function () {
	    return this.width;     
	},
	setHeight: function (height) {
		if(isNaN(height)){
	    	this.height = height;     
		}else{
			this.height = height + "px";
		}
	},
	getHeight: function () {
	    return this.height;     
	},
	setShowZoomCombo: function (showZoomCombo) {
	    	this.showZoomCombo = showZoomCombo;     
	},
	getShowZoomCombo: function () {
	    return this.showZoomCombo;     
	}
});
nui.regClass(nui.bps.ProcessGraph, 'bps-processgraph');


function __cg(_this,id,value){
	var graph = nui.get(id);
	graph.setZoomQuotiety(_this.value);
	graph.load();
}

function showParticipantList(id){
	var element = document.getElementById(id);
	if (element)
		element.style.display = "block";
}

function hideParticipantList(id){
	var element = document.getElementById(id);
	if (element)
		element.style.display = "none";
}
/*
function drawTimeOutFlag(lang){
	return "<span style='position:fixed;color:red'>" + lang + "</span>";
}
*/

function drawStates (states,participants,context,imgTemplate,participantsListTemplate) {
	var res = "";
	for (prop in states) {
		var stat = states[prop];
		var tmpTemplate = imgTemplate;
		if("manual"==stat.type && stat.height!=45 && stat.width!=64 && !stat.isStart){
			stat.height=45;
			stat.width=64;
		}
		tmpTemplate = tmpTemplate.replace('{id}',stat.id);
		tmpTemplate = tmpTemplate.replace('{sid}',"parti_" + stat.id);
		tmpTemplate = tmpTemplate.replace('{hid}',"parti_" + stat.id);
		if (stat.type == "manual" && stat.isStart) {
			tmpTemplate = tmpTemplate.replace('{pic}',"manualstart_" + stat.currentState);
		} else {
			tmpTemplate = tmpTemplate.replace('{pic}',stat.type + "_" + stat.currentState);
		}
		tmpTemplate = tmpTemplate.replace('{activityDefID}','activityDefID');
		tmpTemplate = tmpTemplate.replace('{top}',stat.y*context.zoomQuotiety);
		tmpTemplate = tmpTemplate.replace('{left}',stat.x*context.zoomQuotiety);
		tmpTemplate = tmpTemplate.replace('{height}',stat.height*context.zoomQuotiety);
		tmpTemplate = tmpTemplate.replace('{width}',stat.width*context.zoomQuotiety);
		tmpTemplate = tmpTemplate.replace('{processDefId}',61);
		var extendAttribute = stat.extendAttribute;
		var extendStr = '';
		for (prop in extendAttribute) {
			extendStr += (prop + '="' + extendAttribute[prop]+'" ');
		};
		tmpTemplate = tmpTemplate.replace('{extendAttribute}',extendStr);
		res += tmpTemplate;
		var tmpParticipantsListTemplate = participantsListTemplate;
		tmpParticipantsListTemplate = tmpParticipantsListTemplate.replace("{id}","parti_" + stat.id);
		tmpParticipantsListTemplate = tmpParticipantsListTemplate.replace("{left}",stat.x*context.zoomQuotiety + stat.width*context.zoomQuotiety + "px");
		tmpParticipantsListTemplate = tmpParticipantsListTemplate.replace("{top}",stat.y*context.zoomQuotiety + stat.height*context.zoomQuotiety + "px");
		
		//活动状态每个图元都需要添加；参与者只有存在时才需要展示
		var activityInfos = [];
		activityInfos.push("<table id='activity_info' style='white-space:nowrap;text-align:center;border-collapse:collapse;width:100%;' cellspacing='0px' border='1px'>");
		//活动类型
		activityInfos.push("<tr>");
		activityInfos.push("<td>");
		activityInfos.push(context.activityType);
		activityInfos.push("</td>");
		activityInfos.push("<td>");
		activityInfos.push(mapActivityType(stat.type, stat.isStart));
		activityInfos.push("</td>");
		activityInfos.push("</tr>");
		//活动状态
		activityInfos.push("<tr>");
		activityInfos.push("<td>");
		activityInfos.push(context.activityState);
		activityInfos.push("</td>");
		activityInfos.push("<td>");
		activityInfos.push(mapActivityState(stat.currentState));
		activityInfos.push("</td>");
		activityInfos.push("</tr>");
		
		activityInfos.push("</table>");
		
		var content = "<table style='white-space:nowrap;text-align:center;border-collapse:collapse;' cellspacing='0px' border='1px'>";
		content += "<tr><td>" + context.partiName + "</td><td>" + 
					context.startTime + "</td><td>" + context.endTime + "</td><td>" + context.timeOut + "</td></tr>";
     	if(context.showParticipants == "true" && participants){
     		var partis =  participants[stat.id];
     		var Y = context.Y;
     		var N = context.N;
     		if(partis && partis.length > 0){
				for (var i = partis.length - 1; i >= 0; i--) {
					partis[i].startTime = partis[i].startTime || "-";
					partis[i].endTime = partis[i].endTime || "-";
					content += "<tr><td style='padding-left:5px;padding-right:5px'>" + partis[i].participant + "</td><td style='padding-left:5px;padding-right:5px'>" + partis[i].startTime + "</td><td style='padding-left:5px;padding-right:5px'>" + partis[i].endTime + "</td><td style='padding-left:5px;padding-right:5px'>" + (partis[i].isTimeOut=="Y"?Y:N) + "</td></tr>";
				};
				content += "</table>"
					
				//增加活动状态的table
				content = activityInfos.join("")+content;    			
			}else{
				//增加活动状态的table
				content = activityInfos.join("")
			}
			tmpParticipantsListTemplate = tmpParticipantsListTemplate.replace("{content}",content);
    		res += tmpParticipantsListTemplate;
		}
		
		if(stat.name){
			var mid = { x : (stat.x + stat.width / 2) * context.zoomQuotiety,
						y : (stat.y + stat.height) * context.zoomQuotiety };
			var width = stat.name.length * context.zoomQuotiety * 2 * 10;
			var height = context.fontSize * context.zoomQuotiety * 2;
			var top = mid.y + 1  * context.zoomQuotiety;
			var left = (mid.x - width / 2) ;

			res += drawText(stat.name, context.fontSize * context.zoomQuotiety, left, top, width, height )
		}
		
	};
	return res;
};

function drawLines (states,transactions,context) {
	var result = "";
	var oColor = color;
	for (var i = 0, l = transactions.length; i < l; i++) {
		var transaction = transactions[i];
		var from = states[transaction.from];
		var to = states[transaction.to];
    	var start = {};
		var end = {};
		start.x = (from.x + from.width / 2);
		start.y = (from.y + from.height / 2);
		end.x = (to.x + to.width / 2);
		end.y = (to.y + to.height / 2);
		if (from.currentState =="1" || to.currentState =="1") {
			color="#BCBCBC"
		}else{
			color="#228B22";
		}
		var extAttrNum = 0;
		for(var prop in transaction.extendAttribute){
			if(prop!="extend-nodes")
				extAttrNum += 1;
		}
		extAttrNum = extAttrNum / 4;
		var mid = {};
		if(extAttrNum !=0 ){
			var points = [];
			for(var j = 0 ; j < extAttrNum; j++){
				points[j] = {};
				points[j].x = parseInt(start.x) + parseInt(transaction.extendAttribute[(j + 1) + "w1"]);
				points[j].y = parseInt(start.y) + parseInt(transaction.extendAttribute[(j + 1) + "h1"]);
				points[j].x = points[j].x * context.zoomQuotiety;
				points[j].y = points[j].y * context.zoomQuotiety;
			}
			if (extAttrNum%2!=0) {
				mid.x = points[Math.floor(extAttrNum/2)].x;
    			mid.y = points[Math.floor(extAttrNum/2)].y;
			}else{
				mid.x = (points[extAttrNum/2-1].x + points[extAttrNum/2].x)/2;
    			mid.y = (points[extAttrNum/2-1].y + points[extAttrNum/2].y)/2;
			}
			start = decreaseBegin(start,points[0],from);
        	end = decrease(points[points.length - 1], end, to); 
        	start.x = start.x * context.zoomQuotiety;
        	start.y = start.y * context.zoomQuotiety;
        	end.x = end.x * context.zoomQuotiety;
        	end.y = end.y * context.zoomQuotiety;
			
			result += Line(start.x, start.y, points[0].x, points[0].y); 
			for(var k = 0 ; k < extAttrNum - 1; k++){
				result += Line(points[k].x, points[k].y, points[k+1].x, points[k+1].y); 
			}
			result += LineArrow(points[points.length - 1].x, points[points.length - 1].y, end.x, end.y, context.arrowLength , context.arrowAngle);
		}else{
    		mid.x = (from.x + to.x) / 2;
    		mid.y = (from.y + to.y) / 2;
			start = decreaseBegin(start,end,from);
        	end = decrease(start, end, to); 
        	start.x = start.x * context.zoomQuotiety;
        	start.y = start.y * context.zoomQuotiety;
        	end.x = end.x * context.zoomQuotiety;
        	end.y = end.y * context.zoomQuotiety;
			result += LineArrow(start.x, start.y, end.x, end.y, context.arrowLength , context.arrowAngle); 
		}

		if (transaction.name) {
    		var width = transaction.name.length  * context.zoomQuotiety * 2 * 10;
    		var left = mid.x - width / 2;
    		var top = mid.y - context.fontSize;
    		var height = context.fontSize  * context.zoomQuotiety * 3 ;
    		var tmp = drawText(transaction.name, context.fontSize, left, top, width, height, context.zoomQuotiety);
    		result += tmp;
    	};
		
		var len = result.length;
	};
	color = oColor;

	return result;
} 

function mapActivityState(state){
	if(!state){
		return state;
	}
	var states = {
		"1":"未启动",
		"2":"运行",
		"3":"挂起",
		"7":"已完成",
		"8":"终止",
		"9":"取消",
		"10":"待激活"
	};
	//直接取第一位
	state = state.charAt(0);
	if(states[state]){
		return states[state];
	}
	return state;
}

function mapActivityType(type,isStart){
	var types = {
		"start": "开始活动",
		"manual":"人工活动",
		"finish":"结束活动",
		"subflow":"子流程活动",
		"toolapp":"自由活动",
		"route":"路由活动",
		"webservice":"webservice活动"
	};
	if(type == "manual" && isStart){
		return "人工开始活动";
	}
	if(types[type]){
		return types[type];
	}
	return type;
}