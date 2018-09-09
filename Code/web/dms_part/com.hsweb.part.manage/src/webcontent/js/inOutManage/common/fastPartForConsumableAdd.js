var form=null;
var resultData = {};
$(document).ready(function(){
	form=new nui.Form('#form');
});

function onOk()
{
    var node = form.getData();
    if(node)
    {
        console.log(node);
        resultData = {
        	partlist:node
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