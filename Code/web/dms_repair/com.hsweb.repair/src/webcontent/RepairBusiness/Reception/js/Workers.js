
var baseUrl = apiPath + repairApi + "/";
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
					str = str+"<a class='empl' id="+Member[i].empId+" >&nbsp;"+Member[i].empName+"&nbsp;</a>";
					if((i+1)%3==0){
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

function dispatchOk(){
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
		
	}
    nui.unmask(document.body);
	var data = {
			emlpszId :emlpszId,
			emlpszName:emlpszName
	}
	CloseWindow(data);
}

