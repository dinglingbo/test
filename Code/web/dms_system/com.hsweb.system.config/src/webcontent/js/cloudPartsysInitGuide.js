

function toSysSet(){
	var item={};
	item.id = "initCloudSysParams";
	item.text = "系统参数";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.paramMgr.flow";
	item.iconCls = "fa fa-cog";
	window.parent.activeTab(item);
}

function toComPartTypeSet(){
	var item={};
	item.id = "1466";
	item.text = "配件分类";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.partTypeSet.flow";
	item.iconCls = "fa fa-sitemap";
	window.parent.activeTab(item);
}

function toComAttributeSet(){
	var item={};
	item.id = "1463";
	item.text = "配件管理";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.partMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function toComStoreSet(){
	var item={};
	item.id = "1467";
	item.text = "仓库管理";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.storehouseMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function toComGuestSet(){
	var item={};
	item.id = "1462";
	item.text = "供应商管理";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.supplierMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function toPartStockSet(){
	var item={};
	item.id = "initPartStock";
	item.text = "期初库存";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.initPartStock.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function toFiSettleAccountSet(){
	var item={};
	item.id = "1441";
	item.text = "结算账户";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.settleAccoutSet.flow";
	item.iconCls = "fa fa-credit-card-alt";
	window.parent.activeTab(item);
}

function toFiSettleAccountBalanceSet(){
	var item={};
	item.id = "1422";
	item.text = "期初现金银行";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.initSettleAccountBala.flow";
	item.iconCls = "fa fa-credit-card-alt";
	window.parent.activeTab(item);
}

function toRPBillSet(){
	var item={};
	item.id = "1423";
	item.text = "期初应收应付";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.initQCRPBill.flow";
	item.iconCls = "fa fa-exchange";
	window.parent.activeTab(item);
}

function toOrgSetSet(){
	var item={};
	item.id = "sysSet";
	item.text = "公司属性";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.sysSet.flow";
	item.iconCls = "fa fa-cog";
	window.parent.activeTab(item);
}
//function toTeamMainSet(){
//	var item={};
//	item.id = "TeamMain";
//	item.text = "班组定义";
//	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.TeamMain.flow";
//	item.iconCls = "fa fa-vcard";
//	window.parent.activeTab(item);
//}

function toPartDeductSet(){
	var item={};
	item.id = "1424";
	item.text = "配件提成";
	item.url = webPath + contextPath + "/com.hsweb.cloud.part.basic.partDeductSet.flow";
	item.iconCls = "fa fa-cog";
	window.parent.activeTab(item);
}
