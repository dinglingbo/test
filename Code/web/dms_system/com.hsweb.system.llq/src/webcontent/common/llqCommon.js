//http://14.23.35.20:6288/dms/com.hsweb.system.llq.call.doCall.biz.ext

var url = "com.hsweb.system.llq.call.doCall.biz.ext";
url = "http://g-part.cn:8071/api/sign007";
url = "https://jp-part.xyz/007/api/signfrom007";//?access_token=8a6b82f8-8392-48d0-ba8f-d93b8154409b

function loadData(url, params, callBack){
	callAjax(url, params, processRs);
    nui.ajax({
		url: url,
		type: "post",
		cache: false,
        data: params,
        timeout : 60000,
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
		},
        complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
    　　　　if(status=='timeout'){//超时,status还有success,error等值的情况
     　　　　　 ajaxTimeoutTest.abort();
    　　　　　  alert("超时");
    　　　　}
    　　}
	});
}

/*
* 执行Ajax
*/
function callAjax(url, params, processAjax, callBack){
    //参数匹配
    var p = {}
    p.url = params.url.replace("//llq.", "//llqapitm.")
    p.data = [];
    p.access_token="8a6b82f8-8392-48d0-ba8f-d93b8154409b";
    var obj = params.params;
    for(var k in obj){//用javascript的for/in循环遍历对象的属性 
        var tmp = {};
        tmp[k] = obj[k];
        //alert(k + '=' + obj[k]);
        p.data.push(tmp);
    }
    
    nui.ajax({
		url: url,
		type: "POST",
        data: JSON.stringify(p),
		contentType: 'application/json;charset=utf-8',
        dataType:"json",
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
function processAjax(data, callBack){
    /*
    if(rs.errCode != 'E' && rs.result.code == '1'){
        //nui.alert("获取数据成功！");
        callBack(rs.result.data, rs.result);
    }
    else{
        nui.alert("获取数据失败！\n\r[" + (rs.errMsg || rs.result.msg) + "]");
    }
    */
    //极配
    var rs = eval("(" + data + ")");
    if(rs.code == '1'){
        //nui.alert("获取数据成功！");
        callBack(rs.data, rs);
    }
    else{
        nui.alert("获取数据失败！\n\r[" + (rs.errMsg || rs.msg) + "]");
    }
}

/*
*处理键值对串
*/
function processKeyValue(list){
    var dataList=[];
    var tmpList;
    var tmp={};
    for(var i=0; i<list.length; i++){
        tmpList = list[i].split(":");
        tmp.field1 = tmpList[0] || "";
        tmp.field2 = tmpList[1] || "";
        dataList[i] = nui.clone(tmp);
    }
    return dataList;
}

/*
*零件图片处理
*/
function setPartImg(data, rs){
    vinPartImg.attr("src", data.imgurl);
}