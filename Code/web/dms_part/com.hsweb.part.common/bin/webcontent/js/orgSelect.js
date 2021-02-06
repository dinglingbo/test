/**
 * Created by Administrator on 2018/2/28.
 */


var baseUrl = apiPath + partApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.part.common.svr.getOrgList.biz.ext";

var tree = null;
$(document).ready(function(v)
{
    tree = nui.get("tree1");
    tree.setUrl(treeUrl);
    tree.on("beforeload",function(e){
        e.data.token = token;
    });
});



function CloseWindow(action) {
    //if (action == "close" && form.isChanged()) {
    //    if (confirm("数据被修改了，是否先保存？")) {
    //        return false;
    //    }
    //}
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}
function onOk()
{
    var node = tree.getSelectedNode();
    if(!node)
    {
        showMsg("请选择一个公司/部门","W");
        return;
    }
    resultData.org = node;
    CloseWindow("ok");
}
var resultData = {};
function getData(){
    return resultData;
}