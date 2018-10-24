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

$(document).ready(function(){
	investGrid = nui.get("investGrid");
	investGrid.setUrl(queryInvestListUrl);
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
		nui.alert("请先选择一条数据");
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
                nui.alert(errMsg);
                search();
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
    if (e.field == "carType") {
        e.cellHtml = hash[e.value-1];
}
}