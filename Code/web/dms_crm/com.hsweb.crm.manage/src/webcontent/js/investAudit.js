var investGrid = null;
var baseUrl = apiPath + crmApi + "/"; 
	var queryInvestListUrl = baseUrl+"com.hsapi.crm.svr.svr.queryInvestList.biz.ext";
var basicForm = null;
var rpsPackageGrid = null;
var rpsItemGrid = null;
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

var gIsOutBill=[{
	"id":0,
	"text":"否"
},{
	"id":1,
	"text":"是"
}];
var brandList=[];
var brandHash={};

$(document).ready(function(){
	investGrid = nui.get("investGrid");
	rpsPackageGrid = nui.get("rpsPackageGrid");
	rpsItemGrid = nui.get("rpsItemGrid");
	investGrid.setUrl(queryInvestListUrl);
	basicForm = new nui.Form("#basicInfo");
	initCarBrand("carBrandIdEl",function(data) {
		brandList = nui.get("carBrandIdEl").getData();
		brandList.forEach(function(v) {brandHash[v.id] = v;});
	});
	initServiceType("serviceTypeIdEl",null);
	
	document.onkeyup = function(event) {
        var e = event || window.event;
        var keyCode = e.keyCode || e.which;// 38向上 40向下
        

        if ((keyCode == 13)) { // ESC
        	search();
        }

    }
	search();
	basicForm.setEnabled(false);
});

function search(){
	investGrid.load({
		serviceCode:nui.get("serviceCode").getValue(),
		carNo:nui.get("carNo").getValue(),
		auditSign:nui.get("auditSign").getValue(),
		"page/isCount":true
	});
}


function onDeleteClick(){
	var data = investGrid.getSelected();
	if(data == null){
		nui.alert("请先选择一条数据");
		return;
	}
	if(data.auditSign == 1){
		nui.alert("已审核通过，无法删除");
		return;
	}
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在删除...'
    });

    nui.ajax({
        url : baseUrl+"com.hsapi.crm.svr.svr.deleteInvest.biz.ext",
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
                nui.alert(errMsg);
                search();
                basicForm.clear();
            } else {
            	nui.alert(data.errMsg || "删除失败!");
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
    if (e.field == "carBrandId") {
        if (brandHash && brandHash[e.value]) {
            e.cellHtml = brandHash[e.value].name;
        }
    }
    if (e.field == "carType") {
            e.cellHtml = hash[e.value-1];
    }
}

function onRowclick(e){
	basicForm.setData(e.record);
	var p1 = {
			interType: "package",
			data:{
				serviceId: e.record.serviceId||0
			}
		};
		var p2 = {
			interType: "item",
			data:{
				serviceId: e.record.serviceId||0
			}
		};
		var p3 = {
			interType: "part",
			data:{
				serviceId: e.record.serviceId||0
			}
		};
		loadDetail(p1, p2, p3);

}

function onAuditClick(auditSign){
	var data = investGrid.getSelected()
	if(data.auditSign != 0){
		nui.alert("已审核，无法再次审核");
		return;
	}
	data.auditSign = auditSign;
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '正在加载...'
    });

    nui.ajax({
        url : baseUrl+"com.hsapi.crm.svr.svr.aduitInvest.biz.ext",
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
                nui.alert(errMsg);
                search();
            } else {
            	nui.alert(data.errMsg || "审核失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
        	nui.unmask();
            console.log(jqXHR.responseText);
        }
    });
}
function loadDetail(p1, p2, p3){
	if(p1 && p1.interType){
		getBillDetail(p1, function(text){
			var errCode = text.errCode;
			var data = text.data||[];
			if(errCode == "S"){
				rpsPackageGrid.clearRows();
				rpsPackageGrid.addRows(data);
				rpsPackageGrid.accept();
			}
		}, function(){});
	}
	if(p2 && p2.interType){
		getBillDetail(p2, function(text){
			var errCode = text.errCode;
			var data = text.data||[];
			if(errCode == "S"){
				rpsItemGrid.clearRows();
				rpsItemGrid.addRows(data);
				rpsItemGrid.accept();
			}
		}, function(){});
	}
}
