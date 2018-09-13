/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getPartTypeTree.biz.ext";
var partGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.queryPartList.biz.ext";
var partGrid = null;

var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var abcTypeList = [];
var carBrandList = [];
var chooseType = null;
var codeEl = null;
var tempGrid=null;

var isChooseClose = 1;//默认选择后就关闭窗体

var queryForm = null;
$(document).ready(function(v)
{
    queryForm = new nui.Form("#queryForm");
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
    tempGrid=nui.get("tempGrid");
    codeEl = nui.get("search-code");
    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partGrid.on("drawcell",function(e)
    {
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
                e.cellHtml = brandHash[e.value].name||"";
            }
        }
        else{
            onDrawCell(e);
        }
    });
    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    tree.on("beforeload",function(e){
        e.data.token = token;
    });
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
    
    partGrid.on("rowdblclick",function(e){
		onOk();
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
    params.applyCarModel = (params.applyCarModel||"").replace(/\s+/g, "");
    params.namePy = (params.namePy||"").replace(/\s+/g, "");
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
        targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 740, height: 250,
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
var delcallback = null;
var ckcallback = null;
//用于工单添加配件时
function setViewData(ck, delck, cck){
	//ck 保存数据 delck 删除数据 cck 判断数据
	isChooseClose = 0;
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

function onOk()
{
	var row = partGrid.getSelected();
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
					})
				}
			}
		}else{
			if(callback){
				callback(row,function(data){
					if(data){
						data.check = 1;
						tempGrid.addRow(data);
					}
				})
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

function getData(){
    return resultData;
}
function setData(data,ck)
{
	data = data||{};
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