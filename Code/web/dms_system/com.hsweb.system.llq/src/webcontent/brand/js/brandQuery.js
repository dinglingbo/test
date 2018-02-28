
var vin; //vin
var brand; //品牌
var dgNavigation; //导航
var dg1; //层1
var dg2; //层2
var dg3; //层3
var dg4; //层4
var dg5; //层5
var dg6; //层6
var dg7; //层7
var dg8; //层8
var dg9; //层9
var navData = [];

var panel;

$(document).ready(function(v){
    dgNavigation = nui.get("dgNavigation"); //导航
    dg1 = nui.get("dg1"); //层1
    dg2 = nui.get("dg2"); //层2
    dg3 = nui.get("dg3"); //层3
    dg4 = nui.get("dg4"); //层4
    dg5 = nui.get("dg5"); //层5
    dg6 = nui.get("dg6"); //层6
    dg7 = nui.get("dg7"); //层7
    dg8 = nui.get("dg8"); //层8
    dg9 = nui.get("dg9"); //层9
    
    queryDg1();
    
    dgNavigation.on("rowclick", function (e) {//导航
        var row = dgNavigation.getSelected();
        if (row.index) {
            showRightGrid(eval('dg' + row.index));
        }
    });
    
    dg1.on("rowclick", function (e) {//查分组信息
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        var row = dg1.getSelected();
        if (row.brand) {
            var params = {
                "url":"https://llq.007vin.com/cars/show",
                "params":{
                    "brand":row.brand
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg2);
        }
    });
    
    /*gridSubGroup.on("rowclick", function (e) {//查零件信息
        var row = gridSubGroup.getSelected();
        if (row.auth) {
            var params = {
                "url":"https://llq.007vin.com/ppyvin/parts",
                "params":{
                    "vin":vin,
                    "brand":brand,
                    "is_filter":1,
                    "auth":unescape(row.auth)
                },
                "token": token
            }
            callAjax(url, params, processAjax, setGridPartsData);
        }
    });
    
    gridParts.on("drawcell", function (e) { //表格绘制
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var value = e.value;
        if(field == "detail"){
            var html = '<a class="icon-hedit" href="javascript:openDetail(' + record.pid + ')">' + value + '</a>';
            e.cellHtml = html;
        }
    });*/
});

/*
*用户车架号历史查询记录（使用逻辑流，因为无法控制autocomplete发送请求的方式）
*/

/*
*获取品牌
*/
function queryDg1(){	
    var params = {
        "url":"https://llq.007vin.com/ppycars/brand",
        "params":{
        },
        "token": token
    }
    
    //$(".groupButton").hide();
    callAjax(url, params, processAjax, setDg1);
}

/*
*setNav
*/
function setNav(index, title){
    for(var i=navData.length-1; i>0; i--){
        navData.pop();            
        if(i == index){
            break;
        }
    }
    navData.push({index:index, title: index + " " + title});
}

/*
*setDg1
*/
function setDg1(data){
    dg1.setData(data);
    setNav(1, "选择品牌");
    //navData.push({index:1, title:"1 选择品牌"});
    showRightGrid(dg1);
}

/*
*setDg2
*/
function setDg2(data, rs){
    dg2.setData(data);
    setNav(2, rs.title);
    showRightGrid(dg2);
}

/*
*Dg1
*/
function setDg1Data(){	
    if (checkVin()){
        var params = {
            "url":"https://llq.007vin.com/ppyvin/group",
            "params":{
                "vin":vin,
                "brand":brand
            },
            "token": token
        }
        callAjax(url, params, processAjax, setgridMainGroup);
    }	
}

/*
*主组数据处理
*/
function setgridMainGroup(data){    
    showLeftGrid(gridMainGroup);
    gridMainGroup.set({
        columns: [
            { type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},
            { field: "auth", visible: false},
            { field: "name", width:80, headerAlign: "center", allowSort: false, header: "主组名称"}
        ]
    });
    gridMainGroup.setData(data);
}

/*
*分组信息
*/
function setSubGroupData(data){
    gridSubGroup.setData(data);
    showRightGrid(gridSubGroup);
}

/*
*零件数据处理
*/
function setGridPartsData(data){
    gridParts.setData(data);
    showRightGrid(gridParts);
    
}

/*
*零件详情
*/
function openDetail(pid){	
    try{
        nui.open({
            url : sysDomain + "/com.hsweb.system.llq.vin.partDetail.flow?brand=" + brand + "&pid=" + pid,
            title : "零件详情",
            width : "600px",
            height : "500px",
            showHeader:true,
            onload : function() {
                //var iframe = this.getIFrameEl();
                //iframe.contentWindow.setInitData(row, e);
            },
            ondestroy : function(action) {
                //gridParts.reload();
            }
        });
    }finally{}
}

function checkVin(){
    if (vin && vin.length == 17){
        return true;
    }else{
        nui.alert("请输入17位VIN编码！");
        return false;
    }
}

/*
*左部grid
*/
function showLeftGrid(gridObj){
    gridMainGroup.hide();
    
    gridObj.show();  
}

/*
*右部grid
*/
function showRightGrid(gridObj){
    dg1.hide();
    dg2.hide();
    dg3.hide();
    dg4.hide();
    dg5.hide();
    dg6.hide();
    dg7.hide();
    dg8.hide();
    dg9.hide();    
    
    gridObj.show();
    dgNavigation.setData(navData);
    /* var num = (gridObj==gridCfg)? 0 : ((gridObj==gridSubGroup)? 1 : 2);
    $($(".groupButton")[num]).show();
    setBgColor($(".groupButton")[num]); */
}


function setBgColor(obj){
    $(".groupButton:visible").attr("style", "background:#ffffff;");
    var color = obj.style.background;
    if(color=="red"){
        obj.style.background = "#ffffff";
    }else{
        obj.style.background = "#e0d7d7";
    }
}
