/**
 * Created by Administrator on 2018/2/1.
 */
var rightGridUrl = cloudPartApiUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPchsOrderEnterMain.biz.ext";
var innerPchsGridUrl = cloudPartApiUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPjPchsOrderEnterDetailChkList.biz.ext";
var rightGrid = null;
var searchBeginDate = null;
var searchEndDate = null;
var comServiceId = null;
var comSearchGuestId = null;
var editFormPchsEnterDetail = null;
var innerPchsEnterGrid = null;
var FGuestId = null;

var storehouseHash = {};
var billTypeIdHash = {};
var settTypeIdHash = {};
var enterTypeIdHash = {};
var partBrandIdHash = {};
var partList=[];

$(document).ready(function(v)
{
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    searchBeginDate = nui.get("beginDate");
    searchEndDate = nui.get("endDate");
    searchServiceId = nui.get("serviceId");
    searchServiceMan = nui.get("serviceMan");
    comSearchGuestId = nui.get("searchGuestId");

    innerPchsEnterGrid = nui.get("innerPchsEnterGrid");
    editFormPchsEnterDetail = document.getElementById("editFormPchsEnterDetail");
    innerPchsEnterGrid.setUrl(innerPchsGridUrl);

    searchBeginDate.setValue(getNowStartDate());
    searchEndDate.setValue(addDate(getNowEndDate(), 1));
    nui.get('serviceId').focus();
    getAllPartBrand(function(data)
    {
        var partBrandList = data.brand;
        partBrandList.forEach(function(v)
        {
            partBrandIdHash[v.id] = v;
        });
    });
    
    var dictDefs ={"billTypeId":"DDT20130703000008", "settleTypeId":"DDT20130703000035"};
    initDicts(dictDefs, function(){
        var billTypeIdList = nui.get("billTypeId").getData();
        var settTypeIdList = nui.get("settleTypeId").getData();
        billTypeIdList.forEach(function(v)
        {
            billTypeIdHash[v.customid] = v;
        });
        settTypeIdList.forEach(function(v)
        {
            settTypeIdHash[v.customid] = v;
        });
    });
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
     //   nui.get("storeId").setData(storehouse);
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
    });

    rightGrid.on("showrowdetail",function(e){
        var row = e.record;
        var mainId = row.id;
        
        //将editForm元素，加入行详细单元格内
        var td = rightGrid.getRowDetailCellEl(row);

        td.appendChild(editFormPchsEnterDetail);
        editFormPchsEnterDetail.style.display = "";
        innerPchsEnterGrid.setData([]);

        var params = {};
        params.mainId = mainId;
        innerPchsEnterGrid.load({
            params:params,
            token: token
        }); 
    });

    rightGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "billTypeId":
                if(billTypeIdHash[e.value])
                {
                    e.cellHtml = billTypeIdHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            case "settleTypeId":
                if(settTypeIdHash[e.value])
                {
                    e.cellHtml = settTypeIdHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
            default:
                break;
        }
    });

    innerPchsEnterGrid.on("drawcell",function(e){
        switch (e.field)
        {
            case "storeId":
                if(storehouseHash[e.value])
                {
                    e.cellHtml = storehouseHash[e.value].name||"";
                }
                else{
                    e.cellHtml = "";
                }
                break;
//            case "partBrandId":
//                if(partBrandIdHash[e.value])
//                {
//                    e.cellHtml = partBrandIdHash[e.value].name||"";
//                }
//                else{
//                    e.cellHtml = "";
//                }
//                break;
            case "partBrandId":
                if(partBrandIdHash[e.value])
                {
//                    e.cellHtml = partBrandIdHash[e.value].name||"";
                	if(partBrandIdHash[e.value].imageUrl){
                		
                		e.cellHtml = "<img src='"+ partBrandIdHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+partBrandIdHash[e.value].name||"";
                	}else{
                		e.cellHtml =partBrandIdHash[e.value].name||"";
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
    
    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
        
        if((keyCode==13))  {  
        	onSearch();
        }
        if((keyCode==27))  {  
        	onCancel();
        }
     
    }
});

function getSearchParam(){
    var params = {};

    params.code = searchServiceId.getValue().replace(/\s+/g, "");
    params.serviceMan = searchServiceMan.getValue().replace(/\s+/g, "");
    params.guestId = comSearchGuestId.getValue();
    
    params.endDate = searchEndDate.getFormValue();
    params.startDate = searchBeginDate.getFormValue();
    return params;
}
function onSearch(){
    var params = getSearchParam();

    doSearch(params);
}
function doSearch(params)
{
    params.sortField = "a.audit_date";
    params.sortOrder = "desc";
    params.enterTypeId = '050101';
    rightGrid.load({
        params:params,
        token: token
    });	
   
}
var supplier = null;
function selectSupplier(elId)
{
    supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.guestSelect.flow?token="+token,
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

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var resultData = [];
function onOk()
{
    if(!FGuestId){
        showMsg("请选择客户后再选择采购单!","W");
        return;
    }
//    var node = rightGrid.getSelected();
//    if(node)
//    {
//    
//        resultData = {
//            orderMainId:node.id,
//            orderServiceId:node.serviceId,
//            billTypeId:node.billTypeId,
//            orderMan:node.orderMan,
//            settleTypeId:node.settleTypeId,
//            guestId:node.guestId,
//            fullName:node.fullName,
//            type:"pchs"
//        };
        //  return;
//        CloseWindow("ok");
//    }
    var rows=rightGrid.getSelecteds();
    if(rows.length>0){
    	var idList=''
    	for(var i=0;i<rows.length;i++){
    		idList +=rows[i].id+",";
    	}
    	idList=idList.substr(0, idList.length - 1);
    	var params={idList: idList};
        getDetailList(params);
    	if(partList){
    		for(var i=0;i<partList.length;i++){
    			partList[i].comPartBrandId=partList[i].partBrandId;
    			partList[i].comApplyCarModel=partList[i].applyCarModel;
    			partList[i].comUnit=partList[i].enterUnitId;
    			partList[i].orderQty =partList[i].enterQty;
    			partList[i].orderPrice=partList[i].enterPrice;
    			partList[i].orderAmt=partList[i].enterAmt;
    			partList[i].comSpec=partList[i].spec;
    			partList[i].outUnitId=partList[i].enterUnitId;
    		}
    		var innerPartRow=innerPchsEnterGrid.getSelecteds();
    		if(innerPartRow.length>0){
    			for(var i=0;i<innerPartRow.length;i++){
    				innerPartRow[i].comPartBrandId=innerPartRow[i].partBrandId;
    				innerPartRow[i].comApplyCarModel=innerPartRow[i].applyCarModel;
    				innerPartRow[i].comUnit=innerPartRow[i].enterUnitId;
    				innerPartRow[i].orderQty =innerPartRow[i].enterQty;
    				innerPartRow[i].orderPrice=innerPartRow[i].enterPrice;
    				innerPartRow[i].orderAmt=innerPartRow[i].enterAmt;
    				innerPartRow[i].comSpec=innerPartRow[i].spec;
    				innerPartRow[i].outUnitId=innerPartRow[i].enterUnitId;
    			}
    			var id=innerPartRow[0].id;
    			for(var i=0;i<partList.length;i++){
    				if(partList[i].id==id){   					
    					partList.splice(i--, 1);
    				}
    			}
    			for(var i=0;i<innerPartRow.length;i++){			
    				partList.push(innerPartRow[i]);
    			}
    		}
    		resultData=partList;
    		callback(partList);
    	}
    }
//    	else{       	
//    	var parts=innerPchsEnterGrid.getSelecteds();
//    	for(var i=0;i<parts.length;i++){
//    		parts[i].comPartBrandId=parts[i].partBrandId;
//    		parts[i].comApplyCarModel=parts[i].applyCarModel;
//    		parts[i].comUnit=parts[i].enterUnitId;
//    		parts[i].orderQty =parts[i].enterQty;
//    		parts[i].orderPrice=parts[i].enterPrice;
//    		parts[i].orderAmt=parts[i].enterAmt;
//    		parts[i].comSpec=parts[i].spec;
//    		parts[i].outUnitId=parts[i].enterUnitId;
//    	}
//    	if(parts){
//    		resultData=parts;
//    		callback(parts);
//    	}
//    	
//    }
}

function getDetailList(params){
	nui.ajax({
    	url:innerPchsGridUrl,
    	type:"post",
    	async: false,
    	data:{
    		params:params,
    		token:token
    	},
    	success:function(text){
    		partList=text.detailList;
    		return partList;
    		
    	}
    });
}
//function onOk(){
//	 if(!FGuestId){
//       showMsg("请选择客户后再选择采购单!","W");
//       return;
//    }
//	 var node = rightGrid.getSelecteds();
//}
function getData(){
    return resultData;
}

var callback=null;
var checkcallback=null;
function setInitData(params, ck,cck){
    FGuestId = params.guestId;
    callback = ck;
    checkcallback = cck;
    onSearch();
}