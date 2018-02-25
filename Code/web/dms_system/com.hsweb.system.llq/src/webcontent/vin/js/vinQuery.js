/*
*用户车架号历史查询记录（使用逻辑流，因为无法控制autocomplete发送请求的方式）
*/

/*
*通过vin获取车辆信息
*/
function queryVin(){	
	var obj = nui.get("vin");
    var vin = obj.getValue();
    
    if (vin && vin.length == 17){
        var params = {
            "url":"https://llq.007vin.com/ppyvin/searchvins",
            "params":{
                "vin":vin
            },
            "token": token
        }
        callAjax(url, params, processAjax, setGridSub);        
    }else{
        errorVin();
    }	
}

function errorVin(){
    nui.alert("请输入17位VIN编码！");
}

/*
*主组列表(需要先调用车辆信息接口，再执行)
*/
function queryGroupByVin(brand){	
	var obj = nui.get("vin");
    var vin = obj.getValue();
    
    if (vin && vin.length == 17){
        var params = {
            "url":"https://llq.007vin.com/ppyvin/group",
            "params":{
                "vin":vin,
                "brand":brand
            },
            "token": token
        }
        callAjax(url, params, processAjax, setGridMain);
    }else{
        errorVin();
    }	
}

/*
*主组数据处理
*/
function setGridMain(data){
    var gridMain = nui.get("gridMain");
    gridMain.setData(data);
}

/*
*车辆信息数据处理
*/
function setGridSub(data){
    var dataBody = data.mains;
    var brand = data.brand;
    var gridSub = nui.get("gridSub");
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
            gridSub.setData(dataList);
            
            //加载主组数据
            queryGroupByVin(brand);
        }else{
            panel.hidePane(0);
            panel.hidePane(1);
        }        
    }
}

