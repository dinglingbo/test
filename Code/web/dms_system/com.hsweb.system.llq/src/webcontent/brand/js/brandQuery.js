
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
    
    dg1.on("rowclick", function (e) {//查第2层
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        var row = dg1.getSelected();
        if (row.brand) {
            brand = row.brand;
            var params = {
                "url":"https://llq.007vin.com/cars/show",
                "params":{
                    "brand": brand
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg2);
        }
    });
    
    dg2.on("rowclick", function (e) {//查第3层
        var row = dg2.getSelected();
        if (row.auth && !row.last) {
            var params = {
                "url":"https://llq.007vin.com/cars/code",
                "params":{
                    "brand": brand,
                    "auth": row.auth                                                                           
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg3);
        }else{
            alert("last");
        }
    });
    
    dg3.on("rowclick", function (e) {//查第4层
        var row = dg3.getSelected();
        if (row.auth && !row.last) {
            var params = {
                "url":"https://llq.007vin.com/cars/model",
                "params":{
                    "brand": brand,
                    "auth": row.auth                                                                           
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg4);
        }else{
            alert("last");
        }
    });
    
    dg4.on("rowclick", function (e) {//查第5层
        var row = dg4.getSelected();
        if (row.auth && !row.last) {
            var params = {
                "url":"https://llq.007vin.com/cars/litm",
                "params":{
                    "brand": brand,
                    "auth": row.auth                                                                           
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg5);
        }else{
            alert("last");
        }
    });
    
    dg5.on("rowclick", function (e) {//查第6层
        var row = dg5.getSelected();
        if (row.auth && !row.last) {
            var params = {
                "url":"https://llq.007vin.com/cars/litn",
                "params":{
                    "brand": brand,
                    "auth": row.auth                                                                           
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg6);
        }else{
            alert("last");
        }
    });
    
    dg6.on("rowclick", function (e) {//查第7层
        var row = dg6.getSelected();
        if (row.auth && !row.last) {
            var params = {
                "url":"https://llq.007vin.com/cars/litf",
                "params":{
                    "brand": brand,
                    "auth": row.auth                                                                           
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg7);
        }else{
            alert("last");
        }
    });
    
    dg7.on("rowclick", function (e) {//查第8层
        var row = dg7.getSelected();
        if (row.auth && !row.last) {
            var params = {
                "url":"https://qpds.007vin.com/cars/litfi",
                "params":{
                    "brand": brand,
                    "auth": row.auth                                                                           
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg8);
        }else{
            alert("last");
        }
    });
    
    dg8.on("rowclick", function (e) {//查第9层
        var row = dg8.getSelected();
        if (row.auth && !row.last) {
            var params = {
                "url":"https://qpds.007vin.com/cars/litsx",
                "params":{
                    "brand": brand,
                    "auth": row.auth                                                                           
                },
                "token": token
            }
            callAjax(url, params, processAjax, setDg9);
        }
    });
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
    for(var i=navData.length; i>=index; i--){
        navData.pop();            
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
*setDg3
*/
function setDg3(data, rs){
    dg3.setData(data);
    setNav(3, rs.title);
    showRightGrid(dg3);
}

/*
*setDg4
*/
function setDg4(data, rs){
    dg4.setData(data);
    setNav(4, rs.title);
    showRightGrid(dg4);
}

/*
*setDg5
*/
function setDg5(data, rs){
    dg5.setData(data);
    setNav(5, rs.title);
    showRightGrid(dg5);
}

/*
*setDg6
*/
function setDg6(data, rs){
    dg6.setData(data);
    setNav(6, rs.title);
    showRightGrid(dg6);
}

/*
*setDg7
*/
function setDg7(data, rs){
    dg7.setData(data);
    setNav(7, rs.title);
    showRightGrid(dg7);
}

/*
*setDg8
*/
function setDg8(data, rs){
    dg8.setData(data);
    setNav(8, rs.title);
    showRightGrid(dg8);
}

/*
*setDg9
*/
function setDg9(data, rs){
    dg9.setData(data);
    setNav(9, rs.title);
    showRightGrid(dg9);
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