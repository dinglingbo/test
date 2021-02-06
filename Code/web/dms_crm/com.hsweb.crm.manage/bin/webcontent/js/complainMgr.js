var baseUrl = apiPath + crmApi + "/";
var queryComplainList = baseUrl+"com.hsapi.crm.svr.svr.queryComplainList.biz.ext";
var mainGrid = null;

$(document).ready(function(){
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryComplainList);
	search();
});

function search(){
	var params = {
			sEnterDate:nui.get("sEnterDate").getValue(),
			eEnterDate:nui.get("eEnterDate").getValue(),
			"page/isCount":true
	};
	mainGrid.load({
		params:params
	});
}

function eidComplain(){
	var row = mainGrid.getSelected();
	if (row) {
		 nui.open({
	         url: "com.hsweb.crm.manage.complainDetail.flow",
	         title: "客户投诉修改",
	         width: 750, 
	         height: 600,
	         onload: function () {
	             var iframe = this.getIFrameEl();
	             iframe.contentWindow.setData(row);
	         },
	         ondestroy: function (action) {
	 			if (action == "ok") {
	 				mainGrid.reload();
	 				nui.alert("保存成功","提示");
				}
	         }
	     });
	} else {
		nui.alert("请选中一条记录", "提示");
	}

}

function addComplain(){
	 nui.open({
        url: "com.hsweb.crm.manage.complainDetail.flow",
        title: "客户投诉登记",
        width: 750, 
        height: 600,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(null);
        },
        ondestroy: function (action) {
			if (action == "ok") {
				mainGrid.reload();
				nui.alert("保存成功","提示");
			}
        }
    });
}