/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGridStockUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.queryPartListStock.biz.ext";
var partGrid = null;
//var stockUrl = baseUrl+"com.hsapi.part.invoice.partInterface.queryStockByCode.biz.ext";
var stockUrl = baseUrl + "com.hsapi.part.invoice.query.queryInventoryAccessPart.biz.ext";
var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var carBrandList = [];
var chooseType = null;
var codeEl = null;
var tempGrid = null;
var rightGrid = null;
var protoken = "";
var qtySign = null;
var isChooseClose = 1;//默认选择后就关闭窗体
var queryForm = null;

var statusList = [{id:"0",name:"品牌车型"},{id:"1",name:"拼音"},{id:"2",name:"规格"}];

$(document).ready(function(v)
{
    queryForm = new nui.Form("#queryForm");
    partGrid = nui.get("partGrid");
    qtySign = nui.get("qtySign");
    tempGrid=nui.get("tempGrid");
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(stockUrl);
    codeEl = nui.get("search-code");
    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partGrid.on("selectionchanged", function () {
        var row = partGrid.getSelected();
        var code = row.code;
        var codeM = row.oemCode;
        var params = {};
        if(code){
        	params.partCode = code;
        }else{
        	params.partCode = codeM;
        }
        rightGrid.load({
        	params:params,
        	token: token
        });
    });
    partGrid.on("drawcell",function(e)
    {
    	var record = e.record;
    	var uid = record._uid;
        if(!partTypeHash)
        {
            partTypeHash = {};
            var partTypeList = tree.getList();
            partTypeList.forEach(function(v)
            {
                partTypeHash[v.id] = v;
            });
        }
        var field = e.field;
        if("isUniform" == field)
        {
            e.cellHtml = e.value == 1?"是":"否";
        }
        else if("isDisabled" == field)
        {
            e.cellHtml = e.value == 1?"失效":"有效";
        }
        else if("carTypeIdF" == field || "carTypeIdS" == field || "carTypeIdT" == field)
        {
            if(partTypeHash && partTypeHash[e.value])
            {
                e.cellHtml = partTypeHash[e.value].name||"";
            }
        }
        else if("qualityTypeId" == field)
        {
            if(qualityHash[e.value])
            {
                e.cellHtml = qualityHash[e.value].name||"";
            }
        }
        else if("partBrandId" == field)
        {
        	 if(brandHash[e.value])
             {
//                 e.cellHtml = brandHash[e.value].name||"";
             	if(brandHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
             	}else{
             		e.cellHtml = brandHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
             }
 
        }else if(field == "code"){
                //e.cellHtml = '<a href="javascript:choosePart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;配件</a>' +'<a href="javascript:showBasicDataPart(\'' + uid + '\')" class="chooseClass" ><span class="fa fa-plus"></span>&nbsp;标准配件</a>'+ e.value;
            
                //e.cellHtml = e.value + '</br><a href="javascript:showMorePart(\'' + uid + '\')" class="chooseClass" >询价</a>&nbsp;<a href="javascript:showMorePart(\'' + uid + '\')" class="chooseClass" >采购</a>';	
                			 //'<ul class="add_ul" style="z-index: 99; display: none;">' +
		            		 //'<li>< a href="javascript:choosePart(\'' + uid + '\')">添加配件</ a></li>' +
		            		 //'<li>< a href="javascript:showBasicDataPart(\'' + uid + '\')" class="xzpj">选择配件</ a></li>' +
                             //'</ul>';
        }
        else{
            onDrawCell(e);
        }
    });
    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    tree.load({token:token});
//    tree.on("beforeload",function(e){
//        e.data.token = token;
//    });
    //console.log("xxx");

    getAllPartBrand(function(data)
    {
        data = data||{};
        qualityList = data.quality;
        qualityList.forEach(function(v)
        {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v)
        {
            brandHash[v.id] = v;
        });
        
        
        initPartBrand("partBrandId",function(){
            initDicts({

            },function(){

            });
        });
        initCarBrand("applyCarBrandId",function(){
            initDicts({
                unit:UNIT,// --单位
                abcType:ABC_TYPE // --ABC分类
            },function(){
                //onSearch();
            });
        });
    });

    codeEl.focus();
    
    //protoken = getProToken();

    $("#search-code").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#search-name").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#search-applyCarModel").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#search-namePy").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    $("#search-spec").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    
	tempGrid.on("cellclick",function(e){ 
		var field=e.field;
		var row = e.row;
        if(field=="check" ){
            //if(e.row.check==1){
			//}else{}
			//删除所选记录
			delcallback && delcallback(row,function(){
				tempGrid.removeRow(row);
			});
			tempGrid.removeRow(row);
        }
    });
	
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;

        switch(keyCode){
            case 27:
            window.CloseOwnerWindow("");
            break; 
        }

        /*if((keyCode==83)&&(event.shiftKey))  {  
            onOk();  
        } 

        if((keyCode==67)&&(event.shiftKey))  { 
            onCancel();
        }  */
    }

});
function onDrawNode(e)
{
    var node = e.node;
    e.nodeHtml = node.code + " " + node.name;
}
function onNodeDblClick(e)
{
    var currTree = e.sender;
    var currNode = e.node;
    var level = currTree.getLevel(currNode);
    var list = [];
    var tmpNode = currNode;
    do{
        list[level] = tmpNode.id;
        tmpNode = currTree.getParentNode(tmpNode);
        level = currTree.getLevel(tmpNode);
    }while(tmpNode&&tmpNode.id);

    var cartypef = list[0]||"";
    var cartypes = list[1]||"";
    var cartypet = list[2]||"";

    var partName = {
        carTypeIdF:cartypef,
        carTypeIdS:cartypes,
        carTypeIdT:cartypet
    };
    
    var params = getSearchParams();
    for(var key in params){
    	partName[key]=params[key];
    }
    
    doSearch(partName);
}
var partTypeHash = null;


