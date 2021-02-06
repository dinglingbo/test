
/*
FileReader共有4种读取方法：
1.readAsArrayBuffer(file)：将文件读取为ArrayBuffer。
2.readAsBinaryString(file)：将文件读取为二进制字符串
3.readAsDataURL(file)：将文件读取为Data URL
4.readAsText(file, [encoding])：将文件读取为文本，encoding缺省值为'UTF-8'
 */
var baseUrl = apiPath + partApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var wb;//读取完成的数据
var rABS = false; //是否将文件读取为二进制字符串
var mainGrid = null;
var nstoreId = null;
var enterMain = null;
var ftype = null;;//strategy,unify
var fstrategyId = null;

$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");

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
        if(indexs && indexs.length>0){
            selectConfig(indexs);
        }

		mainGrid.addRows(indexs);
	};
	if (rABS) {
		reader.readAsArrayBuffer(f);
	} else {
		reader.readAsBinaryString(f);
	}
}
function selectConfig(indexs){
    var maxr = {};
    var maxl = 0;
    for(var i=0;i<indexs.length;i++){
        var record=indexs[i];
        var rlen = Object.getOwnPropertyNames(record).length;
        if(rlen>=maxl){
            maxr = record;
            maxl = rlen;
        }
    }

    var columns = [];
    if(maxr){
        columns.push({type:"indexcolumn",headerAlign: "center",header:"序号",width:"20"});
        for (var key in maxr){	
            var newCol = {field: key,headerAlign: "center",header: key};
            columns.push(newCol);
        }
    }
    // var columns = [
    //     /*{ type: "indexcolumn", width:40, headerAlign: "center", header: "序号", summaryType: "count"},*/
    //     { field: "auth", visible: false},
    //     { field: "brand", visible: false, summaryType: "count"}
    // ];
    // var titles = json.title;
    // for(var i=0; i<titles.length; i++){
    //     columns.push({ field: "field" + i, width:80, headerAlign: "center", allowSort: false, header: titles[i]});
    // }
    
    mainGrid.set({
        columns: columns
    });
    
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
		var columns = mainGrid.columns;
		for (var i = 0; i < data.length; i++) {       
			var partCodeList = [];    
            for(var j=1; j<columns.length; j++){
				var fieldName = columns[j].field;
                var partCode = (data[i][fieldName]||"").replace(/\s+/g, "");
                if(partCode){
					partCode = "'"+partCode+"'";
                    partCodeList.push(partCode);
                }
			}
			if(partCodeList && partCodeList.length>0){
				var newRow = {index:i}; 
				var partCodeStr = partCodeList.join(",");
				newRow.partCodeList = partCodeStr;
				partList.push(newRow);
			}
		}
		//btnEdit.setValue(data.id);
		//btnEdit.setText(data.guestname);
    }
    //考虑导入数据中，不同行可能有相同配件编码，这时需要合并替换信息

	savePartCommon(partList);
}

function clear(){
	mainGrid.setData([]);
}

function close(){
	if (window.CloseOwnerWindow) return window.CloseOwnerWindow("cancel");
    else window.close();
}

var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.saveImportPartCommon.biz.ext";
function savePartCommon(partList){
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
	            params : partList,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                var errMsg = data.errMsg;
	                if(errMsg){
                        parent.showMsg(errMsg,"S");
	                }else{
	                	parent.showMsg("导入成功!","S");
					}
	            } else {
	            	parent.showMsg(data.errMsg || "导入失败!","W");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            // nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
		
	}

}