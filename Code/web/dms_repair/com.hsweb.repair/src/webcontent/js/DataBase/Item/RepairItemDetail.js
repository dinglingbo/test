var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var deductForm = null;
var salesDeductTypeEl = null;
var techDeductTypeEl = null;
var advisorDeductTypeEl = null;
var servieTypeList = [];
var servieTypeHash = {};
var serviceTypeIdEl = null;
var requiredField = {
	name: "项目名称",
	//serviceTypeId: "业务类型",
	type: "项目类型",
	//code: "项目编码"
	//carModelId: "车型"
};
var carBrandIdList = [];//品牌
$(document).ready(function(){
	basicInfoForm = new nui.Form("#basicInfoForm");
	deductForm = new nui.Form("#deductForm");
	carBrandIdEl = nui.get("carBrandId");
    carSeriesId = nui.get("carSeriesId");
	carModelIdEl = nui.get("carModelId");
	salesDeductTypeEl = nui.get("salesDeductType");
	techDeductTypeEl = nui.get("techDeductType");
	advisorDeductTypeEl = nui.get("advisorDeductType");
	salesDeductTypeEl.setData(typeList);
	techDeductTypeEl.setData(typeList);
	advisorDeductTypeEl.setData(typeList);
	
	var elList = basicInfoForm.getFields();
	var nameList = ["itemTime","unitPrice","deductAmt","amt"];
	elList.forEach(function(v)
	{
		if(nameList.indexOf(v.name)>-1)
		{
			v.on("focus",function(e){
				onInputFocus(e);
			});
			v.on("blur",function(e){
				onInputBlur(e);
			});
		}
	});
	
	serviceTypeIdEl = nui.get("serviceTypeId");
	if(currIsMaster=="1"){
		$("#isShareTd").show();
		$("#isShare").show();
	}else{
		$("#isShareTd").hide();
		$("#isShare").hide();
	}

	nui.get("type").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
      
      initServiceType("serviceTypeId",function(data) {
          servieTypeList = nui.get("serviceTypeId").getData();
          servieTypeList.forEach(function(v) {
              servieTypeHash[v.id] = v;
          });
      });

});
function onInputFocus(e)
{
	var el = e.sender;
	el.setInputStyle("text-align:left;");
}
function onInputBlur(e)
{
	var el = e.sender;
	el.setInputStyle("text-align:right;");
}
var carBrandIdEl;
var carSeriesId;
var carModelIdEl;
var carModelIdHash = {};

