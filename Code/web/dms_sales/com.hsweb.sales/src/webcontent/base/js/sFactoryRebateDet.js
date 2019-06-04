var saveUrl = apiPath + saleApi + "/sales.base.addCssFactoryRebate.biz.ext";
var gUrl = apiPath + saleApi + "/sales.base.searchCsbRebate.biz.ext?params/isDisabled=0&token="+token;
var form = null;
var mainData = null;
$(document).ready(function() {
    form = new nui.Form("form1"); 


    
    initData();
})

function initData() {
    initMember("operator", function () { });
    nui.get("rebateId").setUrl(gUrl);
    var params = {
        isDisabled: 0
    }
    // nui.ajax({
    //     url:saveUrl,
    //     type:'post',
    //     data:{
    //         params:params
    //     },
    //     success:function(res){
    //         if(res.errCode == 'S'){
    //             nui.get("rebateId").setData(res.list);
    //         }
    //     }
    // })
}

function SetData(row) {
    mainData = row;
    form.setData(row);
}


function save() {
    var data = form.getData(true);

    nui.ajax({
        url:saveUrl,
        type:'post',
        data:{
            data:data
        },
        success:function(res){
            if(res.errCode == 'S'){
                showMsg('保存成功','S');
            }else{
                showMsg('保存失败','E');
            }
            CloseWindow("ok");
        }
    })
}