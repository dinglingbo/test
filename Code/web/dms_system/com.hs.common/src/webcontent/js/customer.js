baseUrl = apiPath + sysApi + "/";
var querCustomerUrl = baseUrl + "com.primeton.tenant.comTenant.queryCusomer.biz.ext";
$(document).ready(function(){
});
function setData(){
	setCustomer();
	
}
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
        	var html="";
        	var index = data.rs.length+5;
            for(var i = 0;i<data.rs.length;i++){
            	if(i==0){
                	html+='<div class="bookPage frist">';		
                	html+='		 <img src="img/dataImg1.png" /> ';
                	html+='</div>';
                	html+='<div class="bookPage runPage" style="z-index:'+index+';">';
                	html+='		<div class="bookWord" style="z-index:'+index+';">';
                	html+='			<p>姓名：&nbsp;&nbsp;&nbsp;'+data.rs[i].name+'</p>';
                	html+='			<p>性别：&nbsp;&nbsp;&nbsp;'+data.rs[i].sex+'</p>';
                	html+='			<p>签名：&nbsp;&nbsp;&nbsp;'+data.rs[i].sign+'</p>';
                	html+='			<p>电话：&nbsp;&nbsp;&nbsp;'+data.rs[i].mobile+'</p>';
                	html+='			<p>QQ&nbsp;：&nbsp;&nbsp;&nbsp;'+data.rs[i].qq+'</p>';
                	html+='			<p>微信：&nbsp;&nbsp;&nbsp;'+data.rs[i].wechat+'</p>';
                	html+='			<p>邮箱：&nbsp;&nbsp;&nbsp;'+data.rs[i].email+'</p>';                	
                	html+='		</div>';
                	html+='		<img src="img/dataImg3.png" style="z-index:'+(parseFloat(index)-1)+';"/>';
                	html+='</div>';
            	}else if(i==data.rs.length-1){           		
                	html+='<div class="bookPage runPage" style="z-index:'+index+';">';
                	html+='		<div class="bookWord" style="z-index:'+index+';">';
                	html+='			<p>姓名：&nbsp;&nbsp;&nbsp;'+data.rs[i].name+'</p>';
                	html+='			<p>性别：&nbsp;&nbsp;&nbsp;'+data.rs[i].sex+'</p>';
                	html+='			<p>签名：&nbsp;&nbsp;&nbsp;'+data.rs[i].sign+'</p>';
                	html+='			<p>电话：&nbsp;&nbsp;&nbsp;'+data.rs[i].mobile+'</p>';
                	html+='			<p>QQ&nbsp;：&nbsp;&nbsp;&nbsp;'+data.rs[i].qq+'</p>';
                	html+='			<p>微信：&nbsp;&nbsp;&nbsp;'+data.rs[i].wechat+'</p>';
                	html+='			<p>邮箱：&nbsp;&nbsp;&nbsp;'+data.rs[i].email+'</p>';                	
                	html+='		</div>';
                	html+='		<img src="img/dataImg3.png" style="z-index:'+(parseFloat(index)-1)+';"/>';                	
                	html+='</div>';
                	html+='<div class="bookPage last">';
                	html+='		<div class="bookWord">';
                	html+='			<span>Ocean</span></span>';              	
                	html+='			<span class="pageNumber">我们会做得更好！</span>';
                	html+='		</div>';
                	html+='</div>';
            	}else{
                	html+='<div class="bookPage runPage" style="z-index:'+index+';">';
                	html+='		<div class="bookWord" style="z-index:'+index+';">';
                	html+='			<p>姓名：&nbsp;&nbsp;&nbsp;'+data.rs[i].name+'</p>';
                	html+='			<p>性别：&nbsp;&nbsp;&nbsp;'+data.rs[i].sex+'</p>';
                	html+='			<p>签名：&nbsp;&nbsp;&nbsp;'+data.rs[i].sign+'</p>';
                	html+='			<p>电话：&nbsp;&nbsp;&nbsp;'+data.rs[i].mobile+'</p>';
                	html+='			<p>QQ&nbsp;：&nbsp;&nbsp;&nbsp;'+data.rs[i].qq+'</p>';
                	html+='			<p>微信：&nbsp;&nbsp;&nbsp;'+data.rs[i].wechat+'</p>';
                	html+='			<p>邮箱：&nbsp;&nbsp;&nbsp;'+data.rs[i].email+'</p>';                	
                	html+='		</div>';
                	html+='		<img src="img/dataImg3.png" style="z-index:'+(parseFloat(index)-1)+';"/>';                	
                	html+='</div>';
            	}
            	index = index-2;
            }

        	$("#demo").append(html);
        },
        error:function(jqXHR, textStatus, errorThrown){
        }
    });
}