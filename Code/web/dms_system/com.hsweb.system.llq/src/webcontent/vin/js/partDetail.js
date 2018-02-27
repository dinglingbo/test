
var dgbasic;
var dgprice;
var dgreplace;
var dgcompt;
var ntab;
var detailCatch = {};

$(document).ready(function(v){
    dgbasic = nui.get("dgbasic");
    dgprice = nui.get("dgprice");
    dgreplace = nui.get("dgreplace");
    dgcompt = nui.get("dgcompt");
    ntab = nui.get("tabs");
});

function changeTabs(e){
    var sender = e. sender;
    var tab = e.tab;
    
    if(tab.name == 'basic'){
        queryBasic();
    }else if(tab.name == 'price'){
        queryPrice();
    }else if(tab.name == 'replace'){
        queryReplace();
    }else if(tab.name == 'article'){
        queryCompt();
    }else if(tab.name == 'compt'){
    }else if(tab.name == 'baseinfo'){
    }else if(tab.name == 'compatible'){
    }
}

/*
*获取基础信息(基础信息, 渠道价格, 替换件, 品牌件, 组件, 技术信息, 适用车型)
*/
function queryBasic(){
    if (!detailCatch['basic']){
        var params = {
            "url":"https://llq.007vin.com/ppypart/partdetail",
            "params":{
                "brand":brand,
                "pid":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setBasic);
    }	
}

function setBasic(data){
    var headname = data.headname;
    var tabs = ntab.getTabs();
    for(var i=0; i<headname.length; i++){
        for(var j=0; j<tabs.length; j++){
            if(tabs[j].title == headname[i]){
                ntab.updateTab(tabs[j], {visible:true});
                break;
            }
        }
    }
    
    var list = processKeyValue(data.headermessage);
    dgbasic.setData(list);
    detailCatch['basic'] = data;
}

/*
*获取价格信息
*/
function queryPrice(){
    if (!detailCatch['price']){
        var params = {
            "url":"https://llq.007vin.com/ppypart/partprice",
            "params":{
                "brand":brand,
                "pid":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setPrice);
    }	
}

function setPrice(data){
    dgprice.setData(data);
    detailCatch['price'] = data;
}

/*
 *产商类型显示
 **/
function onFactoryTypeRender(e) {
    for (var i = 0, l = const_factory_type.length; i < l; i++) {
        var g = const_factory_type[i];
        if (g.value == e.value){
            return g.text;
        }
    }
    return "--";
}

/*
*获取替换件信息
*/
function queryReplace(){
    if (!detailCatch['replace']){
        //https://llq.007vin.com/ppypart/partsreplace
        var params = {
            "url":"https://llq.007vin.com/ppypart/parts_replacement",
            "params":{
                "brand":brand,
                "pid":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setReplace);
    }	
}

function setReplace(data){
    dgreplace.setData(data);
    detailCatch['replace'] = data;
}

/*
*获取组件信息
*/
function queryCompt(){
    if (!detailCatch['compt']){
        var params = {
            "url":"https://llq.007vin.com/ppypart/partscompt",
            "params":{
                "brand":brand,
                "pid":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setCompt);
    }	
}

function setCompt(data){
    var list = processKeyValue(data.headermessage);
    dgcompt.setData(list);
    detailCatch['compt'] = 1;
}