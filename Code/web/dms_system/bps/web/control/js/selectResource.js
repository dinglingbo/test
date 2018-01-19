//@REVIEW mini修改成nui {wuyh}
//@REVIEW 需要增加控件的命名空间,bps[guwei] {wuyh}
//@REVIEW 增加事件扩展，比如可能不使用逗号分隔[guwei] 
nui.bps = nui.bps || {};
nui.bps.SelectResource = function () {
    nui.bps.SelectResource.superclass.constructor.call(this);
};
nui.extend(nui.bps.SelectResource, nui.ButtonEdit, {
	uiCls: "nui-bps-select-resource",
	selectText : "选择",
	selectorTitle : "",
	setSelectorTitle: function(value){
		this.selectorTitle = value;
	},
	getSelectorTitle: function(){
		return this.selectorTitle;
	},
	selectorMaxCount : -1,
	setSelectorMaxCount: function(value){
		this.selectorMaxCount = value;
	},
	getSelectorMaxCount: function(){
		return this.selectorMaxCount;
	},
	selectorWidth : 700,
	setSelectorWidth: function(selectorWidth){
		this.selectorWidth = selectorWidth;
	},
	getSelectorWidth: function(){
		return this.selectorWidth;
	},
	selectorHeight : 450,
	setSelectorHeight: function(selectorHeight){
		this.selectorHeight = selectorHeight;
	},
	getSelectorHeight: function(){
		return this.selectorHeight;
	},
    getAttrs: function (el) {
        var attrs = nui.bps.SelectResource.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);

        nui._ParseString(el, attrs,
            ["selectorTitle"]
        );
        nui._ParseInt(el, attrs,
            ["selectorMaxCount", "selectorWidth", "selectorHeight"]
        );

        return attrs;
    },
	otherParamObj : {commitParamObj : {}},
	setOtherParamObj: function(value){
		this.otherParamObj = value;
	},
	getOtherParamObj: function(){
		return this.otherParamObj;
	},
    _create: function () {
    	nui.bps.SelectResource.superclass._create.call(this);
    	this.setAllowInput(false);
    },
    _initInputEvents: function () {
        nui.bps.SelectResource.superclass._initInputEvents.call(this);
        this.on("buttonclick", this.__DefaultOnButtonClick, this);
    },
    __DefaultOnButtonClick : function onButtonEdit() {
		var selfObj = this;
		nui.open({
			url: bootPATH + "../../bps/web/control/html/resourceSelector.jsp",
			title: selfObj.selectText + selfObj.getSelectorTitle(),
			width: selfObj.getSelectorWidth(),
			height: selfObj.getSelectorHeight(),
			onload: function (){
				var iframe = this.getIFrameEl();
				var data = {
					maxCount : selfObj.getSelectorMaxCount(),
					otherParamObj : selfObj.getOtherParamObj(),
					title : selfObj.getSelectorTitle(),
					ids : selfObj.getValue(),
					texts : selfObj.getText()
				};
				iframe.contentWindow.initData(data);
			},
			ondestroy: function (action){
				if (action == "ok") {      
					var iframe = this.getIFrameEl();						
					var data = iframe.contentWindow.returnData();
					data = nui.clone(data);
					selfObj.setText(data.texts);
					selfObj.setValue(data.ids);
					var valuechangedevent=selfObj._events.valuechanged;
					if(valuechangedevent){
						selfObj.doValueChanged();
					}
				}
			}
		});
	}
});
nui.regClass(nui.bps.SelectResource, 'bps-select-resource');

