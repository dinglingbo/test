/**
 * Created by Administrator on 2018/1/29.
 */

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
		//右边区域
		rightGrid = nui.get("rightGrid");
		rightGrid.setUrl(rightGridUrl);
		loadLeftGridData({});
		loadRightGridData({});
});
	
	function addOrEditTeam(team)
	{
	    nui.open({
	        targetWindow: window,
	        url: "addEditTeam.jsp",
	        title: "班组", width: 400, height: 200,
	        allowResize:false,
	        onload: function ()
	        {
	            if(team)
	            {
	                var iframe = this.getIFrameEl();
	                iframe.contentWindow.setData({
	                	team:team
	                });
	            }
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
	
	function addOrEditTeamMember(member)
	{
	    nui.open({
	        targetWindow: window,
	        url: "addEditTeamMember.jsp",
	        title: "班组成员", width: 400, height: 200,
	        allowDrag:true,
	        allowResize:false,
	        onload: function ()
	        {
	            if(member)
	            {
	                var iframe = this.getIFrameEl();
	                iframe.contentWindow.setData({
	                	member:member
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
		 var team = leftGrid.getSelected();
		    if(team)
		    {
		        var member = {
		            parentId:team.id
		        };
		        addOrEditTeamMember(member);
		    }
	}
	function editTeamMember()
	{
	    var member = rightGrid.getSelected();
	    if(member)
	    {
	    	addOrEditTeamMember(member);
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
	    loadRightGridData(params);
	}
	
	//获取数据
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
	
	//点击获取右边表格数据
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
	
	function loadRightGridData(classId)
	{
	    rightGrid.load({
	    	classId:classId
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
	    rightGrid.reload();
	}
	
	//启用班组
	function enablePartTeam(){
	    var row = leftGrid.getSelected();
	    if(row)
	    {
	        nui.confirm("确定要启用所选班组？","提示",function(action)
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
	//禁用班组
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
	//禁用班组成员
	function disablePartBrand()
	{
	    var row = rightGrid.getSelected();
	    if(row)
	    {
	        nui.confirm("确定要禁用所选班组成员？","提示",function(action)
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
	
	var updateIsDisabledUrl = baseUrl+"com.hsapi.repair.baseData.team.saveTeamMember.biz.ext";
	function updateIsDisabled(member,callback)
	{
	    console.log(member);
	    nui.mask({
	        html:'保存中...'
	    });
	    nui.ajax({
	        url:updateIsDisabledUrl,
	        type:"post",
	        data:JSON.stringify({
	        	member:member
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
	
	
	
	
	
	
	
	
	
	
	
	
	