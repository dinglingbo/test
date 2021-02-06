baseUrl = apiPath + sysApi + "/";
var gridUrl = baseUrl + "com.primeton.tenant.comTenant.comTenantQueryBySql.biz.ext";
var grid = null;
var list = [];
var customer = {};//客服人员
$(document).ready(function(){
	grid = nui.get("datagrid1");
	grid.setUrl(gridUrl);
	grid.load({},function(){
        var rows = grid.findRows(function(row){
            //if(row.age > 20) return true;
            for(var i=0;i<list.length;i++){
            	if(list[i].tenantId == row.tenantId){
            		grid.setSelected ( row );
            	}
            }
        });
	});
});



function setData(row){
	customer = row;
	var queryCustomerAssociatedUrl =  baseUrl +"com.primeton.tenant.comTenant.queryComCustomerAssociated.biz.ext";
    nui.ajax({
        url:queryCustomerAssociatedUrl,
        type:"post",
        data:JSON.stringify({
        	params:{
        		customerId : customer.id
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
                //var  = grid.getData();
            list = data.rs;
        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
           
            closeWindow("cal");
        }
    });
}
function save() {
	var saveUrl =  baseUrl +"com.primeton.tenant.comTenant.saveCustomerAssociated.biz.ext";
	var rows = grid.getSelecteds();
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
            	if (window.CloseOwnerWindow){
            		 closeWindow("ok");
                } else {
                	 closeWindow("cal");
                }
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

function close() {
	if (window.CloseOwnerWindow){
		return window.CloseOwnerWindow('OK');
    } else {
        window.close();
        return ;
    }
}

function Oncancel(){
    closeWindow("cal");
}