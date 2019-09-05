/**
 * Created by Administrator on 2018/3/17.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var rightGridUrl = baseUrl+"com.hsapi.part.invoice.query.queryPartStoreStock.biz.ext";
var rightGrid2Url = baseUrl+"com.hsapi.part.invoice.paramcrud.queryPjPchsOrderEnterDetailChkListBatch.biz.ext";
var basicInfoForm = null;
var rightGrid = null;
var rightGrid2 = null;
var searchBeginDate = null;
var searchEndDate = null;
var comPartNameAndPY = null;
var comPartCode = null;
var partBrandId = null;
var storeId = null;
var storeShelf = null;
var partId = null;
var showAll = null;
var comSearchGuestId = null;
var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var billStatusHash = {
    "0":"未审",
    "1":"已审",
    "2":"已过账",
    "3":"已取消"
};
var UpOrDownList=[{id:1,"name" :"低于下限"},{id:2,"name" :"高于上限"}]
$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
	rightGrid2 = nui.get("rightGrid2");
    rightGrid.setUrl(rightGridUrl);
    rightGrid2.setUrl(rightGrid2Url);
    comPartNameAndPY = nui.get("comPartNameAndPY");
    comPartCode = nui.get("comPartCode");
    comSearchGuestId = nui.get("searchGuestId");
    partBrandId = nui.get("partBrandId");
    storeId = nui.get("storeId");
    storeShelf = nui.get("storeShelf");
    partId = nui.get("partId");
    showAll = nui.get("showAll");
    //console.log("xxx");
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        nui.get("partBrandId").setData(partBrandList);
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
        if(currRepairStoreControlFlag == "1") {
        	if(storehouse && storehouse.length>0) {
        		nui.get("storeId").setValue(storehouse[0].id);
        	}
        }else {
        	nui.get("storeId").setAllowInput(true);
        }
        
        onSearch();
    });

    comPartCode.focus();

    $("#comPartCode").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#comPartNameAndPY").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#partBrandId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#storeId").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    $("#storeShelf").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    $("#applyCarModel").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
});
function getSearchParam(){
    var params = {};
    /*var outableQtyGreaterThanZero = nui.get("outableQtyGreaterThanZero").getValue();
    if(outableQtyGreaterThanZero == 1)
    {
        params.outableQtyGreaterThanZero = 1;
    }*/
    var showZero = nui.get("showAll").getValue();
