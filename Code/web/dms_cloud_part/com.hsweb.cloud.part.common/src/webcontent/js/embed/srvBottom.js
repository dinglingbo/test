
var mainTabs = null;
var stockselect = null;    //库存明细
var pchsRecord = null;       //采购记录
var sellRecord = null;       //销售记录
var guestPrice = null;      //客户销价
var rtnRecord = null;       //退货记录
var partInfo = null;        //配件基础资料
$(document).ready(function(v) {
	mainTabs = nui.get("mainTabs");
	var tabList = mainTabs.getTabs();
	var stockselectTab =  mainTabs.getTab("stockselect");
	var pchsRecordTab =  mainTabs.getTab("pchsRecord");
	var sellRecordTab =  mainTabs.getTab("sellRecord");
	var guestPriceTab =  mainTabs.getTab("guestPrice");
	var rtnRecordTab =  mainTabs.getTab("rtnRecord");
	var partInfoTab =  mainTabs.getTab("partInfo");

	//tabs.updateTab(tabdetailPage, { visible: false });
	var type = parent.confirmType();
	if(type) {
		if(type == 'purchase'){
			//库存明细 采购记录 销售记录  
		}else if(type == 'sell'){

		}
	}
});
function setInitTab(type){
	if(type) {
		if(type == 'purchase'){nui.alert(2);
			var tabList = mainTabs.getTabs();
			console.log(tabList);
		}
	}
}
function showTabInfo(){
	//nui.alert(1);

	//parent.quickSearch(2);
}