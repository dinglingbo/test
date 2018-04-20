
/*
* 命名SQL通用查询(可行转置列)
*/
function callNSQL(params, processAjax, callBack, obj){
	var url = "com.hs.common.unify.intfc.biz.ext";
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
            
            if(processAjax){
                processAjax(json, callBack);                
            }else if(callBack){
                callBack(json.result || json.data || json.rs, json);
            }
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
        if(callBack){
            callBack(json.result || json.data || json.rs, json);
        }
    }
    else{
        //nui.alert("获取数据失败！\n\r[" + (json.errMsg) + "]");// || json.result.msg第三方接口定义消息
        nui.alert(json.errMsg || "操作失败！");
    }
}

function showSuccess(data, json){
    if(json.errCode == 'S'){
        nui.alert(json.errMsg || "操作成功！");        
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

//字数统计
function charCount(objId){
    var obj = nui.get("objId");
    var txt = obj.getInputText() || "";
    //target.setValue(txt.length);
    return txt.length;
}

//表单验证
function formValidate(tform){
    tform.validate();
    if (!tform.isValid()){
        nui.alert(tform.getErrors().length + "个必填项未填写，请检查所有页填写信息！")
        return false;
    }
    return true;    
}

//取消
function onCancel(){
    closeWindow("cancel"); //ok
}

//关闭
function closeWindow(action) {
    var a = true;
    if (action == "cancel") {
        a = window.confirm("是否关闭本页面？", "友情提示!");
    }
    
    if (a == true) {
        if (window.CloseOwnerWindow)
            return window.CloseOwnerWindow(action);
        else
            window.close();
    }
    return false;
}

//设置dataGrid的Column字典值(值，中文)
function setColVal(dataFrom, value, name, eValue){//数据源（控件），值，中文，实际值
    var dataList;
    if(typeof dataFrom=="string"){
        dataList = nui.get(dataFrom).getData();
    }else{
        dataList = dataFrom;
    }
    
    for (var i = 0; i < dataList.length; i++) {
        if (dataList[i][value] == eValue) return dataList[i][name];
    }
    return eValue;
}