//    var showUp=nui.get('showUp').getValue();
//    var showDown=nui.get('showDown').getValue();
	if(typeof comSearchGuestId.getValue() !== 'number'){
    	params.guestId=null;
    	params.guestName = comSearchGuestId.getValue();
    }else{
    	params.guestId = comSearchGuestId.getValue();
    }
    var upOrDown=nui.get('upOrDown').getValue();
    if(showZero == 0){
        params.notShowAll = 1;
    }
    if(upOrDown == 2){
        params.showUp = 1;
    }
    if(upOrDown ==1){
    	 params.showDown = 1;
    }
    params.partNameAndPY = nui.get("comPartNameAndPY").getValue();
	params.partCode = (nui.get("comPartCode").getValue()).replace(/\s+/g, "");
	params.applyCarModel = nui.get("applyCarModel").getValue();
	params.partBrandId = nui.get("partBrandId").getValue();
	params.storeId = nui.get("storeId").getValue();
	params.storeShelf = nui.get("storeShelf").getValue();
	params.partId = nui.get("partId").getValue(); 
    return params;
}
function onSearch(){
	var params = getSearchParam();
	doSearch(params);
   
}
function doSearch(params)
{
	var tabs = nui.get("mainTabs").getActiveTab();
	if(tabs.name=="inventory"){
		//库存
		//var params = getSearchParam();
	    rightGrid.load({
	        params:params,
	        token:token
	    });
	}else if(tabs.name=="batch"){
	    //批次
		//var params = getSearchParam();
		params.outableQty = 0;
	    rightGrid2.load({
	        params:params,
	        token:token
	    },function(){
	    	var detail = rightGrid2.getData();
	    	for(var i = 0;i<detail.length;i++){
	    		detail[i].totalAmt = (detail[i].outableQty||0) * (detail[i].enterPrice||0);
	    	}
	    	rightGrid2.setData(detail);
	    });
	}  
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
	var searchData = advancedSearchForm.getData();
    advancedSearchFormData = {};
    for(var key in searchData)
    {
        advancedSearchFormData[key] = searchData[key];
    }
    var i;
    if(searchData.sOrderDate)
    {
        searchData.sOrderDate = searchData.sOrderDate.substr(0,10);
    }
    if(searchData.eOrderDate)
    {
        var date = searchData.eOrderDate;
        searchData.eOrderDate = addDate(date, 1);
        searchData.eOrderDate = searchData.eOrderDate.substr(0,10);
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //订单单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    /*if(searchData.outableQtyGreaterThanZero == 0)
    {
        delete searchData.outableQtyGreaterThanZero;
    }*/
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onDrawCell(e)
{
    switch (e.field)
    {
    	case "wain" :
    		if(e.record.upLimit){
    			if(e.record.stockQty>e.record.upLimit){
        			e.cellHtml = "<span style='color : red'>高<span>";
        		}
    		}
    		if(e.record.downLimit){
    			if(e.record.stockQty<e.record.downLimit){
        			e.cellHtml = "<span style='color : orange'>低<span>";
        		}
    		}	
    		break;
	    case "partBrandId":
	    	 if(partBrandIdHash[e.value])
             {
//                 e.cellHtml = partBrandIdHash[e.value].name||"";
             	if(partBrandIdHash[e.value].imageUrl){
             		
             		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
             	}else{
             		e.cellHtml =partBrandIdHash[e.value].name||"";
             	}
             }
             else{
                 e.cellHtml = "";
             }
             break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case "enterDayCount":
            var row = e.record;
            var enterTime = (new Date(row.enterDate)).getTime();
            var nowTime = (new Date()).getTime();
            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
            e.cellHtml = dayCount+1;
            break;
        default:
            break;
    }
}
function onDrawCell2(e)
{
    switch (e.field)
    {
	    case "partBrandId":
	    	if(partBrandIdHash[e.value])
            {
//                e.cellHtml = partBrandIdHash[e.value].name||"";
            	if(partBrandIdHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' weight=' '/><br> "+partBrandIdHash[e.value].name||"";
            	}else{
            		e.cellHtml =partBrandIdHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
            break;
	    case "billStatus":
	        if(billStatusHash && billStatusHash[e.value])
	        {
	            e.cellHtml = billStatusHash[e.value];
	        }
	        break;
        case "enterTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            }
            break;
        case "taxSign":
            if(e.value==1) {
                e.cellHtml = "是";
            }else{
            	e.cellHtml = "否";
            }
            break;
        case "billTypeId":
            if(billTypeIdHash && billTypeIdHash[e.value])
            {
                e.cellHtml = billTypeIdHash[e.value].name;
            }
            break;
        case "settleTypeId":
            if(settTypeIdHash && settTypeIdHash[e.value])
            {
                e.cellHtml = settTypeIdHash[e.value].name;
            }
            break;
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        case  "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName || "";
        		}
        	}
/*        case "totalAmt":
                e.cellHtml = (e.row.outableQty||0) * (e.row.enterPrice||0);         
            break; */      	
        default:
            break;
    }
}

//查看入库记录
function onEnter(){
	var row ={};
	row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	onEnterRecord(partId);
	
}

//查看出库记录
function onOut(){
	var row ={};
	row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	onOutRecord(partId);
}

//查看出库记录
function sellRecord(){
	var row ={};
	row = rightGrid.getSelected();
	if(!row){
		showMsg("请选择一条记录","W");
		return;
	}
	var partId = row.partId;
	nui.open({
		url : webPath+contextPath+"/com.hsweb.part.common.partSellRecord.flow?token="+token,
		title : "占用记录",
		width : 780,
		height : 500,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
			var params = {
				partId: partId,
                token :token
            };
            iframe.contentWindow.SetData(params);
		},
		ondestroy : function(action) {
			
		}
	});
}

var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 1,
                guestType:'01020202'
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}
function activechangedmain(){
	var tabs = nui.get("mainTabs").getActiveTab();
	if(tabs.name=="inventory"){
		//库存
		var params = getSearchParam();
	    rightGrid.load({
	        params:params,
	        token:token
	    });
	    nui.get("menuMore").setVisible(true);
	}else if(tabs.name=="batch"){
		//不显示更多
		 nui.get("menuMore").setVisible(false);
	    //批次
		var params = getSearchParam();
		params.outableQty = 0;
	    rightGrid2.load({
	        params:params,
	        token:token
	    },function(){
	    	var detail = rightGrid2.getData();
	    	for(var i = 0;i<detail.length;i++){
	    		detail[i].totalAmt = (detail[i].outableQty||0) * (detail[i].enterPrice||0);
	    	}
	    	rightGrid2.setData(detail);
	    });
	    
	}
}

