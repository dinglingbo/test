/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var wid ="";
$(document).ready(function(v)
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    nui.get('firstChar').focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
});
var requiredField = {
	startIndex:"仓位流水起始号"
};
var saveUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.addStorehouseLocations.biz.ext";
function onOk()
{
    var data = basicInfoForm.getData();
    console.log(data);
    for(var key in requiredField)
    {
        if(!data[key] || data[key].trim().length==0)
        {
            parent.parent.showMsg(requiredField[key]+"不能为空","W");
            return;
        }
    }
    basicInfoForm.validate();
    if (basicInfoForm.isValid() == false)
    {
        var errorTexts = basicInfoForm.getErrorTexts();
        parent.parent.showMsg(errorTexts,"W");
        return;
    }
    var start = parseInt(data.startIndex);
    var end = parseInt(data.endIndex);
    var storeLocations = [];
    for(var i=start;i<=end;i++)
    {
        storeLocations.push({
            storeId:data.storeId,
            firstChar:data.firstChar,
            numId:i,
            name:data.firstChar+"-"+i,
            isDisabled:0
        });
    }
    console.log(storeLocations);
    
    
    
    //return;
    nui.mask({
    	el : document.body,
        cls : 'mini-mask-loading',
        html:'保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            storeLocations:storeLocations,
            wid :wid,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                parent.parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                parent.parent.showMsg(data.errMsg||"保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}


function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}

function onStartIndexChanged()
{
    var value = nui.get("firstChar").getValue()+ "-" + nui.get("startIndex").getValue();
    nui.get("startName").setValue(value);
    console.log(value);
}
function onEndIndexChanged(){
    var value = nui.get("firstChar").getValue()+ "-" + nui.get("endIndex").getValue();
    nui.get("endName").setValue(value);
}
function onFirstCharChanged(){
    var value = "";
    if(nui.get("startIndex").getValue())
    {
        value = nui.get("firstChar").getValue()+ "-" + nui.get("startIndex").getValue();
        nui.get("startName").setValue(value);
    }
    if(nui.get("endIndex").getValue())
    {
        value = nui.get("firstChar").getValue()+ "-" + nui.get("endIndex").getValue();
        nui.get("endName").setValue(value);
    }

}

function setData(data)
{
    if(data.storehouseList)
    {
        var storehouseList = data.storehouseList;
        nui.get("storeId").setData(storehouseList);
    }
    if(data.storehouse)
    {
        basicInfoForm.setData({
            storeId:data.storehouse.id
        });
        if(data.storehouse.cangStoreId){       	
        	wid=data.storehouse.cangStoreId;
        }
    }
}