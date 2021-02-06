/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";
var partGridUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
var partCommonGridUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
var partGrid = null;
var partSGrid = null;
var partCommonGrid = null;
var conditoinsValueEl = null;
var queryConditionsEl = null;
var conditoinsValueEl = null;
var advancedSearchWin = null;
var advancedSearchForm = null;
var partCodeListEl = null;
var queryConditionsMEl = null;
var conditoinsValueMEl = null;

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
    partSGrid = nui.get("partSGrid");
    partCommonGrid = nui.get("partCommonGrid");
    conditoinsValueEl = nui.get("conditoinsValue");
    queryConditionsEl = nui.get("queryConditions");
    conditoinsValueEl = nui.get("conditoinsValue");
    advancedSearchWin = nui.get("advancedSearchWin");
    partCodeListEl = nui.get("partCodeList");
    queryConditionsMEl = nui.get("queryConditionsM");
    conditoinsValueMEl = nui.get("conditoinsValueM");

    partGrid.setUrl(partGridUrl);
    partCommonGrid.setUrl(partCommonGridUrl);
    partSGrid.setUrl(partGridUrl);

    queryConditionsMEl.setData(conList);
    queryConditionsEl.setData(conList);

    advancedSearchForm  = new nui.Form("#advancedSearchForm");

    $("#conditoinsValue").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    $("#conditoinsValueM").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onMSearch();
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
//                      e.cellHtml = brandHash[e.value].name||"";
                  	if(brandHash[e.value].imageUrl){
                  		
                  		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
                  	}else{
                  		e.cellHtml = brandHash[e.value].name||"";
                  	}
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
    partSGrid.on("drawcell",function(e){
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
//                      e.cellHtml = brandHash[e.value].name||"";
                  	if(brandHash[e.value].imageUrl){
                  		
                  		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
                  	}else{
                  		e.cellHtml = brandHash[e.value].name||"";
                  	}
                  }
                  else{
                      e.cellHtml = "";
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
//                      e.cellHtml = brandHash[e.value].name||"";
                  	if(brandHash[e.value].imageUrl){
                  		
                  		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
                  	}else{
                  		e.cellHtml = brandHash[e.value].name||"";
                  	}
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

});
function addMorePart(){
	advancedSearchForm.setData([]);
	advancedSearchWin.show();

	partCodeListEl.focus();
}
function onMSearch() {
	msearch();
}
function msearch() {
    var params = {};
    var qCon = queryConditionsMEl.getValue();
    var qVal = conditoinsValueMEl.getValue();
    if(!qVal){
        showMsg("请输入查询条件!","W");
        return;
    }
    if(qCon == 0){
        params.code = qVal.replace(/(^\s*)|(\s*$)/g, "");
    }else if(qCon == 1){
        params.name = qVal.replace(/\s+/g, "");
    }else if(qCon == 2){
        params.rcode = qVal.replace(/\s+/g, "");
    }else if(qCon == 3){
        params.namePy = qVal.replace(/\s+/g, "");
    }else{
        params.code = qVal.replace(/\s+/g, "");
    }
	doMSearch(params);
}
function doMSearch(params) {
    params.tenantId = currTenantId;
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
	    doSSearch(params);
	}else{
        showMsg("请输入编码!","W");
    }
	
}
function onAdvancedSearchCancel(){
	advancedSearchWin.hide();
	advancedSearchForm.setData([]);
}
var setUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.savePartCommon.biz.ext";
function set()
{
    var row = partGrid.getSelected();
    if(!row){
        showMsg('请选择需要设置替换的配件!','W');
        return;
    }
    var ret = getSelectInfo();
    var partIds = ret.partIds;
    var commonIds = ret.commonIds;
    if(!partIds && !commonIds){
        showMsg('请选择替换配件!','W');
        return;
    }

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
                showMsg('设置成功!','S');
                var newRow = {commonId: commonId};
                partGrid.updateRow(row, newRow);
                var page={length:1000,size:1000};
                var p = {commonId:commonId};
                partCommonGrid.load({
                    page:page,
                    params:p,
                    token:token
                });
            } else {
                showMsg(data.errMsg || "设置失败!",'E');
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var unsetUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.cancelPartCommon.biz.ext";
function unset()
{
    var partIds = getCancelPartInfo();
    if(!partIds){
        showMsg('请选择待取消信息!','W');
        return;
    }
    var rows = partCommonGrid.getSelecteds();
    var commonId = rows[0].commonId||-1;
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
                showMsg('取消成功!','S');
                var page={length:1000,size:1000};
                var p = {commonId:commonId};
                partCommonGrid.load({
                    page:page,
                    params:p,
                    token:token
                });
                
            } else {
                showMsg(data.errMsg || "取消失败!",'E');
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
        
    var rows = partSGrid.getSelecteds();
    if(rows && rows.length>0){

        var mrow = partGrid.getSelected();
        var mpartId = mrow.id;
        var mcommonId = mrow.commonId;
        if(!mcommonId || mcommonId==0){
            partIdsList.push(mpartId);
        }else {
            if(!commonIdsHash[mcommonId] && commonIdsHash[mcommonId] != 0 && mcommonId != 0){
                commonIdsList.push(mcommonId);
                commonIdsHash[mcommonId] = mcommonId;
            }
        }

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
        
    var rows = partCommonGrid.getSelecteds();
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
function onSSearch() {
	ssearch();
}
function ssearch() {
    var params = {};
    var qCon = queryConditionsEl.getValue();
    var qVal = conditoinsValueEl.getValue();
    if(!qVal){
        showMsg("请输入查询条件!","W");
        return;
    }
    if(qCon == 0){
        params.code = qVal.replace(/(^\s*)|(\s*$)/g, "");
    }else if(qCon == 1){
        params.name = qVal.replace(/\s+/g, "");
    }else if(qCon == 2){
        params.rcode = qVal.replace(/\s+/g, "");
    }else if(qCon == 3){
        params.namePy = qVal.replace(/\s+/g, "");
    }else{
        params.code = qVal.replace(/\s+/g, "");
    }
	doSSearch(params);
}
function doSSearch(params) {
	params.tenantId = currTenantId;
    var page={length:1000,size:1000};
	partSGrid.load({
		params : params,
		token : token
	});
}
function importPart(){
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.importPartCommon.flow?token="+token,
        title: "配件替换关系导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {};
        },
        ondestroy: function (action)
        {
            rightPartGrid.reload();
        }
    });
}