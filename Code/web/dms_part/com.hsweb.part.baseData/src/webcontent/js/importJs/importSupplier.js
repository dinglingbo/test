
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

var provinceList = [];
var provinceHash = {};
var cityList = [];
var cityHash = {};
var billTypeIdList = [];
var billTypeIdHash = {};
var settTypeIdList = [];
var settTypeIdHash = {};
var dictDefs ={"billTypeId":"DDT20130703000008", "settType":"DDT20130703000035"};
$(document).ready(function(v)
{

    mainGrid = nui.get("mainGrid");
    
    nui.get("openBtn").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	onClose();
        }
      };
      
   provinceEl = nui.get("provinceId");
  	getProvinceAndCity(function(data) {
  	});
  	 initDicts(dictDefs, function(){
     	billTypeIdList=nui.get('billTypeId').getData();     		
     	settTypeIdList=nui.get('settType').getData();
     	billTypeIdList.forEach(function(v){
     		billTypeIdHash[v.name]=v;
     	});
     	settTypeIdList.forEach(function(v){
     		settTypeIdHash[v.name]=v;
     	});
     	
     });

});

function initData(data){
	provinceList = data.province||[];
    provinceList.forEach(function(v){
        provinceHash[v.name] = v;//code
    });

    cityList = data.city||[];
    cityList.forEach(function(v){
        cityHash[v.name] = v;//code
    });

    billTypeIdList = data.billTypeId||[];
    billTypeIdList.forEach(function(v){
        billTypeIdHash[v.name] = v;//customid
    });
    settTypeIdList = data.settTypeId||[];
    settTypeIdList.forEach(function(v){
        settTypeIdHash[v.name] = v;//customid
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
	code : "编码",
	fullName : "全称",
	shortName : "简称",
	billTypeId : "票据类型",
	settTypeId : "结算方式",
	manager : "联系人",
	mobile : "联系人手机"
/*	provinceId : "省份",
	cityId : "城市"*/
};
function sure() {
	var data = mainGrid.getData();
	var partList = [];
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
			newRow.code = data[i].编码||"";
			newRow.fullName = data[i].全称||"";
			newRow.shortName = data[i].简称||"";
			newRow.billTypeId = data[i].票据类型||"";
			newRow.settTypeId = data[i].结算方式||"";
			newRow.manager = data[i].联系人||"";
			newRow.mobile = data[i].联系人手机||"";
			newRow.provinceId = data[i].省份||"";
			newRow.cityId = data[i].城市||"";
			newRow.isClient = data[i].是否客户 == "是" ? 1 : 0;

			for ( var key in requiredField) {
				if (!newRow[key] || $.trim(newRow[key]).length == 0) {
					parent.parent.showMsg("请完善第"+(i+1)+"行记录的"+requiredField[key]+"!","W");
					return;
				}
			}

			if(billTypeIdHash && billTypeIdHash[newRow.billTypeId]){
				newRow.billTypeId = billTypeIdHash[newRow.billTypeId].customid;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的票据类型信息有误!","W");
				return;
			}

			if(settTypeIdHash && settTypeIdHash[newRow.settTypeId]){
				newRow.settTypeId = settTypeIdHash[newRow.settTypeId].customid;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的结算方式信息有误!","W");
				return;
			}
				
/*			if(provinceHash && provinceHash[newRow.provinceId]){
				newRow.provinceId = provinceHash[newRow.provinceId].code;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的省份信息有误!","W");
				return;
			}

			if(cityHash && cityHash[newRow.cityId]){
				newRow.cityId = cityHash[newRow.cityId].code;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的城市信息有误!","W");
				return;
			}*/

			newRow.guestType = "01020202";
			newRow.isSupplier = 1;
			partList.push(newRow);
		}
		//btnEdit.setValue(data.id);
		//btnEdit.setText(data.guestname);
	}

	//faddPart(partList);
	//判断客户有没有选择  简洁版
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

var saveUrl = baseUrl + "com.hsapi.repair.repairService.crud.getImportGuest.biz.ext";
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
						parent.parent.showMsg(errMsg,"S");
	                }else{
						parent.parent.showMsg("导入成功!","S");
	                }
	            } else {
					parent.parent.showMsg(data.errMsg || "导入失败!","W");
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