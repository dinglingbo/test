
var baseUrl = apiPath + repairApi + "/";
var none = "ALL0";//班组技术样式下标
var serviceId = 0;//工单号
var planFinishDate = new Date();//派工从现在时间开始
var workers="";
var workersId="";
var type = null;
var serviceIdF = null;
var item = null;
$(document).ready(function(v) {
	 //serviceTypeIds = nui.get("serviceTypeIds");
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
    
    /*$(document).on("click",".empl",function(e){
    	if(workersId==""){
    		
    	}else{		
    		document.getElementById(workersId).setAttribute("class", "empl");
    	}
		document.getElementById(e.target.id).setAttribute("class", "empl1");
		workersId = e.target.id;
    });*/
    $(document).on("click",".empl",function(e){
		document.getElementById(e.target.id).setAttribute("class", "empl1");
    });
    $(document).on("click",".empl1",function(e){

    	document.getElementById(e.target.id).setAttribute("class", "empl");
    });

    
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
	var queryMemberUrl = apiPath + sysApi + "/com.hsapi.system.dict.org.queryMember.biz.ext";
    var queryServiceType = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext";
    var setItemWorkersBatch = apiPath + repairApi + "/com.hsapi.repair.repairService.sureMt.setItemCheckers.biz.ext";
function setData(data){
	item = data.item;
	var workersStr =data.checkers||"";
	var workersIdStr =data.checkerIds||"";
	workers =workersStr.split(",");
	workersId =workersIdStr.split(",");
	if(workersId!=""){
		for(var i = 0;i<workersId.length;i++){
			document.getElementById(workersId[i]).setAttribute("class", "empl1");
		}	
	}
	serviceIdF = data.serviceId || 0;
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
		async: false,
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
		 async: false,
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
	var emlpsz = $("a.empl1");//所选技师数组
	var emlpszId = "";
	var emlpszName = "";
	if(emlpsz.length==0){
		showMsg("请选择质检员！","W");
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
    			serviceId :serviceIdF,
    			checkers:emlpszName,
    		    checkerIds:emlpszId,
    		    item:item
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
    				showMsg("设置质检员成功","S");
    				CloseWindow("ok");
    	
    			} else {
    				showMsg("设置质检员失败","E");
    			}
    		}
    	});
}
function getData(){
	return data;
}


