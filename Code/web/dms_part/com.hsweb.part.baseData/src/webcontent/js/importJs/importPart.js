
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

var partBrandIdList = [];
var partBrandIdHash = {};

$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");

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
	partBrandId : "品牌",
	code : "编码",
	name : "名称",
	unit : "单位"
};
function sure() {
	var data = mainGrid.getData();
	var partList = [];
	if (data) {
		//alert(data.length);
		for (var i = 0; i < data.length; i++) {
			var newRow = {};
			newRow.partBrandId = data[i].品牌||"";
			newRow.code = data[i].编码||"";
			newRow.name = data[i].名称||"";
			newRow.unit = data[i].单位||"";
			newRow.spec = data[i].规格||"";
			newRow.model = data[i].型号||"";
			newRow.mobile = data[i].实物码||"";
			newRow.oemCode = data[i].OEM码||"";
			newRow.applyCarModel = data[i].适用车型||"";

			for ( var key in requiredField) {
				if (!newRow[key] || $.trim(newRow[key]).length == 0) {
					nui.alert("请完善第"+(i+1)+"行记录的"+requiredField[key]+"!");
					return;
				}
			}

			newRow.fullName = newRow.name;
		    newRow.fullName = newRow.fullName + " " + newRow.partBrandId;
		    if(newRow.spec)
		    {
		        newRow.fullName = newRow.fullName + " " + newRow.spec;
		    }
		    
	        var matches = newRow.code.match(/([\w]*)/ig);
	        newRow.queryCode = "";
	        for(var j=0;j<matches.length;j++)
	        {
	            newRow.queryCode+=matches[j];
	        }		  

			if(partBrandIdHash && partBrandIdHash[newRow.partBrandId]){
				newRow.qualityTypeId = partBrandIdHash[newRow.partBrandId].parentId;
				newRow.partBrandId = partBrandIdHash[newRow.partBrandId].id;
			}else{
				nui.alert("第"+(i+1)+"行记录的品牌信息有误!");
				return;
			}

			partList.push(newRow);
		}
		//btnEdit.setValue(data.id);
		//btnEdit.setText(data.guestname);
	}

	//faddPart(partList);
	saveEnterPart(partList);
}

function clear(){
	mainGrid.setData([]);
}

function close(){
	if (window.CloseOwnerWindow) return window.CloseOwnerWindow("cancel");
    else window.close();
}

var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.init.getImportPart.biz.ext";
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
	                	nui.alert(errMsg);
	                }else{
	                	nui.alert("导入成功!");
	                }
	            } else {
	                nui.alert(data.errMsg || "导入失败!");
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            // nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
		
	}

}