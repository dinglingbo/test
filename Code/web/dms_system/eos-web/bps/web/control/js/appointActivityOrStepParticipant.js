//指派后继活动或后继活动参与者
nui.bps.AppointActivity = function () {
    nui.bps.AppointActivity.superclass.constructor.call(this);
};
nui.extend(nui.bps.AppointActivity, nui.Button, {
	uiCls: "nui-bps-appoint-activity",
	workItemID:"",
	getWorkItemID: function(){
		return this.workItemID;
	},
	setWorkItemID: function(value){
		this.workItemID = value;
	},
	appointType:"NONE", //指派类型[NONE, FREE_FLOW, APPOINT]
	getAppointType:function(){
		return this.appointType;
	},
	setAppointType:function(value){
		this.appointType = value;
	},
	url:"", //点击跳到哪个jsp页面
	getUrl:function(){
		return this.url;
	},
	setUrl:function(value){
		this.url = value;
	},
	windowTitle:"",
	getWindowTitle:function(){
		return this.windowTitle;
	},
	setWindowTitle:function(value){
		this.windowTitle = value;
	},
	freeFlowTitle:"",
	getFreeFlowTitle:function(){
		return this.freeFlowTitle;
	},
	setFreeFlowTitle:function(value){
		this.freeFlowTitle = value;
	},
	freeFlowText:"",
	getFreeFlowText:function(){
		return this.freeFlowText;
	},
	setFreeFlowText:function(value){
		this.freeFlowText = value;
	},
	appointParticipantTitle:"",
	getAppointParticipantTitle:function(){
		return this.appointParticipantTitle;
	},
	setAppointParticipantTitle:function(value){
		this.appointParticipantTitle = value;
	},
	appointParticipantText:"",
	getAppointParticipantText:function(){
		return this.appointParticipantText;
	},
	setAppointParticipantText:function(value){
		this.appointParticipantText = value;
	},
    getAttrs: function (el) {
        var attrs = nui.bps.AppointActivity.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);
        nui._ParseString(el, attrs,
            ["appointType", "url", "workItemID", "freeFlowTitle", "freeFlowText", "appointParticipantTitle", "appointParticipantText", "windowTitle"]
        );
        return attrs;
    },
	load: function(callback){
		var _this = this;
		setTimeout(function () {
			nui.ajax({
	            url: bootPATH + "../../rest/services/bps/webcontrol/getAppointActivityType",	            
            	type: "POST",
	            data: {workItemID:_this.workItemID },
	            success: function (data) {
	            	var type = data.appointType;
	            	_this.appointType = type;
	            	if(type == "FREE_FLOW"){
						_this.setText(_this.getFreeFlowText());
						_this.setWindowTitle(_this.getFreeFlowTitle());
						_this.url = "../../bps/web/control/html/appointActivity4Freeflow.jsp";
						_this.setVisible(true);
					}else if(type == "APPOINT"){
						_this.setText(_this.getAppointParticipantText());
						_this.setWindowTitle(_this.getAppointParticipantTitle());
						_this.url = "../../bps/web/control/html/appointStepParticipant.jsp";
						_this.setVisible(true);
					}else if(type == "NONE"){
						_this.setVisible(false);
					}
	            	if(callback){
	            		callback(type);
	            	}
	            },
	            error: function () {
	            }
			});
		},1)
	},
    _create: function () {
    	var _this = this;
    	nui.bps.AppointActivity.superclass._create.call(this);
    	if(workItemID!=null && workItemID!=""){
    		_this.load();
    	}
    },
	_initEvents: function () {
        nui.bps.AppointActivity.superclass._initEvents.call(this);
        this.on("click", this.__DefaultOnClick, this);
    },
    __DefaultOnClick : function onClick() {
		var selfObj = this;
		nui.open({
			url: bootPATH + selfObj.getUrl(),
			title: selfObj.getWindowTitle(),
			width: 700,
			height: 400,
			onload: function (){
				var iframe = this.getIFrameEl();
				var data = {
					workItemID:selfObj.getWorkItemID()
				};
				iframe.contentWindow.setFormData(data);
			},
			ondestroy: function (action){
				
			}
		});
	}
});
nui.regClass(nui.bps.AppointActivity, 'bps-appoint-activity');