
var baseUrl = apiPath + partApi + "/";
var rightGridUrl = baseUrl+"com.hsapi.part.baseDataCrud.query.queryPartMatchs.biz.ext";
var rightGrid =null;
var detailGrid = null;
var detailGridUrl =  baseUrl+"com.hsapi.part.baseDataCrud.query.queryPartMatchDetail.biz.ext";
var resultData = {};
var callback=null;

$(document).ready(function(v)
{
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);	
	detailGrid = nui.get("detailGrid");
	detailGrid.setUrl(detailGridUrl);
	
	rightGrid.on("selectionchanged", function(e) {
		var row = rightGrid.getSelected();
		var params={};
		params.parentId = row.id;
		detailGrid.load({
			params: params,
			token: token
		});
	});
	rightGrid.on("rowdblclick", function(e) {
		onOk();       
	});
	 document.onkeyup=function(event){
		    var e=event||window.event;
		    var keyCode=e.keyCode||e.which;
		  
		    if((keyCode==13))  {  //Enter
		    	onSearch();
	        }
		    if((keyCode==27))  {  //ESC
		    	onCancel();
	        }
		}
	
	onSearch();

});

function setInitData(){
	onSearch();
}
function onSearch(){
	var param = getSearchParams();
	doSearch(param);
}

function doSearch(params){
	rightGrid.load({
		params: params,
		token :token
	});
}

function getSearchParams(){
	var params = {};  
    params.partCode = nui.get('partCode').getValue().replace(/\s+/g, "");
    params.partName =  nui.get('partName').getValue().replace(/\s+/g, ""); 
    return params;
}

function onOk()
{
    var node = rightGrid.getSelecteds();
    var nodec = nui.clone(node);
    for(var i=0;i<nodec.length;i++){
    	nodec[i].orderQty =1;
    }
    var detailData =detailGrid.getData(); 
    for(var i=0;i<detailData.length;i++){
    	detailData[i].orderQty =detailData[i].qty
    }
    
    if(!nodec)
    {
        return;
    }
    resultData = {
      rightData: nodec,
      detailData : detailData
    };
    CloseWindow("ok");
    

}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel() {
    CloseWindow("cancel");
}

function getData(){
	return resultData;
}