//选择参与者控件
nui.bps.SelectParticipant = function () {
    nui.bps.SelectParticipant.superclass.constructor.call(this);
};
nui.extend(nui.bps.SelectParticipant, nui.bps.SelectResource, {
	uiCls: "nui-bps-select-participant",	
	participantText : "参与者",
	//设置代理参与者时使用（agentFrom）
	agentFrom : "",	
	setAgentFrom: function(value){
		this.agentFrom = value;
		var otherParam = this.getOtherParamObj();
    	otherParam.commitParamObj.agentFrom = value;
    	this.setOtherParamObj(otherParam);
	},
	getAgentFrom: function(){
		return this.agentFrom;
	},	
	//设置后继活动参与者时使用（processDefID，activityDefID）
	processDefID : "",	
	setProcessDefID: function(value){
		this.processDefID = value;
		var otherParam = this.getOtherParamObj();
    	otherParam.commitParamObj.processDefID = value;
    	this.setOtherParamObj(otherParam);
	},
	getProcessDefID: function(){
		return this.processDefID;
	},	
	activityDefID : "",	
	setActivityDefID: function(value){
		this.activityDefID = value;
		var otherParam = this.getOtherParamObj();
    	otherParam.commitParamObj.activityDefID = value;
    	this.setOtherParamObj(otherParam);
	},
	getActivityDefID: function(){
		return this.activityDefID;
	},
	getData : function(){
		var returnData = [];
		var valueArray = this.value.split(",");
		var textArray = this.getText().split(",");
		for (var i = 0, l = valueArray.length; i < l; i++) {
			var idArray = valueArray[i].split("|");
			returnData.push({typeCode:idArray[0], id:idArray[1], name:textArray[i]});
		}
		if (this.getSelectorMaxCount == 1) {
			if (returnData.length >= 1) {
				return returnData[0];
			} else {
				return {};
			}
		} else {
			return returnData;
		}
	},
	setData : function (data) {
		var values = "";
		var texts = "";
		if(data!=null){
			if (data && data.length) {
			for (var i = 0, l = data.length; i < l; i++) {				
				values = values + "," + data[i].typeCode + "|" + data[i].id;
				texts = texts + "," + data[i].name;
			}
			if (values.length > 0) {
				values = values.substring(1);
				texts = texts.substring(1);
			}
		} else {
			values = data.typeCode + "|" + data.id;
			texts = data.name;
		}	
		}
		
		this.setValue(values);
		this.setText(texts);
	},
    getAttrs: function (el) {
        var attrs = nui.bps.SelectParticipant.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);

        nui._ParseString(el, attrs,
            ["agentFrom", "processDefID", "activityDefID"]
        );

        return attrs;
    },
    _create: function () {
    	nui.bps.SelectParticipant.superclass._create.call(this);
    	this.setSelectorTitle(this.participantText);
    	var otherParam = {
    			commitParamObj : {},
        		isNotAllowParentChild : false,
    	    	loadUrl : bootPATH + "../../rest/services/bps/webcontrol/queryParticipants",
    	    	selectableType : ",person,emp,role,organization,",
    	    	colorMap : {
    	    		"__type" : "java.util.HashMap",
    	    		emp : '#008080',
    	    		person : '#008080',
    				role : '#d5d50c',
    				organization : '#2b6da5'
    	    	}
        	};
    	this.setOtherParamObj(otherParam);
    }
});
nui.regClass(nui.bps.SelectParticipant, 'bps-select-participant');

//选择流程和活动控件
nui.bps.SelectProcessAndActivity = function () {
    nui.bps.SelectProcessAndActivity.superclass.constructor.call(this);
};
nui.extend(nui.bps.SelectProcessAndActivity, nui.bps.SelectResource, {
	uiCls: "nui-bps-select-process-activity",	
	processAndActivityText : "流程和活动",
	containActivity : "",
	setContainActivity: function(value){
		this.containActivity = value;
		var otherParam = this.getOtherParamObj();
    	otherParam.commitParamObj.containActivity = value;
    	this.setOtherParamObj(otherParam);
	},
	getContainActivity: function(){
		return this.containActivity;
	},
	getData : function(){
		var returnData = [];
		var valueArray = this.getValue().split(",");
		var textArray = this.getText().split(",");
		for (var i = 0, l = valueArray.length; i < l; i++) {
			var idArray = valueArray[i].split("|");
			returnData.push({itemType:idArray[0], itemID:idArray[1], itemName:textArray[i]});
		}
		if (this.getSelectorMaxCount == 1) {
			if (returnData.length >= 1) {
				return returnData[0];
			} else {
				return {};
			}
		} else {
			return returnData;
		}
	},
	setData : function (data) {
		 
		var values = "";
		var texts = "";
		if (data && data.length) {
			for (var i = 0, l = data.length; i < l; i++) {				
				values = values + "," + data[i].itemType + "|" + data[i].itemID;
				texts = texts + "," + data[i].itemName;
			}
			if (values.length > 0) {
				values = values.substring(1);
				texts = texts.substring(1);
			}
		} else {
			values = data.itemType + "|" + data.itemID;
			texts = data.itemName;
		}	
		this.setValue(values);
		this.setText(texts);
	},
    getAttrs: function (el) {
        var attrs = nui.bps.SelectProcessAndActivity.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);

        nui._ParseString(el, attrs,
            ["containActivity"]
        );

        return attrs;
    },
    _create: function () {
    	nui.bps.SelectProcessAndActivity.superclass._create.call(this);
    	this.setSelectorTitle(this.processAndActivityText);
    	var otherParam = {
    		commitParamObj : {},
    		isNotAllowParentChild : true,
	    	loadUrl : bootPATH + "../../rest/services/bps/webcontrol/queryProcessAndActivity",
	    	selectableType : ",PROCESS,ACTIVITY,",
	    	colorMap : {
	    		"__type" : "java.util.HashMap",
				PROCESS : '#008080',
				ACTIVITY : '#2b6da5'
	    	}
    	};
    	this.setOtherParamObj(otherParam);
    }
});
nui.regClass(nui.bps.SelectProcessAndActivity, 'bps-select-process-activity');
