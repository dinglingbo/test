/**
 * Created by Administrator on 2018/1/23.
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var partGridUrl = baseUrl+"com.hsapi.part.invoice.svr.queryPjEnterMainList.biz.ext";
var partGrid = null;
var storehouse = null;
var resultData = {};
var callback = null;
var storehouseHash = {};

$(document).ready(function() {
    partGrid = nui.get("partGrid");
    partGrid.setUrl(partGridUrl);
   
    
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 27)) { // ESC
            CloseWindow('cancle');
        }

    }
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
    });

});
function onDrawCell(e)
{
    switch (e.field)
    {
        case "storeId":
            if(storehouseHash && storehouseHash[e.value])
            {
                e.cellHtml = storehouseHash[e.value].name;
            }
            break;
        	
        default:
            break;
    }
}
var disableList = [{ id: 0, text: '未审核' }, { id: 1, text: '已审核'}];
function onRenderer(e) {
    for (var i = 0, l = disableList.length; i < l; i++) {
        var g = disableList[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}
function doSearch()
{
    var params = {};
    params.enterTypeId = '050105';
    params.orgid = currOrgId;
    partGrid.load({
        params:params,
        token:token
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
    if(!callback)
    {
        CloseWindow("ok");
    }
    else{
        
        //弹出数量，单价和金额的编辑界面
        callback(resultData);
        CloseWindow("ok");

    }
}
function getData(){
    return resultData;
}
function setData(ck){
    callback = ck;

    doSearch();
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
function onRowDblClick()
{
    onOk();
}