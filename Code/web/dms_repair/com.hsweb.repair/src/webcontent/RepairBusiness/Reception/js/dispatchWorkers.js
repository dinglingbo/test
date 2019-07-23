
var baseUrl = apiPath + repairApi + "/";
var type = "" ;//区别是套餐还是项目修改的
var none = "ALL0";//班组技术样式下标
var serviceTypeIds = [];
var serviceId = 0;//工单号
var planFinishDate = "";//预计交车时间
$(document).ready(function(v) {
	 serviceTypeIds = nui.get("serviceTypeIds");
	nui.get("sendWechat").setValue(currIsOpenWeChatRemind);
	nui.get("sendApp").setValue(currIsOpenAppRemind);
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
        	
        	json.memberGroupId=((e.target.id).split("Z"))[1]||"";
        	queryMember(json);
        }else if(queryId=="DJ"){
        	json.memberLevelId=((e.target.id).split("J"))[1]||"";
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
    var sendInfoUrl = apiPath + repairApi + "/com.hsapi.repair.repairService.sendWeChat.sAllToWork.biz.ext";
    
function setData(data){
	type = data.type;
	serviceId = data.serviceId;
	planFinishDate = new Date();
	nui.get("planFinishDate").setValue(mini.formatDate ( planFinishDate,"yyyy-MM-dd HH:mm:ss"));

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
			document.getElementById(none).setAttribute("class", "none1");
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
					if((i+1)%4==0){
						str = str+"<br>";
					}
				}
				document.getElementById("empl").innerHTML=str; 
				nui.unmask(document.body);
		}
	});
}

function timeStamp(StatusMinute){
	if(planFinishDate==""){
		nui.get("day").setValue("");
		nui.get("hour").setValue("");
		nui.get("min").setValue("");
		var day=parseInt(StatusMinute/60/24);
	    var hour=parseInt(StatusMinute/60%24);
		var min= parseInt(StatusMinute % 60);
		StatusMinute="";
		if (day > 0){
			nui.get("day").setValue(day);

		} 
		if (hour>0){
			nui.get("hour").setValue(hour);
		} 
		if (min>0){
			nui.get("min").setValue(min);
		}
	}else{
		nui.get("day").setValue("");
		nui.get("hour").setValue("");
		nui.get("min").setValue("");
		var day=parseInt(StatusMinute/60/24);
	    var hour=parseInt(StatusMinute/60%24);
		var min= parseInt(StatusMinute % 60);
		StatusMinute="";
		if (day > 0){
			nui.get("day").setValue(day);
			var yjDate = new Date(planFinishDate);
			yjDate.setDate(yjDate.getDate()+day );
			nui.get("planFinishDate").setValue(mini.formatDate ( yjDate,"yyyy-MM-dd HH:mm:ss"));
			
		} 
		if (hour>0){
			nui.get("hour").setValue(hour);
			var yjDate = new Date(planFinishDate);
			yjDate.setHours(yjDate.getHours()+hour);
			nui.get("planFinishDate").setValue(mini.formatDate ( yjDate,"yyyy-MM-dd HH:mm:ss"));
		} 
		if (min>0){
			nui.get("min").setValue(min);
			var yjDate = new Date(planFinishDate);
			yjDate.setMinutes(yjDate.getMinutes()+min);
			nui.get("planFinishDate").setValue(mini.formatDate ( yjDate,"yyyy-MM-dd HH:mm:ss"));
		}
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

var resultData = null;
function dispatchOk(){
	var userList = [];
	var emlpsz = $("a.empl1");//所选技师数组
	var emlpszId ="";
	var emlpszName ="";
	var serviceTypeIdList = serviceTypeIds.getValue() || "";
	/*实时保存时，传的是字符串*/
	/*serviceTypeIdList = serviceTypeIdList.split(",");
	if(serviceTypeIdList==""){
		serviceTypeIdList = [];	
	};*/
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
		//推送消息用
		var temp = {
				userId:emlpsz[i].id
		}
		userList.push(temp);
	}

    nui.unmask(document.body);

	/*data = {
			emlpszId :emlpszId,
			emlpszName:emlpszName,
			planFinishDate:nui.get("planFinishDate").getValue(),
			serviceTypeIds:serviceTypeIdList
	};
	resultData = data;
	CloseWindow("ok");
  */
    var sendParams = {
			isWc:nui.get("sendWechat").getValue() ,
			isApp:nui.get("sendApp").getValue(),
    }
	
    var json = {
			serviceId :serviceId,
			workerIds :emlpszId,
			workers: emlpszName,
			serviceTypeIds:serviceTypeIdList,
			type:type,
			planFinishDate:nui.get("planFinishDate").getValue(),
			sendParams:sendParams,//推送参数
			userList:userList//推送参数
	};
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
				/*var data = {
						saveSuccess :"saveSuccess"
				}*/
				CloseWindow("ok");
	
			} else {
				showMsg("派工失败","E");
				//if(returnJson.errCode == 'E' && returnJson.errMsg==null){
					//showMsg("保存失败","W");
					//nui.alert("卡已经存在,请修改卡名");
				//}
			}

		}
	});
}

function getData(){
	return resultData;
}
function times(id){
	if(planFinishDate==""){
		
	}else{
			var yjDate = new Date(planFinishDate);
			var day = parseInt(nui.get("day").getValue());
			if(isNaN(day)){
				day=0;
			}
			yjDate.setDate(yjDate.getDate()+day);
			var hour = parseInt(nui.get("hour").getValue());
			if(isNaN(hour)){
				hour=0;
			}
			yjDate.setHours(yjDate.getHours()+hour);
			var min = parseInt(nui.get("min").getValue());
			if(isNaN(min)){
				min=0;
			}
			yjDate.setMinutes(yjDate.getMinutes()+min);
			nui.get("planFinishDate").setValue(mini.formatDate ( yjDate,"yyyy-MM-dd HH:mm:ss"));
	}
}

