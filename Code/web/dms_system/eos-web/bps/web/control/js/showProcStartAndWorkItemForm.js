nui.bps = nui.bps || {};
nui.bps.ShowProcStartForm = function () {
	// @Review -->nui.bps.ShowProcStartForm.superclass.constructor.call(this); (wuyh)
	//@Review nui --> nui (wuyh)	
	nui.bps.ShowProcStartForm.superclass.constructor.call(this)
}

nui.extend(nui.bps.ShowProcStartForm, nui.Control, {
	uiCls: 'nui-bps-showprocstartform',
	processDefID4AutoForm: "",
	prefix: "",
	enabled:"none",
	async:true,
	setAsync:function (async) {
		if (async=="true") {
			this.async = true;
			return;
		};
		this.async = false;
	},
	getAsync:function () {
		return this.async;
	},
	setEnabled:function (enabled) {
		if(enabled===false){
			this.enabled = "false";
		}else if(enabled===true){
			this.enabled = "true";
		}else{
			this.enabled = enabled;
		}
	},
	getEnabled:function () {
		return this.enabled;
	},
	processID:"",
	begin:"<table>",
	end:"</table>",
	template:"<tr><td>{name}</td><td>{html}</td></tr>",
	load: function () {
		var _this = this;
		nui.ajax({
            url: bootPATH + "../../rest/services/bps/webcontrol/getProcStartForm",
            type: "POST",
            data: { processID:_this.processID},
		    async:_this.async,
            success: function (data) {
            	var html = "<input type='hidden' name='processDefID4AutoForm' value='" + _this.processDefID4AutoForm + "'/>" + 
                	"<input type='hidden' name='__wf_auto_form_tag_prefix' value='" + _this.prefix + "'/>";
            	var controls = data.controls;
            	var name , value ,result;
            	html += _this.begin;
            	html += nui.bps.renderControls(controls,_this);
            	html += _this.end;
            	_this.el.innerHTML = html;
            	nui.parse();
            },
            error: function () {
            }
        });
	},
	_create: function () {
		nui.bps.ShowProcStartForm.superclass._create.call(this);
	},

	render: function(p) {
		nui.bps.ShowProcStartForm.superclass.constructor.call(this, p);
	},
	getAttrs: function (el) {
        var attrs = nui.bps.ShowProcStartForm.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);

        nui._ParseString(el, attrs,
            ["processDefID4AutoForm","async", "enabled", "prefix", "processID", "template", "begin", "end"]
        );
        return attrs;
    },
    setBegin: function (begin) {
	    this.begin = begin;     
	},
	setEnd: function (end) {
	    this.end = end;     
	},
	setPrefix: function (prefix) {
	    this.prefix = prefix;     
	},
	setProcessDefID4AutoForm: function (processDefID4AutoForm) {
	    this.processDefID4AutoForm = processDefID4AutoForm;     
	},
	setProcessID: function (processID) {
	    this.processID = processID;     
	}, 
	setTemplate: function (template) {
	    this.template = template;     
	},
	getBegin: function () {
	    return this.begin;     
	},
	getEnd: function () {
	    return this.end;     
	},
	getPrefix: function (prefix) {
	    this.prefix = prefix;     
	},
	getProcessDefID4AutoForm: function () {
	    return this.processDefID4AutoForm;     
	},
	getProcessID: function () {
	    return this.processID;     
	}, 
	getTemplate: function () {
	    return this.template;     
	}
});
nui.regClass(nui.bps.ShowProcStartForm, 'bps-showprocstartform');


nui.bps.renderControls = function (controls,_this) {
	var html='', name , value ,result;
	for (var i = 0, l = controls.length; i < l; i++) {
		name = controls[i].name;
		value = nui.bps.createNuiControl(controls[i],_this);
		result = _this.template.replace("{name}",name+":");
		result = result.replace("{html}",value);
		html += "\n" 
		html += result;
	};
	return html;
}

