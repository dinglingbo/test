/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + partApi + "/";
var partGridUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
var partCommonGridUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
var partGrid = null;
var partCommonGrid = null;
var conditoinsValueEl = null;
var queryConditionsEl = null;
var conditoinsValueEl = null;
var advancedSearchWin = null;
var advancedSearchForm = null;
var partCodeListEl = null;

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];

var conList = [
    {id:"0",name:"配件编码"},
    {id:"1",name:"配件名称"},
    {id:"2",name:"编码尾号"},
    {id:"3",name:"首字拼音"}
];

$(document).ready(function(v) {
    partGrid = nui.get("partGrid");
    partCommonGrid = nui.get("partCommonGrid");
    conditoinsValueEl = nui.get("conditoinsValue");
    queryConditionsEl = nui.get("queryConditions");
    conditoinsValueEl = nui.get("conditoinsValue");
    advancedSearchWin = nui.get("advancedSearchWin");
    partCodeListEl = nui.get("partCodeList");

    partGrid.setUrl(partGridUrl);
    partCommonGrid.setUrl(partCommonGridUrl);

    queryConditionsEl.setData(conList);

    advancedSearchForm  = new nui.Form("#advancedSearchForm");

    $("#conditoinsValue").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    partGrid.on("selectionchanged",function(e){
        var row = partGrid.getSelected();
        if(row && row.commonId){
            var p = {commonId:row.commonId};
            var page={length:1000,size:1000};
            partCommonGrid.load({
                page:page,
                params:p,
                token:token
            });
        }else{
            partCommonGrid.setData([]);
        }
    });
	
	partGrid.on("drawcell",function(e){
        var row = e.record;
        switch (e.field)
        {
            case "qualityTypeId":
                if(qualityHash[e.value])
                {
                    e.cellHtml = qualityHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "partBrandId":
                if(brandHash[e.value])
                {
                    e.cellHtml = brandHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "code":
                if(row.commonId && row.commonId > 0)
                {
                    e.cellHtml = e.value+"(<a style='color:blue;'>有替换</a>)";
                }
                break;
            default:
                break;
        }
    });
    partCommonGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "qualityTypeId":
                if(qualityHash[e.value])
                {
                    e.cellHtml = qualityHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "partBrandId":
                if(brandHash[e.value])
                {
                    e.cellHtml = brandHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });


	getAllPartBrand(function(data) {
        qualityList = data.quality;
        qualityList.forEach(function(v) {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    // pasteEle.addEventListener("paste", function (e){
    //     if ( !(e.clipboardData && e.clipboardData.items) ) {
    //         return;
    //     }
    // });

    var conValEl= document.getElementById("sd");
    conValEl.addEventListener("paste", function (e){ 
        if ( !(e.clipboardData && e.clipboardData.items) ) {  
            return ; 
        }  
        for (var i = 0, len = e.clipboardData.items.length; i < len; i++) {  
            var item = e.clipboardData.items[i];   
            if (item.kind === "string") {   
                item.getAsString(function (str) {    
                    // str 是获取到的字符串   
                    console.log(str);
                })  
            } else if (item.kind === "file") {   
                var pasteFile = item.getAsFile();   // pasteFile就是获取到的文件  
            } 
        }
    });
});
function addMorePart(){
	advancedSearchForm.setData([]);
	advancedSearchWin.show();

	partCodeListEl.focus();
}
function onSearch() {
	search();
}
function search() {
    var params = {};
    var qCon = queryConditionsEl.getValue();
    var qVal = conditoinsValueEl.getValue();
    if(!qVal){
        nui.alert("请输入查询条件!");
        return;
    }
    if(qCon == 0){
        params.code = qVal.replace(/\s+/g, "");;
    }else if(qCon == 1){
        params.name = qVal.replace(/\s+/g, "");;
    }else if(qCon == 2){
        params.rcode = qVal.replace(/\s+/g, "");;
    }else if(qCon == 3){
        params.namePy = qVal.replace(/\s+/g, "");;
    }else{
        params.code = qVal.replace(/\s+/g, "");;
    }
	doSearch(params);
}
function doSearch(params) {
    params.orgids = currOrgId;
    var page={length:1000,size:1000};
	partGrid.load({
		params : params,
		token : token
	}, function() {
        var row = partGrid.getRow(0);
        if(row && row.commonId){
            var p = {commonId:row.commonId};
            partCommonGrid.load({
                page:page,
                params:p,
                token:token
            });
        }else{
            partCommonGrid.setData([]);
        }
	});
}
function onAdvancedSearchOk() {
    // 配件编码
    var params={};
	if (partCodeListEl.getValue()) {
		var tmpList = partCodeListEl.getValue().split("\n");
		for (i = 0; i < tmpList.length; i++) {
			tmpList[i] = "'" + (tmpList[i]).replace(/\s+/g, "") + "'";
		}
        params.partCodeList = tmpList.join(",");
        
        advancedSearchWin.hide();
	    doSearch(params);
	}
	
}
function onAdvancedSearchCancel(){
	advancedSearchWin.hide();
	advancedSearchForm.setData([]);
}
var setUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.savePartCommon.biz.ext";
function set()
{
    var ret = getSelectInfo();
    var partIds = ret.partIds;
    var commonIds = ret.commonIds;

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : setUrl,
        type : "post",
        data : JSON.stringify({
            partIds : partIds,
            commonIds: commonIds,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                var commonId = data.commonId;
                nui.alert("设置成功!","",function(){
                    var page={length:1000,size:1000};
                    var p = {commonId:commonId};
                    partCommonGrid.load({
                        page:page,
                        params:p,
                        token:token
                    });
                });
                
            } else {
                nui.alert(data.errMsg || "设置失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var unsetUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.cancelPartCommon.biz.ext";
function unset()
{
    var partIds = getCancelPartInfo();
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });

    nui.ajax({
        url : unsetUrl,
        type : "post",
        data : JSON.stringify({
            partIds : partIds,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                var commonId = data.commonId;
                nui.alert("取消成功!","",function(){
                    partCommonGrid.setData([]);
                });
                
            } else {
                nui.alert(data.errMsg || "取消失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
//获取配件ID，配件common_id  
function getSelectInfo(){
    var partIds = "";
    var commonIds = "";
    var partIdsList = [];
    var commonIdsList = [];
    var commonIdsHash = {};
        
    var rows = partGrid.getSelecteds();
    if(rows && rows.length>0){
        for(var i=0; i<rows.length; i++){
            var row = rows[i];
            var partId = row.id;
            var commonId = row.commonId;
            if(!commonId || commonId==0){
                partIdsList.push(partId);
            }else {
                if(!commonIdsHash[commonId] && commonIdsHash[commonId] != 0 && commonId != 0){
                    commonIdsList.push(commonId);
                    commonIdsHash[commonId] = commonId;
                }
            }
        }
    }

    if(partIdsList && partIdsList.length>0){
        partIds = partIdsList.join(",");
    }
    if(commonIdsList && commonIdsList.length>0){
        commonIds = commonIdsList.join(",");
    }

    var ret = {
        partIds: partIds,
        commonIds : commonIds
    };

    return ret;
}

function getCancelPartInfo(){
    var partIds = "";
    var partIdsList = [];
        
    var rows = partGrid.getSelecteds();
    if(rows && rows.length>0){
        for(var i=0; i<rows.length; i++){
            var row = rows[i];
            var partId = row.id;
            if(partId){
                partIdsList.push(partId);
            }
        }
    }

    if(partIdsList && partIdsList.length>0){
        partIds = partIdsList.join(",");
    }

    return partIds;
}