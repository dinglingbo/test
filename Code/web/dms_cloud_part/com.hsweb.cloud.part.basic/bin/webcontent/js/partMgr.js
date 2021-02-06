/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var partListUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.queryPartListByOrgid.biz.ext";
var partGrid = null;
var partLoalGrid = null;
var tree = null;
var treeUrl = baseUrl+"com.hsapi.cloud.part.common.svr.getPartTypeTree.biz.ext";
var statusList = [{id:"0",name:"编码"},{id:"1",name:"名称"},{id:"2",name:"车型"},{id:"3",name:"拼音"}];
var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var orgBrandList = [];
var orgBrandHash = {};
var unitList = [];
var abcTypeList = [];
var carBrandList = [];
var queryForm = null;
var mainTabs = null;
$(document).ready(function() {
    queryForm = new nui.Form("#queryForm");
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partListUrl);
    partLoalGrid = nui.get("partLoalGrid");
    partLoalGrid.setUrl(partListUrl);
    mainTabs = nui.get("mainTabs");
    partLoalGrid.load({
        params:{
        	orgid:currOrgId
        },
        token:token
    }); 
    partGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partGrid.on("load", function() {
        onPartGridRowClick({});
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
//                e.cellHtml = brandHash[e.value].name||"";
            	if(brandHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
            	}else{
            		e.cellHtml = brandHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
        }
        else{
            onDrawCell(e);
        }
    });
    partLoalGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    partLoalGrid.on("load", function() {
        onPartGridRowClick({});
    });
    partLoalGrid.on("drawcell",function(e)
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
//                e.cellHtml = brandHash[e.value].name||"";
            	if(brandHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
            	}else{
            		e.cellHtml = brandHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
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
    // console.log("xxx");

    getAllPartBrand(function(data) {
        qualityList = data.quality;
        qualityList.forEach(function(v) {
            qualityHash[v.id] = v;
        });
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
        
        nui.get("partBrandId").setData(brandList);

        initCarBrand("applyCarBrandId",function(){
            initDicts({
                //unit:UNIT,// --单位
                //abcType:ABC_TYPE // --ABC分类
                orgCarBrandId: "10444"
            },function(){
            	orgBrandList = nui.get("orgCarBrandId").getData();
            	orgBrandList.forEach(function(v) {
            		orgBrandHash[v.customid] = v;
                });
                onSearch();
            });
        });
    });

/*    $("#search-code").bind("keydown", function (e) {
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
    });*/
    $("#applyCarBrandId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    //开启APP
    if(currIsOpenApp ==1){
    	nui.get('syncCangBtn').setVisible(true);
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

    var params = {
        carTypeIdF:cartypef,
        carTypeIdS:cartypes,
        carTypeIdT:cartypet
    };
    doSearch(params);
}
var partTypeHash = null;


function reloadData()
{
    if(partGrid)
    {
        partGrid.reload();
    }
    var tab = mainTabs.getActiveTab();
    if(tab.name == "main"){
        if(partGrid)
        {
            partGrid.reload();
        }
    }else if(tab.name == "local"){
        if(partLoalGrid)
        {
            partLoalGrid.reload();
        } 
    }
}
function getSearchParams()
{
    var params = queryForm.getData();
    var type = nui.get("search-type").getValue().replace(/\s+/g, "");
    var typeValue = nui.get("carNo-search").getValue().replace(/\s+/g, "");
    if(type==0){
    	params.code = typeValue;
    }else if(type==1){
    	params.name = typeValue;
    }else if(type==2){
    	params.applyCarModel = typeValue;
    }else if(type==3){
    	params.namePy = typeValue;
    }
    if(params.showDisabled == 0)
    {
        params.isDisabled = 0;
    }
    params.partBrandId = nui.get("partBrandId").getValue();
    params.partId = nui.get("partId-search").getValue();
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
    params.sortField = "id";
    if(params.namePy)
    {
        params.namePy = params.namePy.toUpperCase();
    }
    var tab = mainTabs.getActiveTab();
    if(tab.name == "main"){
        params.orgid = 0;
        partGrid.load({
            params:params
        });  
    }else if(tab.name == "local"){
        params.tenantId = currTenantId;
        partLoalGrid.load({
            params:params,
            token:token
        });  
    }



}
function addPart(){
    addOrEditPart();
}
function editPart(){
	var index = mainTabs.activeIndex;
	var row = {};
	if(index==0){
		row = partLoalGrid.getSelected();
		//本地可修改
		addOrEditPart(row);
	}else {
		//云配件不可修改
		row = partGrid.getSelected();
		return;
	}

}
function onPartGridRowDblClick(){
    editPart();
}
function addOrEditPart(row)
{
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.basic.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 470, height: 450,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var carBrandList = nui.get("applyCarBrandId").getData();
            var orgBrandList = nui.get("orgCarBrandId").getData();
            var params = {
                qualityTypeIdList:qualityList,
                partBrandIdList:brandList,
                unitList:unitList,
                abcTypeList:abcTypeList,
                applyCarModelList:carBrandList,
                orgBrandList:orgBrandList
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
                reloadData();
            }
        }
    });
}
function onPartGridRowClick(e)
{
    var row = e.record||partGrid.getSelected();
    if(!row)
    {
        return;
    }
    if(row.isDisabled == 1)
    {
        nui.get("disableBtn").hide();
        nui.get("enableBtn").show();
    }
    else{
        nui.get("enableBtn").hide();
        nui.get("disableBtn").show();
    }
    if(row.orgid != currOrgid)
    {
        nui.get("editBtn").disable();
        nui.get("disableBtn").disable();
        nui.get("enableBtn").disable();
    }
    else{
        nui.get("editBtn").enable();
        nui.get("disableBtn").enable();
        nui.get("enableBtn").enable();
    }
}
function disablePart()
{
	var cangHash={};
    var row = partLoalGrid.getSelected();
    if(!row)
    {
        showMsg("请选择要禁用的配件","W");
        return;
    }
    if(currAgencyId>0 && currIsOpenApp ==1){
    	cangHash.agency_id = currAgencyId;
    	cangHash.part_id = row.cangPartId;
    	cangHash.status =0;
    }
    savePart({
        id:row.id,
        code:row.code,
        partBrandId:row.partBrandId,
        isDisabled:1
    },cangHash,"禁用成功","禁用失败");
}
function enablePart()
{
	var cangHash={};
    var row = partLoalGrid.getSelected();
    console.log(row);
    if(!row)
    {
        showMsg("请选择要启用的配件","W");
        return;
    }
    if(currAgencyId>0 && currIsOpenApp ==1){
    	cangHash.agency_id = currAgencyId;
    	cangHash.part_id = row.cangPartId;
    	cangHash.status =1;
    }
    savePart({
        id:row.id,
        code:row.code,
        partBrandId:row.partBrandId,
        isDisabled:0
    },cangHash,"启用成功","启用失败");
}
var saveUrl = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.savePart.biz.ext";
function savePart(part,cangHash,successTip,errorTip)
{
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : "处理中..."
	});
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            part:part,
            cangHash :cangHash,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
            	nui.unmask();
                showMsg(successTip||"保存成功","S");
                reloadData();
            }
            else{
            	nui.unmask();
                showMsg(data.errMsg||errorTip||"保存失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
        	nui.unmask();
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function importGuest(){
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.importPart.flow?token="+token,
        title: "配件导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var carBrandList = nui.get("applyCarBrandId").getData();
            var orgBrandList = nui.get("orgCarBrandId").getData();
            iframe.contentWindow.initData({
            	qualityTypeIdList:qualityList,
                partBrandIdList:brandList,
                carBrandList: carBrandList,
                orgBrandList:orgBrandList
            });
        },
        ondestroy: function (action)
        {
            onSearch();
        }
    });
}