//@Review 与ShowProcStartForm抽象成一个 （wuyh）
nui.bps.ShowWorkItemForm = function () {
	nui.bps.ShowProcStartForm.superclass.constructor.call(this);
}
nui.extend(nui.bps.ShowWorkItemForm, nui.bps.ShowProcStartForm, {
	uiCls: 'nui-bps-showworkitemform',
	workitemID4AutoForm: "",
	workItemID:"",
	load: function () {
		var _this = this;
		nui.ajax({
            url: bootPATH + "../../rest/services/bps/webcontrol/getWorkItemForm",
            type: "POST",
            data: { workItemID:_this.workItemID},
		    async:_this.async,
            success: function (data) {
            	var html = "<input type='hidden' name='workitemID4AutoForm' value='" + _this.workitemID4AutoForm + "'>" + 
                	"<input type='hidden' name='__wf_auto_form_tag_prefix' value='" + _this.prefix + "'>";
        		//_this.el.innerHTML = html;
            	var controls = data.controls;
            	html += _this.begin;
            	html += nui.bps.renderControls(controls,_this);
            	html += _this.end;
            	_this.el.innerHTML = html;
            	nui.parse();
            },
            error: function () {
            }
        });
	},
	_create: function () {
		nui.bps.ShowWorkItemForm.superclass._create.call(this);
	},
	render: function(p) {
		nui.bps.ShowWorkItemForm.superclass.constructor.call(this, p);
	},
	getAttrs: function (el) {
        var attrs = nui.bps.ShowWorkItemForm.superclass.getAttrs.call(this, el);
        var jq = jQuery(el);

        nui._ParseString(el, attrs,
            ["workitemID4AutoForm","workItemID"]
        );
        return attrs;
    },
	setWorkitemID4AutoForm: function (workitemID4AutoForm) {
	    this.workitemID4AutoForm = workitemID4AutoForm;     
	},
	setWorkItemID: function (workItemID) {
	    this.workItemID = workItemID;     
	},
	getWorkItemID: function () {
	    return this.workItemID;     
	},
	getWorkitemID4AutoForm: function () {
	    return this.workitemID4AutoForm;     
	}
});
nui.regClass(nui.bps.ShowWorkItemForm, 'bps-showworkitemform');




