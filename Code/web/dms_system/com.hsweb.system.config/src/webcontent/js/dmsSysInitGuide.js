

function initSysParamsCfg(){
	var item={};
	item.id = "initSysParamsCfg";
	item.text = "系统参数";
	item.url = webPath + sysDomain + "/config/parameterSet.jsp";
	item.iconCls = "fa fa-cog";
	window.parent.activeTab(item);
}


function initComStoreCfg(){
	var item={};
	item.id = "initComStoreCfg";
	item.text = "仓库管理";
	item.url = webPath + sysDomain + "/com.hsweb.part.baseData.storehouseMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}


function initComPartTypeCfg(){
	var item={};
	item.id = "initComPartTypeCfg";
	item.text = "配件分类";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.partTypeSet.flow";
	item.iconCls = "fa fa-sitemap";
	window.parent.activeTab(item);
}

function initComPartBrandCfg(){
	var item={};
	item.id = "initComPartBrandCfg";
	item.text = "配件品牌";
	item.url = webPath + sysDomain + "/com.hsweb.part.baseData.partBrandMgr.flow";
	item.iconCls = "fa fa-sitemap";
	window.parent.activeTab(item);
}

function initBeginPeriodStockCfg(){
	var item={};
	item.id = "initBeginPeriodStockCfg";
	item.text = "期初库存";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.initPartStock.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initCarBarndCfg(){
	var item={};
	item.id = "initCarBarndCfg";
	item.text = "品牌车型";
	item.url = webPath + sysDomain + "/com.hsweb.repair.DataBase.BrandMain.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initInsuranceCompanyCfg(){
	var item={};
	item.id = "initInsuranceCompanyCfg";
	item.text = "保险公司";
	item.url = webPath + sysDomain + "/com.hsweb.repair.DataBase.InsuranceMain.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initCheckReportCfg(){
	var item={};
	item.id = "initCheckReportCfg";
	item.text = "出车报告";
	item.url = webPath + sysDomain + "/com.hsweb.repair.DataBase.OutCarMain.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initFiSettleAccountCfg(){
	var item={};
	item.id = "initFiSettleAccountCfg";
	item.text = "结算账户";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.settleAccoutSet.flow";
	item.iconCls = "fa fa-credit-card-alt";
	window.parent.activeTab(item);
}

function initFiSettleAccountBalanceCfg(){
	var item={};
	item.id = "initFiSettleAccountBalanceCfg";
	item.text = "期初现金银行";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.initSettleAccountBala.flow";
	item.iconCls = "fa fa-credit-card-alt";
	window.parent.activeTab(item);
}

function initRPBillCfg(){
	var item={};
	item.id = "initRPBillCfg";
	item.text = "期初应收应付";
	item.url = webPath + sysDomain + "/com.hsweb.cloud.part.basic.initQCRPBill.flow";
	item.iconCls = "fa fa-exchange";
	window.parent.activeTab(item);
}

function toTeamMainSet(){
	var item={};
	item.id = "TeamMain";
	item.text = "班组定义";
	item.url = webPath + sysDomain + "/com.hsweb.repair.DataBase.TeamMain.flow";
	item.iconCls = "fa fa-vcard";
	window.parent.activeTab(item);
}


function initComAttributeSet(){
	var item={};
	item.id = "1463";
	item.text = "配件管理";
	item.url = webPath + sysDomain + "/com.hsweb.part.baseData.partMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function initComGuestSet(){
	var item={};
	item.id = "1462";
	item.text = "供应商管理";
	item.url = webPath + sysDomain + "/com.hsweb.part.baseData.supplierMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}
