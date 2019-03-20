
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
var advancedTipWin = null;
var advancedTipForm = null;

var brandHash = {};
var brandList = [];

$(document).ready(function(v)
{

	mainGrid = nui.get("mainGrid");
	
	advancedTipWin = nui.get("advancedTipWin");
	advancedTipForm  = new nui.Form("#advancedTipForm");

});

function initData(main, storeId, brandIdList){
	nstoreId = storeId;
	enterMain = main;
	brandList = brandIdList;

	brandList.forEach(function(v)
    {
        brandHash[v.name] = v;
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

function sure() {
	var data = mainGrid.getData();
	var partList = [];
	if (data) {
		//alert(data.length);
		for (var i = 0; i < data.length; i++) {
			//partid  partcode  partname  enterqty  enterunit  enterprice  enteramt
			var taxSignStr = data[i].是否含税;
			var taxSign = taxSignStr == "是" ? 1 : 0;
			var partBrandId = (data[i].品牌||"").replace(/\s+/g, "");
			
			if(brandHash && brandHash[partBrandId]){
				partBrandId = brandHash[partBrandId].id;
			}else{
				parent.showMsg("第"+(i+1)+"行记录的品牌信息有误!","W");
				return;
			}

			var newRow = {
				partBrandId: partBrandId,
				partCode : (data[i].配件编码||"").replace(/\s+/g, ""),
				storeId : nstoreId||"",
				enterQty : (data[i].数量||"").replace(/\s+/g, ""),
				enterPrice : (data[i].单价||"").replace(/\s+/g, ""),
				sellPrice: (data[i].建议售价||"").replace(/\s+/g, ""),
				taxSign : taxSign||0,
				taxRate : (data[i].税率||"0.07").replace(/\s+/g, ""),
				storeShelf : (data[i].仓位||"").replace(/\s+/g, ""),
				remark : (data[i].备注||"").replace(/\s+/g, "")
			};
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

var saveUrl = baseUrl + "com.hsapi.part.baseDataCrud.crud.getImportPartInfo.biz.ext";
function saveEnterPart(partList){
	advancedTipForm.setData([]);
	if(partList && partList.length>0) {
		nui.mask({
	        el: document.body,
	        cls: 'mini-mask-loading',
	        html: '正在导入...'
	    });

	    if (enterMain.operateDate) {
			enterMain.operateDate = format(enterMain.operateDate, 'yyyy-MM-dd HH:mm:ss');
		}

	    nui.ajax({
	        url : saveUrl,
	        type : "post",
	        data : JSON.stringify({
	            enterMain : enterMain,
	            enterDetail : partList,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            if (data.errCode == "S") {
	                var errMsg = data.errMsg;
	                if(errMsg){
						var rt = errMsg.split("：");
						if(rt && rt.length>=2){
							var rs = rt[1];
							var partList = rs.split(";");

							var parts = partList.join("\r\n");
							
							nui.get("fastCodeList").setValue(parts);
							advancedTipWin.show();
						}
						//parent.showMsg(errMsg,"S");
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