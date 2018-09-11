var form=null;
var resultData = {};
$(document).ready(function(){
	form=new nui.Form('#form');
});

function onOk()
{
    var node = form.getData();
    var req=/^\d*$/;
    
    if (!req.test(node.orderQty)){
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

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}

