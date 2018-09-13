var packageGrid = null;
var itemGrid = null;
var partGrid = null;

$(document).ready(function(v) {
	packageGrid = nui.get("packageGrid");
	itemGrid = nui.get("itemGrid");
	partGrid = nui.get("partGrid");
	

});

function onPayOk(){
	packageGrid.getData();
	itemGrid.getData();
	partGrid.getData();
	
}