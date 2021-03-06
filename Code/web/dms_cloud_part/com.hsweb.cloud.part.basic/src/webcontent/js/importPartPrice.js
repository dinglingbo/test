
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
var ftype = null;;//strategy,unify
var fstrategyId = null;
var brandHash = {};
var brandList = [];
var qualityHash = {};
var qualityList = [];
var compBrandList = [];
var compBrandHash = {};

$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");
    
    var dictDefs ={"orgCarBrandId": "10444"};
	initDicts(dictDefs, function(){
		
		compBrandList = nui.get("orgCarBrandId").getData();
		compBrandList.forEach(function(v){
			compBrandHash[v.name]=v;
    	});
		
		getAllPartBrand(function(data) {
			brandList = data.brand;
			brandList.forEach(function(v) {
				brandHash[v.name] = v;
			});
	
			qualityList = data.quality;
			qualityList.forEach(function(v) {
				qualityHash[v.name] = v;
			});
		});
	});

});

function initData(data){
	ftype = data.type;
	fstrategyId = data.strategyId;
}
// 提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    var row = e.row;

    editor.validate();
    if (editor.isValid() == false) {
		showMsg("请输入数字!","W");
        e.cancel = true;
    } 
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

function sure() {
	var data = mainGrid.getData();
	var partList = [];
	if (data) {
		//alert(data.length);
		for (var i = 0; i < data.length; i++) {
			//partid  partcode  partname  enterqty  enterunit  enterprice  enteramt
			var newRow = {
				partCode : data[i].配件编码||"",
				sellPrice : data[i].单价||""
			};

			var orgCarBrandId = (data[i].厂牌||"").replace(/(^\s*)|(\s*$)/g, "");
			var qualityTypeId = (data[i].品质||"").replace(/(^\s*)|(\s*$)/g, "");
			var partBrandId = (data[i].品牌||"").replace(/(^\s*)|(\s*$)/g, "");
			
			if(compBrandHash && compBrandHash[orgCarBrandId]){
				orgCarBrandId = compBrandHash[orgCarBrandId].customid;
			}else{
				showMsg("第"+(i+1)+"行记录的厂牌信息有误!","W");
				return;
			}
			
			
			if(qualityHash && qualityHash[qualityTypeId]){
				qualityTypeId = qualityHash[qualityTypeId].id;
			}else{
				showMsg("第"+(i+1)+"行记录的品质信息有误!","W");
				return;
			}

			if(brandHash && brandHash[partBrandId]){
				partBrandId = brandHash[partBrandId].id;
			}else{
				showMsg("第"+(i+1)+"行记录的品牌信息有误!","W");
				return;
			}
			
			newRow.orgCarBrandId = orgCarBrandId;
			newRow.qualityTypeId = qualityTypeId;
			newRow.partBrandId = partBrandId;
			
			partList.push(newRow);
		}
		//btnEdit.setValue(data.id);
		//btnEdit.setText(data.guestname);
	}

	//faddPart(partList);
	if(ftype == "strategy"){
		saveStraPart(partList);
	}else if(ftype == "unify"){
		saveUnifyPart(partList);
	}
}

function clear(){
	mainGrid.setData([]);
}

function close(){
	if (window.CloseOwnerWindow) return window.CloseOwnerWindow("cancel");
    else window.close();
}

var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveImportStrategyPart.biz.ext";
function saveStraPart(partList){
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
	            stragegyId : fstrategyId,
	            addList : partList,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                var errMsg = data.errMsg;
	                if(errMsg){
						showMsg(errMsg,"S");
	                }else{
						showMsg("导入成功!","S");
	                }
	            } else {
					showMsg(data.errMsg || "导入失败!","W");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            // nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
		
	}

}
var saveUnifyUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.saveImportUnifyPart.biz.ext";
function saveUnifyPart(partList){
	if(partList && partList.length>0) {
		nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '正在导入...'
	    });

	    nui.ajax({
	        url : saveUnifyUrl,
	        type : "post",
	        data : JSON.stringify({
	            addList : partList,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                var errMsg = data.errMsg;
	                if(errMsg){
						showMsg(errMsg,"S");
	                }else{
						showMsg("导入成功!","S");
	                }
	            } else {
					showMsg(data.errMsg || "导入失败!","W");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            // nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
		
	}

}