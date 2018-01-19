//获取工作项信息
nui.bps = nui.bps || {};
nui.bps.FetchMessageList = function () {
	nui.bps.FetchMessageList.superclass.constructor.call(this)
}

nui.extend(nui.bps.FetchMessageList, nui.Control, {
	uiCls: 'nui-bps-fetchmessagelist',
	
	template:'',
	
	data:"",
	getData: function(){
		return this.data;
	},
	setData: function(value){
		this.data = value;
	},
	restMethod:"",
	getRestMethod: function(){
		return this.restMethod;
	},
	setRestMethod: function(value){
		this.restMethod = value;
	},
	load: function (value) {
		
		var _this = this;
		setTimeout(function () {
			nui.ajax({
				url: bootPATH + "../../rest/services/bps/webcontrol/"+_this.restMethod,
				type: "POST",
				data: value,
	            success: function (data) {
					var conlumn = _this.template;
	            	var html = "";
	            	var messageArry = data.wfMessages;
					conlumn.each(function(){
						if($(this).attr("name")==_this.el.id){
							conlumn = $(this);
							conlumn.attr("name","")
						}
					});
					conlumn.addClass("nui-bps-fetchmsg-head");
					width = Math.round(1/conlumn.children().length*100)+"%";
					conlumn.children().each(function(){
						$(this).css({"position":"relative","height":"20px","top":"6px","width":width,"float":"left","text-indent":"2em"});
					});
					header = conlumn[0].outerHTML;
					conlumn.removeClass();
					html += header;
					if(messageArry != null){
						if(messageArry.length!=0){
							for (var i = 0, j = messageArry.length; i < j; i++) {
								conlumn.addClass("nui-bps-fetchmsg-row-height");
								if((i%2)==0){
									conlumn.addClass("nui-bps-fetchmsg-row-even");
								}else{
									conlumn.addClass("nui-bps-fetchmsg-row-odd");
								}
								conlumn.children().each(function(){
									$(this).css({"height":"20px","top":"10px"});
									field = $(this).attr("field");
									$(this).html(messageArry[i][field]);
								});
								html += "\n";
								html += conlumn[0].outerHTML;
								conlumn.removeClass();
							};
							if(messageArry.length<7){
								conlumn.children().each(function(){
									$(this).css({"height":"20px","top":"10px"});
									$(this).html("");
								});
								for(var i=messageArry.length;i<9;i++){
									conlumn.addClass("nui-bps-fetchmsg-row-height");
									if((i%2)==0){
										conlumn.addClass("nui-bps-fetchmsg-row-even");
									}else{
										conlumn.addClass("nui-bps-fetchmsg-row-odd");
									}
									html += "\n";
									html += conlumn[0].outerHTML;
									conlumn.removeClass();
								};
							}
						}else{
							conlumn.children().each(function(){
								$(this).html("");
							});
							for(var i=0;i<9;i++){
								conlumn.addClass("nui-bps-fetchmsg-row-height");
								if((i%2)==0){
									conlumn.addClass("nui-bps-fetchmsg-row-even");
								}else{
									conlumn.addClass("nui-bps-fetchmsg-row-odd");
								}
								html += "\n";
								html += conlumn[0].outerHTML;
								conlumn.removeClass();
							};
						}
					}
					_this.template = header;
	            	_this.el.innerHTML = html;
	            },
	            error: function () {
	            	
	            }
	        });
		})
	},
	_create: function () {
		var _this = this;
		nui.bps.FetchMessageList.superclass._create.call(this);
		_this.template= $("[property='column']");
	},
	render: function(p) {
		nui.bps.FetchMessageList.superclass.constructor.call(this, p);
	}
});
nui.regClass(nui.bps.FetchMessageList, 'bps-fetchmessagelist');