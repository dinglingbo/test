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
function addBrands(brand){
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
function editBrands(brand){
	nui.open({
		targetWindow: window,
        url: "CarBrandDetail.jsp",
        title: "编辑品牌", width: 400, height: 190,
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
	addBrands();
}
function editBrand(){
	var row = leftBrandGrid.getSelected();
	if(row){
		editBrands(row);
	}
}
//series
function addSerieses(series){
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
function editSerieses(series){
	nui.open({
		targetWindow: window,
        url: "CarSeriesDetail.jsp",
        title: "编辑车系", width: 600, height: 240,
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
				carBrandId:row.id
		};
		addSerieses(series);
	}
	
}
function editSeries(){
	var row = leftSeriesGrid.getSelected();
	if(row){
		editSerieses(row);
	}
}

//model
function addModels(model){
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
function editModels(model){
	nui.open({
		targetWindow: window,
        url: "CarModelDetail.jsp",
        title: "编辑车型", width: 600, height: 240,
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

//function addSeries(){
//	var row = leftBrandGrid.getSelected();
//	if(row){
//		var series = {
//				carBrandId:row.id
//		};
//		addSerieses(series);
//	}
//	
//}
//根据XX添加到父类
function addModel(){
	var row = leftSeriesGrid.getSelected();
	if(row){
		var model = {
				carBrandId:row.carBrandId,
				carSeriesId:row.id
		};
		addModels(model);
	}
	
}
function editModel(){
	var row = rightModelGrid.getSelected();
	if(row){
		editModels(row);
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
    
    loadLeftSeriesGridData(row.id);
	loadRightModelGrid(row.id);
    
}

function onLeftSeriesGridRowClick(e){
	var row = e.record;
    
    loadRightModelGrid(row.carBrandId,row.id);
    
}

function loadLeftSeriesGridData(carBrandId){
	leftSeriesGrid.load({
		carBrandId:carBrandId
	});
}
function loadRightModelGrid(carBrandId,carSeriesId){
	
	rightModelGrid.load({
		
		carBrandId:carBrandId,
		carSeriesId:carSeriesId
	});
}
//重新刷新页面
function reBrand(){
    var form = new  nui.Form("#form");
    var json = form.getData(false,false);
    leftBrandGrid.load(json);//grid查询
}
//function reloadLeftSeriesGrid(){
//	leftSeriesGrid.reload();
//}
//function reloadRightModelGrid(){
//	rightModelGrid.reload();
//}

//brand 本页面修改保存
var brandUrl = baseUrl + "com.hsapi.repair.baseData.brand.saveBrand.biz.ext";
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
//series
var seriesUrl = baseUrl + "com.hsapi.repair.baseData.brand.saveSeries.biz.ext";
function upadateData(series,callback)
{
    console.log(series);
    nui.mask({
        html:'保存中...'
    });
    nui.ajax({
        url:seriesUrl,
        type:"post",
        data:JSON.stringify({
        	series:series
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