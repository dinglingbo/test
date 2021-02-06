

function initSysParamsCfg(){
	var item={};
	item.id = "initSysParamsCfg";
	item.text = "系统参数";
	item.url = webPath + contextPath + "/com.hsweb.system.config.paramMgr.flow?token="+token;//webPath + contextPath + "/config/parameterSet.jsp";
	item.iconCls = "fa fa-cog";
	window.parent.activeTab(item);
}
function initImport(){
	var item={};
	item.id = "initImport";
	item.text = "导入功能";
	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.import.flow?token="+token;
	item.iconCls = "fa fa-cog";
	window.parent.activeTab(item);
}

function initComStoreCfg(){
	var item={};
	item.id = "initComStoreCfg";
	item.text = "仓库管理";
	item.url = webPath + contextPath + "/com.hsweb.part.baseData.storehouseMgrT.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}


function initComPartTypeCfg(){
	var item={};
	item.id = "initComPartTypeCfg";
	item.text = "配件分类";
	item.url = webPath + contextPath + "/com.hsweb.part.manage.partTypeSet.flow";
	item.iconCls = "fa fa-sitemap";
	window.parent.activeTab(item);
}

function initComPartBrandCfg(){
	var item={};
	item.id = "initComPartBrandCfg";
	item.text = "配件品牌";
	item.url = webPath + contextPath + "/com.hsweb.part.baseData.partBrandMgrT.flow";
	item.iconCls = "fa fa-sitemap";
	window.parent.activeTab(item);
}

function initBeginPeriodStockCfg(){
	var item={};
	item.id = "initBeginPeriodStockCfg";
	item.text = "期初库存";
	item.url = webPath + contextPath + "/com.hsweb.part.manage.initPartStock.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initCarBarndCfg(){
	var item={};
	item.id = "initCarBarndCfg";
	item.text = "品牌车型";
	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.BrandMain.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initInsuranceCompanyCfg(){
	var item={};
	item.id = "initInsuranceCompanyCfg";
	item.text = "保险公司";
	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.InsuranceMain.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initCheckReportCfg(){
	var item={};
	item.id = "initCheckReportCfg";
	item.text = "出车报告";
	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.OutCarMain.flow";
	item.iconCls = "fa fa-cube";
	window.parent.activeTab(item);
}

function initFiSettleAccountCfg(){
	var item={};
	item.id = "initFiSettleAccountCfg";
	item.text = "结算账户";
	item.url = webPath + contextPath + "/com.hsweb.frm.arap.settleAccoutSet.flow";
	item.iconCls = "fa fa-credit-card-alt";
	window.parent.activeTab(item);
}

function initFiSettleAccountBalanceCfg(){
	var item={};
	item.id = "initFiSettleAccountBalanceCfg";
	item.text = "期初现金银行";
	item.url = webPath + contextPath + "/com.hsweb.frm.manage.initSettleAccountBala.flow";
	item.iconCls = "fa fa-credit-card-alt";
	window.parent.activeTab(item);
}

function initRPBillCfg(){
	var item={};
	item.id = "initRPBillCfg";
	item.text = "期初应收应付";
	item.url = webPath + contextPath + "/com.hsweb.frm.arap.initQCRPBill.flow";
	item.iconCls = "fa fa-exchange";
	window.parent.activeTab(item);
}

function toTeamMainSet(){
	var item={};
	item.id = "TeamMain";
	item.text = "班组定义";
	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.TeamMain.flow";
	item.iconCls = "fa fa-vcard";
	window.parent.activeTab(item);
}


function initComAttributeSet(){
	var item={};
	item.id = "1463";
	item.text = "配件管理";
	item.url = webPath + contextPath + "/com.hsweb.part.baseData.partMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function initComGuestSet(){
	var item={};
	item.id = "1462";
	item.text = "供应商管理";
	item.url = webPath + contextPath + "/com.hsweb.part.baseData.supplierMgr.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function importMaintain(){
	var item={};
	item.id = "importMaintain";
	item.text = "导入工单";
	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.importMaintain.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}

function companyMgr(){
	var item={};
	item.id = "companyMgr";
	item.text = "门店管理";
	item.url = webPath + contextPath + "/com.hs.common.orgExtendT.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}
function appointmentMgr(){
	var item={};
	item.id = "appointmentMgr";
	item.text = "预约参数";
	item.url = webPath + contextPath + "/com.hsweb.repair.DataBase.appointmentParamsSet.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}
function partDeductMgr(){
	var item={};
	item.id = "partDeductMgr";
	item.text = "配件提成";
	item.url = webPath + contextPath + "/com.hsweb.part.manage.partDeductSet.flow";
	item.iconCls = "fa fa-file";
	window.parent.activeTab(item);
}
