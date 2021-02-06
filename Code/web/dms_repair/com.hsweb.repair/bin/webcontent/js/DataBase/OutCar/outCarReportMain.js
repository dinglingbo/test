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
            nui.get("type").setData(list);
            list.forEach(function(v){
                typeHash[v.customid] = v;
            });
        }
    });

    dataGrid = nui.get("datagrid1");
    dataGrid.setUrl(dataGridUrl);
    dataGrid.on("load",function()
    {
    	basicInfoForm.clear();
        basicInfoForm.setEnabled(false);
        var row = dataGrid.getSelected();
        if(row)
        {
            onOutCarDataRowClick({
                record:row
            });
        }
        else{
            nui.get("addBtn").enable();
            nui.get("editBtn").disable();
            nui.get("deleteBtn").disable();
            nui.get("saveBtn").disable();
            nui.get("cancelBtn").disable();
        }
    });
    dataGrid.on("drawcell",function(e)
    {
        if("type" == e.field && typeHash[e.value])
        {
            e.cellHtml = typeHash[e.value].name;
        }
    });
    basicInfoForm = new nui.Form("#basicInfoForm");
    basicInfoForm.setEnabled(false);
    
});
function onOutCarRowClick(e)
{
    var row = e.record;
    nui.get("addBtn").enable();
    nui.get("editBtn").disable();
    nui.get("deleteBtn").disable();
    nui.get("saveBtn").disable();
    nui.get("cancelBtn").disable();
    basicInfoForm.setEnabled(false);
    loadDataGridData(row.customid);
}
function onOutCarDataRowClick(e)
{
    var row = e.record;
    nui.get("addBtn").enable();
    nui.get("editBtn").enable();
    nui.get("deleteBtn").enable();
    nui.get("saveBtn").disable();
    nui.get("cancelBtn").disable();
    basicInfoForm.setData(row);
    basicInfoForm.setEnabled(false);
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

function addReport()
{
    nui.get("addBtn").disable();
    nui.get("editBtn").disable();
    nui.get("deleteBtn").disable();
    nui.get("saveBtn").enable();
    nui.get("cancelBtn").enable();
    basicInfoForm.setEnabled(true);
    nui.get("type").disable();
    basicInfoForm.clear();
    var node = leftTree.getSelectedNode();
    var data = {
        type:node.customid
    };
    basicInfoForm.setData(data);
}
function editReport()
{
	nui.get("addBtn").disable();
    nui.get("editBtn").disable();
    nui.get("deleteBtn").disable();
    nui.get("saveBtn").enable();
    nui.get("cancelBtn").enable();
    basicInfoForm.setEnabled(true);
}
function cancelEdit()
{
    var row = dataGrid.getSelected();
    if(row)
    {
        onOutCarDataRowClick({
            record:row
        });
    }
    else{
        nui.get("addBtn").enable();
        nui.get("saveBtn").disable();
        nui.get("cancelBtn").disable();
    }
    basicInfoForm.setEnabled(false);
}
var requiredField = {
    content: "报告类型"
};
var saveUrl = baseUrl+"com.hsapi.repair.baseData.outCar.saveOutReport.biz.ext";
function save()
{
    var data = basicInfoForm.getData();
    for (var key in requiredField) {
        if (!data[key] || data[key].trim().length == 0) {
            nui.alert(requiredField[key] + "不能为空");
            return;
        }
    }
    nui.mask({
        html: '保存中..'
    });
    doPost({
        url:saveUrl,
        data:{
            report:data
        },
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if(data.errCode == "S")
            {
                nui.alert("保存成功");
                dataGrid.reload();
            }
            else{
                nui.alert(data.errMsg||"保存失败");
            }
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
var deleteUrl = baseUrl+"com.hsapi.repair.baseData.outCar.deleteOutReport.biz.ext";
function deleteReport()
{
    var row = dataGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要删除所选报告？","提示",function(action)
        {
            if(action == "ok")
            {
                doPost({
                    url:deleteUrl,
                    data:{
                        report:{
                            id:row.id
                        }
                    },
                    success:function(data)
                    {
                        nui.unmask();
                        data = data||{};
                        if(data.errCode == "S")
                        {
                            nui.alert("删除成功");
                            dataGrid.reload();
                        }
                        else{
                            nui.alert(data.errMsg||"删除失败");
                        }
                    },
                    error:function(jqXHR, textStatus, errorThrown)
                    {
                        console.log(jqXHR.responseText);
                        nui.unmask();
                        nui.alert("网络出错");
                    }
                });
            }
        }.bind(row));
    }
}

function setData()
{
    nui.get("selectBtn").show();
}
function onOk()
{
    var row = dataGrid.getSelected();
    if(!row)
    {
        nui.alert("请选择一份报告");
    }
    resutlData.report = row;
    CloseWindow("ok");
}
var resutlData = {};
function getData()
{
    return resutlData;
}
function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}