function onExport(){
	var tabs = nui.get("mainTabs").getActiveTab();
	if(tabs.name=="inventory"){
		//库存
		var detail = nui.clone(rightGrid.getData());
		//多级
		exportMultistage(rightGrid.columns);
		for(var i=0;i<detail.length;i++){
			detail[i].id=1;
			for(var j in storehouseHash) {
			    if(detail[i].storeId ==storehouseHash[j].id ){
			    	detail[i].storeId=storehouseHash[j].name;
			    }
			}
/*			if(detail[i].taxSign==0){
				detail[i].taxSign="否";
			}else{
				detail[i].taxSign="是";
			}*/
			for(var j in partBrandIdHash) {
				if(detail[i].partBrandId ==partBrandIdHash[j].id ){
					detail[i].partBrandId=partBrandIdHash[j].name;
				}
			}
		}
		if(detail && detail.length > 0){
			//多级表头类型
			setInitExportData( detail,rightGrid.columns,"汇总库存导出");
		}		
	}else if(tabs.name=="batch"){
	    //批次
		var detail = rightGrid2.getData();
		//多级
		exportMultistage(rightGrid2.columns);
		for(var i=0;i<detail.length;i++){
			detail[i].id=1;
			detail[i].totalAmt=(detail[i].outableQty||0) * (detail[i].enterPrice||0);
			for(var j in storehouseHash) {
			    if(detail[i].storeId ==storehouseHash[j].id ){
			    	detail[i].storeId=storehouseHash[j].name;
			    }
			}
			if(detail[i].taxSign==0){
				detail[i].taxSign="否";
			}else{
				detail[i].taxSign="是";
			}
			for(var j in partBrandIdHash) {
				if(detail[i].partBrandId ==partBrandIdHash[j].id ){
					detail[i].partBrandId=partBrandIdHash[j].name;
				}
			}
		}
		if(detail && detail.length > 0){
			//多级表头类型
			setInitExportData( detail,rightGrid2.columns,"批次库存导出");
		}
	}
	
}


function printCode(){
	var tabs = nui.get("mainTabs").getActiveTab();
	var row = [];
	if(tabs.name=="inventory"){
		row = rightGrid.getSelecteds();	
	}else if(tabs.name=="batch"){
	    row = rightGrid2.getSelecteds();
	}
	var codeList = [];
	//所有配件转化json字符串
	for(var i = 0;i<row.length;i++){
		var code ={
				name : row[i].comPartName||"",
				code : row[i].partCode||"",
				id : row[i].codeId||""
		}; 
		var strCode = JSON.stringify(code);
		var towCode = {
				str : strCode,
				name : row[i].comPartName||"",
				code : row[i].partCode||"",
				id : row[i].codeId||""
		};
		codeList.push(towCode);
	}
	var createQRCodeByListUrl = webPath + sysDomain + "/com.hs.common.uitls.createQRCodeByList.biz.ext";
    nui.ajax({
        url: createQRCodeByListUrl,
        type:"post",
        async: false,
        data:{
        	codeList:codeList,
        	"width": 150,
        	"height" : 150,
        	token:token
        },
        cache: false,
        success: function (data) {
        	var codeList = data.codeList;
            if(data.errCode == "S"){
                nui.open({
                    url:  webPath + contextPath + "/com.hsweb.print.codePrint.flow",
                    title:"打印配件二维码",
                    height:"100%",
                    width:"100%",
                    onload:function(){
                        var iframe = this.getIFrameEl();
                        iframe.contentWindow.setData(codeList);
                    },
                    ondestroy:function(action){
                    }

                });
            }else{
                showMsg("生成二维码失败!","E");
            }
        }
    });
}

