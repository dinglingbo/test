

var savePositionsUrl = apiPath + partApi + "/com.hsapi.part.baseDataCrud.crud.editPositions.biz.ext";
var row =null;//传过来的修改行
$(document).ready(function(v) {

	
	
});

    
function setData(data){
	row = data;
	nui.get("oldPositions").setValue(row.storeShelf||"");
}
function onOk(){
	row.storeShelf =  nui.get("positions").getValue();
    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '数据修改中...'
    });
    var json = {
    		storeId:	row.storeId,
    		partId: 	row.partId,
    		storeShelf:	row.storeShelf
    }
	nui.ajax({
		url : savePositionsUrl,
		type : 'POST',
		data: json,
		cache : false,
		contentType : 'text/json',
		success : function(text) {
			nui.unmask(document.body);
				if(text.errCode=="S"){
					showMsg("保存成功！","S");
					CloseWindow("saveSuccess");
				}else{
					showMsg(text.errMsg||"保存失败！","W");
				}
		}
	});
}

//关闭窗口
function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else window.close();
}
//取消
function onCancel() {
    CloseWindow("cancel");
}


