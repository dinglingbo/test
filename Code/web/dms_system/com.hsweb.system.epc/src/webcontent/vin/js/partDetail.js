
var dgbasic;
var dgprice;
var dgreplace;
var dgreplace2;
var dgarticle;
var dgcompt;
var dgbaseinfo;
var dgcompatible;
var dgstock;
var ntab;
var detailCatch = {};
var pids=[];
var pidHash={};
var innnerData=[];
var editFormDetail = null;
var innerPartGrid=null;
var passPart = {};
$(document).ready(function(v){
    dgbasic = nui.get("dgbasic");
    dgprice = nui.get("dgprice");
    dgreplace = nui.get("dgreplace");
    dgreplace2 =nui.get("dgreplace2");
    innerPartGrid = nui.get("innerPartGrid");
    dgarticle = nui.get("dgarticle");
    dgcompt = nui.get("dgcompt");
    dgbaseinfo = nui.get("dgbaseinfo");
    dgcompatible = nui.get("dgcompatible");
    dgstock = nui.get("dgstock");
    ntab = nui.get("tabs");
    editFormDetail = document.getElementById("editFormDetail");
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
    }else if(tab.name == 'stock'){
        queryChainStock();
    }
}

/*
*获取基础信息(基础信息, 渠道价格, 替换件, 品牌件, 组件, 技术信息, 适用车型)
*/
function queryBasic(){
/*    if (!detailCatch['basic']){
        var params = {
            "url": llq_pre_url + "/ppys/partssearchs",//ppypart/parts_baseinfo
            "params":{
                "brand":brand,
                "part":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setBasic);
    }	*/
	setBasic();
}
//原
/*function setBasic(data, json){
    var headname = json.headname;
    var tabs = ntab.getTabs();
    for(var i=0; i<headname.length; i++){
        for(var j=0; j<tabs.length; j++){
            if(tabs[j].title == headname[i]){
                ntab.updateTab(tabs[j], {visible:true});
                break;
            }
        }
    }
    
    //ntab.updateTab(tabs[7], {visible:true});

    var list = json.partdetail;
    data = [];
    for(var i=0; i<list.length; i++){
        var obj = {};
        obj.field1 = list[i].key;
        obj.field2 = list[i].value;
        data.push(obj);
    }
    dgbasic.setData(data);
    detailCatch['basic'] = data;
    
    setBaseinfo(data, json);
}*/
function setBasic(){
    data = [];
    var filed = {
    		field1 : "原厂名",
    		field2 : passPart.label
    };
    data.push(filed);
     filed = {
    		field1 : "原厂OE号",
    		field2 : passPart.pid
    };
    data.push(filed);
    dgbasic.setData(data);
    detailCatch['basic'] = data;  
    //setBaseinfo(data, json);
}

/*
*获取价格信息
*/
function queryPrice(){
    var str = "&brandCode="+passPart.brandCode;
    str = encodeURI(str);
    var params = {
			url:"llq/parts/place/"+passPart.pid,
			params:str,
			token:token
    }
        callAjax(url, params, processAjax, setPrice);
}

function setPrice(data){
    var tData = [];
    for(var i=0; i<data.length; i++){
        data[i].pid=passPart.pid;
    }
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
        var str = "&brandCode="+passPart.brandCode;
        str = encodeURI(str);
        var params = {
    			url:"llq/parts/replace/"+passPart.pid,
    			params:str,
    			token:token
        }
        callAjax(url, params, processAjax, setReplace);
    }	
}