var typeList = [{id:"1",text:"按原价比例"},{id:"2",text:"按折后价比例"},{id:"3",text:"按产值比例"},{id:"4",text:"固定金额"}];
function setData(data)
{
	
	data = data||{};
	if(data.typeList)
	{//项目类型
		var typeList = data.typeList;
		var typeItemList = [];
/*		for(var i=0; i<typeList.length; i++){
			var type = typeList[i].type;
			if(type == 'item'){
				typeItemList.push(typeList[i]);
			}
		}*/
		nui.get("type").setData(typeList);
	}
	if(data.carBrandIdList)
	{//品牌
		carBrandIdList = data.carBrandIdList;
		//carBrandIdEl.setData(carBrandIdList);
	}
	if(data.item)
	{
		var item = data.item;
		basicInfoForm.setData(item);
		deductForm.setData(item);
		carBrandIdEl.doValueChanged();
		carSeriesId.doValueChanged();		
		var salesDeductType = item.salesDeductType||0;
		var techDeductType = item.techDeductType||0;
		var advisorDeductType = item.advisorDeductType||0;
		if(salesDeductType == 4){
			$("#salesDeductValue").next().hide();
		}else {
			$("#salesDeductValue").next().show();
		}
	
		if(techDeductType == 4){
			$("#techDeductValue").next().hide();
		}else {
			$("#techDeductValue").next().show();
		}
	
		if(advisorDeductType == 4){
			$("#advisorDeductValue").next().hide();
		}else {
			$("#advisorDeductValue").next().show();
		}
		if(item.carBrandId){
			//查找车型
			var modelName = "";
			for(var i = 0;i<carBrandIdList.length;i++){
				if(carBrandIdList[i].id ==item.carBrandId){
					nui.get("carBrandId").setValue(carBrandIdList[i].id);
					nui.get("carBrandId").setText(carBrandIdList[i].name);
					break;
				}
			}
		}
		if(item.carSeriesId){
			var json={
					carBrandId : item.carBrandId,
					token:token
			};
			nui.ajax({
				url : webPath + sysDomain +"/systemApi/com.hsapi.system.dict.dictMgr.queryCarSeries.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					if(text.errCode=="S"){
						for(var i = 0;i<text.data.length;i++){
							if(text.data[i].carSeriesId ==item.carSeriesId){
								nui.get("carSeriesId").setValue(text.data[i].id);
								nui.get("carSeriesId").setText(text.data[i].carSeriesName);
								break;
							}
						}

					}
				}
			});
		}
		if(item.carModelId){
			var json={
				carSeriesId : item.carSeriesId,
				token:token
			};			
			nui.ajax({
				url : webPath + sysDomain +"/systemApi/com.hsapi.system.dict.dictMgr.queryCarModel.biz.ext",
				type : 'POST',
				data : json,
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					if(text.errCode=="S"){
						for(var i = 0;i<text.data.length;i++){
							if(text.data[i].carModelId ==item.carModelId){
								nui.get("carModelId").setValue(text.data[i].carModelId);
								nui.get("carModelId").setText(text.data[i].carModel);
								break;
							}
						}

					}
				}
			});
		}
	}
}
var saveUrl = baseUrl+"com.hsapi.repair.baseData.item.saveRpbItem.biz.ext";
function onOk(){
	var data = basicInfoForm.getData();
	if(data.id){
		var orgid = data.orgid||0;
		if(orgid != currOrgId){
			parent.showMsg("只能修改本店项目!","W");
			return;
		}
		data.editType = "edit";
	}else{
		data.editType = "add";
		
	}
	
	//判断名称重复，提示
	var judgeResults= null;//返回参数ES
	judge(data,function(code){
		judgeResults = code; 
		if(judgeResults!="S"){
			   nui.confirm("已经存在名称为   ["+data.name+"] 的项目，是否确定保存？", "友情提示",function(action){
				       if(action!="ok"){
				    	   return;		
				     }else{
				    	 for(var key in requiredField){
				 			if(!data[key] || data[key].trim().length==0)
				 	        {
				 	            parent.showMsg(requiredField[key]+"不能为空!", "W");
				 	            return;
				 	        }
				 		}
				 		if(!nui.get("serviceTypeId").getValue()) {
				 			parent.showMsg("业务类型不能为空!", "W");
				 	        return;
				 		}

				 		deductForm.validate();
				 	    if (deductForm.isValid() == false) {
				 	        return;
				 		}

				 		var deData = deductForm.getData();
				 		for(var key in deData){
				 			data[key] = deData[key];
				 		}
				 		
				 		nui.mask({
				 			el : document.body,
				 			cls : 'mini-mask-loading',
				 			html : '保存中...'
				 		});
				 		doPost({
				 			url:saveUrl,
				 			data:{
				 				item:data	
				 			},
				 			success:function(data)
				 			{
				 				nui.unmask();
				 				data = data||{};
				 				if(data.errCode == "S")
				 				{
				 					
				 					CloseWindow("ok");
				 				}
				 				else{
				 					parent.showMsg(data.errMsg||"保存失败", "E");
				 				}
				 			},
				 			error:function(jqXHR, textStatus, errorThrown)
				 			{
				 				console.log(jqXHR.responseText);
				 				nui.unmask();
				 				parent.showMsg("网络出错", "E");
				 			}
				 		});
				     }
				 });
		}else{
			for(var key in requiredField){
				if(!data[key] || data[key].trim().length==0)
		        {
		            parent.showMsg(requiredField[key]+"不能为空!", "W");
		            return;
		        }
			}
			if(!nui.get("serviceTypeId").getValue()) {
				parent.showMsg("业务类型不能为空!", "W");
		        return;
			}

			deductForm.validate();
		    if (deductForm.isValid() == false) {
		        return;
			}

			var deData = deductForm.getData();
			for(var key in deData){
				data[key] = deData[key];
			}
			
			nui.mask({
				el : document.body,
				cls : 'mini-mask-loading',
				html : '保存中...'
			});
			doPost({
				url:saveUrl,
				data:{
					item:data	
				},
				success:function(data)
				{
					nui.unmask();
					data = data||{};
					if(data.errCode == "S")
					{
						
						CloseWindow("ok");
					}
					else{
						parent.showMsg(data.errMsg||"保存失败", "E");
					}
				},
				error:function(jqXHR, textStatus, errorThrown)
				{
					console.log(jqXHR.responseText);
					nui.unmask();
					parent.showMsg("网络出错", "E");
				}
			});
		}
	})

	
		
	
}
function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel() {
  CloseWindow("cancel");
}
function onRateValidation(e){
	var el = e.sender.id;
	var value = 0;
	if(el == "salesDeductValue"){
		value = salesDeductTypeEl.getValue();
		if(value == 4){
			if(e.value == "" || e.value == null){

			}else{
				var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$|0$)/;
				if (!reg.test(e.value)) {
					e.errorText = "请输入大于等于0的整数或者保留两位小数";
					e.isValid = false;
					parent.showMsg("请输入大于0的整数或者保留两位小数!","W");
				}
			}
		}else {
			if (e.isValid) {
				//var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
				if(e.value == "" || e.value == null){

				}else{
					var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
					if (!reg.test(e.value)) {
						e.errorText = "请输入0~100的数,最多可保留两位小数";
						e.isValid = false;
						parent.showMsg("请输入0~100的数,最多可保留两位小数!","W");
					}
				}
			}
		}
	}else if(el == "techDeductValue"){
		value = techDeductTypeEl.getValue();
		if(value == 4){
			if(e.value == "" || e.value == null){

			}else{
				var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$)|0$/;
				if (!reg.test(e.value)) {
					e.errorText = "请输入大于等于0的整数或者保留两位小数";
					e.isValid = false;
					parent.showMsg("请输入大于0的整数或者保留两位小数!","W");
				}
			}
		}else {
			if (e.isValid) {
				//var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
				if(e.value == "" || e.value == null){

				}else{
					var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
					if (!reg.test(e.value)) {
						e.errorText = "请输入0~100的数,最多可保留两位小数";
						e.isValid = false;
						parent.showMsg("请输入0~100的数,最多可保留两位小数!","W");
					}
				}
			}
		}
	}else if(el == "advisorDeductValue"){
		value = advisorDeductTypeEl.getValue();
		if(value == 4){
			if(e.value == "" || e.value == null){

			}else{
				var reg=/(^[1-9]{1}[0-9]*$)|(^[0-9]*\.[0-9]{2}$)|0$/;
				if (!reg.test(e.value)) {
					e.errorText = "请输入大于等于0的整数或者保留两位小数";
					e.isValid = false;
					parent.showMsg("请输入大于0的整数或者保留两位小数!","W");
				}
			}
		}else {
			if (e.isValid) {
				//var reg=/(^[1-9][0-9]$|^[0-9]$|^100$)/;
				if(e.value == "" || e.value == null){

				}else{
					var reg=/^(\d|[1-9]\d)(\.\d{1,2})?$|100$/;
					if (!reg.test(e.value)) {
						e.errorText = "请输入0~100的数,最多可保留两位小数";
						e.isValid = false;
						parent.showMsg("请输入0~100的数,最多可保留两位小数!","W");
					}
				}
			}
		}
	}


}
function calc(type){
    var itemTime = nui.get("itemTime").getValue();
    var unitPrice = nui.get("unitPrice").getValue();
    var amt = nui.get("amt").getValue();
    
    if(itemTime == null || itemTime == '') {
        nui.get("itemTime").setValue(0);
    }else if(itemTime < 0) {
        nui.get("itemTime").setValue(0);
    }
    
    if(unitPrice == null || unitPrice == '') {
        nui.get("unitPrice").setValue(0);
    }else if(unitPrice < 0) {
        nui.get("unitPrice").setValue(0);
    }
    
    if(amt == null || amt == '') {
        nui.get("amt").setValue(0);
    }else if(amt < 0) {
        nui.get("amt").setValue(0);
    }
    
    itemTime = nui.get("itemTime").getValue();
    unitPrice = nui.get("unitPrice").getValue();
    amt = nui.get("amt").getValue();
    
    if(type == 'itemTime'){
        nui.get("amt").setValue(itemTime * unitPrice);
    }
    
    if(type == 'unitPrice'){
        nui.get("amt").setValue(itemTime * unitPrice);
    }
    
    if(type == 'amt'){
        if(itemTime > 0) {
            unitPrice = (amt / itemTime).toFixed(2);
            nui.get("unitPrice").setValue(unitPrice);
        }else {
            nui.get("itemTime").setValue(0);
            nui.get("amt").setValue(0);
        }
    }
}
function hidePercent(e){
	var value = e.value;
	var el = e.sender.id;
	if(el == "salesDeductType"){
		if(value == 4){
			$("#salesDeductValue").next().hide();
		}else {
			$("#salesDeductValue").next().show();
		}
	}else if(el == "techDeductType"){
		if(value == 4){
			$("#techDeductValue").next().hide();
		}else {
			$("#techDeductValue").next().show();
		}
	}else if(el == "advisorDeductType"){
		if(value == 4){
			$("#advisorDeductValue").next().hide();
		}else {
			$("#advisorDeductValue").next().show();
		}
	}
}

