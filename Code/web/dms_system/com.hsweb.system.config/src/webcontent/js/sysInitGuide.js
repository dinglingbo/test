

function toSysSet(){
	var item={};
	item.id = "sysSet";
	item.text = "公司属性";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.sysSet.flow";
	item.iconCls = "fa fa-cog";
	window.parent.activeTab(item);
}

function toComPartTypeSet(){
	var item={};
	item.id = "partTypeSet";
	item.text = "配件分类";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.partTypeSet.flow";
	item.iconCls = "fa fa-sitemap";
	window.parent.activeTab(item);
}

function toComAttributeSet(){
	var item={};
	item.id = "partMgr";
	item.text = "配件资料";
	item.url = webPath + sysDomain + "/com.hsweb.part.baseData.partMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function toComStoreSet(){
	var item={};
	item.id = "partMgr";
	item.text = "仓库管理";
	item.url = webPath + sysDomain + "/com.hsweb.part.baseData.storehouseMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function toComGuestSet(){
	var item={};
	item.id = "partMgr";
	item.text = "供应商管理";
	item.url = webPath + sysDomain + "/com.hsweb.part.baseData.supplierMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function toPartStockSet(){
	var item={};
	item.id = "initPartStock";
	item.text = "期初库存";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.initPartStock.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}



