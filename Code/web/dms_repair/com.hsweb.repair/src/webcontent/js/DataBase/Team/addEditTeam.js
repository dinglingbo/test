var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var dataform1 = null;
var requiredField = {
		type:"维修工种",
		name:"班组名称",
		captainName:"班组长名称"
};
$(document).ready(function (){
	dataform1 = new nui.Form("#dataform1");
});
function setData(data){
	if(!dataform1){
		dataform1 = new nui.Form("#dataform1");
	}
	
	data = data||{};
	var team = data.team;
	dataform1.setData(team);
}
function onOk(){
	debugger;
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
		url:"com.hsapi.repair.baseData.team.saveTeam.biz.ext",
		type:"post",
		data:JSON.stringify({
			team:data
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
  if (window.CloseOwnerWindow)
  return window.CloseOwnerWindow(action);
  else window.close();
}

function onCancel() {
  CloseWindow("cancel");
}