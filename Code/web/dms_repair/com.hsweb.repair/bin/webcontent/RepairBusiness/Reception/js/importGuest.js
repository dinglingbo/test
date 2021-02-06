
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
	fullName : "客户名称",
	mobile : "手机号码",
	carNo: "车牌号"
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
			newRow.fullName = data[i].客户名称||"";
			newRow.mobile = data[i].手机号码||"";
			newRow.carNo = data[i].车牌号||"";
			newRow.vin = data[i].车架号||"";
			newRow.addr = data[i].地址||"";
			newRow.carModel = data[i].厂牌车型信息||"";
			newRow.engineNo = data[i].发动机号||"";
			newRow.annualVerificationDueDate = data[i].年审到期日期||"";
			
			newRow.annualInspectionNo = data[i]. 商业险单号||"";
			newRow.annualInspectionCompCode = data[i]. 商业险投保公司ID||"";
			newRow.annualInspectionCompName = data[i]. 商业险投保公司名称||"";
			newRow.annualInspectionAmt = data[i]. 商业险金额||"";			
			newRow.annualInspectionDate = data[i]. 商业险到期日期||"";
			
			newRow.insureNo = data[i]. 交强险单号||"";
			newRow.insureCompCode = data[i]. 交强险投保公司ID||"";
			newRow.insureCompName = data[i]. 交强险投保公司名称||"";
			newRow.insureAmt = data[i]. 交强险金额||"";			
			newRow.insureDueDate = data[i].交强险到期日期||"";
			
			newRow.color = data[i].颜色||"";
			newRow.issuingDate = data[i].驾驶证发证日期||"";
			newRow.careLastDate = data[i].上次保养日期||"";
			newRow.careDueDate = data[i].下次保养日期||"";
			newRow.careDueMileage = data[i].下次保养里程||"";
			
			newRow.dayKilometers = data[i].日均里程||"";
			newRow.mtCycle = data[i].维修周期||"";
			newRow.careCycle = data[i].保养周期||"";
			newRow.careKilometers = data[i].间隔保养里程||"";
			
			newRow.lastComeKilometers = data[i].最近进店里程||""; 
			newRow.lastComeDate = data[i].最近进店日期||"";
			newRow.lastLeaveDate = data[i].最近离店日期||"";
			newRow.prevAdvisorName = data[i].最后维修顾问名称||"";
			newRow.chainComeTimes = data[i].来厂次数||"";
			newRow.chainConsumeAmt = data[i].消费金额||"";
			
			newRow.remark = data[i].备注||"";


		for ( var key in requiredField) {
				if (!newRow[key] || $.trim(newRow[key]).length == 0) {
					parent.parent.showMsg("请完善第"+(i+1)+"行记录的"+requiredField[key]+"!","W");
					return;
				}
			}

			partList.push(newRow);
		}

	}

	saveEnterPart(partList);
}

function clear(){
	var guestList = mainGrid.getData();
	for(var i = 0 ; i<guestList.length;i++){
		mainGrid.removeRow(guestList[i]);
	}
}

function close(){
	if (window.CloseOwnerWindow) return window.CloseOwnerWindow("cancel");
    else window.close();
}

var saveUrl = baseUrl + "com.hsapi.repair.repairService.crud.getImportGuest.biz.ext";
function saveEnterPart(partList){
	if(partList && partList.length>0) {
		  nui.confirm("确定导入吗？", "友情提示",function(action){
		       if(action == "ok"){
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
		     }else {
					return;
			 }
			 }); 



		
	}

}