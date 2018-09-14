var form=null;
var resultData = {};
var mtAdvisorIdEl = null;
var mtAdvisorIdEl2=null;
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
   
});


function onOk()
{
	form.validate();
    if (form.isValid() == false) return;
    var node = form.getData();
    if(node)
    {
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

