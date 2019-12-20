function itemCopy(){
	var saveUrl = apiPath + repairApi + "/com.hsapi.repair.baseData.item.itemCopy.biz.ext";
	var yorgid = nui.get("yorgid").getValue()
	var xorgid = nui.get("xorgid").getValue()
	if(!yorgid>0){
		showMsg("请输入原门店orgid！","W");
		return;
	}
	if(!xorgid>0){
		showMsg("请输入现门店orgid！","W");
		return;
	}	
	var params = {};
	params.yorgid = yorgid;	
	params.xorgid = xorgid;	
	var json = {
			params : 	params,
			token : token
	};
	  nui.confirm("是否确定复制?", "友情提示",function(action){
	       if(action == "ok"){
				nui.mask({
					el : document.body,
					cls : 'mini-mask-loading',
					html : '数据处理中...'
				});
				nui.ajax({
					url : saveUrl,
					type : 'POST',
					data : json,
					cache : false,
					contentType : 'text/json',
					success : function(text) {
						nui.unmask(document.body);
						if(text.errCode=="S"){
							showMsg("复制成功!","S")
							CloseWindow("ok");
						}else{
							showMsg(text.errMsg||"复制失败!","W");
						}
					}
				 });

	     }else {
				return;
		 }
		 }); 
}