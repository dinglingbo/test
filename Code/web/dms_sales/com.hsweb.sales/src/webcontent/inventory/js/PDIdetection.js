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
    morePartGrid.on("cellendedit",function(e){
        var field = e.field;
        var record = e.record;
        var column = e.column;
        var row={status:-1,nosettleType :1,settleType :1};
        var nrow={status:1,nostatus:-1,nosettleType :0,settleType:-1};
        var row2={status:0,nosettleType :0,settleType :-1};
        var nrow2={status:0,settleType :-1};
        
        var row3={status:-1,nostatus:1,settleType:1};
        var nrow3 ={status:-1,nostatus:1,nosettleType :0};
        var row4={status:-1,nostatus:1,settleType:0};
        var nrow4 ={status:-1,nostatus:1,nosettleType :1};
        var nrow5 ={status:1,settleType :-1 ,nosettleType :0}
        if(field == "status"){
            if(record.status == 1){
            	morePartGrid.updateRow(record,nrow);
            }else{
            	morePartGrid.updateRow(record,nrow2);
            }
        }
        if(field == "nostatus"){
            if(record.nostatus == 1){
            	morePartGrid.updateRow(record,row);
            }else{
            	morePartGrid.updateRow(record,row2);
            }
        }
    });
    
});

function setData(row){
	if(row){
		var searchPdiUrl = bearUrl+"sales.inventory.queryPDI.biz.ext";
	    nui.ajax({
	        url: searchPdiUrl,
	        type:"post",
	        async: false,
	        data:{
	        	params:{enterId:row.id},
	        	token:token
	        },
	        cache: false,
	        success: function (text) {
	            var pdi = text.pdi||[];
	            var pdiD = text.pdiD||[];

	            if(pdi.length<1){
	            	row.enterId = row.id;
	            	row.id = null;
	        		advancedSearchForm.setData(row);
	        		nui.get("pdiDetectioner").setValue(currEmpId);
	        		nui.get("pdiDetectioner").setText(currUserName);
	        		nui.get("pdiDetectionDate").setValue(new Date());
	        		nui.get("vin").setValue(row.vin);
	            }else{
		            advancedSearchForm.setData(pdi[0]);
		            nui.get("enterId").setValue(row.id);
		            nui.get("pdiTemplateId").setValue(pdiD[0].pdiTemplateId);
		            for(var i = 0;i<pdiD.length;i++){
		            	if(pdiD[i].isNormal==0){
		            		pdiD[i].status = 1;
		            	}else{
		            		pdiD[i].nostatus = 1;
		            	}		            	
		            }
		        	morePartGrid.setData(pdiD);
	            }
	        }
	    });
	}	
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
            if(list && list.length>0){
            	for(var i=0;i<list.length;i++){
            		list[i].checkRemark=list[i].remark;
            		list[i].remark=null;
            	}
            }
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
	nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});
	var cssCheckPdiMain = advancedSearchForm.getData();
	var cssCheckPdiDetail = morePartGrid.getData();
	for(var i = 0;i<cssCheckPdiDetail.length;i++){
		cssCheckPdiDetail[i].pdiItemName = cssCheckPdiDetail[i].name;
		cssCheckPdiDetail[i].pdiItemId = cssCheckPdiDetail[i].id;
		cssCheckPdiDetail[i].pdiItemTypeId = cssCheckPdiDetail[i].pdiTypeId;
		cssCheckPdiDetail[i].pdiTemplateId = cssCheckPdiMain.pdiTemplateId;
		if(cssCheckPdiDetail[i].status==1){
			cssCheckPdiDetail[i].isNormal = 0;
		}else if(cssCheckPdiDetail[i].nostatus==1){
			cssCheckPdiDetail[i].isNormal = 1;
		}
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
        	nui.unmask(document.body);
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

function setNormal(){
	var data=morePartGrid.getData();
	var nrow={status:1,nostatus:-1,nosettleType :0,settleType:-1};
	var row2={status:0,nosettleType :0,settleType :-1};
	var count=0;
		for(var i=0;i<data.length;i++){
			if(data[i].status==1){
				count++;
			}
		}
		for(var i=0;i<data.length;i++){
			if(count==data.length){
				morePartGrid.updateRow(data[i],row2) ;
			}				
			else{
				morePartGrid.updateRow(data[i],nrow) ;
			}
				
		}
}