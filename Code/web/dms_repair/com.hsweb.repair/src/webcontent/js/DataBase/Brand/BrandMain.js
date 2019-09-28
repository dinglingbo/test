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
    leftBrandGrid.on("load",function()
    {
        var row = leftBrandGrid.getSelected();
        if(row)
        {
            onLeftBrandGridRowClick({
                record:row
            });
        }
    });
    

    leftBrandGrid.on("rowclick",function(e)
    {
        onLeftBrandGridRowClick(e);
    });
	//左边下区域
	leftSeriesGrid = nui.get("leftSeriesGrid");
	leftSeriesGrid.setUrl(leftSeriesGridUrl);
	//右边区域
	rightModelGrid = nui.get("rightModelGrid");
	rightModelGrid.setUrl(rightModelGridUrl);
    rightModelGrid.on("load",function()
    {
        var row = rightModelGrid.getSelected();
        if(row)
        {
            onRightModelGridRowClick({
                record:row
            });
        }
        rightModelGrid.mergeColumns(["carFactoryName","carSeriesName"]);
    });
    rightModelGrid.on("rowclick",function(e)
    {
        onRightModelGridRowClick(e);
    });
    
    leftBrandGrid.on("rowdblclick", function(e) {
        var row = leftBrandGrid.getSelected();
        var rowc = nui.clone(row);
        if (!rowc)
            return;
        editBrand();

    });
    
    leftSeriesGrid.on("rowdblclick", function(e) {
        var row = leftSeriesGrid.getSelected();
        var rowc = nui.clone(row);
        if (!rowc)
            return;
        editSeries();

    });
    
    rightModelGrid.on("rowdblclick", function(e) {
        var row = rightModelGrid.getSelected();
        var rowc = nui.clone(row);
        if (!rowc)
            return;
       editModel();

    });

	onSearch(currType);
});
var currType = 2;
function getSearchParams(type)
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
    currType = type;
    return params;
}
function onSearch(type)
{
    var params = getSearchParams(type);
    loadLeftBrandGridData(params);
}
function loadLeftBrandGridData(params)
{
    leftSeriesGrid.clearRows();
    rightModelGrid.clearRows();
    leftBrandGrid.load({
    	token:token,
        params:params
    });
}
//选择(单击)品牌时
function onLeftBrandGridRowClick(e)
{
    var row = e.record;
    if(row)
    {
        if(row.isDisabled == 1)
        {
            nui.get("disableBrand").hide();
            nui.get("enableBrand").show();
        }
        else{
            nui.get("enableBrand").hide();
            nui.get("disableBrand").show();
        }
        loadLeftSeriesGridData(row.id);
        loadRightModelGrid(row.id);
    }

}
//加载车系
function loadLeftSeriesGridData(carBrandId)
{
    var params = getSearchParams(currType);
    params.carBrandId = carBrandId;
    leftSeriesGrid.load({
    	token:token,
        params:params
    });
}
//加载车型
function loadRightModelGrid(carBrandId)
{
    var params = getSearchParams(currType);
    params.carBrandId = carBrandId;
    rightModelGrid.load({
    	token:token,
        params:params
    });
}
function onRightModelGridRowClick(e)
{
    var row = e.record;
    if(row)
    {
        if(row.isDisabled == 1)
        {
            nui.get("disableModel").hide();
            nui.get("enableModel").show();
        }
        else{
            nui.get("enableModel").hide();
            nui.get("disableModel").show();
        }
    }
}

