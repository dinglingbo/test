var investGrid = null;
var baseUrl = apiPath + crmApi + "/";
var queryInvestListUrl = baseUrl+"com.hsapi.crm.svr.svr.queryInvestList.biz.ext";
var gAuditSign=[{
	"id":0,
	"text":"未审核"
},{
	"id":1,
	"text":"通过"
},{
	"id":2,
	"text":"不通过"
}];

var brandList=[];
var brandHash={};
var serviceList=[];
var serviceHash={};

$(document).ready(function(){
	investGrid = nui.get("investGrid");
	investGrid.setUrl(queryInvestListUrl);
	
	initCarBrand("carBrandId",function(data) {
		brandList = nui.get("carBrandId").getData();
		brandList.forEach(function(v) {brandHash[v.id] = v;});
	});
	initServiceType("serviceTypeId",function(data) {
		serviceList = nui.get("serviceTypeId").getData();
		serviceList.forEach(function(v) {serviceHash[v.id] = v;});
	});
	
	
	investGrid.on("rowdblclick", function(e) {
		var row = investGrid.getSelected();
		var rowc = nui.clone(row);
		if (!rowc)
			return;
		onEditClick();

	});
    document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // Enter
        	search();
        }

    }
	search();
});

function search(){
	investGrid.load({
		serviceCode:nui.get("serviceCode").getValue(),
		carNo:nui.get("carNo").getValue(),
		auditSign:nui.get("auditSign").getValue(),
		"page/isCount":true
	});
}

function onAddClick(){
	nui.open({
		url:  webPath + contextPath+ "/com.hsweb.crm.manage.investDetail.flow?token="+ token,
		title: "业绩新增",
		allowResize:false,
		width: 400, 
		height: 300,
		onload: function () {
			var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(null);
         },
         ondestroy: function (action) {
             if(action == "ok"){
            	 search();
             }
         }
	});
}

function onEditClick(){
	var data = investGrid.getSelected();
	if(data == null){
		showMsg("请先选择一条数据","W");
		return;
	}
	nui.open({
		url: webPath + contextPath+ "/com.hsweb.crm.manage.investDetail.flow?token="+ token,
		title: "业绩修改",
		allowResize:false,
		width: 400,
		height: 300,
		onload: function () {
			var iframe = this.getIFrameEl();
        	iframe.contentWindow.setData(data);
         },
         ondestroy: function (action) {
        	 if(action == "ok"){
            	 search();
             }
         }
	});
}

function onDeleteClick(){
	var data = investGrid.getSelected();
	if(data == null){
		showMsg("请先选择一条数据","W");
		return;
	}
	if(data.auditSign == 1){
		showMsg("已审核通过，无法删除","W");
		return;
	}
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在删除...'
    });

    nui.ajax({
        url :baseUrl+ "com.hsapi.crm.svr.svr.deleteInvest.biz.ext",
        type : "post",
        data : {
        	invest:data,
        	token:token
        },
        success : function(data) {
            nui.unmask();
            data = data || {};
            if (data.errCode == "S") {
                var errMsg = data.errMsg;
                showMsg(errMsg,"S");
                search();
            } else {
            	showMsg(data.errMsg || "删除失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}

function onDrawcell(e) {
	var hash = new Array("潜在客户", "回访来厂", "流失回厂");
    if(e.field == "auditSign"){
        for(var i=0;i<gAuditSign.length;i++){
            if(e.value == gAuditSign[i].id){
                e.cellHtml = gAuditSign[i].text;
            }
        }
    }
    if (e.field == "carType") {
        e.cellHtml = hash[e.value-1];
}
    if (e.field == "serviceTypeId") {
        if (serviceHash && serviceHash[e.value]) {
            e.cellHtml = serviceHash[e.value].name;
        }
    }
}



function onEditClick22(){
	var data = investGrid.getSelected();
	if(data == null){
		showMsg("请先选择一条数据","W");
		return;
	}

}
