//http://14.23.35.20:6288/dms/com.hsweb.system.llq.call.doCall.biz.ext

var url = "com.hsweb.system.llq.call.doCall.biz.ext";
var llq_pre_url = "http://124.172.221.179:81";

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
    //url = url.replace("llq.","llqapitm.");
    params.token = "214e2f71-4237-4601-9a1a-538bf982b995";
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
        callBack(rs.result.data, rs.result);
    }else if(rs.errCode != 'E' && rs.result.code == '6'){//针对输入零件号判断品牌的接口,如果
        var data = rs.result.data;
        if(data && data.length > 0){
            callBack(rs.result.data, rs.result);
        }else{
            nui.alert("获取数据失败！\n\r[" + (rs.errMsg || rs.result.msg) + "]");
        }
    }else if(rs.errCode != 'E' && rs.result.code == '4007'){
        selectBrand(rs.result.brand_list, rs.result);//brandQuery
    }else if(rs.errCode != 'E' && rs.result.code == '4005'){
        //alert("该类型正在调试中，后续开放！[4005]");
        selectConfig(rs.result.brand_list, rs.result);
    }else if(rs.errCode != 'E' && rs.result.code == '4003'){
        selectBrand4003(rs.result.data, rs.result);
    }else{
        nui.alert("获取数据失败！\n\r[" + (rs.errMsg || rs.result.msg) + "]");
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