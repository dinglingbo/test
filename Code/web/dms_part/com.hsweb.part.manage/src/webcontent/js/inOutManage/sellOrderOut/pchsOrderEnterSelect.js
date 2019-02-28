/**
 * Created by Administrator on 2018/2/1.
 */
var partApiUrl  = apiPath + partApi + "/";
var rightGridUrl = partApiUrl+"com.hsapi.part.invoice.paramcrud.queryPchsOrderEnterMain.biz.ext";
var innerPchsGridUrl = partApiUrl+"com.hsapi.part.invoice.paramcrud.queryPjPchsOrderEnterDetailChkList.biz.ext";
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
            case "partBrandId":
            	if(partBrandIdHash[e.value])
                {
//                    e.cellHtml = partBrandIdHash[e.value].name||"";
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
            default:
                break;
        }
    });

});

function getSearchParam(){
    var params = {};

    params.code = searchServiceId.getValue();
    params.serviceMan = searchServiceMan.getValue();
    params.guestId = comSearchGuestId.getValue();
    
    params.endDate = searchEndDate.getValue();
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

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
var resultData = {};
function onOk()
{
    if(!FGuestId){
        showMsg("请选择客户后再选择采购单!","W");
        return;
    }
    var node = rightGrid.getSelected();
    if(node)
    {
    
        resultData = {
            orderMainId:node.id,
            orderServiceId:node.serviceId,
            billTypeId:node.billTypeId,
            orderMan:node.orderMan,
            settleTypeId:node.settleTypeId,
            guestId:node.guestId,
            fullName:node.fullName,
            type:"pchs"
        };
        //  return;
        CloseWindow("ok");
    }
}
function getData(){
    return resultData;
}
function setInitData(params){
    FGuestId = params.guestId;
    onSearch();
}