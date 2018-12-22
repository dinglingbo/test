$(document).ready(function()
{	
	//nui.get("addAEl").focus();
	document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;//38向上 40向下

        if((keyCode==27))  {  //ESC
            if(isOpenWin==1){
                onCancel();
            }
           
        }
      };
    setHotWord();
});
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
	var guestTab = null;
	for(var i=0;i<tabList.length;i++){
		if(i==0){
			guestTab=guestTab+tabList[i].innerHTML;
		}else if(i<tabList.length-1){
			guestTab=","+guestTab+tabList[i].innerHTML;
		}else{
			guestTab=guestTab+tabList[i].innerHTML;
		}
	}
	
}