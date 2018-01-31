/**
 * Created by Administrator on 2018/1/29.
 */

var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.repair.team.TeamQuery.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.repair.team.TeamMemberQuery.biz.ext";
var leftGrid = null;
var rightGrid = null;
var splitter = null;

	$(document).ready(function(v)
{
		leftGrid = nui.get("leftGrid");
		leftGrid.setUrl(leftGridUrl);
		rightGrid = nui.get("rightGrid");
		rightGrid.setUrl(rightGridUrl);
		loadLeftGridData({});
});
	
	function onIsDisabled(e) {
        if (e.value == 1) return "禁用";
        if (e.value == 0) return "启用";
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
	    rightGrid.reload();
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
	
	function addTeam(){
		nui.open({
			url:"TeamDetail.jsp",
			title:"添加班组",width:400,height:200,
			onload:function(){
			    var iframe = this.getIFrameEl();
			    var data = {pageType:"add"};
			    iframe.contentWindow.setFormData(data);
			},
			
		    ondestroy:function(action){
		    grid.reload();
		}	
		});
		
	}
	function editTeam(){
	    var row = grid.getSelected();
	    if(row) {
	        nui.open({
	            url:"TeamEdit.jsp",
	            title:"编辑",
	            width:400,
	            height:200,
	            onload:function(){
	                var iframe = this.getIFrameEl();
	                var data = row;
	                //直接从页面获取，不用去后台获取
	                iframe.contentWindow.setData(data);
	            },
	            ondestroy:function(action){
	                if(action == "saveSuccess"){
	                    grid.reload();
	                }
	            }
	        });
	    }else {
	        nui.alert("请选中一条数据", "系统提示");
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
	