//判断是否同名
var judgeUrl = baseUrl+"com.hsapi.repair.baseData.item.checkRpbItemExists.biz.ext";
function judge(data,callback){
	var json={
			name:data.name,
			code:data.code,
			editType:data.editType,
			id:data.id,
			token:token
	};
	nui.ajax({
		url : judgeUrl,
		type : 'POST',
		data : json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var returnJson = nui.decode(text);
			callback && callback(returnJson.errCode);
		}
	});
}
function getCarModel() {
	nui.open({
		//// targetWindow: window,,
		url : webPath + contextPath + "/com.hsweb.repair.common.carModelSelectT.flow?token="+token,
		title : "选择车型",
		width : 855,
		height : 600,
		allowDrag : true,
		allowResize : false,
		onload : function() {
			var iframe = this.getIFrameEl();
            var type = "item";//项目设置传过来，可不全部选择
            iframe.contentWindow.setData(type);
		},
		ondestroy : function(action) {
			if (action == "ok") {
				var iframe = this.getIFrameEl();
				var data = iframe.contentWindow.getData(true);
				if (data && data.carModel) {
					var carModel = data.carModel;
					nui.get("carBrandId").setValue(data.carModel.carBrandId||"");
					nui.get("carBrandId").setText(data.carModel.carBrandName||"");
					
					nui.get("carSeriesId").setValue(data.carModel.carSeriesId||"");
					nui.get("carSeriesId").setText(data.carModel.carSeriesName||"");
					
					nui.get("carModelId").setValue(data.carModel.id||"");
					nui.get("carModelId").setText(data.carModel.carModel||"");
					

				}
			}
		}
	});
}
