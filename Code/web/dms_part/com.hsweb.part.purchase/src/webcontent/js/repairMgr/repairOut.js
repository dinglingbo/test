/**
 * Created by Administrator on 2018/2/7.
 */

var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var basicInfoForm = null;
var queryForm = null;
var queryInfoForm = null;


var leftGrid = null;
var leftGridUrl = baseUrl+"";
var rightGrid = null;
var rightGridUrl = baseUrl+"";
var rightGrid1 = null;
var rightGrid1Url = baseUrl+"";
var rightGrid2 = null;
var rightGrid2Url = baseUrl+"";
var rightGrid3 = null;
var rightGrid3Url = baseUrl+"";
var rightGrid4 = null;
var rightGrid4Url = baseUrl+"";
var rightGrid5 = null;
var rightGrid5Url = baseUrl+"";

$(document).ready(function()
{
    basicInfoForm = new nui.Form("#basicInfoForm");
    console.log(basicInfoForm);
    queryForm = new nui.Form("#queryForm");
    console.log(queryForm);
    queryInfoForm = new nui.Form("#queryInfoForm");
    console.log(queryInfoForm);

    leftGrid = nui.get("leftGrid");
    leftGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    console.log(leftGrid);
    leftGrid.setUrl(leftGridUrl);
    rightGrid = nui.get("rightGrid");
    rightGrid.on("beforeload",function(e){
        e.data.token = token;
    });
    console.log(rightGrid);
    rightGrid.setUrl(rightGridUrl);
    rightGrid1 = nui.get("rightGrid1");
    rightGrid1.on("beforeload",function(e){
        e.data.token = token;
    });
    console.log(rightGrid1);
    rightGrid1.setUrl(rightGrid1Url);
    rightGrid2 = nui.get("rightGrid1");
    rightGrid2.on("beforeload",function(e){
        e.data.token = token;
    });
    console.log(rightGrid2);
    rightGrid2.setUrl(rightGrid2Url);
    rightGrid3 = nui.get("rightGrid3");
    rightGrid3.on("beforeload",function(e){
        e.data.token = token;
    });
    console.log(rightGrid3);
    rightGrid3.setUrl(rightGrid3Url);
    rightGrid4 = nui.get("rightGrid4");
    rightGrid4.on("beforeload",function(e){
        e.data.token = token;
    });
    console.log(rightGrid4);
    rightGrid4.setUrl(rightGrid4Url);
    rightGrid5 = nui.get("rightGrid5");
    rightGrid5.on("beforeload",function(e){
        e.data.token = token;
    });
    console.log(rightGrid5);
    rightGrid5.setUrl(rightGrid5Url);
});

function onAddMaterial(){
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.purchase.repairMaterial.flow",
        title: "供应商资料", width: 560, height: 200,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            //var iframe = this.getIFrameEl();
            //iframe.contentWindow.setData({
            //    province:provinceList,
            //    city:cityList,
            //    supplierType:supplierTypeList,
            //    billTypeId:billTypeIdList,
            //    settTypeId:settTypeIdList,
            //    tgrade:tgradeList,
            //    managerDuty:managerDutyList
            //});
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var data  = iframe.contentWindow.getData();
                console.log(data);
                rightGrid2.addRow(data.material);
            }
        }
    });
}
function onEditMaterial()
{
    var row = rightGrid2.getSelected();
    var list = rightGrid2.getData();
    if(row)
    {
        nui.open({
            targetWindow: window,
            url: "com.hsweb.part.purchase.repairMaterial.flow?token=" + token,
            title: "供应商资料", width: 560, height: 200,
            allowDrag:true,
            allowResize:false,
            onload: function ()
            {
                var iframe = this.getIFrameEl();
                iframe.contentWindow.setData({
                    list:list,
                    material:row
                });
            },
            ondestroy: function (action)
            {
                if(action == "ok")
                {
                    var iframe = this.getIFrameEl();
                    var data  = iframe.contentWindow.getData();
                    console.log(data);
                    rightGrid2.addRow(data.material);
                }
            }
        });
    }
    else{

    }
}
function onDeleteMaterial(){
    var row = rightGrid2.getSelected();
    if(row)
    {
        rightGrid2.removeRow(row);
    }
}
function onSaveMaterial()
{

}