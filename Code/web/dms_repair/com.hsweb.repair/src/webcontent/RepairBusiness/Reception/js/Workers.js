
var baseUrl = apiPath + repairApi + "/";
var none = "ALL0";//班组技术样式下标
//var serviceTypeIds = null;
var serviceId = 0;//工单号
var planFinishDate = new Date();//派工从现在时间开始
var workers={};
var workersId={};
$(document).ready(function(v) {
	 //serviceTypeIds = nui.get("serviceTypeIds");
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
    
    // nui.get("toolbar1").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
        	onClose();
        }
      };
    
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
	serviceId =data.serviceId;
	var workersStr =data.workers||"";
	var workersIdStr =data.workersId||"";
	workers =workersStr.split(",");
	workersId =workersIdStr.split(",");
	if(workersId!=""){
		for(var i = 0;i<workersId.length;i++){
			document.getElementById(workersId[i]).setAttribute("class", "empl1");
		}	
	}
	nui.get("planFinishDate").setValue(mini.formatDate ( new Date(),"yyyy-MM-dd HH:mm:ss"));
}
function init(){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据加载中...'
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
					str = str+"<a class='empl' id="+Member[i].empId+">"+Member[i].empName+"</a>";
					if((i+1)%4==0){
						str = str+"<br>";
					}
				}
				document.getElementById("empl").innerHTML=str; 
				nui.unmask(document.body);
		}
	});
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
var data={};
function dispatchOk(){
	var userList = [];
	var emlpsz = $("a.empl1");//所选技师数组
	var emlpszId = "";
	var emlpszName = "";
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
    if(nui.get("sendWechat").getValue() != "0" ||nui.get("sendApp").getValue() != "0"){
    	sendInfo(userList);
    }
	data = {
			emlpszId :emlpszId,
			emlpszName:emlpszName,
			planFinishDate:nui.get("planFinishDate").getValue(),
	};
	CloseWindow("ok");
}
function getData(){
	return data;
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

//推送消息
function sendInfo(userList){
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '消息推送中...'
    });
	nui.ajax({
		url:sendInfoUrl,
		type:"psot",
		async:false,
		data:{
			serviceId:serviceId,
			workerIdList:userList,
			isWc:nui.get("sendWechat").getValue(),
			isApp:nui.get("sendApp").getValue(),
		},
		success : function(data) {
			nui.unmask(document.body);
			if(data.errCode == "S"){
				showMsg("推送成功","S");
			}else{
				showMsg("推送失败","E");
			}
			console.log(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			nui.unmask(document.body);
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			
		}
	})
}

