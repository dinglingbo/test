
var vin; //vin
var brand; //品牌
var gridMain;
var gridSub;
var panel;

$(document).ready(function(v){
	gridMain = nui.get("gridMain");
    gridSub = nui.get("gridSub");
    panel = nui.get("panel");
    
    panel.hidePane(0);
    panel.hidePane(1); 
    
    gridMain.on("rowclick", function (e) {//分组信息
        var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value;
        row = gridMain.getSelected();
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
});

/*
*
*/
function setSubGroupData(data){
    //alert(data);
    /*
    主组 num
    分组 subgroup
    图号  mid
    名称  subgroupname
    备注description
    型号  model
    */
    gridSub.set({
        columns: [
            { type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},
            { field: "num", width:30, headerAlign: "center", allowSort: false, header: "主组"},
            { field: "subgroup", width:30, headerAlign: "center", allowSort: false, header: "分组"},
            { field: "mid", width:60, headerAlign: "center", allowSort: false, header: "图号"},
            { field: "subgroupname", width:150, headerAlign: "center", allowSort: false, header: "名称"},
            { field: "description", width:150, headerAlign: "center", allowSort: false, header: "备注"},
            { field: "model", width:100, headerAlign: "center", allowSort: false, header: "型号"}
        ]
    });
    gridSub.setData(data);
}


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
        callAjax(url, params, processAjax, setGridSub);
    }	
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
*主组列表(需要先调用车辆信息接口，再执行)
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
        callAjax(url, params, processAjax, setGridMain);
    }	
}

/*
*主组数据处理
*/
function setGridMain(data){    
    gridMain.setData(data);
}

/*
*车辆信息数据处理
*/
function setGridSub(data){
    var dataBody = data.mains;
    brand = data.brand;
    gridSub.setData([]);
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
            panel.showPane(0);
            panel.showPane(1);
            gridSub.set({
                columns: [
                    { type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},
                    { field: "field1", width:80, headerAlign: "center", allowSort: false, header: "分类"},
                    { field: "field2", width:150, headerAlign: "center", allowSort: false, header: "详情"}
                ]
            });
            gridSub.setData(dataList);
            
            //加载主组数据
            queryGroupByVin();
        }else{
            panel.hidePane(0);
            panel.hidePane(1);
        }        
    }
}