//brand
function addOrEditBrand(brand)
{
    var title = "新增品牌";
    if(brand)
    {
        title = "修改品牌";
    }
	nui.open({
		// targetWindow: window,
        url: "com.hsweb.repair.DataBase.CarBrandDetail.flow",
        title: title, width: 400, height: 290,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {};
            if(brand)
            {
                params.brand = brand;
            }
            iframe.contentWindow.setData(params);
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
    addOrEditBrand();
}
function editBrand(){
	var row = leftBrandGrid.getSelected();
	if(row){
        addOrEditBrand(row);
	}
}

function disableBrand()
{
    var row = leftBrandGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateBrand({
                    id:row.id,
                    isDisabled:1
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        leftBrandGrid.reload();
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
function enableBrand()
{
    var row = leftBrandGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选品牌？","提示",function(action)
        {
            if(action == "ok")
            {
                updateBrand({
                    id:row.id,
                    isDisabled:0
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        leftBrandGrid.reload();
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
var brandUrl = baseUrl + "com.hsapi.repair.baseData.brand.saveBrand.biz.ext";
function updateBrand(brand,callback)
{
    nui.mask({
        html:'保存中...'
    });
    doPost({
        url:brandUrl,
        data:{
            brand:brand
        },
        success:function(data)
        {
            nui.unmask();
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}


//series
function addOrEditSeries(series)
{
  var title = "新增车系";
  if(series && series.id)
  {
      title = "修改车系";
  }
  nui.open({
      // targetWindow: window,
      url: "com.hsweb.repair.DataBase.CarSeriesDetail.flow",
      title: title, width: 600, height: 230,
      allowResize:false,
      onload: function ()
      {
          var iframe = this.getIFrameEl();
          var params = {};
          if(series)
          {
              params.series = series;
          }
          iframe.contentWindow.setData(params);
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
function addSeries(){
	var row = leftBrandGrid.getSelected();
	if(row){
		var series = {
          carBrandId:row.id,
          carBrandName:row.carBrandZh
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
function addOrEditModel(model)
{
  var title = "新增车型";
  if(model && model.id)
  {
      title = "修改车型";
  }
  nui.open({
      // targetWindow: window,
      url: "com.hsweb.repair.DataBase.CarModelDetail.flow",
      title: title, width: 600, height: 230,
      allowResize:false,
      onload: function ()
      {
          var iframe = this.getIFrameEl();
          var params = {};
          if(model)
          {
              params.model = model;
          }
          iframe.contentWindow.setData(params);
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
function addModel()
{
	var row = leftBrandGrid.getSelected();
	if(row){
		var model = {
          carBrandId:row.id,
          carBrandName:row.carBrandZh
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

function disableModel()
{
    var row = rightModelGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要禁用所选车型？","提示",function(action)
        {
            if(action == "ok")
            {
                updateModel({
                    id:row.id,
                    isDisabled:1
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        rightModelGrid.reload();
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
function enableModel()
{
    var row = rightModelGrid.getSelected();
    if(row)
    {
        nui.confirm("确定要启用所选车型？","提示",function(action)
        {
            if(action == "ok")
            {
                updateModel({
                    id:row.id,
                    isDisabled:0
                },function(data)
                {
                    data = data||{};
                    if(data.errCode == "S")
                    {
                        rightModelGrid.reload();
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
var modelUrl = baseUrl + "com.hsapi.repair.baseData.brand.saveModel.biz.ext";
function updateModel(model,callback)
{
    nui.mask({
        html:'保存中...'
    });
    doPost({
        url:modelUrl,
        data:{
            model:model
        },
        success:function(data)
        {
            nui.unmask();
            callback && callback(data);
        },
        error:function(jqXHR, textStatus, errorThrown)
        {
            console.log(jqXHR.responseText);
            nui.unmask();
            nui.alert("网络出错");
        }
    });
}
function onDrawCell(e)
{
    switch (e.field)
    {
        case "isDisabled":
            e.cellHtml = e.value==1?"禁用":"启用";
            break;
        case "imageUrl":
        	if(e.value){   	             		
        		e.cellHtml = "<img src='"+ e.value+ "'alt='配件图片' height='25px' width=' '/><br>";
        	}else{
        		e.cellHtml = "";
        	}
            break;            
        default:
            break;
    }
}