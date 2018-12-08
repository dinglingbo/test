/**
 * Created by steven on 2018/1/31.
 */
var baseUrl = apiPath + repairApi + "/";;
var mainUrl = baseUrl + "com.hsapi.repair.baseData.query.queryScoutParam.biz.ext";

var returnForm = null;

var showList = [{ id: 0, name: "启用" },{ id: 1, name: "禁用" }];
$(document).ready(function(v) {
	returnForm = new nui.Form("#returnForm");

	doSearch();

});
function doSearch()
{
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '加载中...'
	});

	nui.ajax({
		url : mainUrl,
		type : "post",
		data : {
			token:token
		},
		success : function(data) {
			data = data || {};
			var list = data.list;
			if (list) {
				setInitData(list);
			} else {
				nui.unmask(document.body);
				parent.showMsg(data.errMsg || "回访参数获取失败!","W");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			console.log(jqXHR.responseText);
		}
	});
}
function setInitData(list){
	//1,2,3,4
	var data = {};
	if(list && list.length>0){
		for(var i=0; i<list.length; i++){
			var rs = list[i];
			var id = rs.id;
			var billTypeId = rs.billTypeId;
			var scoutDay1 = rs.scoutDay1;
			var scoutDisabled1 = rs.scoutDisabled1;
			var scoutDay2 = rs.scoutDay2;
			var scoutDisabled2 = rs.scoutDisabled2;
			var scoutDay3 = rs.scoutDay3;
			var scoutDisabled3 = rs.scoutDisabled3;
			if(billTypeId == 1){
				data.workId = id;
				data.workScoutDay1 = scoutDay1;
				data.workScoutDisable1 = scoutDisabled1;
				data.workScoutDay2 = scoutDay2;
				data.workScoutDisable2 = scoutDisabled2;
				data.workScoutDay3 = scoutDay3;
				data.workScoutDisable3 = scoutDisabled3;
			}else if(billTypeId == 2){
				data.washId = id;
				data.washScoutDay1 = scoutDay1;
				data.washScoutDisable1 = scoutDisabled1;
				data.washScoutDay2 = scoutDay2;
				data.washScoutDisable2 = scoutDisabled2;
				data.washScoutDay3 = scoutDay3;
				data.washScoutDisable3 = scoutDisabled3;
			}else if(billTypeId == 3){
				data.zeroId = id;
				data.zeroScoutDay1 = scoutDay1;
				data.zeroScoutDisable1 = scoutDisabled1;
				data.zeroScoutDay2 = scoutDay2;
				data.zeroScoutDisable2 = scoutDisabled2;
				data.zeroScoutDay3 = scoutDay3;
				data.zeroScoutDisable3 = scoutDisabled3;
			}else if(billTypeId == 4){
				data.claimId = id;
				data.claimScoutDay1 = scoutDay1;
				data.claimScoutDisable1 = scoutDisabled1;
				data.claimScoutDay2 = scoutDay2;
				data.claimScoutDisable2 = scoutDisabled2;
				data.claimScoutDay3 = scoutDay3;
				data.claimScoutDisable3 = scoutDisabled3;
			}
		}
		returnForm.setData(data);
	}
	nui.unmask(document.body);
}
var returnFormUrl = baseUrl + "com.hsapi.repair.baseData.crud.saveScoutParam.biz.ext";
function returnFormSet(){
	var data = returnForm.getData();
	var addList = [];
	var updateList = [];
	var workR = {
		billTypeId:1,
		scoutDay1:data.workScoutDay1,
		scoutDisabled1:data.workScoutDisable1,
		scoutDay2:data.workScoutDay2,
		scoutDisabled2:data.washScoutDisable2,
		scoutDay3:data.workScoutDay3,
		scoutDisabled3:data.workScoutDisable3
	}
	var washR = {
		billTypeId:2,
		scoutDay1:data.washScoutDay1,
		scoutDisabled1:data.washScoutDisable1,
		scoutDay2:data.washScoutDay2,
		scoutDisabled2:data.workScoutDisable2,
		scoutDay3:data.washScoutDay3,
		scoutDisabled3:data.washScoutDisable3
	}
	var zeroR = {
		billTypeId:3,
		scoutDay1:data.zeroScoutDay1,
		scoutDisabled1:data.zeroScoutDisable1,
		scoutDay2:data.zeroScoutDay2,
		scoutDisabled2:data.zeroScoutDisable2,
		scoutDay3:data.zeroScoutDay3,
		scoutDisabled3:data.zeroScoutDisable3
	}
	var claimR = {
		billTypeId:4,
		scoutDay1:data.claimScoutDay1,
		scoutDisabled1:data.claimScoutDisable1,
		scoutDay2:data.claimScoutDay2,
		scoutDisabled2:data.claimScoutDisable2,
		scoutDay3:data.claimScoutDay3,
		scoutDisabled3:data.claimScoutDisable3
	}
	if(workR.scoutDay1>=workR.scoutDay2||workR.scoutDay2>=workR.scoutDay3){
		parent.showMsg("工单第一次回访不能大于第二次或者第二次大于第三次，请重新设置!","S");
		return;
	}
	if(washR.scoutDay1>=washR.scoutDay2||washR.scoutDay2>=washR.scoutDay3){
		parent.showMsg("洗车单第一次回访不能大于第二次或者第二次大于第三次，请重新设置!","S");
		return;
	}
	if(zeroR.scoutDay1>=zeroR.scoutDay2||zeroR.scoutDay2>=zeroR.scoutDay3){
		parent.showMsg("零售第一次回访不能大于第二次或者第二次大于第三次，请重新设置!","S");
		return;
	}
	if(claimR.scoutDay1>=claimR.scoutDay2||claimR.scoutDay2>=claimR.scoutDay3){
		parent.showMsg("理赔单第一次回访不能大于第二次或者第二次大于第三次，请重新设置!","S");
		return;
	}
	if(data.workId){
		workR.id = data.workId;
		updateList.push(workR);
	}else{
		addList.push(workR);
	}
	if(data.washId){
		washR.id = data.washId;
		updateList.push(washR);
	}else{
		addList.push(washR);
	}
	if(data.zeroId){
		zeroR.id = data.zeroId;
		updateList.push(zeroR);
	}else{
		addList.push(zeroR);
	}
	if(data.claimId){
		claimR.id = data.claimId;
		updateList.push(claimR);
	}else{
		addList.push(claimR);
	}

	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
	nui.ajax({
		url:returnFormUrl,
		type:"post",
		data:{
			addList:addList,
			updateList:updateList,
			token:token
		},
		success: function (data) {
			nui.unmask(document.body);
			if (data.errCode == "S"){
				parent.showMsg("保存成功!","S");
				doSearch();
			}
			else{
				parent.showMsg("保存失败!","E");
			}
	
		},
		error: function (jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			nui.alert(jqXHR.responseText);
		}
	
	});
}


