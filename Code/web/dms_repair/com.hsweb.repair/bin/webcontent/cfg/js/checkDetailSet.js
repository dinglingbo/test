/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var contentUrl = baseUrl + "com.hsapi.repair.baseData.query.queryCheckModelDetailContent.biz.ext";
var editForm = null;
var contentGrid = null;
var checkTypeEl = null;

$(document).ready(function(){
    editForm = new nui.Form("#editForm");
    checkTypeEl = nui.get("checkType");
    contentGrid = nui.get("contentGrid");
    contentGrid.setUrl(contentUrl);
    nui.get('checkType').focus();
    contentGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "opt":
                e.cellHtml = //'<span class="icon-remove" onClick="javascript:deletePart()" title="删除行">&nbsp;&nbsp;&nbsp;&nbsp;</span>';/*'<span class="icon-add" onClick="javascript:addPart()" title="添加行">&nbsp;&nbsp;&nbsp;&nbsp;</span>' +
                            '<span class="fa fa-plus" onClick="javascript:addNewRow()" title="添加行">&nbsp;&nbsp;</span>' +
                            ' <span class="fa fa-close" onClick="javascript:deleteRow()" title="删除行"></span>';
                break;
            default:
                break;
        }
    });
    
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
    var dictDefs ={"checkType":"10081"};
    initDicts(dictDefs, null);
});
function initForm(){

}
function setInitData(data)
{
	data = data||{};
	if(data)
	{
        editForm.setData(data);
        nui.get("partNameId").setText(data.partName);
        nui.get("itemNameId").setText(data.itemName);
    }
    var checkId = data.id||0;
    loadContent(checkId);
	
}
function loadContent(checkId){
    if(checkId>0){
        contentGrid.load({
            checkId:checkId,
            token:token
        },function(){
            if(!checkRow()){
                addNewRow();
            }
        });
    }else{
        contentGrid.setData([]);
        addNewRow();
    }
}
var requiredField = {
	checkType: "检查类型",
	checkName: "项目名称"
};
var saveUrl = baseUrl+"com.hsapi.repair.baseData.crud.saveCheckDetail.biz.ext";
function onOk(){
	var data = editForm.getData();
	for(var key in requiredField){
		if(!data[key] || data[key].trim().length==0)
        {
            nui.alert(requiredField[key]+"不能为空");
            return;
        }
    }
    
    var addList = contentGrid.getChanges("added");
    var updateList = contentGrid.getChanges("modified");
    var deleteList = contentGrid.getChanges("removed");
	
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
            deleteList:deleteList,
            token: token
        }),
		success:function(data)
		{
			nui.unmask();
			data = data||{};
			if(data.errCode == "S")
			{	
				parent.parent.showMsg( data.errMsg ||"保存成功!","S");
				CloseWindow("ok");
			}
			else{
				parent.parent.showMsg(data.errMsg ||"保存失败!","E");
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
function addNewRow(){
    var newRow={};
    contentGrid.addRow(newRow);
}
function deleteRow(){
    var row = contentGrid.getSelected();
    if(row){
        contentGrid.removeRow(row);

        if(!checkRow()){
            addNewRow();
        }
    }
}
function checkRow(){
    var data = contentGrid.getData();
    if(data && data.length>0){
        return true;
    }

    return false;
}
function onPartButtonEdit()
{
    nui.open({
//        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.partNameSelect.flow?token="+token,
        title: "配件名称查询",
        width:900, height: 650,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var partName = data.partName;
                nui.get("partNameId").setValue(partName.id);
                nui.get("partNameId").setText(partName.name);
                nui.get("partName").setValue(partName.name);
            }
        }
    });
}
function onItemButtonEdit()
{
    nui.open({
//        // targetWindow: window,
        url: webPath+contextPath+"/repair/DataBase/Item/RepairItemMain.jsp?token="+token,
        title: "项目查询",
        width:1000, height: 650,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {list:[]};
			iframe.contentWindow.setData(data);
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var item = data.item;
                if(item){
                    nui.get("itemNameId").setValue(item.id);
                    nui.get("itemNameId").setText(item.name);
                    nui.get("itemName").setValue(item.name);
                }
            }
        }
    });
}
