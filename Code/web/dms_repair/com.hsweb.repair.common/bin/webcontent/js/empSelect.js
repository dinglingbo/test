/**
 * Created by Administrator on 2018/3/15.
 */
var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.repair.common.common.queryOrgTree.biz.ext";
var tree = null;
$(document).ready(function(v)
{
    tree = nui.get("tree");
    tree.setUrl(treeUrl);
});
function onBeforeTreeLoad(e)
{
    // 增加nodeType参数以便区分是加载机构下的结点还是岗位下的结点
    e.params.nodeType = e.node.nodeType;
}
function onPreTreeLoad(e)
{
    var data = e.data;
    data.forEach(function(v)
    {
        if(v.iconCls)
        {
            delete v.iconCls;
        }
    });
}
function onDrawTreeNode(e)
{
    var node = e.node;
    if(node.nodeType != "OrgEmployee")
    {
        e.showCheckBox = false;
    }
}
var multiSelect = true;
function setData(data)
{
    data = data||{};
    if(data.multiSelect === false || data.multiSelect === 0)
    {
        multiSelect = false;
    }
}
var resultData = {};
function getData(){
    return resultData;
}
function onOk()
{
    var empList = tree.getCheckedNodes(false);
    if(empList.length>0)
    {
    	if(!multiSelect && empList.length>1)
        {
            nui.alert("只能选择一个用户");
            return;
        }
        resultData.empList = empList;
        CloseWindow("ok");
    }
    else{
        nui.alert("请至少选择一个用户");
    }
}

function CloseWindow(action)
{
    if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
    else window.close();
}
function onCancel(e) {
    CloseWindow("cancel");
}