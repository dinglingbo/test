baseUrl = apiPath + sysApi + "/";
var gridUrl = baseUrl + "com.primeton.tenant.comTenant.queryComCustomer.biz.ext";
var grid = null;

$(document).ready(function(v) {
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	search();
	
	grid.on("drawcell", function (e) {
        var record = e.record;
        if (e.field == "sex") {
        	if(e.value==1) {
        		e.cellHtml = "男";
        	}else if(e.value==0) {
            	e.cellHtml = "女";
            }
        }
    });
});


function edit() {
    var row = grid.getSelected();
    nui.open({
        url: webPath + contextPath + "/common/editCustomer.jsp?token="+token,
        width: 480,         //宽度
        height: 350,        //高度
        title: "客服信息",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {  //弹出页面关闭前
            if (action == "ok") {       //如果点击“确定”
                search();
            }
        }
    });	    
}

function add() {
    var row = {};
    nui.open({
        url: webPath + contextPath + "/common/editCustomer.jsp?token="+token,
        width: 480,         //宽度
        height: 350,        //高度
        title: "客服信息",      //标题 组织编码选择
        allowResize:true,
        onload: function () {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {  //弹出页面关闭前
            if (action == "ok") {       //如果点击“确定”
                search();
            }
        }
    });	    
}

function search(){
	var params = {};
	params.name = nui.get("name").getValue();
	params.mobile = nui.get("mobile").getValue();
	grid.load({params : params,token:token});
}

function addTenantId(){
	var row = grid.getSelected();
	if(row){
	    nui.open({
	        url: webPath + contextPath + "/common/tenantIdList.jsp?token="+token,
	        width: 600,         //宽度
	        height: 550,        //高度
	        title: "客服信息",      //标题 组织编码选择
	        allowResize:true,
	        onload: function () {
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.setData(row);
	        },
	        ondestroy: function (action) {  //弹出页面关闭前
	            if (action == "ok") {       //如果点击“确定”
	                search();
	            }
	        }
	    });	
	}else{
		showMsg("请选择行！","W");
		return;
	}
}