function onNoShow(e){
	var row = e.record||partGrid.getSelected();
    if(!row)
    {
        return;
    }
    nui.get("editBtn").disable();
    nui.get("disableBtn").disable();
    nui.get("enableBtn").disable();
}
function onDrawCell(e){
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
//            e.cellHtml = brandHash[e.value].name||"";
        	if(brandHash[e.value].imageUrl){
        		
        		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
        	}else{
        		e.cellHtml = brandHash[e.value].name||"";
        	}
        }
        else{
            e.cellHtml = "";
        }
    }
    else if("orgCarBrandId" == field)
    {
        if(orgBrandHash[e.value])
        {
            e.cellHtml = orgBrandHash[e.value].name||"";
        }
        else{
            e.cellHtml = "";
        }
    }
}

//查询未同步的配件
function getNoSync(params){
	var params ={};
	params.orgid=currOrgid;
	params.noPage=1;
	params.noCangPartId=1;
	var partInfosList=[];
	var partList=[];
	var partinfos ="";
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : "同步中..."
	});
    nui.ajax({
        url:partListUrl,
        type:"post",
        async:false,
        data:JSON.stringify({
        	params:params,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
//            	nui.unmask();
            	partList= data.parts;
            }
            else{
            	nui.unmask();
                showMsg(data.errMsg||"同步失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
        	nui.unmask();
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
    for(var i=0;i<partList.length;i++){
    	var temp={};
    	temp.erp_part_id =partList[i].id;
    	temp.cars =partList[i].applyCarModel || "";
    	temp.pid =partList[i].code;
    	temp.label =partList[i].fullName;
    	if(brandHash && brandHash[partList[i].partBrandId]){    	
    		temp.origin = brandHash[partList[i].partBrandId].name;
	    }else{
	    	temp.origin = "";
	    }
    	temp.source_pid =partList[i].code;
    	temp.um =partList[i].unit;
    	temp.spec ="";
    	temp.remark ="";
    	temp.brand =temp.origin;
    	if(qualityHash && qualityHash[partList[i].qualityTypeId]){
    		temp.part_type_id =qualityHash[partList[i].qualityTypeId].cangBrandId;
    	}else{
    		temp.part_type_id ="";
    	}
    	
    	partInfosList.push(temp);
    }
    partinfos =JSON.stringify(partInfosList);
    return partinfos;
}
//同步配件到仓先生
var syncUrl =baseUrl+"com.hsapi.cloud.part.baseDataCrud.cang.addParts.biz.ext";
function syncCang(){
	var partinfos = getNoSync(params);
	if(partinfos=="[]" ||partinfos.length ==0){
		showMsg("配件已经全部同步","S");
		return;
	}
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : "同步中..."
	});
    nui.ajax({
        url:syncUrl,
        type:"post",
        data:JSON.stringify({
        	agency_id:currAgencyId,
        	partinfos:partinfos,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
//            	nui.unmask();
        	    showMsg(data.errMsg||"同步成功","S");
            }
            else{
            	nui.unmask();
                showMsg(data.errMsg ||"同步失败","E");
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
        	nui.unmask();
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}