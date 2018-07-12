/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = apiPath + partApi + "/";
var brandUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.queryPartBrandList.biz.ext";
var brandGrid = null;
var FData = [];
$(document).ready(function(v)
{
    brandGrid = nui.get("brandGrid");
    brandGrid.setUrl(brandUrl);

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
var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveOrgPartBrand.biz.ext";
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
                showMsg("保存成功","S");
                CloseWindow("ok");
            }
            else{
                showMsg(data.errMsg||"保存失败","W");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
