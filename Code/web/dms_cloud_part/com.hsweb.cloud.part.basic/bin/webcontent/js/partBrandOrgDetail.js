/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + cloudPartApi + "/";
var brandUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.queryPartBrandList.biz.ext";
var brandGrid = null;
var FData = [];
$(document).ready(function(v)
{
    brandGrid = nui.get("brandGrid");
    brandGrid.setUrl(brandUrl);
    nui.get("saveBtn").focus();
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }

    brandGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "isDisabled":
                e.cellHtml = e.value==1?"禁用":"启用";
                break;
            default:
                break;
        }
    });

    brandGrid.on("preload",function(e){
        var data = e.result.brands;
        var rows = [];
        if(FData && FData.length>0){
            for(var i=0; i<FData.length; i++){
                var brandId = FData[i].id;
                for(var j=0; j<data.length; j++){
                    if(data[j].id == brandId){
                        rows.push(data[j]);
                        data[j].del = 1;
                    }
                }
            }
        }


    });
    
    brandGrid.on("rowdblclick",function(){
    	save();
    });

});
function setInitData(data)
{
    load();
    FData = data;
    
}
function load(){
    brandGrid.load({
        parentId:-1,
        isDisabled:0,
        token:token
    },function(){
        var rows = brandGrid.findRows(function(row){
            if(row && row.del) return true;
        });
        if(rows && rows.length>0){
            brandGrid.removeRows(rows);
        } 
    });


}
var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveOrgPartBrand.biz.ext";
function save()
{
    var data = brandGrid.getSelecteds();
    if(!data || data.length<=0) return;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            addList:data,
            token:token
        }),
        success:function(rs)
        {
            nui.unmask();
            rs = rs||{};
            if(rs.errCode == "S")
            {
                parent.showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                parent.showMsg(data.errMsg||"保存失败","E");
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
