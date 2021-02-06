var baseUrl = window._rootUrl || "http://127.0.0.1:8080/default/";
var dataGridUrl = baseUrl + "com.hsapi.repair.baseData.insurance.InsuranceQuery.biz.ext";
var dataGrid = null;

$(document).ready(function (v)
{
    dataGrid = nui.get("datagrid1");
    dataGrid.setUrl(dataGridUrl);
    dataGrid.on("rowclick",function(e){
       onRowClick(e);
    });
    dataGrid.on("load",function(){
        onRowClick({});
    });
    
    dataGrid.on("rowdblclick", function(e) {
        var row = dataGrid.getSelected();
        var rowc = nui.clone(row);
        if (!rowc)
            return;
        edit();

    });
    onSearch(0);
});
function onRowClick(e)
{
    var row = dataGrid.getSelected();
    if(row && row.isDisabled)
    {
        nui.get("disableBtn").hide();
        nui.get("enableBtn").show();
    }
    else{
        nui.get("enableBtn").hide();
        nui.get("disableBtn").show();
    }
}

function loadDataGridData(params)
{
	params.orgid = currOrgid;
    dataGrid.load({
        params:params
    });
}
function onSearch(type)
{
    var params = {};
    if (type == 1 || type == 0) {
        params.isDisabled = type;
    }
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    loadDataGridData(params);
}

function addOrEditInsurance(comguest) 
{
	var title = "新增保险公司";
    if(comguest)
    {
        title = "修改保险公司";
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.repair.DataBase.InsuranceDetail.flow",
        allowResize:false,
        title: title, width: 600, height: 400,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {};
            if (comguest) {
                params.comguest = comguest;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action) {
            if (action == "ok") {
                dataGrid.reload();
            }
        }
    });
}
function addInsurance()
{
    addOrEditInsurance();
}
function editInsurance(comguest) 
{
    addOrEditInsurance(comguest);
}
function add() {
    addInsurance();
}
function edit() {
    var row = dataGrid.getSelected();
    if (row) {
        editInsurance(row);
    }
}
function onDrawCell(e) {
    switch (e.field) {
        case "isDisabled":
            e.cellHtml = e.value == 1 ? "禁用" : "启用";
            break;
        default:
            break;
    }
}
function disableComeguest()
{
    var row = dataGrid.getSelected();
    if (row)
    {
        nui.confirm("确定要禁用所选保险公司？", "提示", function (action)
        {
            if (action == "ok")
            {
                updateIsDisabled({
                	rid:row.rid,
                    id: row.id,
                    isDisabled: 1
                }, function (data) {
                    data = data || {};
                    if (data.errCode == "S") {
                        dataGrid.reload();
                        nui.alert("禁用成功");
                    }
                    else {
                        nui.alert(data.errMsg || "禁用失败");
                    }
                });
            }
        }.bind(row));
    }
}
function enableComeguest()
{
    var row = dataGrid.getSelected();
    if (row)
    {
        nui.confirm("确定要启用所选保险公司？", "提示", function (action)
        {
            if (action == "ok")
            {
                updateIsDisabled({
                	rid:row.rid,
                    id: row.id,
                    isDisabled: 0
                }, function (data) {
                    data = data || {};
                    if (data.errCode == "S") {
                        dataGrid.reload();
                        nui.alert("启用成功");
                    }
                    else {
                        nui.alert(data.errMsg || "启用失败");
                    }
                });
            }
        }.bind(row));
    }
}
//修改保存启用禁用
var saveUrl = baseUrl + "com.hsapi.repair.baseData.insurance.saveInsurance.biz.ext";
function updateIsDisabled(comguest, callback)
{
    nui.mask({
        html: '保存中...'
    });
    doPost({
        url:saveUrl,
        data:{
            comguest:comguest
        },
        success:function(data)
        {
            nui.unmask();
            callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}