//http://14.23.35.20:6288/dms/com.hsweb.system.llq.call.doCall.biz.ext

var url = "com.hsweb.system.llq.call.doCall.biz.ext";

function loadData(url, params, callBack){
	nui.ajax({
		url: url,
		type: "post",
		cache: false,
        data: params,
		contentType: 'text/json',
		success: function (json) {
            if(json.result.code == '1'){
                //nui.alert("获取数据成功！");
                callBack(json.result.data);
            }
            else{
                nui.alert("获取数据失败！");
            }
		},
		error: function () {
			nui.alert("获取数据遇到错误！");
		}
	});
}