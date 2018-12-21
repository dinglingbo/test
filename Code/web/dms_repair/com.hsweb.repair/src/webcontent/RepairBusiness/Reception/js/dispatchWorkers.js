
var baseUrl = apiPath + repairApi + "/";


var none = "0";
$(document).ready(function(v) {

    $(document).on("click",".none",function(e){
        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据加载中...'
        });
    	nui.ajax({
    		
    		url : queryMember,
    		type : 'POST',
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
    				document.getElementById(none).setAttribute("class", "none");
    				none = e.currentTarget.id;
    				document.getElementById(none).setAttribute("class", "none1");
    				nui.unmask(document.body);
    		}
    	});
    });

	setData();
    

});
	var queryMemberLevel = apiPath + repairApi + "/com.hsapi.repair.baseData.team.queryMemberLevel.biz.ext";
	var queryWorkTeam = apiPath + repairApi + "/com.hsapi.repair.baseData.team.queryWorkTeam.biz.ext";
	var queryMember = apiPath + sysApi + "/com.hsapi.system.dict.org.queryMember.biz.ext";
    var queryServiceType = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryServiceType.biz.ext";
function  setData(){
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
				var str = "";
				for(var i = 0;i<ServiceType.length;i++){
					str = str+"<input  class='nui-CheckBox' id="+ServiceType[i].id+" />"+ServiceType[i].name;
					if((i+1)%5==0){
						str = str+"<br>";
					}
				}
				document.getElementById("Project").innerHTML=str; 		
		}
	});
var teamStr ="<a class='none1' href= 'javascript:queryMember()' id='0' >所有</a></br>";
	nui.ajax({
		url : queryWorkTeam,
		type : 'POST',
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
			var Member = text.list;
			for(var i = 0;i<Member.length;i++){
				teamStr = teamStr+"<a class='none' href= 'javascript:queryMember()'  id='WorkTeam"+Member[i].id+"' >"+Member[i].name+"</a></br>";
				
			}	
			nui.ajax({
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
			});
		}
	});

}


function queryMember(){
	nui.ajax({
		url : queryMember,
		type : 'POST',
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			
			var Member = text.data;
				var str = "";
				for(var i = 0;i<Member.length;i++){
					str = str+"<a class='empl' id="+Member[i].empId+" >"+Member[i].empName+"</a></br>";

				}
				document.getElementById("empl").innerHTML=str; 		
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