
var index,max; //navigator
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
var dg10; //层10
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
    dg10 = nui.get("dg10"); //层10
    
    queryDg1();
    
    dgNavigation.on("rowclick", function (e) {//导航
        var row = dgNavigation.getSelected();
        if (row.index) {
            showRightGrid(eval('dg' + row.index));
        }
    });
    
    dg1.on("select", rowClickDg1);
    
    dg2.on("rowclick", rowClickDg2);
    
    dg3.on("rowclick", rowClickDg3);
    
    dg4.on("rowclick", rowClickDg4);
    
    dg5.on("rowclick", rowClickDg5);
    
    dg6.on("rowclick", rowClickDg6);
    
    dg7.on("rowclick", rowClickDg7);
    
    dg8.on("rowclick", rowClickDg8);

    dg9.on("rowclick", rowClickDg9);
});
function rowClickDg1(){
    var row = dg1.getSelected();
    if (row.brand) {
        brand = row.brand;
        setTopNav(2, row.brandCn);
        var params = {
            "url": llq_pre_url + "/cars/show",
            "params":{
                "brand": brand
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg2);
    }
}
function rowClickDg2(){
    var row = dg2.getSelected();
    if (row.auth && !row.last) {
        setTopNav(3, row.name);
        var params = {
            "url": llq_pre_url + "/cars/code",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg3);
    }else{
        queryGroupByAuth(row.auth);
    }
}
function rowClickDg3(){
    var row = dg3.getSelected();
    if (row.auth && !row.last) {
        setTopNav(4, row.name);
        var params = {
            "url": llq_pre_url + "/cars/model",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg4);
    }else{
        queryGroupByAuth(row.auth);
    }
}
function rowClickDg4(){
    var row = dg4.getSelected();
    if (row.auth && !row.last) {
        setTopNav(5, row.name);
        var params = {
            "url": llq_pre_url + "/cars/litm",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg5);
    }else{
        queryGroupByAuth(row.auth);
    }
}
function rowClickDg5(){
    var row = dg5.getSelected();
    if (row.auth && !row.last) {
        setTopNav(6, row.name);
        var params = {
            "url": llq_pre_url + "/cars/litn",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg6);
    }else{
        queryGroupByAuth(row.auth);
    }
}
function rowClickDg6(){
    var row = dg6.getSelected();
    if (row.auth && !row.last) {
        setTopNav(7, row.name);
        var params = {
            "url": llq_pre_url + "/cars/litf",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg7);
    }else{
        queryGroupByAuth(row.auth);
    }
}
function rowClickDg7(){
    var row = dg7.getSelected();
    if (row.auth && !row.last) {
        setTopNav(8, row.name);
        var params = {
            "url": llq_pre_url + "/cars/litfi",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg8);
    }else{
        queryGroupByAuth(row.auth);
    }
}
function rowClickDg8(){
    var row = dg8.getSelected();
    if (row.auth && !row.last) {
        setTopNav(9, row.name);
        var params = {
            "url": llq_pre_url + "/cars/litsx",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg9);
    }else{
        queryGroupByAuth(row.auth);
    }
}
function rowClickDg9(){
    var row = dg9.getSelected();
    if (row.auth && !row.last) {
        setTopNav(10, row.name);
        var params = {
            "url": llq_pre_url + "/cars/litsx",
            "params":{
                "brand": brand,
                "auth": unescape(row.auth)                                                                           
            },
            "token": token
        }
        callAjax(url, params, processAjax, setDg10);
    }else{
        queryGroupByAuth(row.auth);
    }
}
/*
*获取品牌
*/
function queryDg1(){	
    var params = {
        "url": llq_pre_url + "/ppycars/brand",
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
function setNav(title){
    for(var i=navData.length; i>=index; i--){
        navData.pop();            
    }
    navData.push({index:index, title: index + " " + title});
}

/*
*setTopNav
*/
function setTopNav(index, name){
    var topData = $("#topNav").children();
    for(var i=topData.length; i>=index; i--){
        $(topData[i-1]).remove();            
    }
    $("#topNav").append('<a style="cursor:pointer" onclick="showRightGrid(eval(\'dg' + index + '\'))"><span><B>&nbsp;&gt;&nbsp;' + name + '</B></span></a>');
}

/*
*setDg1
*/
function setDg1(data){
    dg1.setData(data);
    index = 1, max = 1;
    setNav("选择品牌");
    //navData.push({index:1, title:"1 选择品牌"});
    showRightGrid(dg1);
    
    if(initBrand != ""){
        var row = dg1.findRow(function(row){
            if(row.brand == initBrand) return true;
        });
        if(row){
            dg1.select(row, true);
        }
    }
}

/*
*setDg2
*/
function setDg2(data, rs){
    dg2.setData(data);
    index = 2, max = 2;
    setNav(rs.title);
    showRightGrid(dg2);
}

/*
*setDg3
*/
function setDg3(data, rs){
    dg3.setData(data);
    index = 3, max = 3;
    setNav(rs.title);
    showRightGrid(dg3);
}

/*
*setDg4
*/
function setDg4(data, rs){
    dg4.setData(data);
    index = 4, max = 4;
    setNav(rs.title);
    showRightGrid(dg4);
}

/*
*setDg5
*/
function setDg5(data, rs){
    dg5.setData(data);
    index = 5, max = 5;
    setNav(rs.title);
    showRightGrid(dg5);
}

/*
*setDg6
*/
function setDg6(data, rs){
    dg6.setData(data);
    index = 6, max = 6;
    setNav(rs.title);
    showRightGrid(dg6);
}

/*
*setDg7
*/
function setDg7(data, rs){
    dg7.setData(data);
    index = 7, max = 7;
    setNav(rs.title);
    showRightGrid(dg7);
}

/*
*setDg8
*/
function setDg8(data, rs){
    dg8.setData(data);
    index = 8, max = 8;
    setNav(rs.title);
    showRightGrid(dg8);
}

/*
*setDg9
*/
function setDg9(data, rs){
    dg9.setData(data);
    index = 9, max = 9;
    setNav(rs.title);
    showRightGrid(dg9);
}

/*
*setDg10
*/
function setDg10(data, rs){
    dg10.setData(data);
    index = 10, max = 10;
    setNav(rs.title);
    showRightGrid(dg10);
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
    
    var gid = gridObj.getId();
    index = parseInt(gid.replace("dg", ""));
    
    if(index==1){
        $($(".groupButton")[0]).attr("style", "background:#e0d7d7;");
    }else{
        $($(".groupButton")[0]).attr("style", "background:#ffffff;");
    }
    if(index==max){
        $($(".groupButton")[1]).attr("style", "background:#e0d7d7;");
    }else{
        $($(".groupButton")[1]).attr("style", "background:#ffffff;");
    }

    var data = gridObj.getData();
    if(data && data.length == 1) {
        var row = gridObj.getRow(0);
        gridObj.setSelected(row);
        if(index==1){
            rowClickDg1();
        }else if(index==2){
            rowClickDg2();
        }else if(index==3){
            rowClickDg3();
        }else if(index==4){
            rowClickDg4();
        }else if(index==5){
            rowClickDg5();
        }else if(index==6){
            rowClickDg6();
        }else if(index==7){
            rowClickDg7();
        }else if(index==8){
            rowClickDg8();
        }else if(index==9){
            rowClickDg9();
        }
    }
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
/*
 *上一步
 **/
function showUp(){
    if(index > 1){
        index -= 1;
        showRightGrid(eval('dg' + index))
    }
}

/*
 *下一步
 **/
function showDown(){
    if(index < max){
        index += 1;
        showRightGrid(eval('dg' + index))
    }
}