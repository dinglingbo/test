
/*
FileReader共有4种读取方法：
1.readAsArrayBuffer(file)：将文件读取为ArrayBuffer。
2.readAsBinaryString(file)：将文件读取为二进制字符串
3.readAsDataURL(file)：将文件读取为Data URL
4.readAsText(file, [encoding])：将文件读取为文本，encoding缺省值为'UTF-8'
*/
var baseUrl = apiPath + crmApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var wb;//读取完成的数据
var rABS = false; //是否将文件读取为二进制字符串
var mainGrid = null;
var nstoreId = null; 
var enterMain = null; 

$(document).ready(function(v){
	mainGrid = nui.get("dgGrid");
	initData();
});

function initData(data){
    initComp("query_orgid");//公司组织
    initCarBrand("carBrandId");//车辆品牌s
    //initInsureComp("insureCompCode");//保险公司
    initDicts({
        //isCome: "DDT20150303000004",//来厂状态
        visitStatus: "DDT20130703000081",//跟踪状态
        color: "DDT20130726000003"//车辆颜色
    });
    initMember("man",function(){});
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
		var columns = JSON.stringify(XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]));
		var indexs = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		var trow = toGrid(indexs);
		mainGrid.addRows(trow);
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
	guestName : "客户名称",
	mobile : "手机号",
	carNo: "车牌号"
};

function toGrid(data) {
	arrList = [];
	for (var i = 0; i < data.length; i++) {
		var newRow = {};
		newRow.orgid = data[i].所在分店||"";
		newRow.carNo = data[i].车牌号||"";
		newRow.carBrandId = data[i].品牌||"";
		newRow.carModel = data[i].车型||"";
		newRow.vin = data[i].车架号||"";
		newRow.engineNo = data[i].发动机号||"";
		newRow.color = data[i].颜色||"";
		newRow.firstRegDate = data[i].初登日期||"";
		newRow.annualInspectionDate = data[i].保险到期||"";
		newRow.recorder = data[i].建档人||"";
		newRow.recordDate = data[i].建档日期||"";
		newRow.guestName = data[i].客户名称||"";
		newRow.mobile = data[i].手机号||"";
		newRow.contacts = data[i].联系人||"";
		newRow.tel = data[i].电话||"";
		newRow.sex = data[i].性别||"";
		newRow.address = data[i].地址||"";
		newRow.visitManId = data[i].营销员||"";
		newRow.visitStatus = data[i].跟踪状态||"";
		newRow.priorScoutDate = data[i].上次联系时间||"";
		newRow.nextScoutDate = data[i].下次联系时间||"";
		arrList.push(newRow);
	}
	return arrList;
}

function changedToText(newRow){//从文字转化为编码存到数据库中
	var colorList = nui.get("color").getData();
	var orgList = nui.get("query_orgid").getData();
	var brandList = nui.get("carBrandId").getData();
	var visitStatusList = nui.get("visitStatus").getData();
	var manList = nui.get("man").getData();
	
	if(newRow.sex == "男"){
		newRow.sex = 1;
	}else if(newRow.sex == "女"){
		newRow.sex = 0;
	}
	for (var i = 0; i < colorList.length; i++) {
		if(newRow.color == colorList[i].name){
			newRow.color = colorList[i].customid;
		}
	}
	for (var i = 0; i < orgList.length; i++) {
		if(newRow.orgid == orgList[i].orgname){
			newRow.orgid = orgList[i].orgid;
		}
	}
	for (var i = 0; i < brandList.length; i++) {
		if(newRow.carBrandId == brandList[i].nameCn){
			newRow.carBrandId = brandList[i].id;
		}
	}
	for (var i = 0; i < visitStatusList.length; i++) {
		if(newRow.visitStatus == visitStatusList[i].name){
			newRow.visitStatus = visitStatusList[i].customid;
		}
	}
	for (var i = 0; i < manList.length; i++) {
		if(newRow.visitManId == manList[i].empName){
			newRow.visitManId = manList[i].empId;
		}
	}
	return newRow;
}




function sure() {
	if(!importTimeLimit()){
		parent.parent.showMsg("请在规定时间内导入！","W");
		return;
	}
	var data = mainGrid.getData();
	var partList = [];
	var length = 0;
	if (data) {
		//alert(data.length);
		for (var i = 0; i < data.length; i++) {
			var newRow = data[i];
			length++;
			if(length>4000){
				parent.parent.showMsg("导入不能超过四千条，请重新选择文件！","W");
				return;
			}
			for ( var key in requiredField) {
				if (!newRow[key] || $.trim(newRow[key]).length == 0) {
					parent.parent.showMsg("请完善第"+(i+1)+"行记录的"+requiredField[key]+"!","W");
					return;
				}
			}
			var row = changedToText(newRow);
			partList.push(row);
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

var saveUrl = baseUrl + "com.hsapi.crm.svr.svr.saveImportGuestInfo.biz.ext";
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
								//nui.get("fastCodeList").setValue(errMsg);
								parent.parent.showMsg(errMsg,"S");
							}else{
								parent.parent.showMsg("导入成功!","S");
							}
						} else {
							//nui.get("fastCodeList").setValue(data.errMsg);
							var noImportList = data.noImportList;
							var l = noImportList.length;
							parent.parent.showMsg(l+"条导入失败!","W");
							showNoImportList(noImportList);
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


function showNoImportList(list){

	nui.open({
		url: webPath + contextPath+ "/manage/datumMgr_noImportList.jsp?token="+ token,
		title: "未导入的数据",
		allowResize:true,
		width: 800,
		height: 400,
		onload: function () {
			var iframe = this.getIFrameEl();
			iframe.contentWindow.setData(list);
		},
		ondestroy: function (action) {

		}
	});
}