
var baseUrl = apiPath + repairApi + "/";
var type = "" ;//区别是套餐还是项目修改的
var none = "ALL0";//班组技术样式下标
var serviceTypeIds = null;
var serviceId = 0;//工单号
$(document).ready(function(v) {
	 serviceTypeIds = nui.get("serviceTypeIds");
    $(document).on("click",".none",function(e){
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
        var queryId = ( e.target.id).slice(0,2);
    	var json = {
    			token  : token
    	};
        if(queryId=="BZ"){
        	json.memberGroupId=( e.target.id).slice(2,4);
        	queryMember(json);
        }else if(queryId=="DJ"){
        	json.memberLevelId=( e.target.id).slice(2,4);
        	queryMember(json);
        }else{
        	queryMember(json);
        }
		document.getElementById(none).setAttribute("class", "none");
		none = e.currentTarget.id;
		document.getElementById(none).setAttribute("class", "none1");
    });

    $(document).on("click",".empl",function(e){
		document.getElementById(e.target.id).setAttribute("class", "empl1");
    });
    $(document).on("click",".empl1",function(e){

    	document.getElementById(e.target.id).setAttribute("class", "empl");
    });

	init();
    

});
var queryMemberLevel = apiPath + repairApi + "/com.hsapi.repair.baseData.team.getRepairGroup.biz.ext";
	//var queryMemberLevel = apiPath + repairApi + "/com.hsapi.repair.baseData.team.queryMemberLevel.biz.ext";
	//var queryWorkTeam = apiPath + repairApi + "/com.hsapi.repair.baseData.team.queryWorkTeam.biz.ext";
	var queryMemberUrl = apiPath + sysApi + "/com.hsapi.system.dict.org.queryMember.biz.ext";
    var queryServiceType = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext";
    var setItemWorkersBatch = apiPath + repairApi + "/com.hsapi.repair.repairService.crud.setItemWorkersBatch.biz.ext";
    
function setData(data){
	type = data.type;
	serviceId = data.serviceId;
}
function init(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
    });
	nui.ajax({
		url : queryServiceType,
		type : 'POST',
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var ServiceType = text.data;
			serviceTypeIds.setData(ServiceType);
/*				var str = "";
				for(var i = 0;i<ServiceType.length;i++){
					str = str+"<input  class='nui-CheckBox' id='"+ServiceType[i].id+"'/>"+ServiceType[i].name;
					if((i+1)%5==0){
						str = str+"<br>";
					}
				}
				document.getElementById("Project").innerHTML=str; */		
		}
	});
var teamStr ="";
	nui.ajax({
		url : queryMemberLevel,
		type : 'POST',
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			var Member = text.data;
			none = Member[0].type+Member[0].id;
			for(var i = 0;i<Member.length;i++){
				teamStr = teamStr+"<a class='none' href= 'javascritp:void(0);'  id='"+Member[i].type+Member[i].id+"' >"+Member[i].name+"</a></br>";
				
			}	
			document.getElementById("team").innerHTML=teamStr; 	
			nui.unmask(document.body);
/*			nui.ajax({
				url : queryMemberLevel,
				type : 'POST',
				cache : false,
				contentType : 'text/json',
				success : function(text) {
					
					var Member = text.list;
						for(var i = 0;i<Member.length;i++){
							teamStr = teamStr+"<a class='none' href= 'javascript:queryMember()'  id='Member"+Member[i].id+"'>"+Member[i].name+"</a></br>";

						}
						document.getElementById("team").innerHTML=teamStr; 	
						nui.unmask(document.body);
				}
			});*/
		}
	});
	queryMember({toke:token});
}


function queryMember(json){
	nui.ajax({	
		url : queryMemberUrl,
		type : 'POST',
		data:json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			
			var Member = text.data;
				var str = "";
					
				for(var i = 0;i<Member.length;i++){
					str = str+"<a class='empl' id="+Member[i].empId+" >"+Member[i].empName+"</a>";
					if((i+1)%3==0){
						str = str+"<br>";
					}
				}
				document.getElementById("empl").innerHTML=str; 
				nui.unmask(document.body);
		}
	});
}

var zongTime = 0;
function timeStamp(StatusMinute){
	zongTime = parseInt(zongTime) + parseInt(StatusMinute);
	var day=parseInt(zongTime/60/24);
    var hour=parseInt(zongTime/60%24);
	var min= parseInt(zongTime % 60);
	StatusMinute="";
	if (day > 0)
	{
		nui.get("day").setValue(day);
	} 
	if (hour>0)
	{
		nui.get("hour").setValue(hour);
	} 
	if (min>0)
	{
		nui.get("min").setValue(min);
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

function dispatchOk(){

	var emlpsz = $("a.empl1");//所选技师数组
	var emlpszId = "";
	var emlpszName = "";
	var serviceTypeIdList = serviceTypeIds.getValue();
	if(emlpsz.length==0){
		showMsg("请选择施工员！","W");
		return;
	}

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '处理中...'
    });
	for(var i = 0;i<emlpsz.length;i++){
		if(i==0){
			emlpszId = emlpsz[i].id;
			emlpszName = emlpsz[i].innerText;
		}else{
			emlpszId = emlpszId+","+emlpsz[i].id;	
			emlpszName = emlpszName+","+emlpsz[i].innerText;
		}
		
	}


	var json = {
			serviceId :serviceId,
			workerIds :emlpszId,
			workers: emlpszName,
			serviceTypeIds:serviceTypeIdList,
			type:type
	}
	nui.ajax({	
		url : setItemWorkersBatch,
		type : 'POST',
		data:json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			if (text.errCode == 'S') {
				showMsg("派工成功","S");
				CloseWindow("saveSuccess");
	
			} else {
				showMsg(returnJson.errMsg||"保存失败","W");
				//if(returnJson.errCode == 'E' && returnJson.errMsg==null){
					//showMsg("保存失败","W");
					//nui.alert("卡已经存在,请修改卡名");
				//}
			}

		}
	});
}