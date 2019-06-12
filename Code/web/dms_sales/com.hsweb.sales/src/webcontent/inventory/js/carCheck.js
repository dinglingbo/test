var partApiUrl  = apiPath + saleApi + "/";
var rightGridUrl=partApiUrl+"sales.inventory.queryCheckOrderDetailList.biz.ext";
var rightGrid = null;
$(document).ready(function(v){
	rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
	var dictDefs ={frameColorId:"DDT20130726000003",interialColorId:"10391"};
	initDicts(dictDefs, function(){
		getStorehouse(function(data) {
			getAllPartBrand(function(data) {
				brandList = data.brand;
				brandList.forEach(function(v) {
					brandHash[v.id] = v;
				});
		 	 	frameColorIdList = nui.get('frameColorId').getData();
 	 			interialColorIdList = nui.get('interialColorId').getData();
				gsparams.billStatusId = 2;
				gsparams.auditSign = 1;
//				quickSearch(0);

				nui.unmask();
			});
			
		});
	});
	
    rightGrid.on("drawcell", function (e) {      
        switch (e.field) {
            case "carLock":
            	 e.cellHtml = inventory[e.value].name;
                break;
            case "frameColorId":
            	e.cellHtml = setColVal('frameColorId', 'customid', 'name', e.value);
               break;
            case "interialColorId":
            	e.cellHtml = setColVal('interialColorId', 'customid', 'name', e.value);
               break;
            default:
                break;
        }
    });

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

function onClose(){
	CloseWindow("close");
}