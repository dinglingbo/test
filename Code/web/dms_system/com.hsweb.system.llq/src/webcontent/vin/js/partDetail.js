
var dgbasic;
var dgprice;
var dgreplace;
var dgarticle;
var dgcompt;
var dgbaseinfo;
var dgcompatible;
var ntab;
var detailCatch = {};

$(document).ready(function(v){
    dgbasic = nui.get("dgbasic");
    dgprice = nui.get("dgprice");
    dgreplace = nui.get("dgreplace");
    dgarticle = nui.get("dgarticle");
    dgcompt = nui.get("dgcompt");
    dgbaseinfo = nui.get("dgbaseinfo");
    dgcompatible = nui.get("dgcompatible");
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
        queryArticle();
    }else if(tab.name == 'compt'){
        queryCompt();
    }else if(tab.name == 'baseinfo'){
        queryBaseinfo();
    }else if(tab.name == 'compatible'){
        queryCompatible();
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
*获取品牌件信息
*/
function queryArticle(){
    if (!detailCatch['article']){
        var params = {
            "url":"https://llq.007vin.com/ppypart/parts_article",
            "params":{
                "brand":brand,
                "pid":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setArticle);
    }	
}

function setArticle(data){
    dgarticle.setData(data);
    detailCatch['article'] = data;
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

/*
*获取技术信息
*/
function queryBaseinfo(){
    if (!detailCatch['baseinfo']){
        var params = {
            "url":"https://llq.007vin.com/ppypart/parts_baseinfo",
            "params":{
                "brand":brand,
                "pid":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setBaseinfo);
    }	
}

function setBaseinfo(data){
    dgbaseinfo.setData(data);
    detailCatch['baseinfo'] = 1;
}

/*
*获取适用车型信息
*/
var compatible_page = 0;
function queryCompatible(page){
    if (!detailCatch['compatible']){
        var params = {
            "url":"https://llq.007vin.com/ppypart/partcompatiblecars",
            "params":{
                "brand":brand,
                "page":compatible_page,
                "pid":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setCompatible);
    }	
}

function setCompatible(data, rs){
    var last = rs.last || 1;
    if(last==0){
        $(".continue").show();
        compatible_page += 1;
    }else{
        compatible_page = 0;
        $(".continue").hide();
    }
    dgcompatible.setData(data);
    detailCatch['compatible'] = 1;
}
