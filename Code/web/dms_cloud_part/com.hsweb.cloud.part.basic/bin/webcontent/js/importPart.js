
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
var orgBrandList = [];
var orgBrandHash = {};
var qualityList = [];
var qualityHash = {};
var typeList = [];
var typeHash = {};

$(document).ready(function(v)
{

	mainGrid = nui.get("mainGrid");
	advancedTipWin = nui.get("advancedTipWin");
	advancedTipForm  = new nui.Form("#advancedTipForm");
	
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
	
	carBrandList = data.carBrandList||[];
    carBrandList.forEach(function(v)
    {
        carBrandHash[v.nameCn] = v;
	});
    
    orgBrandList = data.orgBrandList||[];
    orgBrandList.forEach(function(v)
    {
    	orgBrandHash[v.name] = v;
	});
    
    qualityList = data.qualityTypeIdList||[];
    qualityList.forEach(function(v)
    {
    	qualityHash[v.name] = v;
	});

    getType();
}


function getType(){
	var hotUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
	var dictids = ["10441","10442"];
	nui.ajax({
		url : hotUrl,
		type : "post",
		aynsc:false,
		data : {
			dictids:dictids,
			tenantIds:currTenantId,
			token:token
		},
		success : function(data) {
			
			data = data || {};
			if (data.errCode == "S") {
				
				typeList = nui.clone(data.data);
				typeList.forEach(function(v)
			    {
			    	typeHash[v.name] = v;
				});
				
			}

		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
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
	orgCarBrandId : "厂牌",
	qualityTypeId : "品质",
	partBrandId : "品牌",
	code : "编码",
	name : "名称",
	unit : "单位"
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
			newRow.orgCarBrandId = data[i].厂牌||"";
			newRow.qualityTypeId = data[i].品质||"";
			newRow.partBrandId = data[i].品牌||"";
			newRow.code = data[i].编码||"";
			newRow.name = data[i].名称||"";
			newRow.unit = data[i].单位||"";
			newRow.spec = data[i].规格||"";
			newRow.model = data[i].型号||"";
			newRow.goodsCode = data[i].实物码||"";
			newRow.oemCode = data[i].OE码||"";
			newRow.applyCarModel = data[i].适用车型||"";
			newRow.produceFactory = data[i].生产厂家||"";
			newRow.commonCode = data[i].通用编码||"";
			newRow.remark = data[i].备注||"";
			newRow.customClassName = data[i].自定义分类||"";
			newRow.property1 = data[i].属性1||"";
			newRow.property2 = data[i].属性2||"";

			newRow.code = newRow.code.replace(/(^\s*)|(\s*$)/g, "");
			newRow.name = newRow.name.replace(/\s+/g, "");
			newRow.oemCode = newRow.oemCode.replace(/(^\s*)|(\s*$)/g, "");
			newRow.commonCode = newRow.commonCode.replace(/(^\s*)|(\s*$)/g, "");

			for ( var key in requiredField) {
				if (!newRow[key] || $.trim(newRow[key]).length == 0) {
					parent.parent.showMsg("请完善第"+(i+1)+"行记录的"+requiredField[key]+"!","W");
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
	        
	        if(orgBrandHash && orgBrandHash[newRow.orgCarBrandId]){
				newRow.orgCarBrandId = orgBrandHash[newRow.orgCarBrandId].customid;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的厂牌信息有误!","W");
				return;
			}
	        
	        if(qualityHash && qualityHash[newRow.qualityTypeId]){
				newRow.qualityTypeId = qualityHash[newRow.qualityTypeId].id;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的品质信息有误!","W");
				return;
			}

			if(partBrandIdHash && partBrandIdHash[newRow.partBrandId]){
				newRow.partBrandId = partBrandIdHash[newRow.partBrandId].id;
			}else{
				parent.parent.showMsg("第"+(i+1)+"行记录的品牌信息有误!","W");
				return;
			}

			/*var carBrand = newRow.applyCarbrandId.replace(/\s+/g, "");
			if(carBrand){
				if(carBrandHash && carBrandHash[newRow.applyCarbrandId.replace(/\s+/g, "")]){
					newRow.applyCarbrandId = carBrandHash[newRow.applyCarbrandId.replace(/\s+/g, "")].id;
				}else{
					parent.parent.showMsg("第"+(i+1)+"行记录的厂牌信息有误!","W");
					return;
				}
			}*/
			
			if(newRow.customClassName!=null && newRow.customClassName!="") {
				var m = newRow.customClassName.split(",");
				var h = new Array();
				if(m!=null) {
					for(var j=0; j<m.length; j++){
						if(typeHash && typeHash[m[j]]) {
							h.add(typeHash[m[j]].id);
						}
					}
					newRow.customClassId = h.join(",");
				}
			}

			partList.push(newRow);
		}
		//btnEdit.setValue(data.id);
		//btnEdit.setText(data.guestname);
	}

	//faddPart(partList);
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

var saveUrl = baseUrl + "com.hsapi.cloud.part.baseDataCrud.crud.getImportPart.biz.ext";
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
						//parent.parent.showMsg(errMsg,"S");
	                }else{
						parent.parent.showMsg("导入成功!","S");
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