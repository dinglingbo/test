/**
 * Created by Administrator on 2018/1/24.
 */

var baseUrl = "";
var leftGridUrl = baseUrl+"";
var rightGridUrl = baseUrl+"";
var leftGrid = null;
var rightGrid = null;
var splitter = null;
$(document).ready(function(v)
{
    //splitter = nui.get("splitter");
    //console.log(splitter);
    leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);
    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
});


function addPartQuality()
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.partQualityDetail.flow",
        title: "新增品质", width: 350, height: 150,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {

        }
    });
}


function addPartBrand(){
    nui.open({
        targetWindow: window,
        url: "com.hsweb.part.baseData.partBrandDetail.flow",
        title: "新增品质", width: 350, height: 200,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {

        },
        ondestroy: function (action)
        {

        }
    });
}