
var baseUrl = apiPath + partApi + "/";
var protoken=null;
var partGrid=null;
var protokenEl=null;
var partGridUrl=baseUrl+"com.hsapi.part.invoice.partInterface.queryJoinStock.biz.ext"
$(document).ready(function() {
    protokenEl=nui.get('protoken');
	partGrid =nui.get('partGrid');
	partGrid.setUrl(partGridUrl);
});


function onSearch (){
	protoken =protokenEl.value;
	partGrid.load({
		protoken :protoken
	});
}