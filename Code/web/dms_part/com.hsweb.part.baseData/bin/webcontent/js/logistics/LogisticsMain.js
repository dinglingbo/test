var baseUrl = apiPath + partApi + "/";
var dataGridUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.queryLogistics.biz.ext";
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

    nui.get("fullName").focus();
    onSearch();

    $("#fullName").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    $("#manager").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
    $("#mobile").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            onSearch();
        }
    });
});
function onRowClick(e)
{
    var row = dataGrid.getSelected();
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
function onSearch()
{
    var params = {};
    params.manager = nui.get("manager").getValue();
    params.mobile = nui.get("mobile").getValue();
    params.fullName = nui.get("fullName").getValue();

    loadDataGridData(params);
}

function addOrEditLogistics(comguest) 
{
	var title = "新增物流公司";
    if(comguest)
    {
        title = "修改物流公司";
    }
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.part.baseData.LogisticsDetail.flow?token="+token,
        allowResize:false,
        title: title, width: 470, height: 250,
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
function addLogistics()
{
    addOrEditLogistics();
}
function editLogistics(comguest) 
{
    addOrEditLogistics(comguest);
}
function add() {
    addLogistics();
}
function edit() {
    var row = dataGrid.getSelected();
    if (row && row.orgid == currOrgid) {
        editLogistics(row);
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
    if (row && row.orgid == currOrgid)
    {
        nui.confirm("确定要禁用所选物流公司？", "提示", function (action)
        {
            if (action == "ok")
            {
                updateIsDisabled({
                    id: row.id,
                    isDisabled: 1
                }, function (data) {
                    data = data || {};
                    if (data.errCode == "S") {
                        dataGrid.reload();
                        showMsg("禁用成功","S");
                    }
                    else {
                        showMsg(data.errMsg || "禁用失败","W");
                    }
                });
            }
        }.bind(row));
    }
}
function enableComeguest()
{
    var row = dataGrid.getSelected();
    if (row && row.orgid == currOrgid)
    {
        nui.confirm("确定要启用所选物流公司？", "提示", function (action)
        {
            if (action == "ok")
            {
                updateIsDisabled({
                    id: row.id,
                    isDisabled: 0
                }, function (data) {
                    data = data || {};
                    if (data.errCode == "S") {
                        dataGrid.reload();
                        showMsg("启用成功","S");
                    }
                    else {
                        showMsg(data.errMsg || "启用失败","W");
                    }
                });
            }
        }.bind(row));
    }
}
//修改保存启用禁用
var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.updateGuestDisable.biz.ext";
function updateIsDisabled(comguest, callback)
{
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
            guest:comguest,
            token:token
        }),
        success:function(data)
        {
            nui.unmask();
            callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
        }
    });
}