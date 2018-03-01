
var vin; //vin
var brand; //品牌
var vinPartImg;//零件图片
var gridCfg; //车辆配置
var gridMainGroup; //主组
var gridSubGroup;//分组
var gridParts;//零件
var panel;

$(document).ready(function(v){
    vinPartImg = $("#vin_part_img");
    gridCfg = nui.get("gridCfg");
	gridMainGroup = nui.get("gridMainGroup");
    gridSubGroup = nui.get("gridSubGroup");
    gridParts = nui.get("gridParts");
    panel = nui.get("panel");
    
    //panel.hidePane(0);
    panel.hidePane(2); 
    
    gridMainGroup.on("rowclick", function (e) {//查分组信息
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        var row = gridMainGroup.getSelected();
        if (row.auth) {
            var params = {
                "url":"https://llq.007vin.com/ppyvin/subgroup",
                "params":{
                    "vin":vin,
                    "brand":brand,
                    "is_filter":1,
                    "auth":unescape(row.auth)
                },
                "token": token
            }
            callAjax(url, params, processAjax, setSubGroupData);
        }
    });
    
    gridSubGroup.on("rowclick", function (e) {//查零件信息
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
            
            params = {
                "url":"https://llq.007vin.com/ppycars/subimgs",
                "params":{
                    "brand":brand,
                    "auth":unescape(row.auth)
                },
                "token": token
            }
            callAjax(url, params, processAjax, setPartImg);
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
    });
});

/*
*用户车架号历史查询记录（使用逻辑流，因为无法控制autocomplete发送请求的方式）
*/

/*
*通过vin获取车辆信息
*/
function queryVin(){	
	var obj = nui.get("vin");
    vin = obj.getValue();
    
    if (checkVin()){
        var params = {
            "url":"https://llq.007vin.com/ppyvin/searchvins",
            "params":{
                "vin":vin
            },
            "token": token
        }
        
        $(".groupButton").hide();
        callAjax(url, params, processAjax, setGridCfg);
    }	
}

/*
*车辆信息数据处理
*/
function setGridCfg(data){
    var dataBody = data.mains;
    brand = data.brand;
    gridCfg.setData([]);
    showRightGrid(gridCfg);
    if(dataBody){
        data = dataBody.split("\n");
        var dataList=[];
        var tmpList;
        var tmp={};
        for(var i=0; i<data.length-1; i++){//最后一个无效
            tmpList = data[i].split(":");
            tmp.field1 = tmpList[0] || "";
            tmp.field2 = tmpList[1] || "";
            dataList[i] = nui.clone(tmp);
        }
        
        if(dataList && dataList.length > 0){
            panel.showPane(2);
            /* gridCfg.set({
                columns: [
                    { type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},
                    { field: "field1", width:80, headerAlign: "center", allowSort: false, header: "分类"},
                    { field: "field2", width:150, headerAlign: "center", allowSort: false, header: "详情"}
                ]
            }); */
            gridCfg.setData(dataList);
            
            //加载主组数据
            queryGroupByVin();
        }else{
            panel.hidePane(2);
        }        
    }
}

/*
*获取主组列表(需要先调用车辆信息接口，再执行)
*/
function queryGroupByVin(){	
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
function setGridPartsData(data, rs){
    gridParts.setData(data);
    //img
    showRightGrid(gridParts);
    showLeftGrid(vinPartImg);
}

/*
*零件图片处理
*/
function setPartImg(data, rs){
    vinPartImg.attr("src", data.imgurl);
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
            height : "400px",
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
    vinPartImg.hide();
    
    gridObj.show();  
}

/*
*右部grid
*/
function showRightGrid(gridObj){
    gridCfg.hide();
    gridSubGroup.hide();
    gridParts.hide();
    
    gridObj.show();
    var num = (gridObj==gridCfg)? 0 : ((gridObj==gridSubGroup)? 1 : 2);
    $($(".groupButton")[num]).show();
    //$($(".groupButton")[num]).click();
    setBgColor($(".groupButton")[num]);
    
    if(gridObj != gridParts){//非零件
        showLeftGrid(gridMainGroup);
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
