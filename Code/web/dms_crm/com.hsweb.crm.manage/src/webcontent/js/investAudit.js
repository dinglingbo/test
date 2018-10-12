var investGrid = null;
var basicForm = null;
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
	basicForm = new nui.Form("#basicInfo");
	
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
        url : "com.hsapi.crm.svr.svr.deleteInvest.biz.ext",
        type : "post",
        data : {
        	invest:data
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
    if(e.field == "auditSign"){
        for(var i=0;i<gAuditSign.length;i++){
            if(e.value == gAuditSign[i].id){
                e.cellHtml = gAuditSign[i].text;
            }
        }
    }
}

function onRowclick(e){
	basicForm.setData(e.record);
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
        url : "com.hsapi.crm.svr.svr.aduitInvest.biz.ext",
        type : "post",
        data : {
        	invest:data
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