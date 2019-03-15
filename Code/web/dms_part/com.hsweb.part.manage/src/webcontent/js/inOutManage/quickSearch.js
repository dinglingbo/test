/**
 * Created by Administrator on 2018/1/23.
 * There must be a query condition
 */
var baseUrl = apiPath + partApi + "/";

var partGridUrl = baseUrl+"com.hsapi.part.invoice.query.queryQuickPartWithStock.biz.ext";
var innerPartCommonGridUrl = baseUrl+"com.hsapi.part.invoice.query.queryQuickPartCommonWithStock.biz.ext";
var partGrid = null;
var queryConditionsEl = null;
var conditoinsValueEl = null;
var partCodeListEl = null;
var resListEl = null;
var partCommonForm = null;
var innerPartCommonGrid = null;
var win = null;
var cartGrid = null;
var mainTabs = null;

var gpartId = 0;
var gpartCode = "";

var conList = [
    {id:"0",name:"配件编码"},
    {id:"1",name:"配件名称"},
    {id:"2",name:"编码尾号"},
    {id:"3",name:"首字拼音"}
];
var qualityList = [];
var qualityHash = {};
var brandHash = {};
var brandList = [];
var unitList = [];
var carBrandList = [];
$(document).ready(function() {
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);

    queryConditionsEl = nui.get("queryConditions");
    conditoinsValueEl = nui.get("conditoinsValue");
    partCodeListEl = nui.get("partCodeList");
    resListEl = nui.get("resList");
    win = nui.get("win");
    cartGrid = nui.get("cartGrid");
    mainTabs = nui.get("mainTabs");

    partCommonForm = document.getElementById("partCommonForm");
    innerPartCommonGrid = nui.get("innerPartCommonGrid");
    innerPartCommonGrid.setUrl(innerPartCommonGridUrl);

    queryConditionsEl.setData(conList);

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
//                     e.cellHtml = brandHash[e.value].name||"";
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
            case "partCode":
                if(row.commonId && row.commonId > 0)
                {
                    e.cellHtml = e.value+"(<a style='color:blue;'>有替换</a>)";
                }
                if(row.sourceType == 'EPC'){
                    var value = e.value;
                    var brandname = row.brandname||"";
                    if(brandname){
                        value = value+'('+brandname+')';
                    }
                    e.cellHtml = "<span class='fa fa-cloud' style='color:#1e395b'></span>"+(value||"");
                }
                break;
            default:
                break;
        }
    });
    partGrid.on("selectionchanged",function(e){
        var row = partGrid.getSelected();
        //如果是EPC配件，根据配件编码查询库存分布，本店库存，出入库记录，替换不用查询
        gpartId = row.partId||0;
        gpartCode = row.partCode||"";
        if(row.partId){
            showTabInfo(gpartId,gpartCode);
            document.getElementById("epcFormIframe").src=webPath + contextPath+"/manage/inOutManage/epcTip.html";
        }else if(row.brand && row.partCode){
            showTabInfo(0,"");
            document.getElementById("epcFormIframe").src=webPath + contextPath + "/com.hsweb.system.epc.partDetail.flow?brand=" + row.brand + "&pid=" + row.partCode;
        }else{
            showTabInfo(0,"");
            document.getElementById("epcFormIframe").src=webPath + contextPath+"/manage/inOutManage/epcTip.html";
        }
    });
    partGrid.on("cellclick",function(e){ 
        var field=e.field;
        if(field=="check" ){
            if(!e.value){
                addToCartGrid("PART", e.row);
            }
        }
    });
    innerPartCommonGrid.on("cellclick",function(e){ 
        var field=e.field;
        if(field=="check" ){
            if(!e.value){
                addToCartGrid("PART", e.row);
            }
        }
    });
    innerPartCommonGrid.on("selectionchanged",function(e){
        var row = innerPartCommonGrid.getSelected();
        //如果是EPC配件，根据配件编码查询库存分布，本店库存，出入库记录，替换不用查询
        gpartId = row.partId||0;
        gpartCode = row.partCode||"";
        if(row.partId){
            showTabInfo(gpartId,gpartCode);
            document.getElementById("epcFormIframe").src=webPath + contextPath+"/manage/inOutManage/epcTip.html";
        }else if(row.brand && row.partCode){
            showTabInfo(0,"");
            document.getElementById("epcFormIframe").src=webPath + contextPath + "/com.hsweb.system.epc.partDetail.flow?brand=" + row.brand + "&pid=" + row.partCode;
        }else{
            showTabInfo(0,"");
            document.getElementById("epcFormIframe").src=webPath + contextPath+"/manage/inOutManage/epcTip.html";
        }
    });
    innerPartCommonGrid.on("drawcell",function(e){
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
            case "partCode":
                if(row.sourceType == 'EPC'){
                    var value = e.value;
                    var brandname = row.brandname||"";
                    if(brandname){
                        value = value+'('+brandname+')';
                    }
                    e.cellHtml = "<span class='fa fa-cloud' style='color:#1e395b'></span>"+(value||"");
                }
                break;
            default:
                break;
        }
    });

    partGrid.on("showrowdetail",function(e){
        var row = e.record;
        var mainId = row.id;
        
        var td = partGrid.getRowDetailCellEl(row);   

        td.appendChild(partCommonForm);
        partCommonForm.style.display = "";
        innerPartCommonGrid.setData([]);

        //EPC是有品牌和编码的
        if(row.sourceType && row.sourceType == 'EPC'){
            innerPartCommonGrid.load({
                type:'EPC',
                partCode: row.partCode,
                brand: row.brand,
                token: token
            });
        }else{
            //只有编码
            //if(!row.commonId || row.commonId<=0) return;
            innerPartCommonGrid.load({
                type:'ALL',
                partId: row.partId,
                partCode: row.partCode,
                token: token
            });
        }
        
    });
    mainTabs.on("activechanged",function(e){
        showTabInfo(gpartId,gpartCode);
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

        getAllCarBrand(function(data) {
            data = data || {};
            carBrandList = data.data || [];
            
            var dictIdList = [];
            dictIdList.push('DDT20130703000016');// --单位
            getDictItems(dictIdList, function(data) {
                if (data && data.dataItems) {
                    var dataItems = data.dataItems || [];
                    unitList = dataItems.filter(function(v) {
                        return v.dictid == 'DDT20130703000016';
                    });
                }
                //onSearch();
            });
        });

    });

    $("#conditoinsValue").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });

    var clipboard = new ClipboardJS('.tipBtn');

    clipboard.on('success', function(e) {
         console.log(e);
    });

    clipboard.on('success', function(e) {
         console.log(e);
    });

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
        
        if((keyCode==81)&&(event.altKey))  {  
			cutTipText();
	    } 
     
    }


});
var partHash={};
function getSearchParams()
{
    var params = {};
    var partCodeArr = [];
    var qCon = queryConditionsEl.getValue();
    var qVal = conditoinsValueEl.getValue();
    if(qCon == 0){
        params.code = qVal.replace(/\s+/g, "");
    }else if(qCon == 1){
        params.name = qVal.replace(/\s+/g, "");
    }else if(qCon == 2){
        params.rcode = qVal.replace(/\s+/g, "");
    }else if(qCon == 3){
        params.namePy = qVal.replace(/\s+/g, "");
    }else{
        params.code = qVal.replace(/\s+/g, "");
    }

    var partCodeList = partCodeListEl.getValue();
    if (partCodeList) {
        var tmpList = partCodeList.split("\n");
        for (i = 0; i < tmpList.length; i++) {
            //tmpList[i] = "'" + (tmpList[i]).replace(/\s+/g, "") + "'";
            var partCode =  (tmpList[i]).replace(/\s+/g, "");
            if(!partHash[partCode]){
                partCodeArr.push(partCode);
                partHash[partCode] = partCode;
            }
        }
        //params.partCodeList = tmpList.join(",");

        params.partCodeArr = partCodeArr;
        partHash={};
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
    if(!conditoinsValueEl.getValue() && !partCodeListEl.getValue()){
        showMsg("请输入查询条件!","W");
        return;
    }
    partGrid.load({
        params:params,
        token:token
    },function(e){
        var res = e.result;
        var errCode = res.errCode;
        var errMsg = res.errMsg;
        if(errMsg){
            errMsg = errMsg.replace(/:/g, ":\r\n");//<br/>
            errMsg = errMsg.replace(/：/g, "：\r\n");
            errMsg = errMsg.replace(/;/g, "\r\n");
            resListEl.setValue(errMsg);
        }else{
            resListEl.setValue("");
        }

        //查找库存>0的信息，匹配价格
        showQuote();

    });
}
var partInfoHash = {};
var commonHash = {};
var partIdList = [];
function showQuote(){
    var rows = partGrid.findRows(function(row){
        if((row.stockQty && row.stockQty>0)||(row.commonId && row.commonId>0)){
            return true;
        }
    });
    var commonIdList = [];
    var ch = {};
    if(rows && rows.length>0){
        for (i = 0; i < rows.length; i++) {
            var partId =  rows[i].partId;
            var commonId = rows[i].commonId;
            if(!partInfoHash[partId]){
                if(partId && partId>0){
                    partIdList.push(partId);
                    partInfoHash[partId] = rows[i];

                    if(commonId && commonId>0){
                        if(!ch[commonId]){
                            commonIdList.push(commonId);
                            ch[commonId] = commonId;
                        }
                        
                        if(!commonHash[partId]){
                            commonHash[partId] = commonId;
                        }
                    }
                }
            }
        }
        var params = {};
        if(partIdList && partIdList.length>0){
            params.partIds  = partIdList.join(",");
            params.opartIds  = partIdList.join(",");
        }
        if(commonIdList && commonIdList.length>0){
            params.ocommonIds  = commonIdList.join(",");
            params.partIds  = null;
            params.partCommon = 1;
        }
        params.outableQty = 1;
        searchPrice(params);
    }
}
var spUrl = cloudPartApiUrl+"com.hsapi.part.invoice.pricemanage.getQuickPartPrice.biz.ext";
function searchPrice(params){
    var price = [];
    var flag = false;
    nui.ajax({
		url : spUrl,
        type : "post",
        async : false,
		data : JSON.stringify({
			params : params,
			token: token
		}),
		success : function(data) {
			data = data || {};
			if (data.price) {
                var price = data.price;
                var priceHash = {};
                var quoteList = [];
                for(var i=0; i<price.length; i++){
                    var partId = price[i].partId;
                    priceHash[partId] = price[i];
                }
                

                for(var j=0; j<partIdList.length; j++){
                    var mPartId = partIdList[j];
                    var mCommonId = commonHash[mPartId];
                    var haveMain = 0;
                    if(priceHash[mPartId]){
                        haveMain = 1;
                        var sellPrice = priceHash[mPartId].sellPrice;
                        var partCode = priceHash[mPartId].partCode;
                        quoteList.push(partCode +" "+sellPrice);
                    }

                    for(var i=0; i<price.length; i++){
                        var partId = price[i].partId;
                        var commonId = price[i].commonId;
                        var partCode = price[i].partCode;
                        var sellPrice = price[i].sellPrice;
                        
                        if(mPartId == partId){
                        }else if(mCommonId == commonId && commonId != null && mCommonId !=undefined){
                            if(haveMain == 0) {
                                if(i>0){
                                    partCode = '='+partCode;
                                }
                            }else{
                                partCode = '='+partCode;
                            }
                            quoteList.push(partCode +" "+sellPrice);
                        }
                    }

                }

                var quoteStr = "";
                if(quoteList && quoteList.length>0){
                    quoteStr = quoteList.join("\r\n");
                    quoteStr = "报价：\r\n"+quoteStr;
                }

                var resValue = resListEl.getValue();
                if(resValue && quoteStr){
                    resValue = resValue + "\r\n";
                }
                quoteStr = resValue + quoteStr;
                resListEl.setValue(quoteStr);
                document.getElementById("tipText").value=quoteStr;
                flag = true;
                
                partInfoHash = {};
                commonHash = {};
                partIdList = [];

			} else {
                showMsg('报价失败!','W');
                partInfoHash = {};
                commonHash = {};
                partIdList = [];
                document.getElementById("tipText").value="";
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
            partInfoHash = {};
            commonHash = {};
            partIdList = [];
            document.getElementById("tipText").value="";
			console.log(jqXHR.responseText);
		}
    });
    
    partInfoHash = {};
    commonHash = {};
    partIdList = [];

    return flag;
}
function cutTipText(){
    //自动点击
    $("#tipBtn").trigger("click");
    showMsg("复制报价内容成功!","S");
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
        url: webPath+contextPath+"/com.hsweb.part.baseData.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 740, height: 250,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                qualityTypeIdList:qualityList,
                partBrandIdList:brandList,
                unitList:unitList,
                abcTypeList:[],
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
                reloadData();
            }
        }
    });
}

