var setNature = apiPath+repairApi+"/com.hsapi.repair.repairService.svr.saveNature.biz.ext";
var concator = {};
var natureId = "";
var nature = "";
$(document).ready(function()
{	
	//nui.get("auditBtn").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            onCancel();
        }
      };
    setHotWord();
});
function setData(params){
	concator = params;
	//客户车辆跳转过来的
	if(concator =="guest"){
		
	}else{
		if(!concator.contactorId){
			showMsg("联系人数据出错，请重新操作!","E");
			return;
		}
		var params = {
				id:concator.contactorId,
		};
		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '加载中...'
		});
		nui.ajax({
			url : setNature,
			type : "post",
			aynsc:false,
			data : {
				params:params,
				token:token
			},
			success : function(data) {		
				nui.unmask(document.body);
				if (data.errCode == "S") {
					var guestTab = data.contcator;
					var str = guestTab.natureId;
					//str = "1545469092700,1545469092701,1545469092702";
					if(str){
						showTab(str);
					}
					
				}else{
					showMsg("保存失败","E");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});
	}

}

function CloseWindow(action)
{
	if (window.CloseOwnerWindow)
		return window.CloseOwnerWindow(action);
	else window.close();
}

function onCancel() {
	CloseWindow("cancel");
}

 function setHotWord(){
	var hotUrl = apiPath + sysApi + "/com.hsapi.system.dict.dictMgr.queryDict.biz.ext";
	var dictids = ["10181"];
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
				
				var list = nui.clone(data.data);
				var temp = "";
				for(var i=0;i<list.length;i++){
					
					 var aEl = "<a href='##' id='"+list[i].id+"' value="+list[i].name+"  name='HotWord' class='hui'>"+list[i].name+"</a>";
					 temp +=aEl;
				}
				$("#addAEl").html(temp);
				selectclick();
			} else {
				showMsg(data.errMsg || "设置客户标签失败!","E");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}
function selectclick() {
    $("a[name=HotWord]").click(function () {
//        $(this).siblings().removeClass("xz");
        $(this).toggleClass("xz");
        
    });
}
function save(){
	var tabList = document.querySelectorAll('.xz');
	 nature = "";
	 natureId = "";
	for(var i=0;i<tabList.length;i++){
		if(i==0){
			nature=tabList[i].innerHTML;
			natureId=tabList[i].id;
		/*}else if(i<tabList.length-1){
			nature=nature+","+tabList[i].innerHTML;
			natureId=natureId+","+tabList[i].id;*/
		}else{
			nature=nature+","+tabList[i].innerHTML;
			natureId=natureId+","+tabList[i].id;
		}
	}
	//客户车辆跳转过来的
	if(concator =="guest"){		
		CloseWindow("ok");
	}else{
		if(!concator.contactorId){
			showMsg("联系人数据出错，请重新操作!","E");
			return;
		}		
		var params = {
				nature:nature,
				natureId:natureId,
				id:concator.contactorId,
				type:"update"
		};
		nui.mask({
			el : document.body,
			cls : 'mini-mask-loading',
			html : '保存中...'
		});
		//nature，
		nui.ajax({
			url : setNature,
			type : "post",
			aynsc:false,
			data : {
				params:params,
				token:token
			},
			success : function(data) {	
				nui.unmask(document.body);
				if (data.errCode == "S") {
					showMsg("保存成功","S");
					CloseWindow("cancel");
				}else{
					showMsg("保存失败","E");
				}
			},
			error : function(jqXHR, textStatus, errorThrown) {
				console.log(jqXHR.responseText);
			}
		});
	}

	
}
function NoSave(){
	onCancel();
}
function showTab(str){
	var list = str.split(",");
	if(list.length >0){
		for(var i = 0 ;i<list.length;i++){
			var id = list[i];
			var s = "#"+id;
			$(s).toggleClass("xz");
		}
	}
}

function getData(){
	var natureList = {
			natureId:natureId,
			natureName : nature
	}
	return  natureList;
}