var packageGrid = null;
var itemGrid = null;
var partGrid = null;
var sellForm = null;
$(document).ready(function(v) {
	sellForm = new nui.Form("#sellForm");
	

});


function getData(data){
		// 跨页面传递的数据对象，克隆后才可以安全使用
		data = data||{};
		var json = nui.clone(data);
		sellForm.setData(json);
}
function onPayOk(){
	packageGrid.getData();
	itemGrid.getData();
	partGrid.getData();
	
}