var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var dataform1 = null;

var requiredFieldew = {
		code:"项目编码",
		type:"项目工种",
		name:"项目名称",
		itemKind:"项目类型",
		carBrandId:"品牌",
		carModel:"车型"
}
$(document).ready(function(){
	dataform1 = new nui.Form("#dataform1");
});
function setData(data){
	if(!dataform1){
		dataform1 = new nui.Form("#dataform1");
	}
	
	data = data||{};
	var item = data.item;
	dataform1.setData(item);
	
}

function onOk(){
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
		url:"",
		type:"post",
		data:JSON.stringify({
			item:data
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