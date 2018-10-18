var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var dataGridUrl = baseUrl + "com.hsapi.repair.baseData.outCar.queryOutCar.biz.ext";
var leftTree = null;
var dataGrid = null;
var basicInfoForm = null;
var typeHash = {};
$(document).ready(function (v) {
	leftTree = nui.get("tree1");
	var dictIdList = [];
    dictIdList.push("DDT20130703000058");
    getDictItems(dictIdList,function(data)
    {
        var list = data.dataItems;
        if(list && list.length>0)
        {
            leftTree.loadList(list,"customid",'partentid');
            list.forEach(function(v){
                typeHash[v.customid] = v;
            });
        }
    });
    dataGrid = nui.get("datagrid1");
    dataGrid.setUrl(dataGridUrl);
    dataGrid.on("drawcell",function(e)
    {
        if("type" == e.field && typeHash[e.value])
        {
            e.cellHtml = typeHash[e.value].name;
        }
     });
	
});

function onOutCarRowClick(e)
{
    var row = e.record;
    loadDataGridData(row.customid);
}

function loadDataGridData(type)
{
    var params = {};
    params.type = type;
    params.orgid = currOrgid;
    dataGrid.load({
    	token:token,
        params:params
    });
}