var resultData = {};
var callback = null;
var checkcallback = null;
function onOk()
{
    var node = partGrid.getSelected();
    var nodec = nui.clone(node);
    
    if(!nodec)
    {
        return;
    }
    resultData = {
        part:nodec
    };
    if(!parent.addDetail)
    {
        return;
    }
    else{
        //需要判断是否已经添加了此配件
        var checkMsg = parent.checkPartIDExists(nodec.id);
        if(checkMsg) 
        {
            nui.confirm(checkMsg, "友情提示",
                function (action) { 
                    if (action == "ok") {
                        parent.addDetail(nodec);
                    }else {
                        return;
                    }
                }
            );
        }else
        {
            //弹出数量，单价和金额的编辑界面
            parent.addDetail(resultData.part);
        }

    }
}
function getData(){
    return resultData;
}
function onRowDblClick()
{
    onOk();
}
function initData(partCode){
    codeEl.setValue(partCode);
    onSearch();
    codeEl.focus();
}
function onClear(){
    conditoinsValueEl.setValue("");
    partCodeListEl.setValue("");
    resListEl.setValue("");
    document.getElementById("tipText").value="";
}
function showPanel(type){
    if(type == 'PART'){
        win.showAtPos("right", "bottom");  
    }else{    
        if(win.visible == true){
            win.hide();
        }else{
            win.showAtPos("right", "bottom");  
        }
    }
}
function addToCartGrid(type, row){
    showPanel(type);
    var data = cartGrid.getData();
    if(data && data.length>0){
        var rows = cartGrid.findRows(function(r){
            if(row.partCode == r.partCode) {
                cartGrid.scrollIntoView(r);
                return true;
            }
        });
        if(!row.partId || row.partId <= 0) {
            row.partId = -1;
        }
        if(rows && rows.length>0){
            showMsg("此配件已经添加到购物车!","W");
            return;
        }else{
            var newRow = {partId: row.partId, partCode: row.partCode, partName: row.partName, fullName:row.fullName, unit:row.unit, orderQty: 1, orderPrice: 0};
            cartGrid.addRow(newRow);       
        }
    }else{
        if(!row.partId || row.partId <= 0) {
            row.partId = -1;
        }
        var newRow = {partId: row.partId, partCode: row.partCode, partName: row.partName, fullName:row.fullName, unit:row.unit, orderQty: 1, orderPrice: 0};
        cartGrid.addRow(newRow);       
    }

}
function deleteCartShop(){
    var rows = cartGrid.getSelecteds();
    cartGrid.removeRows(rows);
}
function openGeneratePop(partList, type, title){
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.manage.shopCarPop.flow?token="+token,
        title : title,
        width : 600,
        height : 400,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                storeId: "",
                partList: partList,
                type: type
            };
            iframe.contentWindow.setInitData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                //var data = iframe.contentWindow.getData();
            }
        }
    });
}
function addToPchsCart(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "fromPchsCart", "添加采购车");

    }else{
        showMsg("请选择配件信息!","W");
        return;
    }
}
function addToSellCart(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "fromSellCart", "添加销售车");

    }else{
        showMsg("请选择配件信息!","W");
        return;
    }
}
function generatePchsOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "fromPchsCart", "生成采购订单");

    }else{
        showMsg("请选择配件信息!","W");
        return;
    }
}
function generateSellOrder(){
    var rows = cartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "fromSellCart", "生成销售订单");

    }else{
        showMsg("请选择配件信息!","W");
        return;
    }
}
function showTabInfo(partId, partCode){
	var tab = mainTabs.getActiveTab();
	var name = tab.name;
    var url = tab.url;
    partId = partId||0;
	switch (name)
    {
        case "storeStockTab":  
            var params = {};
            params.partId=partId;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containPartStock.jsp?partId="+partId, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }     
            break;
        case "chainStockTab":
            var params = {};
            params.partCode=partCode;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomChainStock.jsp?partCode="+partCode, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }
            break;
        case "BMWStockTab":
            var params = {};
            params.partId=partCode;
            params.token=token;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBmwParts.jsp?partCode="+partCode, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }
            break;
        case "priceTab": 
            var params = {};
            params.partId=partId;
            if(!url){
                mainTabs.loadTab(cloudPartWebUrl + "/manage/inOutManage/common/embedJsp/containPartPrice.jsp?partId="+partId, tab);
            }else {
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }  
            break;
        case "enterRecordTab":
            var params = {};
            params.partId=partId;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containPchsOrderRecord.jsp?partId="+partId, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);  
            }
            
            break;
        case "outRecordTab":
            var params = {};
            params.partId=partId;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containSellOrderRecord.jsp?partId="+partId, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }
            
        	break;
        case "preOutTab":
            var params = {};
            params.partId=partId;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomSellRecord.jsp", tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }
            
            break;
        case "invocingTab":
            gparams.guestId=null;
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containBottomSellRecord.jsp?partId="+partId, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }
            
            break;
        case "partCommonTab":
            var params = {};
            params.partId=partId;
            params.type="LOCAL";
            if(!url){
                mainTabs.loadTab(webPath + contextPath + "/manage/inOutManage/common/embedJsp/containPartCommon.jsp?partId="+partId, tab);
            }else{
                mainTabs.getTabIFrameEl(tab).contentWindow.doSearch(params);
            }
            
            break;
        default:
            break;
    }
}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字！!","W");
        e.cancel = true;
    } else {
        var newRow = {};
        if (e.field == "orderQty") {
            var orderQty = e.value;
            var orderPrice = record.orderPrice;

            if (e.value == null || e.value == '') {
                e.value = 0;
                orderQty = 0;
            } else if (e.value < 0) {
                e.value = 0;
                orderQty = 0;
            }

            // record.enteramt.cellHtml = enterqty * enterprice;
        } else if (e.field == "orderPrice") {
            var orderQty = record.orderQty;
            var orderPrice = e.value;
            
            if (e.value == null || e.value == '') {
                e.value = 0;
                orderPrice = 0;
            } else if (e.value < 0) {
                e.value = 0;
                orderPrice = 0;
            }

        }
    }
}