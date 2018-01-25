/**
 * Created by Administrator on 2018/1/24.
 */
var baseUrl = window._rootUrl||"";
var leftGridUrl = baseUrl+"";
var rightGridUrl = baseUrl+"";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var leftGrid = null;
var rightGrid = null;
$(document).ready(function(v)
{
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    //console.log("xxx");
});
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    doSearch(param);
}
function getSearchParam(){

}
function doSearch(params)
{
    grid.load(params);
}
function advancedSearch()
{
    advancedSearchWin.show();
    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel(){
    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function addInbound()
{
    basicInfoForm.clear();
}
function editInbound(){
    var node = leftGrid.getSelected();
    console.log(node);
    if(node)
    {

    }
}


function selectSupplier(elId)
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.common.supplierSelect.flow",
        title: "供应商资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {
            if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                console.log(data);
                var value = "";
                var text = "1";
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
            }
        }
    });
}

function selectPart(callback)
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.common.partSelectView.flow",
        title: "供应商资料", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({},callback);
        },
        ondestroy: function (action)
        {
        }
    });
}

function addPart()
{
    selectPart(function(part)
    {
        console.log(part);
    });
}