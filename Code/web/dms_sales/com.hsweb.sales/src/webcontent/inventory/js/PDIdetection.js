var bearUrl  = apiPath +saleApi + "/";
var rightGridUrl = bearUrl+"sales.inventory.queryCheckEnter.biz.ext";
var searchCsbPDICarDetailUrl = bearUrl+"sales.base.searchCsbPDICarDetail.biz.ext";
var searchCsbPDICarTemplateUrl = bearUrl+"sales.base.searchCsbPDICarTemplate.biz.ext";
var morePartGrid = null;
var advancedSearchForm = null;
var pdiTemplateId = null;
$(document).ready(function(v){
	advancedSearchForm = new nui.Form("#advancedSearchForm");
	pdiTemplateId = nui.get("pdiTemplateId");
	pdiTemplateId.setUrl(searchCsbPDICarTemplateUrl);
	morePartGrid = nui.get("morePartGrid");
	initMember("pdiDetectioner",function(){
        memList = nui.get('pdiDetectioner').getData();
    });
    $("#pdiDetectioner").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            var remark = nui.get("remark");
            remark.focus();
        }
    });
});

function setData(row){
	advancedSearchForm.setData(row);
	nui.get("pdiDetectioner").setValue(currEmpId);
	nui.get("pdiDetectioner").setText(currUserName);
	nui.get("pdiDetectionDate").setValue(new Date());
	nui.get("vin").setValue(row.carFrameNo);
	nui.get("enterId").setValue(row.id);
	
/*	nui.ajax({
		url : searchCsbPDICarTemplateUrl,
		type : "post",
		data : "",
		success : function(data) {
			data = data || {};
			var  searchCsbPDICarTemplate = data.list;
			
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});*/
}

function ValueChanged(e) {
    var sdata = e.selected; 
    nui.ajax({
        url: searchCsbPDICarDetailUrl,
        type:"post",
        async: false,
        data:{
        	params:{templateId:sdata.id},
        	token:token
        },
        cache: false,
        success: function (text) {
            var list = text.list;
/*            if(list && list.length>0){
            	for(var i=0;i<list.length;i++){
            		list[i].checkRemark=list[i].remark;
            		list[i].remark=null;
            	}
            }*/
            morePartGrid.clearRows();
        	morePartGrid.setData(list);
        	if(list.length==0){
        		showMsg("该检查模板无检查项目,请添加检查项目","W");
        		nui.get('pdiTemplateId').setValue("");
        		nui.get('pdiTemplateId').setText("");
        		return;
        	}
        }
    });
    
   
}
var saveCssCheckPdiMainUrl = bearUrl+"sales.inventory.saveCssCheckPdiMain.biz.ext";

function onOk(){
	var cssCheckPdiMain = advancedSearchForm.getData();
	var cssCheckPdiDetail = morePartGrid.getSelecteds();
	for(var i = 0;i<cssCheckPdiDetail.length;i++){
		cssCheckPdiDetail[i].pdiItemName = cssCheckPdiDetail[i].name;
	}
    nui.ajax({
        url: saveCssCheckPdiMainUrl,
        type:"post",
        async: false,
        data:{
        	cssCheckPdiMain:cssCheckPdiMain,
        	cssCheckPdiDetail : cssCheckPdiDetail,
        	token:token
        },
        cache: false,
        success: function (text) {
            var list = text.list;
            if(text.errCode=="S"){
            	showMsg("保存成功","S");
            	onCancel();
            }else{
            	showMsg("保存异常","W");
            }
        }
    });
}

function onCancel(){
	CloseWindow("ok");
}

function CloseWindow(action) {
    if (window.CloseOwnerWindow)
        return window.CloseOwnerWindow(action);
    else
        window.close();
}