nui.bps.createNuiControl = function (data,_this) {
	var html;
	var prefix = _this.prefix;
	if (prefix!="") {
		prefix = prefix+"/";
	}else{
		prefix = "";
	}
	var name = data.fieldType == "relevant-data"?data.path:data.variableName.resourceName;

	if (data.dataType == "textInput"){
		html = '<input class="nui-textbox" name="' + prefix + name + '" ';
		if (data.required) {
			html += 'required = "true" errorMode="none"';
		};
		if(_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none" )){
			html += 'enabled="false" ';
		};
		if (data.value) {
			html += 'value="'+ data.value +'" ';
		};
		html += '/>';
	}else if (data.dataType == "email") {
		html = '<input class="nui-textbox" name="' + prefix + name + '" ';
		html += 'vType="email" ';
		if (data.required) {
			html += 'required = "true" errorMode="none" ';
		};
		if(_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none")){
			html += 'enabled="false" ';
		};
		if (data.value) {
			html += 'value="'+ data.value +'" ';
		};
		html += '/>';
	}else if (data.dataType == "longTextInput") {
		html = '<textarea class="nui-textarea" name="' + prefix + name + '" ';
		if (data.required) {
			html += 'required="true" errorMode="none" ';
		};
		if(_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none")){
			html += 'enabled="false" ';
		};
		if (data.value) {
			html += 'value="'+ data.value +'" ';
		};
		html += ' ></textarea>';
	}else if (data.dataType == "numberInput") {
		html = '<input class="nui-textbox" name="' + prefix + name + '" ';
		html += 'vtype="int" ';
		if (data.required) {
			html += 'required = "true" errorMode="none"';
		};
		if(_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none")){
			html += 'enabled = "false" ';
		};
		if (data.value) {
			html += 'value="'+ data.value +'" ';
		};
		html += '/>';
	}else if (data.dataType == "checkBox") {
		html = '<div class="nui-checkbox" name="' + prefix + name + '" ';
		if(_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none")){
			html += 'enabled="false"';
		};
		if (data.value == "true") {
			html += 'checked="true"';
		};
		html += ' ></div>';
	}else if (data.dataType == "sltSelect") {
		var datas = data.fieldAttribute
		datas = datas.split(";")
		var dArr = [];
		var obj;
		var commaIdx;
		//[name,value;name,value]
		var defaultValue = '';
		for (var i = 0 , j = datas.length; i < j ; i++) {
			obj = {};
			//@Review 对类似name,value的数据进行split操作（wuyh）
			obj.text = datas[i].split(",")[0];
			obj.value = datas[i].split(",")[1];
			if (i==0){
				defaultValue = obj.value;
			};
			dArr.push(obj);
		};
		if(data.value && !data.value==""){
			defaultValue = data.value;
		};
		
		dArr = nui.encode(dArr);
		html = '<input class="nui-combobox" name="'+ prefix + name +'" textField="text" valueField="value" data=\'' + dArr +'\' ';
		if (data.required) {
			html += 'required="true" errorMode="none" ';
		};
		if(_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none")){
			html += 'enabled="false" ';
		};
		html += 'value="'+ defaultValue +'" ';
		html += '/>';
	}else if (data.dataType == "date") {
		//@Review nui --> nui
		html = '<input class="nui-datepicker" name="' + name + '" '
		//@Review 复用以下三个if判断 （yangyong）
		if (data.required) {
			html += 'required="true" errorMode="none" ';
		};
		if(_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none")){
			html += 'enabled = "false" ';
		};
		if (data.value) {
			html += 'value="'+ data.value +'" ';
		};
		html += ' />';
	}else if (data.dataType == "user") {
		//@Review user 的输入框用wuyh编写的参与者选择控件（wuyh）
		html = '<input name="'+ prefix + name +'" class="nui-bps-select-participant" '
		if(data.value) {
			var values = data.value.split(",");
			var value = "";
			var text = "";
			for(var i = 0,l = values.length; i < l;i++){
				var idx = values[i].lastIndexOf("|");
				var val = values[i].substring(0,idx);
				var txt = values[i].substring(idx + 1);
				value += (val+",");
				text += (txt+",");
			}
			
			html += 'value="' + value.substring(0,value.length -1) + '" text="' + text.substring(0,text.length -1) + '"';
		};
			html += ' allowInput="false" selectorMaxCount="-1" ';
		html += '/>';
	}else if (data.dataType == "sltRadio") { 
		var datas = data.fieldAttribute;
		datas = datas.split(";");
		var dArr = [];
		var obj;
		var tmp;
		for (var i = 0 , j = datas.length; i < j ; i++) {
			if (_this.enabled == "false" || (data.accessType=="read" && _this.enabled == "none") && data.value) {
				commaIdx = datas[i].indexOf(",");
				if (datas[i].substring(commaIdx+1) == data.value) {
					obj = {};
					obj.text = datas[i].substring(0,commaIdx);
					obj.value = datas[i].substring(commaIdx+1);
					dArr.push(obj);
					break;
				};
			}
			if (data.accessType=="read-write" && _this.enabled!="false"){
				obj = {};
				tmp = datas[i].split(",");
				obj.text = tmp[0];
				obj.value = tmp[1];
				dArr.push(obj);
			}
		};
		dArr = nui.encode(dArr);
		html = '<div class="nui-radiobuttonlist" name="'+ prefix + name +'" textField="text" valueField="value" data=\'' + dArr +'\' ';
		 
		if (data.value) {
			html += 'value="'+ data.value +'" ';
		};
		html += '/>';
	}

	if(data.required){
		html+='<font style="color:red">*</font>';
	}
	return html;	
}