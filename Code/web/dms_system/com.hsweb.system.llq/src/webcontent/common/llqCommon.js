//http://14.23.35.20:6288/dms/com.hsweb.system.llq.call.doCall.biz.ext

var url = "com.hsweb.system.llq.call.doCall.biz.ext";

function loadData(url, params, callBack){
	callAjax(url, params, processRs);
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

/*
* 执行Ajax
*/
function callAjax(url, params, processAjax, callBack){
	nui.ajax({
		url: url,
		type: "post",
        data: params,
		contentType: 'text/json',
		success: function (json) {
            processAjax(json, callBack);
		},
		error: function () {
			nui.alert("获取数据遇到错误！");
		}
	});
}

/*
* 处理Ajax结果
*/
function processAjax(rs, callBack){
    if(rs.errCode != 'E' && rs.result.code == '1'){
        //nui.alert("获取数据成功！");
        callBack(rs.result.data);
    }
    else{
        nui.alert("获取数据失败！\n\r[" + (rs.errMsg || rs.result.msg) + "]");
    }
}