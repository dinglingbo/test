
/*
FileReader共有4种读取方法：
1.readAsArrayBuffer(file)：将文件读取为ArrayBuffer。
2.readAsBinaryString(file)：将文件读取为二进制字符串
3.readAsDataURL(file)：将文件读取为Data URL
4.readAsText(file, [encoding])：将文件读取为文本，encoding缺省值为'UTF-8'
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
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

var storehouse =[];
var storeHash ={};
$(document).ready(function(v)
{

	mainGrid = nui.get("mainGrid");
	advancedTipWin = nui.get("advancedTipWin");
	advancedTipForm  = new nui.Form("#advancedTipForm");
	
	getStorehouse(function(data){
        storehouse = data.storehouse||[];
        storehouse.forEach(function(v){
        	storeHash[v.name] =v;
        });
    });
	nui.get("openBtn").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	onClose();
        }
      };

});

function initData(data){
	partBrandIdList = data.partBrandIdList||[];
    partBrandIdList.forEach(function(v)
    {
        partBrandIdHash[v.name] = v;
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
	partCode : "配件编码",
	partBrandId : "品牌",
	storeId : "仓库"
};
function sure() {
	var data = mainGrid.getData();
	var stockList = [];
	var length = 0;//用于限制大小不能超过一千
	if (data) {
		//alert(data.length);
		for (var i = 0; i < data.length; i++) {
			length++;
			if(length>1000){
				parent.parent.showMsg("导入不能超过一千条，请重新选择文件！","W");
				return;
			}
			var newRow = {};
			newRow.partBrandId = data[i].品牌||"";
			newRow.partCode = data[i].配件编码||"";
			newRow.storeId = data[i].仓库||"";
			newRow.shelf = data[i].仓位||"";
			newRow.upLimit = data[i]["库存上限(夏季)"]||"";
			newRow.downLimit = data[i]["库存下限(夏季)"] ||"";
			newRow.upLimitWinter = data[i]["库存上限(冬季)"]||"";
			newRow.downLimitWinter = data[i]["库存下限(冬季)"]||"";
			newRow.minOrderQty = data[i].最小起订量||"";
			newRow.minPackQty = data[i].最小包装量||"";
			


			for ( var key in requiredField) {
				if (!newRow[key] || $.trim(newRow[key]).length == 0) {
					parent.parent.showMsg("请完善第"+(i+1)+"行记录的"+requiredField[key]+"!","W");
					return;
				}
			}

			if(storeHash && storeHash[newRow.storeId]){
				newRow.storeId = storeHash[newRow.storeId].id;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的仓库信息有误!","W");
				return;
			}
			

			if(partBrandIdHash && partBrandIdHash[newRow.partBrandId]){
				newRow.partBrandId = partBrandIdHash[newRow.partBrandId].id;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的品牌信息有误!","W");
				return;
			}

			

			stockList.push(newRow);
		}
		//btnEdit.setValue(data.id);
		//btnEdit.setText(data.guestname);
	}

	//faddPart(partList);
	  nui.confirm("确定导入吗？", "友情提示",function(action){
	       if(action == "ok"){
	    		saveStock(stockList);
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

var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.getImportStockSet.biz.ext";
function saveStock(stockList){
	if(stockList && stockList.length>0) {
		nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '正在导入...'
	    });

	    nui.ajax({
	        url : saveUrl,
	        type : "post",
	        data : JSON.stringify({
	            list : stockList,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                var errMsg = data.errMsg;
	                if(errMsg){
//						nui.get("fastCodeList").setValue(errMsg);
//						advancedTipWin.show();
						parent.parent.showMsg(errMsg,"S");
						CloseWindow('ok');
	                }else{
						parent.parent.showMsg("导入成功!","S");
						CloseWindow('ok');
	                }
	            } else {
					nui.get("fastCodeList").setValue(data.errMsg);
					advancedTipWin.show();
					//parent.parent.showMsg(data.errMsg || "导入失败!","W");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            // nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
		
	}

}


function CloseWindow(action) {
	if (action == "close") {
	} else if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else
		return window.close();
}

function onClose(){
	window.CloseOwnerWindow();	
}