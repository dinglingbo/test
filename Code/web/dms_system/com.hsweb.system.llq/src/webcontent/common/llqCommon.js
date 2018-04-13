//http://14.23.35.20:6288/dms/com.hsweb.system.llq.call.doCall.biz.ext

var url = "com.hsweb.system.llq.call.doCall.biz.ext";
url = "http://g-part.cn:8070/api/sign007";

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
    //参数匹配
    var p = {}
    p.url = params.url.replace("//llq.", "//llqapitm.")
    p.data = [];
    p.data.push(params.params);
    /*for(var k in obj){//用javascript的for/in循环遍历对象的属性 
        //temp += i+":"+obj[i]+"\n"; 
        alert(k + '=' + obj[k]);
        //params.data.push({k:obj[k]});
    }
    //return;*/
    
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
    }*/
    var rs = eval("(" + data + ")");
    //rs = data;
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