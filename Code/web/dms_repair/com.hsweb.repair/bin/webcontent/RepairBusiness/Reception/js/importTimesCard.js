
/*
FileReader共有4种读取方法：
1.readAsArrayBuffer(file)：将文件读取为ArrayBuffer。
2.readAsBinaryString(file)：将文件读取为二进制字符串
3.readAsDataURL(file)：将文件读取为Data URL
4.readAsText(file, [encoding])：将文件读取为文本，encoding缺省值为'UTF-8'
 */
var baseUrl = apiPath + repairApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var wb;//读取完成的数据
var rABS = false; //是否将文件读取为二进制字符串
var mainGrid = null;
var nstoreId = null;
var enterMain = null;
var advancedTipWin = null;
var advancedTipForm = null;

var partBrandIdList = [];
var partBrandIdHash = {};
var carBrandList = [];
var carBrandHash = {};

$(document).ready(function(v)
{

	mainGrid = nui.get("mainGrid");
	advancedTipWin = nui.get("advancedTipWin");
	advancedTipForm  = new nui.Form("#advancedTipForm");

});

function initData(data){
	partBrandIdList = data.partBrandIdList||[];
    partBrandIdList.forEach(function(v)
    {
        partBrandIdHash[v.name] = v;
	});
	
	carBrandList = data.carBrandList||[];
    carBrandList.forEach(function(v)
    {
        carBrandHash[v.nameCn] = v;
	});

}

function importf(obj) {//导入
	if (!obj.files) {
		return;
	}
	var f = obj.files[0];
	var reader = new FileReader();
	reader.onload = function(e) {
		var data = e.target.result;
		if (rABS) {
			wb = XLSX.read(btoa(fixdata(data)), {//手动转化
				type : 'base64'
			});
		} else {
			wb = XLSX.read(data, {
				type : 'binary'
			});
		}
		//wb.SheetNames[0]是获取Sheets中第一个Sheet的名字
		//wb.Sheets[Sheet名]获取第一个Sheet的数据
		//document.getElementById("demo").innerHTML= JSON.stringify( XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]) );
		var columns = JSON.stringify(XLSX.utils
				.sheet_to_json(wb.Sheets[wb.SheetNames[0]]));
		var indexs = XLSX.utils
				.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		mainGrid.addRows(indexs);
	};
	if (rABS) {
		reader.readAsArrayBuffer(f);
	} else {
		reader.readAsBinaryString(f);
	}
}

function fixdata(data) { //文件流转BinaryString
	var o = "", l = 0, w = 10240;
	for (; l < data.byteLength / w; ++l)
		o += String.fromCharCode.apply(null, new Uint8Array(data.slice(
				l * w, l * w + w)));
	o += String.fromCharCode.apply(null, new Uint8Array(data.slice(l
			* w)));
	return o;
}
var requiredField = {
		carNo : "车牌号",
	itemName: "项目名称",
	totalTimes : "总次数",
	useTimes : "已使用次数"
};
function sure() {
	if(!importTimeLimit()){
		parent.parent.showMsg("请在规定时间内导入！","W");
		return;
	}
	var data = mainGrid.getData();
	var partList = [];
	var length = 0;//用于限制大小不能超过一千
	if (data) {
		//alert(data.length);
		for (var i = 0; i < data.length; i++) {
			length++;
			if(length>4000){
				parent.parent.showMsg("导入不能超过四千条，请重新选择文件！","W");
				return;
			}
			var newRow = {};
			newRow.carNo = data[i].车牌号||"";
			newRow.itemName = data[i].项目名称||"";
			newRow.totalTimes = data[i].总次数||"";
			newRow.useTimes = data[i].已使用次数||"";


		for ( var key in requiredField) {
				if (!newRow[key] || $.trim(newRow[key]).length == 0) {
					parent.parent.showMsg("请完善第"+(i+1)+"行记录的"+requiredField[key]+"!","W");
					return;
				}
			}
		  partList.push(newRow);

		}

	}
	//判断客户有没有选择
	  nui.confirm("确定导入吗？", "友情提示",function(action){
	       if(action == "ok"){
	    	   saveEnterPart(partList);
	     }else {
				return;
		 }
		 }); 
	
}

function clear(){
	mainGrid.setData([]);
}

function close(){
	if (window.CloseOwnerWindow) return window.CloseOwnerWindow("cancel");
    else window.close();
}

var saveUrl = baseUrl + "com.hsapi.repair.repairService.crud.getImportTimesCard.biz.ext";
function saveEnterPart(partList){
	if(partList && partList.length>0) {
		nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '正在导入...'
	    });

	    nui.ajax({
	        url : saveUrl,
	        type : "post",
	        data : JSON.stringify({
	            list : partList,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                var errMsg = data.errMsg;
	                if(errMsg){
						nui.get("fastCodeList").setValue(errMsg);
						advancedTipWin.show();
						//showMsg(errMsg,"S");
	                }else{
	                	parent.parent.showMsg("导入成功!","S");
	                }
	            } else {
					nui.get("fastCodeList").setValue(data.errMsg);
					advancedTipWin.show();
					//showMsg(data.errMsg || "导入失败!","W");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            // nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
		
	}

}