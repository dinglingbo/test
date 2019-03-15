
var partId;
var dgGrid;

$(document).ready(function(v){
    //partId = nui.get("partId");
    dgGrid = nui.get("dgGrid");

    if(partCode){
        var params = {
            "partId": partCode,
            "token": token
        }
        doSearch(params);
    }
});

/*
* 配件编码查询
*/
function doSearch(params){
    if(!params.partId){
        //showMsg("请输入宝马配件编码！", "W");
        return;
    }
    
    var url = apiPath + cloudPartApi + "/com.hsapi.cloud.part.common.bmw.bmwParts.biz.ext";
    // var params = {
    //     "partId": partCode,
    //     "token": token
    // }
    callAjax(url, params, processAjax, setGridData, document.body);
}

/*
*dgGrid 数据
*/
function setGridData(data, json){
    var tmpData = [];
    tmpData.push(data);
    dgGrid.setData(tmpData);
}

function onBmwDrawCell(e){
	var record = e.record;
	switch (e.field) {
	   case "stockQtySy01Bj" :
		   if(e.value>=1){
			   e.cellHtml="<span style='color:green;' class='fa fa-circle fa-lg'></span>";
		   }
		   break;
	   case  "stockQtySy02Sh" :
		   if(e.value>=1){
			   e.cellHtml="<span style='color:green;' class='fa fa-circle fa-lg'></span>";
		   }
		   break;
	   case  "stockQtySy03Gz"  :
		   if(e.value>=1){
			   e.cellHtml="<span style='color:green;' class='fa fa-circle fa-lg'></span>";
		   }
		   break;
	   case  "stockQtySy06Cd"  :
		   if(e.value>=1){
			   e.cellHtml="<span style='color:green;' class='fa fa-circle fa-lg'></span>";
		   }
		   break;
	   case "stockQtySy07Sy" :
		   if(e.value>=1){
			   e.cellHtml="<span style='color:green;' class='fa fa-circle fa-lg'></span>";
		   }
		   break;
	   default:
		   break;
	}
}