
var partId;
var dgGrid;

$(document).ready(function(v){
    partId = nui.get("partId");
    dgGrid = nui.get("dgGrid");
});

/*
* 配件编码查询
*/
function doSearch(){
    var partCode = partId.getValue();
    if(!partCode){
        showMsg("请输入宝马配件编码！", "W");
        return;
    }
    
    var url = apiPath + cloudPartApi + "/com.hsapi.cloud.part.common.bmw.bmwParts.biz.ext";
    var params = {
        "partId": partCode,
        "token": token
    }
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