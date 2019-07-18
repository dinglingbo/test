baseUrl = apiPath + sysApi + "/";
var querCustomerUrl = baseUrl + "com.primeton.tenant.comTenant.queryCusomer.biz.ext";
$(document).ready(function(){
	setCustomer();
});

function setCustomer(){
    nui.ajax({
        url:querCustomerUrl,
        type:"post",
        data:JSON.stringify({
        	params:{
        		tenantId : currTenantId
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
        }
    });
}