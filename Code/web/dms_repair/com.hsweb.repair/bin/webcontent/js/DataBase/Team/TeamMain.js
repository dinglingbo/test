var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.repair.baseData.team.queryTeam.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.repair.baseData.team.queryTeamMember.biz.ext";
var leftGrid = null;
var rightGrid = null;


$(document).ready(function(v)
{
    //左边区域
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    leftGrid.on("load",function()
    {
        var row = leftGrid.getSelected();
        if(row)
        {
            onLeftGridRowClick({
                record:row
            });
        }
    });
    leftGrid.on("rowclick",function(e){
        onLeftGridRowClick(e);
    });
    //右边区域
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    rightGrid.on("load",function()
    {
        var row = rightGrid.getSelected();
        if(row)
        {
            onRightGridRowClick({
                record:row
            });
        }
    });
    rightGrid.on("rowclick",function(e){
        onRightGridRowClick(e);
    });
    onSearch(2);
});
function addOrEditTeam(team)
{
	var title = "新增班组";
    if(team)
    {
        title = "修改班组";
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.repair.DataBase.TeamDetail.flow",
        title: title, width: 300, height: 170,
        allowResize:false,
        onload: function ()
        {
        	var iframe = this.getIFrameEl();
            var params = {};
            if(team)
            {
                params.detail = team;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                leftGrid.reload();
            }
        }
    });
}
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

function addTeamMember()
{

    var team = leftGrid.getSelected();
    if(!team)
    {
        return;
    }
    nui.open({
        // targetWindow: window,
        url: "com.hsweb.repair.common.empSelect.flow",
        title: "选择用户", width: 300, height: 500,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var empList = data.empList;
             //   console.log(empList);
                empList = empList.map(function(v){
                    return {
                        emplId:v.nodeId,
                        emplName:v.nodeName,
                        classId:team.id
                    };
                });
                saveTeamMember(empList);
            }
        }
    });
}
var saveTeamMemberUrl = baseUrl+"com.hsapi.repair.baseData.team.saveTeamMembers.biz.ext";
function saveTeamMember(empList)
{
    var currList = rightGrid.getData();
    var newList = empList.filter(function(v)
    {
        for(var i=0;i<currList.length;i++)
        {
            if(v.emplId == currList[i].emplId)
            {
                return false;
            }
        }
        return true;
    });
    if(newList.length>0)
    {
        nui.mask({
            html:'保存中..'
        });
        doPost({
            url:saveTeamMemberUrl,
            data:{
                members:newList
            },
            success:function(data)
            {
                nui.unmask();
                if(data && data.errCode == "S")
                {
                	rightGrid.reload();
                    nui.alert("保存成功");
                }
                else{
                    nui.alert(data.errMsg||"保存失败");
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                //  nui.alert(jqXHR.responseText);
                console.log(jqXHR.responseText);
                nui.unmask();
                nui.alert("保存失败");
            }
        });
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
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    loadLeftGridData(params);
}

//获取数据
function loadLeftGridData(params)
{
	params.orgid = currOrgid;
    rightGrid.setData([]);
    leftGrid.load({
    	token:token,
        params:params
    });
}

//点击获取右边表格数据
function onLeftGridRowClick(e)
{
	var row = e.record;
    if(row.isDisabled)
    {
        nui.get("disabledLeft").hide();
        nui.get("enabledLeft").show();
        nui.get("addMemberBtn").disable();
    }
    else{
        nui.get("disabledLeft").show();
        nui.get("enabledLeft").hide();
        nui.get("addMemberBtn").enable();
    }
    loadRightGridData(row.id);
}
function onRightGridRowClick(e)
{
    var row = e.record;
    if(row.isDisabled)
    {
        nui.get("disabledRight").hide();
        nui.get("enabledRight").show();
    }
    else{
        nui.get("disabledRight").show();
        nui.get("enabledRight").hide();
    }
}

function loadRightGridData(classId)
{
    rightGrid.load({
    	token:token,
        classId:classId
    });
}
function reloadRightGrid(){
    rightGrid.reload();
}

//启用班组
function enableTeam(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选班组？","提示",function(action)
        {
            if(action == "ok")
            {
                saveTeam({
                    id:row.id,
                    isDisabled:0
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        leftGrid.reload();
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
//禁用班组
function disableTeam(){
    var row = leftGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选班组？","提示",function(action)
        {
            if(action == "ok")
            {
                saveTeam({
                    id:row.id,
                    isDisabled:1
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        leftGrid.reload();
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
var saveUrl = baseUrl+"com.hsapi.repair.baseData.team.saveTeam.biz.ext";
function saveTeam(data,callback)
{
    nui.mask({
        html:'保存中..'
    });
    callback = callback||function(){};
    doPost({
        url:saveUrl,
        data:{
            team:data
        },
        success:function(data)
        {
        	nui.unmask();
            callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            callback();
        }
    });
}
//禁用班组成员
function disableTeamMember()
{
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选班组成员？","提示",function(action)
        {
            if(action == "ok")
            {
                updateTeamMember({
                    id:row.id,
                    isDisabled:1
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        rightGrid.reload();
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
function enableTeamMember(){
    var row = rightGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选班组成员？","提示",function(action)
        {
            if(action == "ok")
            {
                updateTeamMember({
                    id:row.id,
                    isDisabled:0
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        rightGrid.reload();
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
var updateTeamMemberUrl = baseUrl+"com.hsapi.repair.baseData.team.updateTeamMember.biz.ext";
function updateTeamMember(member,callback)
{
    nui.mask({
        html:'保存中...'
    });
    callback = callback||function(){};
    doPost({
        url:updateTeamMemberUrl,
        data:{
            member:member
        },
        success:function(data)
        {
            nui.unmask();
            callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            nui.unmask();
            callback();
        }
    });
}