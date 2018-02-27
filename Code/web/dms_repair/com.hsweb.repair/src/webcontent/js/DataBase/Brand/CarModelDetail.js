var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var dataform1 = null;
var requiredField = {
		carBrandName:"品牌",
		carFactoryName:"厂商",
		carSeriesName:"车系",
		carModel:"车型"
};

$(document).ready(function(){
	dataform1 = new nui.Form("#dataform1");
});
function setData(data){
	if(!dataform1){
		dataform1 = new nui.Form("#dataform1");
	}
	data = data||{};
	var model = data.model;
	dataform1.setData(model);
}
savaUrl = "com.hsapi.repair.baseData.brand.saveModel.biz.ext";
function saveData(){
	var data = dataform1.getData();
	console.log(data);
	for(var key in requiredField){
		if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
	}
	nui.mask({
		html:'保存中..'
	});
	nui.ajax({
		url:savaUrl,
		type:"post",
		data:JSON.stringify({
			model:data
		}),
		success:function(data){
			nui.unmask();
			data = data||{};
			if(data.errCode == "S")
			{
				nui.alert("保存成功");
				CloseWindow("ok");
			}
			else{
				nui.alert(data.errMsg||"保存失败");
			}
		},
		error:function(jqXHR, textStatus, errorThrown){
			//  nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
function onOk(){
	saveData();
}
function CloseWindow(action) {
//  if (action == "close" && form.isChanged()) {
//      if (confirm("数据被修改了，是否先保存？")) {
//          saveData();
//      }
//  }
  if (window.CloseOwnerWindow)
  return window.CloseOwnerWindow(action);
  else window.close();
}

function onCancel() {
  CloseWindow("cancel");
}