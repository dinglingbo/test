
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
var type=null;

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
		type=null;
	};
	if (rABS) {
		reader.readAsArrayBuffer(f);
	} else {
		reader.readAsBinaryString(f);
	}
}

function importfBMW(obj){
	if (!obj.files) return;
	
	nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
	
    var f = obj.files[0];
    var reader = new FileReader();
    reader.onload = function (e) {
        var data = e.target.result;
        wb = null;
        if (isCSV) {
            data = new Uint8Array(data);
            let f = isUTF8(data);
            var result = "是CSV文件,编码" + (f ? "是" : "不是") + "UTF-8";
            console.log(result);
            if (f) {
                data = e.target.result;
            } else {
            	nui.unmask(document.body);
            	showMsg("请选择xlsx的格式","W");
//            	var	str =Utf8ArrayToStr(data);
            	
//                var str = cptable.utils.decode(936, data); //UTF-8数组转字符串；
//                wb = XLSX.read(str, { type: "string" });
            }
        }else{
        	var result ="不是CSV文件";
        	console.log(result);
        }
        if (!wb) {
            wb = rABS|| isCSV ? XLSX.read(btoa(fixdata(data)), { type: 'base64' }) : XLSX.read(data, { type: 'binary' });
        }
        //wb.SheetNames[0]是获取Sheets中第一个Sheet的名字
        //wb.Sheets[Sheet名]获取第一个Sheet的数据
       var result = JSON.stringify(XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]));
       console.log(result);
       var needArray=strToArray(result);
       nui.unmask(document.body);
       mainGrid.addRows(needArray);
       type='4S';
    };
    isCSV = f.name.split(".").reverse()[0] == "csv";//判断是否是 CSV
    if (rABS || isCSV) {
        reader.readAsArrayBuffer(f);
    } else {
        reader.readAsBinaryString(f);
    }
    obj.value = "";
}

//给宝马用
function strToArray(result){
	
	var array =JSON.parse(result);
	var needKey={"零件编号.":"配件编码",
				"总库存量":"数量",
				"主(1)仓仓位":"仓位",
				"Stock价格":"销售价"};
	var needArray=[];
	for(var i=0;i<array.length;i++){
		var object={};
		for(var key in needKey){		
			if(array[i].hasOwnProperty(key)){				
				if(key=='零件编号.'){
					var reg=/[A-Za-z]+/
					var str=array[i][key].replace(reg,"").replace(/\./g,"");
					object[needKey[key]]=str;
				}
				if(key=='Stock价格'){
					object['单价']=array[i][key];
					object[needKey[key]]=array[i][key];
				}
				if(key == '总库存量'){
					if(array[i][key]>0){
						object[needKey[key]]=array[i][key];
					}else{
						break;
					}
				}
				else if(key!='零件编号.' &&  key!='Stock价格' && key !='总库存量'){				
					object[needKey[key]]=array[i][key];	
					object['品牌']='原厂';
					object['是否含税']='是';
					object['税率']='0.13';
				}
			}
			
		}
		if(object.hasOwnProperty('配件编码') && object.hasOwnProperty('数量') && object.hasOwnProperty('仓位') && object.hasOwnProperty('销售价')){			
			needArray.push(object);

		}
	}
	
	console.log(needArray);
    return needArray;
	
	
}
function Utf8ArrayToStr(array) {
	var out, i, len, c;
	var char2, char3;

	out = "";
	len = array.length;
	i = 0;
	while(i < len) {
	c = array[i++];
	switch(c >> 4)
	{ 
	case 0: case 1: case 2: case 3: case 4: case 5: case 6: case 7:
	// 0xxxxxxx
	out += String.fromCharCode(c);
	break;
	case 12: case 13:
	// 110x xxxx 10xx xxxx
	char2 = array[i++];
	out += String.fromCharCode(((c & 0x1F) << 6) | (char2 & 0x3F));
	break;
	case 14:
	// 1110 xxxx 10xx xxxx 10xx xxxx
	char2 = array[i++];
	char3 = array[i++];
	out += String.fromCharCode(((c & 0x0F) << 12) |
	((char2 & 0x3F) << 6) |
	((char3 & 0x3F) << 0));
	break;
	}
	}

	return out;
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
var deleteUrl=baseUrl + "com.hsapi.cloud.part.invoicing.crud.deletePartStock.biz.ext";
function deletePartStock(){
	 nui.ajax({
	        url : deleteUrl,
	        type : "post",
	        async: false,
	        data : JSON.stringify({
	            token : token
	        }),
	        success : function(data) {
	            nui.unmask(document.body);
	            data = data || {};
	            var errMsg = data.errMsg;
	            if (data.errCode == "S") {
	                return true;
	            } else {
					showMsg(data.errMsg || "删除库存失败!","W");
					return false;
	            }
	        },
	        error : function(jqXHR, textStatus, errorThrown) {
	            // nui.alert(jqXHR.responseText);
	            console.log(jqXHR.responseText);
	        }
	    });
}
function sure() {
	var data = mainGrid.getData();
	var partList = [];
	if(type=='4S'){
		var flag=deletePartStock();
		if(flag==false){
			return;
		}
	}
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
				showMsg("第"+(i+1)+"行记录的品牌信息有误!","W");
				return;
			}

			var newRow = {
				partBrandId: partBrandId,
				partCode : (data[i].配件编码||"").replace(/\s+/g, ""),
				storeId : nstoreId||"",
				enterQty : (data[i].数量||"").replace(/\s+/g, ""),
				enterPrice : (data[i].单价||"").replace(/\s+/g, ""),
				sellPrice : (data[i].销售价||"").replace(/\s+/g, ""),
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

var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.getImportPartInfo.biz.ext";
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
						//showMsg(errMsg,"S");
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