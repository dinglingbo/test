
var concator = {};
var temp = "";
var temp2="";
var resultData={};
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
//	concator = params;
//	if(!concator.contactorId){
//		showMsg("联系人数据出错，请重新操作!","E");
//		return;
//	}
//	var params = {
//			id:concator.contactorId
//	};
//	nui.mask({
//		el : document.body,
//		cls : 'mini-mask-loading',
//		html : '加载中...'
//	});
//	nui.ajax({
//		url : setNature,
//		type : "post",
//		aynsc:false,
//		data : {
//			params:params,
//			token:token
//		},
//		success : function(data) {		
//			nui.unmask(document.body);
//			if (data.errCode == "S") {
//				var guestTab = data.contcator;
//				var str = guestTab.natureId;
//				//str = "1545469092700,1545469092701,1545469092702";
//				if(str){
//					showTab(str);
//				}
//				
//			}else{
//				showMsg("保存失败","E");
//			}
//		},
//		error : function(jqXHR, textStatus, errorThrown) {
//			console.log(jqXHR.responseText);
//		}
//	});
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
	var dictids = ["10441","10442"];
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
				
				for(var i=0;i<list.length;i++){
					 var a="产品线分类";
					 var b ="维修性质分类";
					 if(list[i].dictid =="10441"){
						 var aEl = "<a href='##' id='"+list[i].id+"' value="+list[i].name+"  name='HotWord' class='hui'>"+list[i].name+"</a>";
						 temp +=aEl;
					 }
					 if(list[i].dictid =="10442"){
						 var aEl2 = "<a href='##' id='"+list[i].id+"' value="+list[i].name+"  name='HotWord' class='hui'>"+list[i].name+"</a>";
						 temp2 +=aEl2;
					 }
					
				}
				$("#addAEl").html(temp);
				$("#addAEl2").html(temp2);
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
function onOk(){

	var tabList = document.querySelectorAll('.xz');
	var tmp ="";
	var nature = "";
	var natureId = "";
	for(var i=0;i<tabList.length;i++){
		tmp +=tabList[i].outerHTML;
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
	var data={};
	data.customClassName=nature;
	data.customClassId=natureId;
	data.tmp=tmp;
	console.log(nature);
	console.log(natureId);
	console.log(tmp);
	resultData=data;
	CloseWindow("ok");
	
	
}

function getData(){
    return resultData;
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