function setReplace(data){
	var direct=[]; //直接替换
	var indirectd=[]; //间接替换
	var arr=[];
	var hash={};
	var inData=[];
	if(data.length<0){
		return;
	}
	for(var i=0;i<data.length;i++){
		data[i].lable='';
		data[i].prices='';
		data[i].ptype='';
		data[i].brandcn='';
		
		if(data[i].isRe==1){
			direct.push(data[i]);
		}else{
			indirectd.push(data[i]);
		}
		
		if(data[i].pid.length>1){
			innnerData[data[i].parentnum]=data[i].pid;

		}

		for(var j=0;j<data[i].pid.length;j++){
			arr.push(data[i].pid[j]);
		}

		
	}
	for(var k=0;k<arr.length;k++){
		if(!hash[arr[k].pid]){
			pids.push(arr[k]);
			hash[arr[k].pid]=true;
		}
	}
	
	pids.forEach(function(v){
		pidHash[v.pid]=v;
	});
    dgreplace.setData(direct);
    dgreplace2.setData(indirectd);
    detailCatch['replace'] = data;
    console.log(pids);
//    console.log(pidHash);
}

/*
*获取品牌件信息
*/
function queryArticle(){
    if (!detailCatch['article']){
        var params = {
            "url": llq_pre_url + "/ppypart/parts_article",
            "params":{
                "brand":brand,
                "part":pid
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
            "url": llq_pre_url + "/ppypart/partscompt",
            "params":{
                "brand":brand,
                "part":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setCompt);
    }	
}

function setCompt(data){
    dgcompt.setData(data);
    detailCatch['compt'] = 1;
}

/*
*获取技术信息
*/
function queryBaseinfo(){
    if (!detailCatch['baseinfo']){
        var params = {
            "url": llq_pre_url + "/ppypart/parts_baseinfo",
            "params":{
                "brand":brand,
                "part":pid
            },
            "token": token
        }
        callAjax(url, params, processAjax, setBaseinfo);
    }	
}

function setBaseinfo(data, rs){
    var list = processKeyValue(rs.showmessage);
    dgbaseinfo.setData(list);
    detailCatch['baseinfo'] = 1;
}

/*
*获取适用车型信息
*/
var compatible_page = 0;
function queryCompatible(page){
    if (!detailCatch['compatible']){
        var str = "";
        str = encodeURI(str);
        var params = {
    			url:"llq/parts/car_model/"+passPart.pid,
    			params:str,
    			token:token
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

/*
*获取库存分布信息
*/
function queryChainStock(){
    if (!detailCatch['stock']){
        var params = {
            "params":{
                "partCode":pid
            },
            "token": token
        }
        callAjax(apiPath + cloudPartApi + "/com.hsapi.cloud.part.common.svr.queryChainStock.biz.ext", params, processAjax, setChainStock);
    }   
}

function setChainStock(data){
    dgstock.setData(data);
    detailCatch['stock'] = 1;
}

function onDeReplaceDraw(e){
	var field = e.field;
	var parentnum=e.record.parentNum;
	if(!pidHash[parentnum]){
		return;
	}
	if(e.field=='lable'){
		e.cellHtml = pidHash[parentnum].lable || "";
	}
	if(e.field=='prices'){
		e.cellHtml = pidHash[parentnum].prices || "";
	}
	if(e.field=='ptype'){
		e.cellHtml = pidHash[parentnum].ptype || "";
	}
	if(e.field=='brandcn'){
		e.cellHtml = pidHash[parentnum].brandcn || "";
	}
}

function onShowRowDetail(e) {
    var row = e.record;
    var parentnum=row.parentnum;
    //将editForm元素，加入行详细单元格内
 
    if(!innnerData[parentnum]){
    	innerPartGrid.setData([]);
    }else{
    	var td = dgreplace.getRowDetailCellEl(row);
    	td.appendChild(editFormDetail);
    	editFormDetail.style.display = "";
    	innerPartGrid.setData(innnerData[parentnum]);
    }
    
}

function onShowRowDetail2(e) {
    var row = e.record;
    var parentnum=row.parentnum;  
    //将editForm元素，加入行详细单元格内

    if(!innnerData[parentnum]){
    	innerPartGrid.setData([]);
    }else{
        var td = dgreplace2.getRowDetailCellEl(row);
        td.appendChild(editFormDetail);
        editFormDetail.style.display = "";
    	innerPartGrid.setData(innnerData[parentnum]);
    }
}

function setData(row){
	passPart = row;
	queryBasic();
}