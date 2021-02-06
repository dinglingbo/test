baseUrl = apiPath + sysApi + "/";
var gridUrl = baseUrl + "com.primeton.tenant.comTenant.queryComCustomer.biz.ext";
var grid = null;
var gridUrl2 = baseUrl + "com.primeton.tenant.comTenant.comTenantQueryBySql.biz.ext";
var grid2 = null;
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
	
	grid2 = nui.get("datagrid2");
	grid2.setUrl(gridUrl2);

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

function setTenantId(){
	var list = [];
	var row = grid.getSelected();
	if(row){
		var queryCustomerAssociatedUrl =  baseUrl +"com.primeton.tenant.comTenant.queryComCustomerAssociated.biz.ext";
	    nui.ajax({
	        url:queryCustomerAssociatedUrl,
	        type:"post",
	        data:JSON.stringify({
	        	params:{
	        		customerId : row.id
	        		},
	        	page:{
	        			pageSize : 9999
	        		},
	        	token: token
	        }),
	        success:function(data)
	        {
	            nui.unmask();
	            data = data||{};
	            list = data.rs;
				grid2.load({},function(){
			        var rows = grid2.findRows(function(row){
			            //if(row.age > 20) return true;
			            for(var i=0;i<list.length;i++){
			            	if(list[i].tenantId == row.tenantId){
			            		grid2.setSelected ( row );
			            	}
			            }
			        });
				});	
	        },
	        error:function(jqXHR, textStatus, errorThrown){
	            //  nui.alert(jqXHR.responseText);
	           
	            closeWindow("cal");
	        }
	    });

	}else{
		showMsg("请选择行！","W");
		return;
	}
}


function save() {
	var saveUrl =  baseUrl +"com.primeton.tenant.comTenant.saveCustomerAssociated.biz.ext";
	var customer = grid.getSelected();
	if(!customer){		
		showMsg("请选择行！","W");
		return;
	}
	var rows = grid2.getSelecteds();
	var customerAssociated = [];
	for(var i=0;i<rows.length;i++){
		var temp = {};
		temp.customerId = customer.id;
		temp.tenantId = rows[i].tenantId;
		customerAssociated.push(temp);
	}
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url:saveUrl,
        type:"post",
        data:JSON.stringify({
        	customerAssociated:customerAssociated,
        	customerId : customer.id,
        	token: token
        }),
        success:function(data)
        {
            nui.unmask();
            data = data||{};
            if (data.errCode == 'S') {
                showMsg(data.errMsg,"S");
            }else{
                showMsg(data.errMsg,"W");
                //basicInfoForm.setData([]); 
            }
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
           
            closeWindow("cal");
        }
    });
}