function reloadData()
{
    if(partGrid)
    {
        partGrid.reload();
    }
}
function getSearchParams()
{
    var params = queryForm.getData();
    params.code = (params.code||"").replace(/\s+/g, "");
    params.name = (params.name||"").replace(/\s+/g, "");
   /* params.applyCarModel = (params.applyCarModel||"").replace(/\s+/g, "");
    params.namePy = (params.namePy||"").replace(/\s+/g, "");
    params.spec = (params.spec||"").replace(/\s+/g, "");*/
    
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.applyCarModel = (typeValue ||"").replace(/\s+/g, "");
    }else if(type==1){
        params.namePy = (typeValue||"").replace(/\s+/g, "");
    }else if(type==2){
    	params.spec = (typeValue||"").replace(/\s+/g, "");
    }
    return params;
}
function onSearch()
{
    var params = getSearchParams();
    doSearch(params);
}
function doSearch(params)
{
	params.sortOrder = "ASC";
    params.sortField = "is_host";
    if(params.namePy)
    {
        params.namePy = params.namePy.toUpperCase();
    }
    /*显示0库存*/
    if(qtySign.checked){
    	partGrid.setUrl(partGridUrl);
    }else{
    	partGrid.setUrl(partGridStockUrl);
    	
    }
    partGrid.load({
        params:params,
        token:token
    });
}

function addPart(){
    addOrEditPart();
}
function editPart(){
    var row = partGrid.getSelected();
    if(row)
    {
        addOrEditPart(row);
    }

}
function addOrEditPart(row)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 480, height: 330,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var carBrandList = nui.get("applyCarBrandId").getData();
            var params = {
                qualityTypeIdList:qualityList,
                partBrandIdList:brandList,
                unitList:unitList,
                abcTypeList:abcTypeList,
                applyCarModelList:carBrandList
            };
            if(row)
            {
                params.partData = row;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                partGrid.reload();
            }
        }
    });
}

var resultData = {};
var callback = null;

