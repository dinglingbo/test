var form=null;
var resultData = {};
var mtAdvisorIdEl = null;
var mtAdvisorIdEl2=null;
$(document).ready(function(){
	form=new nui.Form('#form');

    mtAdvisorIdEl = nui.get("mtAdvisorId");
    mtAdvisorIdE2 = nui.get("mtAdvisorId2");
    
    initMember("mtAdvisorId",function(){
        memList = mtAdvisorIdEl.getData();
    });


    mtAdvisorIdEl.on("valueChanged",function(e){
        var text = mtAdvisorIdEl.getText();
//        nui.get("mtAdvisor").setValue(text);
    });
   
});


function onOk()
{
    var node = form.getData();
    var req=/^\d*$/;
    
    if (!req.test(node.outReturnQty)){
	   showMsg("请输入整数");
    }
    if(node)
    {
        console.log(node);
        resultData = {
        	data:node
        };
        //  return;
        CloseWindow("ok");
    }

}
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

