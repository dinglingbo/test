var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var leftBrandGridUrl = baseUrl+"com.hsapi.repair.baseData.brand.queryBrand.biz.ext";
var leftSeriesGridUrl = baseUrl+"com.hsapi.repair.baseData.brand.querySeries.biz.ext";
var rightModelGridUrl = baseUrl+"com.hsapi.repair.baseData.brand.queryCarModel.biz.ext";
var leftBrandGrid = null;
var leftSeriesGrid = null;
var rightModelGrid = null;

$(document).ready(function(v){

	//左边上区域
	leftBrandGrid = nui.get("leftBrandGrid");
	leftBrandGrid.setUrl(leftBrandGridUrl);
	//左边下区域
	leftSeriesGrid = nui.get("leftSeriesGrid");
	leftSeriesGrid.setUrl(leftSeriesGridUrl);
	//右边区域
	rightModelGrid = nui.get("rightModelGrid");
	rightModelGrid.setUrl(rightModelGridUrl);
	
	loadLeftBrandGridData({});
	loadLeftSeriesGridData({});
	loadRightModelGrid({});
});
//brand
function addOrEditBrands(brand){
	nui.open({
		targetWindow: window,
        url: "CarBrandDetail.jsp",
        title: "新增品牌", width: 400, height: 190,
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
            	leftBrandGrid.reload();
            }
        }
	});
}
function addBrand(){
	addOrEditBrands();
}
function editBrand(){
	var row = leftBrandGrid.getSelected();
	if(row){
		addOrEditBrands(row);
	}
}
//series
function addOrEditSeries(series){
	nui.open({
		targetWindow: window,
        url: "CarSeriesDetail.jsp",
        title: "新增车系", width: 600, height: 240,
        allowResize:false,
        onload: function ()
        {
            if(series)
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                	series:series
                });
            }
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	leftSeriesGrid.reload();
            }
        }
	});
}
//根据XX添加到父类
function addSeries(){
	var row = leftBrandGrid.getSelected();
	if(row){
		var series = {
				parentId:row.id
		};
		addOrEditSeries(series);
	}
	
}
function editSeries(){
	var row = leftSeriesGrid.getSelected();
	if(row){
		addOrEditSeries(row);
	}
}
//model
function addOrEditModel(model){
	nui.open({
		targetWindow: window,
        url: "CarModelDetail.jsp",
        title: "新增车型", width: 600, height: 240,
        allowResize:false,
        onload: function ()
        {
            if(model)
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                	model:model
                });
            }
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
            	rightModelGrid.reload();
            }
        }
	});
}
//根据XX添加到父类
function addModel(){
	var row = rightModelGrid.getSelected();
	if(row){
		var model = {
				parentId:row.id
		};
		addOrEditModel(model);
	}
	
}
function editModel(){
	var row = rightModelGrid.getSelected();
	if(row){
		addOrEditModel(row);
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
function loadLeftBrandGridData(params){
	leftSeriesGrid.setData([]);
	rightModelGrid.setData([]);
	leftBrandGrid.load(params,function(){
		var row = leftBrandGrid.getSelected();
		if(row){
			if(row.isDisabled){
				nui.get("disabledBrand").hide();
				nui.get("enabledBrand").show();
			}else{
				nui.get("disabledBrand").show();
                nui.get("enabledBrand").hide();
			}
			loadLeftSeriesGridData(row.id);
			loadRightModelGrid(row.id);
		}
	});
}

function onLeftBrandGridRowClick(e){
	var row = e.record;
    if(row.isDisabled)
    {
        nui.get("disabledBrand").hide();
        nui.get("enabledBrand").show();
    }
    else{
        nui.get("disabledBrand").show();
        nui.get("enabledBrand").hide();
    }
    loadLeftSeriesGridData(row.id);
	loadRightModelGrid(row.id);
    
}

function loadLeftSeriesGridData(carBrandId){
	leftSeriesGrid.load({
		carBrandId:carBrandId
	},function(){
		var row = leftSeriesGrid.getSelected();
		if(row.isDisabled){
			nui.get("disabledSeries").hide();
			nui.get("enabledSeries").show();
		}else{
			nui.get("disabledSeries").show();
            nui.get("enabledSeries").hide();
		}
	});
}
function loadRightModelGrid(carBrandId){
	rightModelGrid.load({
		carBrandId:carBrandId
	},function(){
		var row = rightModelGrid.getSelected();
		if(row.isDisabled){
			nui.get("disabledModel").hide();
			nui.get("enabledModel").show();
		}else{
			nui.get("disabledModel").show();
            nui.get("enabledModel").hide();
		}
	});
}
//function reloadLeftSeriesGrid(){
//	leftSeriesGrid.reload();
//}
//function reloadRightModelGrid(){
//	rightModelGrid.reload();
//}

//brand
var brandUrl = "com.hsapi.repair.baseData.brand.saveBrand.biz.ext";
function upadateData(brand,callback)
{
    console.log(brand);
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:brandUrl,
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