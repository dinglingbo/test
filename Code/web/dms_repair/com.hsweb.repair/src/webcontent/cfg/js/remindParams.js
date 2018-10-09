var baseUrl = apiPath + repairApi + "/";
var qUrl = baseUrl + "com.hsapi.repair.baseData.query.queryRemindParams.biz.ext";
var editForm = null;

$(document).ready(function(){
    editForm = new nui.Form("#editForm");

    doSearch();


});
function setInitData(list)
{
    var data = {};
    if (list && list.length>0) {
        var data = list[0];

    }
	editForm.setData(data);    

    nui.unmask(document.body);
	
}
function doSearch()
{
    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});

	nui.ajax({
		url : qUrl,
		type : "get",
		data : JSON.stringify({
            token:token
        }),
		success : function(data) {
			
            data = data || {};
            var list = data.list;
			if (list && list.length>0) {
				setInitData(list);
			} 
			else {
                nui.unmask(document.body);
//				parent.showMsg(data.errMsg || "加载数据失败!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			console.log(jqXHR.responseText);
		}
	});
}
var saveUrl = baseUrl+"com.hsapi.repair.baseData.crud.saveRemindParams.biz.ext";
function onOk(){
	var data = editForm.getData();
	
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
	nui.ajax({
        url:saveUrl,
        type : "post",
		data : JSON.stringify({
            params : data,
            token: token
        }),
		success:function(data)
		{
			nui.unmask();
			data = data||{};
			if(data.errCode == "S")
			{
                parent.showMsg("保存成功","S");
				
			}
			else{
				parent.showMsg(data.errMsg||"保存失败","W");
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
function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel() {
  CloseWindow("cancel");
}
function checkRow(){
    var data = contentGrid.getData();
    if(data && data.length>0){
        return true;
    }

    return false;
}