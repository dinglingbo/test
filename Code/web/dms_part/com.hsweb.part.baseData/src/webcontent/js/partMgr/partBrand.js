var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
$(document).ready(function(v){
	
});


function getPartBrandLetter(letter){
	var queryPartBrandUrl = baseUrl +"com.hsapi.system.dict.dictMgr.queryPartBrandParams.biz.ext";
	var params = {
			firstCodeCh : letter
			//name : document.getElementById("brandName").value
	};
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	nui.ajax({
		url : queryPartBrandUrl,
		type : "post",
		aynsc:false,
		data : {
			params:params,
			token:token
		},
		success : function(data) {		
			nui.unmask(document.body);
			if (data.errCode == "S") {
				
				
			}else{
				showMsg("查询失败","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function getPartBrandName(){
	var queryPartBrandUrl = baseUrl +"com.hsapi.system.dict.dictMgr.queryPartBrandParams.biz.ext";
	var params = {
			name : document.getElementById("brandName").value
	};
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});
	nui.ajax({
		url : queryPartBrandUrl,
		type : "post",
		aynsc:false,
		data : {
			params:params,
			token:token
		},
		success : function(data) {		
			nui.unmask(document.body);
			if (data.errCode == "S") {
				
				
			}else{
				showMsg("查询失败","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
