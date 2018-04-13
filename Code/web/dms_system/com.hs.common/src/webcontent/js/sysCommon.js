
/*
* 命名SQL通用查询(可行转置列)
*/
function callNSQL(params, processAjax, callBack, obj){
	var url = "com.hs.commons.unify.intfc.biz.ext";
    if(params){
        params.token = token;
    }
	callAjax(url, params, processAjax, callBack, obj);
}

/*
* 执行Ajax
*/
function callAjax(url, params, processAjax, callBack, obj){
	if(obj){
        nui.mask({
            el: obj,
            cls: 'mini-mask-loading',
            html: '加载中...'
        });
    }
    
    if(params){
        params.token = token;
    }
    
    nui.ajax({
		url: url,
		type: "post",
        data: params,
		contentType: 'text/json',
		success: function (json) {
            if(obj){
                nui.unmask(obj);
            }
            processAjax(json, callBack);
		},
		error: function () {
			nui.alert("获取数据遇到错误！");
            if(obj){
                nui.unmask(obj);
            }
		}
	});
}

/*
* 处理Ajax结果
*/
function processAjax(json, callBack){
    if(json.errCode != 'E'){//&& json.result.code == '1' 第三方接口定义代码
        //nui.alert("获取数据成功！");
        callBack(json.result || json.data || json.rs);
    }
    else{
        nui.alert("获取数据失败！\n\r[" + (json.errMsg) + "]");// || json.result.msg第三方接口定义消息
    }
}

/*
*处理键值对串为Array
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

Number.prototype.toFixed = function( digits ){//处理部分浏览器不兼容返回结果不一致
    if(!digits){
    	digits = 0;
    }
    return (parseInt(this * Math.pow(10, digits) + 0.5)/Math.pow(10, digits)).toString();
}