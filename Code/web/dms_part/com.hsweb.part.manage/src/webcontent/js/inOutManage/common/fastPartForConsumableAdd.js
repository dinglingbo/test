var form=null;
var resultData = {};
var mtAdvisorIdEl = null;
var brandHash = {};
var brandList = [];
$(document).ready(function(){
	form=new nui.Form('#form');

    mtAdvisorIdEl = nui.get("mtAdvisorId");

    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });


    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
//        nui.get("mtAdvisor").setValue(text);
    });
    getData();
    

	
//	if (brandHash[e.value]) {
//		e.cellHtml = brandHash[e.value].name || "";
//	} else {
//		e.cellHtml = "";
//	}

});


function onOk()
{
	form.validate();
    if (form.isValid() == false) return;
    var node = form.getData();
    var req=/^\d*$/;
    
    if (!req.test(node.outQty)){
	   showMsg("请输入整数");
    }
    if(node)
    {
        resultData = {
        	data:node
        };
        //  return;
        CloseWindow("ok");
    }

}
//getAllPartBrand(function(data) {
//	brandList = data.brand;
//	var partBrand=nui.get('partBrandId').getValue();
//	for(var i=0;i<brandList.length;i++){
//		if(partBrand==brandList[i].id){
//			nui.get('partBrandId').setText(brandList[i].name);
//		}
//	}
////	nui.get('partBrandId').setData(brandList);
////	brandList.forEach(function(v) {
////		brandHash[v.id] = v;
////		
////	});
//});
function getData(){
    return resultData;
}

function SetData(params) {
    var params = nui.clone(params);
    if(params.data!=null){
        form.setData(params.data);
    }

}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