function onOk()
{	
	if(nui.get("bxMsg").value){
		var row = partGrid.getSelected();
		if(row){
			CloseWindow("ok");
		}else{
			showMsg("暂无选中数据","W");
			return;
		}
	}else{
		if($('#splitDiv').css('display')=='none'){
			onCommon();
		}
		else if($('#splitDiv').css('display')=='block'){
			onOrder();
		}
	}
}
function getData(){
    return resultData;
}
function setData(data,ck)
{	
	
	data = data||{};
	if(data){
		nui.get("bxMsg").setValue(data.bxMsg);
	}
	list = data.list||[];
    callback = ck;
}
var checkcallback = null;
function setCloudPartData(type,ck,cck){
    chooseType = type;
    callback = ck;
    checkcallback = cck;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
//function onRowDblClick()
//{
//    onOk();
//}

//用作常用
function onCommon()
{
    var node = partGrid.getSelected();
    var nodec = nui.clone(node);

    if(!nodec)
    {
        return;
    }

    if(chooseType && chooseType == "cloudPart"){
        resultData = {
            part:nodec
        };
        if(!callback)
        {
            CloseWindow("ok");
        }
        else{
            //需要判断是否已经添加了此配件??
            var checkMsg = checkcallback(resultData);
            if(checkMsg) 
            {
                nui.confirm(checkMsg, "友情提示",
                    function (action) { 
                        if (action == "ok") {
                            callback(resultData);
                        }else {
                            return;
                        }
                    }
                );
            }else
            {
                //弹出数量，单价和金额的编辑界面
                callback(resultData);
            }

        }
    }else{
        var tmp = list.filter(function(v){
            return v.partId == nodec.id;
        });
        if(tmp && tmp.length>0)
        {
            showMsg("此配件已在明细中，不能重复选择","W");
            return;
        }
        resultData = {
            part:nodec
        };
        if(!callback)
        {
            CloseWindow("ok");
        }
        else{
            callback(resultData);
        }
    }
    

}
//用作工单
function onOrder()
{
	if(nui.get("state").value){
		CloseWindow("ok");
	}else{
		var row = partGrid.getSelected();
		row.billItemId = itemId;
		if(row)
		{
			if(ckcallback){
				var rs = ckcallback(row);
				if(rs){
					showMsg("此配件已添加,请返回查看!","W");
					return;
				}else{
					if(callback){
						nui.mask({
							el: document.body,
							cls: 'mini-mask-loading',
							html: '处理中...'
						});

						callback(row,function(data){
							if(data){
								data.check = 1;
								tempGrid.addRow(data);
							}
						},function(){
							nui.unmask(document.body);
						});
					}
				}
			}else{
				if(callback){
					nui.mask({
						el: document.body,
						cls: 'mini-mask-loading',
						html: '处理中...'
					});
					callback(row,function(data){
						if(data){
							data.check = 1;
							tempGrid.addRow(data);
						}
					},function(){
						nui.unmask(document.body);
					});
				}
			}
			resultData.part = row;
			if(isChooseClose == 1){
				CloseWindow("ok");
			}
		}
		else{
			showMsg("请选择一个配件", "W");
		}
	}
}

var callback = null;
var delcallback = null;
var ckcallback = null;
var itemId = null;
//用于工单添加配件时
function setViewData(tId,ck, delck, cck){
	//ck 保存数据 delck 删除数据 cck 判断数据
	isChooseClose = 0;
	itemId = tId;
	callback = ck;
	delcallback = delck;
	ckcallback = cck;
	partGrid.setWidth("70%");
	tempGrid.setStyle("display:inline");
	document.getElementById("splitDiv").style.display="";
}

function setCkcallback(ck){
	isChooseClose = 1;
	ckcallback = ck;
}

function getDataAll(){
	var row = partGrid.getSelecteds();
	return row;
}

function setValueData(){
	nui.get("state").setValue(6);
	partGrid.showColumn("checkcolumn");
}

function getProToken(){
	var systoken = "";
    nui.ajax({
        url : webPath + contextPath + "/com.hs.common.sysService.srmAuthPro.biz.ext",
        type : "post",
        async: false,
        data : {
        },
        success : function(data) {
            var errCode = data.errCode;
            if(errCode == "S"){
            	systoken = data.systoken;
            }else {
            	systoken = "";
            }
            
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
    return systoken;
}

function BXselectPart(){
	var row = partGrid.getSelected();
	return row;
}