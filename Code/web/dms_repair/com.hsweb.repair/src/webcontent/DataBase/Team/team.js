/**
 * Created by Administrator on 2018/1/24.
 */

var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.repair.team.TeamQuery.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.repair.team.TeamQuery.biz.ext";
var leftGrid = null;
var rightGrid = null;
var splitter = null;
$(document).ready(function(v)
{
	//splitter = nui.get("splitter");
    //console.log(splitter);
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    loadLeftGridData({});
});



function addTeam()
{
	addOrEditTeam();
}
function editTeam()
{
    var row = leftGrid.getSelected();
    if(row)
    {
    	addOrEditTeam(row);
    }
}


function addOrEditTeamMember(brand){
    nui.open({
        targetWindow: window,
        url: "com.hsweb.repair.DataBase.TeamDetail.flow",
        title: "添加班组成员", width: 350, height: 200,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            if(brand)
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                    brand:brand
                });
            }
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                rightGrid.reload();
            }
        }
    });
}

function addTeamMember()
{
    var quality = leftGrid.getSelected();
    if(quality)
    {
        var brand = {
            parentId:quality.id
        };
        addOrEditPartBrand(brand);
    }
}

function onDrawCell(e)
{
    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==1?"禁用":"启用";
            break;
        default:
            break;
    }
}
function onSearch(type)
{
    var params = {};
    if(type == 1||type == 0)
    {
        params.isDisabled = type;
    }
    loadLeftGridData(params);
}
function loadLeftGridData(params)
{
    rightGrid.setData([]);
    leftGrid.load(params,function()
    {
        var row = leftGrid.getSelected();
        if(row)
        {
            if(row.isDisabled)
            {
                nui.get("disabledLeft").hide();
                nui.get("enabledLeft").show();
            }
            else{
                nui.get("disabledLeft").show();
                nui.get("enabledLeft").hide();
            }
            loadRightGridData(row.id);
        }
    });
}
function onLeftGridRowClick(e)
{
    var row = e.record;
    if(row.isDisabled)
    {
        nui.get("disabledLeft").hide();
        nui.get("enabledLeft").show();
    }
    else{
        nui.get("disabledLeft").show();
        nui.get("enabledLeft").hide();
    }
    loadRightGridData(row.id);
}
function loadRightGridData(parentId)
{
    rightGrid.load({
        parentId:parentId
    },function(){
        var row = rightGrid.getSelected();
        if(row.isDisabled)
        {
            nui.get("disabledRight").hide();
            nui.get("enabledRight").show();
        }
        else{
            nui.get("disabledRight").show();
            nui.get("enabledRight").hide();
        }
    });
}
function reloadRightGrid(){
    rightGrid.reload()
}

function disableTeam(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选班组？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:1
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 1;
                        leftGrid.updateRow(row,row);
                        nui.get("disabledLeft").hide();
                        nui.get("enabledLeft").show();
                        nui.alert("禁用成功");
                    }
                    else{
                        nui.alert(data.errMsg||"禁用失败");
                    }
                });
            }
        }.bind(row));
    }
}
function enableTeam(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选品质？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:0
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 0;
                        leftGrid.updateRow(row,row);
                        nui.get("disabledLeft").show();
                        nui.get("enabledLeft").hide();
                        nui.alert("启用成功");
                    }
                    else{
                        nui.alert(data.errMsg||"启用失败");
                    }
                });
            }
        }.bind(row));
    }
}
function disablePartBrand()
{
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:1
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 1;
                        rightGrid.updateRow(row,row);
                        nui.get("disabledRight").hide();
                        nui.get("enabledRight").show();
                        nui.alert("禁用成功");
                    }
                    else{
                        nui.alert(data.errMsg||"禁用失败");
                    }
                });
            }
        }.bind(row));
    }
}
function enablePartBrand()
{
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateIsDisabled({
                    id:row.id,
                    isDisabled:0
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        row.isDisabled = 0;
                        rightGrid.updateRow(row,row);
                        nui.get("disabledRight").show();
                        nui.get("enabledRight").hide();
                        nui.alert("启用成功");
                    }
                    else{
                        nui.alert(data.errMsg||"启用失败");
                    }
                });
            }
        }.bind(row));
    }
}
var updateIsDisabledUrl = baseUrl+"com.hsapi.part.baseDataCrud.crud.savePartBrand.biz.ext";
function updateIsDisabled(brand,callback)
{
    console.log(brand);
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:updateIsDisabledUrl,
        type:"post",
        data:JSON.stringify({
            brand:brand
        }),
        success:function(data)
        {
            nui.unmask();
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}