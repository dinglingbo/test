var baseUrl = apiPath + repairApi + "/";
var contentUrl = baseUrl + "com.hsapi.repair.baseData.query.queryGuestTypeDiscountSrv.biz.ext";
var editForm = null;
var contentGrid = null;
var checkTypeEl = null;

var guestTypeId = 0;

var discountHash={};
$(document).ready(function(){
    editForm = new nui.Form("#editForm");
    contentGrid = nui.get("contentGrid");
    contentGrid.setUrl(contentUrl);

    discountRangeEl = nui.get("discountRange");
    integralAddEl = nui.get("integralAdd");
    reduceEl = nui.get("reduce");
    nui.get('name').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
        	onCancel();
        }

    }

    contentGrid.on("preload",function(e){
        //var typeList = e.result.typeList;
        var listSrv = e.result.list;
        var resList = e.result.resList;
        contentGrid.setData([]);
        if(resList && resList.length>0){

            listSrv.forEach(function(v) {
                discountHash[v.serviceTypeId] = v;
            });

            for(var i=0; i<resList.length; i++){
                var newRow = {};
                var rs = resList[i];
                var id = rs.serviceTypeId;
                resList[i].guestTypeId = guestTypeId;
                if(discountHash && discountHash[id]){
                    var disVal = discountHash[id];
                    resList[i].id = disVal.id;
                    resList[i].packageDiscountRate = disVal.packageDiscountRate;
                    resList[i].itemDiscountRate = disVal.itemDiscountRate;
                    resList[i].partDiscountRate = disVal.partDiscountRate;
                } 
            }

            contentGrid.setData(resList);
        }
    });

});
function setInitData(data)
{
	data = data||{};
	if(data)
	{
        editForm.setData(data);
    }
    guestTypeId = data.id||0;
    loadContent(guestTypeId);
	
}
function loadContent(guestTypeId){
   
    contentGrid.load({
        guestTypeId:guestTypeId,
        token:token
    });
}
var requiredField = {
	name: "客户级别名称"
};
var saveUrl = baseUrl+"com.hsapi.repair.baseData.crud.saveGuestTypeAndDiscount.biz.ext";
function onOk(){
	var data = editForm.getData();
	for(var key in requiredField){
		if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    
    //var addList = contentGrid.getChanges("added");//修改里面没有ID的为新增
    var list = contentGrid.getChanges("modified");
    var addList = [];
    var updateList = [];
    for(var i=0; i<list.length; i++){
        var r = list[i];
        if(r.id){
            updateList.push(r);
        }else{
            addList.push(r);
        }
    }
	
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
	nui.ajax({
        url:saveUrl,
        type : "post",
		data : JSON.stringify({
            data : data,
            addList:addList,
            updateList:updateList,
            token: token
        }),
		success:function(data)
		{
			nui.unmask();
			data = data||{};
			if(data.errCode == "S")
			{
                showMsg("保存成功！","S");
                CloseWindow("ok");
				
			}
			else{
				showMsg(data.errMsg||"保存失败","E");
			}
		},
		error:function(jqXHR, textStatus, errorThrown)
		{
			console.log(jqXHR.responseText);
			nui.unmask();
			showMsg("网络出错", "E");
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