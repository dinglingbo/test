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
    }	
}

/*
*主组列表(需要先调用车辆信息接口，再执行)
*/
function queryGroupByVin(){	
	var obj = nui.get("vin");
    var vin = obj.getValue();
    
    if (vin && vin.length == 17){
        var params = {
            "url":"https://llq.007vin.com/ppyvin/group",
            "params":{
                "vin":vin
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
    alert(data);
    var obj = nui.get("brand");
    //obj.dataField = data;
}

/*
*车辆信息数据处理
*/
function setGridSub(data){
    var dataBody = data.mains;
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
        
        var gridContent = nui.get("gridContent");
        gridSub.setData(dataList);
        if(dataList && dataList.length > 0){
            $("#gridContent").show();
        }else{
            $("#gridContent").hide();
        }
        
        //加载主组数据
        queryGroupByVin();
    }
}

