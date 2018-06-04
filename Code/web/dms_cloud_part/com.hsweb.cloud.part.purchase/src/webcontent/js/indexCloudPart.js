/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl + "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderMainList.biz.ext";
var rightGridUrl = baseUrl + "com.hsapi.cloud.part.invoicing.svr.queryPjPchsOrderDetailList.biz.ext";

var leftGrid = null;
var rightGrid = null;

// 单据状态
var AuditSignList = [ {
	customid : '0',
	name : '未审'
}, {
	customid : '1',
	name : '已审'
}, {
	customid : '2',
	name : '已过账'
}, {
	customid : '3',
	name : '已取消'
} ];
var AuditSignHash = {
	"0" : "未审",
	"1" : "已审",
	"2" : "已过账",
	"3" : "已取消"
};
$(document).ready(function(v) {
	leftGrid = nui.get("leftGrid");
	leftGrid.setUrl(leftGridUrl);

	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);

});
var StatusHash = {
	"0" : "草稿",
	"1" : "待发货",
	"2" : "待收货",
	"3" : "部分入库",
	"4" : "全部入库",
	"5" : "已退回",
	"6" : "已关闭"
};

function toAskPartPrice(){
	nui.alert("研发中...");
}
function toPchsOrder(){
	var item={};
	item.id = "1184";
	item.text = "采购订单";
	item.url = webPath + cloudPartDomain + "/com.hsweb.cloud.part.purchase.purchaseOrder.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toSellOrder(){
	var item={};
	item.id = "1269";
	item.text = "销售订单";
	item.url = webPath + cloudPartDomain + "/com.hsweb.cloud.part.purchase.sellOrder.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toEPC(){
	var item={};
	item.id = "1521";
	item.text = "EPC云服务";
	item.url = webPath + cloudPartDomain + "/com.hsweb.system.llq.vin.vinLinkMain.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toPackOut(){
	var item={};
	item.id = "1561";
	item.text = "打包发货";
	item.url = webPath + cloudPartDomain + "/com.hsweb.cloud.part.purchase.packOut.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toState(){
	var item={};
	item.id = "1541";
	item.text = "月结对账";
	item.url = webPath + cloudPartDomain + "/com.hsweb.cloud.part.settlement.billStatement.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}
function toSettleAccount(){
	var item={};
	item.id = "1282";
	item.text = "应收应付结算";
	item.url = webPath + cloudPartDomain + "/com.hsweb.cloud.part.settlement.rpAccountSettle.flow";
	item.iconCls = "fa fa-exchange";
	window.parent.activeTab(item);
}
function toCostOut(){
	var item={};
	item.id = "1425";
	item.text = "费用支出单";
	item.url = webPath + cloudPartDomain + "/com.hsweb.cloud.part.settlement.expensePay.flow";
	item.iconCls = "fa fa-file-text";
	window.parent.activeTab(item);
}