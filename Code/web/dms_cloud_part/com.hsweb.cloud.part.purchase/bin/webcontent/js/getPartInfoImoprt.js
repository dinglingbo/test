
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

var brandHash = {};
var brandList = [];
var compBrandList = [];
var compBrandHash = {};

var noImportList=[];
$(document).ready(function(v)
{

	mainGrid = nui.get("mainGrid");
	
	advancedTipWin = nui.get("advancedTipWin");
	advancedTipForm  = new nui.Form("#advancedTipForm");
	$('#selectBtn').focus();
	
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

	    });
    });
	
	
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	CloseWindow();
        }
      };
});

var callback = null;
function initData(ck){
	callback = ck;
}


function initImportData(storeId, ck){
	nstoreId = storeId,
	callback = ck;
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
			var newRow = {
				partCode : (data[i].配件编码||"").replace(/(^\s*)|(\s*$)/g, ""),
				orderQty : (data[i].数量||"").replace(/\s+/g, ""),
				orderPrice : (data[i].单价||"").replace(/\s+/g, ""),
				shelf : (data[i].仓位||"").replace(/\s+/g, ""),
				remark : (data[i].备注||"").replace(/\s+/g, ""),
				partBrandId: (data[i].品牌||"").replace(/\s+/g, ""),
				qualityTypeId: (data[i].品质||"").replace(/\s+/g, ""),
				orgCarBrandId: (data[i].厂牌||"").replace(/\s+/g, "")
			};

			if(brandHash && brandHash[newRow.partBrandId]){
				newRow.partBrandId = brandHash[newRow.partBrandId].id;
			}else{
				newRow.partBrandId = "";
			}
			
			if(brandHash && brandHash[newRow.qualityTypeId]){
				newRow.qualityTypeId = brandHash[newRow.qualityTypeId].id;
			}else{
				newRow.qualityTypeId = "";
			}
			
			if(compBrandHash && compBrandHash[newRow.orgCarBrandId]){
				newRow.orgCarBrandId = compBrandHash[newRow.orgCarBrandId].customid;
			}else{
				newRow.orgCarBrandId = "";
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

var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.getPartInfoByCodes.biz.ext";
//开启app
/*if(currIsOpenApp ==1){
	saveUrl =baseUrl + "com.hsapi.cloud.part.invoicing.paramcrud.getPartInfoByCodesForCang.biz.ext";
}*/
function saveEnterPart(partList){
	advancedTipForm.setData([]);
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
	            type : 'enter',
	            storeId: nstoreId,
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
				data = data || {};
				var rtnList = data.rtnList;
				var parts = "";
				if (data.errCode == "S") {
					var errMsg = data.errMsg||"";
	                if(errMsg){
//						var rt = errMsg.split("：");
//						if(rt && rt.length>=2){
//							var rs = rt[1];
//							var partList = rs.split(";");
//
//							parts = partList.join("\r\n");
//							
//						}
	                	noImportList = data.noImportList;
	                	nui.get("fastCodeList").setValue(errMsg);
						advancedTipWin.show();
						onExport(noImportList);
					}else{
						parent.parent.showMsg("导入成功!","S");
					}
					
					callback(rtnList,errMsg);

					CloseWindow("ok");
					
				} else {
					nui.get("fastCodeList").setValue(data.errMsg);
					advancedTipWin.show();
//					showMsg(data.errMsg || "导入数据失败!","W");
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
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}


function onExport(noImportList){
	
	var detail = noImportList;
	if(detail && detail.length > 0){
		setInitExportData(detail);
	}
}
function setInitExportData(detail){

    var tds ="<td  colspan='1' align='left'>[partBrandId]</td>" +
    		 '<td  colspan="1" align="left">[partCode]</td>';
    	
    var tableExportContent = $("#tableExportContent");
    tableExportContent.empty();
    for (var i = 0; i < detail.length; i++) {
        var row = detail[i];
     
        var tr = $("<tr></tr>");
        tr.append(tds.replace("[partCode]", detail[i].partCode?detail[i].partCode:"")
                     .replace("[partBrandId]", detail[i].partBrandId?brandHash[detail[i].partBrandId].name:""));
        tableExportContent.append(tr);
    
    }

    method5('tableExcel',"未导入的配件",'tableExportA');
}