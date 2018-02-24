//用户车架号历史查询记录接口
function searchVins(){	
	var params = {
		"url":"https://llq.007vin.com/search/vins",
		"params":{},
		"token": token

	};
	
	loadData(url, params, setSearchBox);
}

function setSearchBox(data){
    //alert(data);
    //var obj = mini.get("brand");
    //obj.dataField = data;
}