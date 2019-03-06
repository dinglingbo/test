var baseUrl = apiPath + cloudPartApi + "/";
var packGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.paramcrud.queryPJPackList.biz.ext";
var getDetailUrl=baseUrl+"com.hsapi.cloud.part.invoice.svr.queryPjPchsOrderDetailList.biz.ext";
var innnerGridUrl=baseUrl+"com.hsapi.cloud.part.invoice.svr.queryPjSellOrderDetailList.biz.ext";
var basicInfoForm = null;
var packGrid=null;
var innerGrid=null;
var detailGrid=null;

$(document).ready(function(v){
	packGrid=nui.get('packGrid');
	packGrid.setUrl(packGridUrl);
	innerGrid=nui.get('innerGrid');
	innerGrid.setUrl(innnerGridUrl);
	detailGrid =nui.get('detailGrid');
	detailGrid.setUrl(getDetailUrl);
	packGrid.load({params:{},token:token});
});