var bearUrl  = apiPath +saleApi + "/";
var rightGridUrl = bearUrl+"sales.inventory.queryCheckEnter.biz.ext";
var advancedSearchForm = null;
$(document).ready(function(v){
	advancedSearchForm = nui.get("advancedSearchForm");
});

function setData(row){
	advancedSearchForm.setData(row);
}