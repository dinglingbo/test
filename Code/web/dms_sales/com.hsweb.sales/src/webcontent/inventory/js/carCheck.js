var partApiUrl  = apiPath + saleApi + "/";
var rightGridUrl=partApiUrl+"sales.inventory.queryCheckOrderDetailList.biz.ext";
var rightGrid = null;
$(document).ready(function(v){
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
     rightGrid.load({
    	 params:{
    		 checkingQty : 0 
    	 },
        token:token
    });
});

function getRow() {
    return rightGrid.getSelected();
}

function onCancel() {
    CloseWindow("cancel");
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else
        window.close();
}

function choose(){
	CloseWindow("ok");
}