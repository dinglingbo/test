
var vin; //vin
var vin_len; //vin长度要求
var vin_input;//vin输入
var curr_check;//当前选择品牌
var brand; //品牌
var mcid;//查询分组需要
var vinPartImg;//零件图片
var gridCfg; //车辆配置
var gridMainGroup; //主组
var subGroups;//分组
var gridSubGroup;//分组grid
var gridParts;//零件
var panel;
var partPanel //购物车、库存分布

var selectWin;
var configWin;
var gridConfig;
var vinWin;
var winCarCfg = null;
var gridCfgT = null;

var stockGrid =null;
var stockGridUrl= apiPath + cloudPartApi +"/" +"com.hsapi.cloud.part.invoicing.query.queryChainStockByPartId.biz.ext";
var storehouseHash = {};
var final_data_brand = [
    {text: "全部品牌", value: 17, brand: "all"}, 
    {text: "宝马", value: 7, brand: "bmw"}, 
    {text: "MINI", value: 7, brand: "minis"}, 
    {text: "奔驰", value: 8, brand: "benz"}, 
    {text: "smart", value: 8, brand: "smart"}, 
    {text: "捷豹", value: 7, brand: "jaguar"}, 
    {text: "路虎", value: 8, brand: "land_rover"}, 
    {text: "玛莎拉蒂", value: 7, brand: "maserati"}
];
var availableTags =[];

$(document).ready(function(v){
    selectWin = nui.get("brandWin");
    configWin = nui.get("configWin");
    gridConfig = nui.get("gridConfig");
    vinWin = nui.get("vinWin");
        
    vin_input = $(" input[ name='vin' ] "); //改用 jQuery
    vinPartImg = $("#vin_part_img");
    gridCfg = nui.get("gridCfg");
	gridMainGroup = nui.get("gridMainGroup");
    subGroups = $("#subGroups");
    gridSubGroup = nui.get("gridSubGroup");
    gridParts = nui.get("gridParts");
    panel = nui.get("panel");

    partPanel = nui.get("partPanel");
    
    winCarCfg = nui.get("winCarCfg");
    gridCfgT = nui.get("gridCfgT");
    
    //panel.hidePane(0);
    panel.hidePane(2); 
    
    cartPartGrid = nui.get("cartPartGrid");
    stockGrid = nui.get("stockGrid");
    stockGrid.setUrl(stockGridUrl);
    //获取vin输入缓存数组
    availableTags=getAvailableTags();
    /*vin_input.autocomplete({
        source: availableTags,
        max: 10,
        cacheLength: 10
      });*/
    getStorehouse(function(data)
    {
        var storehouse = data.storehouse||[];
        storehouse.forEach(function(v)
        {
            if(v && v.id)
            {
                storehouseHash[v.id] = v;
            }
        });
    });

    stockGrid.on("drawcell", function (e) { //表格绘制
    	switch (e.field)
        {
            case "storeId":
                if(storehouseHash && storehouseHash[e.value])
                {
                    e.cellHtml = storehouseHash[e.value].name;
                }
                break;
            default:
                break;
        }
    });
    
    gridMainGroup.on("rowclick", function (e) {//查分组信息
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        var row = gridMainGroup.getSelected();
        clickGdMainGroup(row);
    });
    
    gridSubGroup.on("rowclick", function (e) {//查零件信息
        var row = gridSubGroup.getSelected();
        clickGdSubGroup(row);
    });
    
    gridParts.on("drawcell", function (e) { //表格绘制
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var value = e.value;
        if(field == "detail"){
            var html = '<a class="" href="javascript:openDetail()">详情 </a>';
            e.cellHtml = html;
        }else if(field == "opt"){
            var html = '<a class="" href="javascript:addPart()"><i class="fa fa-shopping-cart"></i></a>';
            e.cellHtml = html;
        }
    });
    gridParts.on("cellclick",function(e){ 
        var field=e.field;
        var row =e.row;
        if(field=="check" ){
            if(e.row.check==1){
                addPart(1);
                searchStok(row);
                
            }else{
                addPart(-1);
            }
        }
    });
    
    cartPartGrid.on("cellclick",function(e){ 
        var field=e.field;
        var row =e.row;
        searchStok(row);

    });

    gridParts.on("selectionchanged", function (e) { //表格绘制
        var row = e.selected;
        if(row){ 
            renderMapRect(row.num);

            clearSelectedCls();
            gridParts.addRowCls(row, "select-row");
        }
    });
    
    gridConfig.on("select", function (e) {//4005选择配置
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        var row = e.record;
        if (row.auth) {
            var params = {
                "url": llq_pre_url + "/ppyvin/searchvins",  //searchvins_v2
                "params":{
                    "vin":vin,
                    "brand": row.brand,
                    "is_filter":1,
                    "auth":row.auth//unescape
                },
                "token": token
            }
        
            $(".groupButton").hide();
            callAjax(url, params, processAjax, setGridCfg);
        }
        closeSelectBrand(configWin);
    });
    
    $("#vin").bind("keydown", function (e) {
        if (e.keyCode == 13) {
            queryVin();
        }
    });

    $("#vin_part_img").click(function(e){
        //getMousePos(e);
    });

});

function getMousePos(event) {
   var e = event || window.event;
   var scrollX = document.documentElement.scrollLeft || document.body.scrollLeft;
   var scrollY = document.documentElement.scrollTop || document.body.scrollTop;
   var x = e.pageX || e.clientX + scrollX;
   var y = e.pageY || e.clientY + scrollY;
   //alert('x: ' + x + '\ny: ' + y);
   return { 'x': x, 'y': y };
}

/*
*用户车架号历史查询记录（使用逻辑流，因为无法控制autocomplete发送请求的方式）
*/

/*
*通过vin获取车辆信息
*/
/*function queryVin(){	
    vin = vin_input.val().replace(/\s+/g, "");
      
    brand = curr_check;
    if (checkVin()){
        var params = {
            "url": llq_pre_url + "/ppyvin/searchvins", //searchvins_v2
            "params":{
                "vin": vin,
                "brand": brand
            },
            "token": token
        }
        
        $(".groupButton").hide();
        callAjax(url, params, processAjax, setGridCfg);
    }	
}*/
/*
*维保通过vin获取车辆信息
*/
function queryVin(){	
    vin = vin_input.val().replace(/\s+/g, "");
      
    brand = curr_check;
    if (checkVin()){
        var params = {
    			url:"llq/vins/cars/vin",
    			params:"&vin="+vin+"",
    			token:token
        }
        
        $(".groupButton").hide();
        callAjax(url, params, processAjax, setGridCfg);
    }	
}

/*
*车辆信息数据处理
*/
function setGridCfg(data, json){
	//添加历史记录
	vin=data.vin;
	//缓存
	var key=new Date().getTime();
	localStorage.setItem(key, vin);
	
//	//去重添加
//    if(availableTags.length>0){
//    	
//    	for(var i = 0; i < availableTags.length; i++){
//    		if(vin.indexOf(availableTags[i]) == -1){
//    			availableTags.push(vin);
//    		}
//    	}
//    }else{
//	    availableTags.push(vin);
//    }
//    
	var str = "车型 :" + data.modelName;
	var informationList = [];
	informationList.push(str);
	for(var i in data.mainData){
		informationList.push(i+":"+data.mainData[i])
	}
	for(var i in data.subData){
		informationList.push(i+":"+data.subData[i])
	}
	mcid = data.mcid;
    brand = data.brandCode;
    gridCfg.setData([]);
    showRightGrid(gridCfg);
    if(informationList){
        var dataList=[];
        var tmpList;
        var tmp={};
        for(var i=0; i<informationList.length-1; i++){//最后一个无效
            tmpList = informationList[i].split(":");
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

    winCarCfg.hide();
}

/*
*获取主组列表(需要先调用车辆信息接口，再执行)
*/
function queryGroupByVin(){	
    if (checkVin()){
        var params = {
    			url:"llq/vins/cars/group",
    			params:"&mcid="+mcid+"&brandCode="+brand+"&vin="+vin,
    			token:token
        }
        callAjax(url, params, processAjax, setgridMainGroup);
    }	
}

/*
*主组数据处理
*/
function setgridMainGroup(data){ 
	//主组数据
	groupData=data;
    showLeftGrid(gridMainGroup);
    gridMainGroup.set({
        columns: [
            /*{ type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},*/
            { field: "auth", visible: false},
            { field: "label", width:80, headerAlign: "center", allowSort: false, header: "主组名称", summaryType: "count"}
        ]
    });
    gridMainGroup.setData(data);
}

/*
*分组信息
*/
function setSubGroupData(data,json){
	
	//分组数据
	subGroupData =data;
    gridSubGroup.setData(data);
    
    //img
    var len = data.length;
    var imgSubGroup = $("#imgSubGroup");
    imgSubGroup.children().remove();
    var img = "";
    var imgList = json.imgs;
    for(var i = 0;i<data.length;i++){
    	for(var j in imgList){
    		if(data[i].imageLarge == j){
    			data[i].url = imgList[j];
    		}
    	}
    }
    for(var i=0;i<len;i++){
        img = '<a class="sub-group" data=' + i + '>'
            + '<div class="LazyLoad is-visible" style="height:140px; width:140px;">'
            + '    <img src="' + data[i].url + '" alt="sub-group-img" class="sub-group-img"/>'
            + '</div>'
            + '<div class="label">' + data[i].subGroup + '</div>'
            + '<div class="float-panel">' + data[i].name + '</div>'
        + '</a>';
        imgSubGroup.append(img);
        
    }
    $(".sub-group").bind("click", function(obj){//.sub-group-img
        var rowid = $(this).attr("data");
        var row = gridSubGroup.getRow(parseInt(rowid));
        gridSubGroup.select(row, true);
        clickGdSubGroup(row);
    });
    showRightGrid(subGroups);
}
function setSubGroupDataJaguar(data,json){
	
	//分组数据
	subGroupData =data;
    gridSubGroup.setData(data);
    
    //img
    var len = data.length;
    var imgSubGroup = $("#imgSubGroup");
    imgSubGroup.children().remove();
    for(var i=0;i<len;i++){
        img = '<a class="sub-group" data=' + i + '>'
            + '<div class="LazyLoad is-visible" style="height:140px; width:140px;">'
            + '    <img src="' + data[i].imageLarge + '" alt="sub-group-img" class="sub-group-img"/>'
            + '</div>'
            + '<div class="label">' + data[i].subgroup + '</div>'
            + '<div class="float-panel">' + data[i].name + '</div>'
        + '</a>';
        imgSubGroup.append(img);
        
    }
    $(".sub-group").bind("click", function(obj){//.sub-group-img
        var rowid = $(this).attr("data");
        var row = gridSubGroup.getRow(parseInt(rowid));
        gridSubGroup.select(row, true);
        clickGdSubGroup(row);
    });
    showRightGrid(subGroups);
}
/*
*主组事件
*/
function clickGdMainGroup(row){
    if (row.label) {   	
    	//主组标识
    	groupnum =row.num;
/*    	var lhMic = "";
        var params1 = {
    			url:"llq/vins/cars/subgroup",
    			params:"&mcid="+mcid+"&brandCode="+brand+"&num="+groupnum+"&level="+1,
    			token:token
        }
    	//路虎、捷豹需要调两次
    	if(brand=="land_rover"||brand=="jaguar"){
    		nui.ajax({
    			async: false,
    			url: "/systemApi/com.hsapi.system.llq.call.maintenanceCallV.biz.ext",
    			type: "post",
    	        data: params1,
    			contentType: 'text/json',
    			success: function (json) {
    				lhMic = 
    			},
    			error: function () {
    				nui.alert("获取数据遇到错误！");
    			}
    		});
    	}else{  		
    		var params = {
    				url:"llq/vins/cars/subgroup",
    				params:"&mcid="+mcid+"&brandCode="+brand+"&num="+groupnum,
    				token:token
    		}
    		callAjax(url, params, processAjax, setSubGroupData);
    	}*/
    	//路虎、捷豹需要调两次
    	if(brand=="land_rover"||brand=="jaguar"){
    		var params = {
    				url:"llq/vins/cars/subgroup/sub",
    				params:"&mcid="+row.mcid+"&brandCode="+brand+"&num="+groupnum+"&level="+1,
    				token:token
    		}
    		callAjax(url, params, processAjax, setSubGroupData);
    	}else{  		
    		var params = {
    				url:"llq/vins/cars/subgroup",
    				params:"&mcid="+row.mcid+"&brandCode="+brand+"&num="+groupnum,
    				token:token
    		}
    		callAjax(url, params, processAjax, setSubGroupData);
    	}	
    	
    }
}

/*
*分组事件
*/
function clickGdSubGroup(row){
    if(row.has_subs){
        clickGdMainGroup(row);
        has_subs=1;
        return;
    }
    
    if (row.mid) {
    	//分组零件号
    	subMid=row.mid;
    var params = {
			url:"llq/vins/cars/parts",
			params:"&mcid="+row.mcid+"&brandCode="+brand+"&num="+row.num+"&mid="+subMid+"&subgroup="+row.subGroup,
			token:token
    }
        callAjax(url, params, processAjax, setGridPartsData);
        
/*        params = {
            "url": llq_pre_url + "/ppycars/subimgs",
            "params":{
                "code":brand,
                "auth":row.auth
            },
            "token": token
        }
        callAjax(url, params, processAjax, setPartImg);*/
    row.imgurl = row.url;
    setPartImg(row);
    }
}

/*
*零件数据处理
*/
function setGridPartsData(data, rs){
    var tData = [];
    for(var i=0; i<data.partDetail.length; i++){
    	//data.partDetail[i].detail = "详情";
        tData = tData.concat(data.partDetail[i]);
    }
    gridParts.setData(tData);
    showRightGrid(gridParts);
    showLeftGrid(vinPartImg);
}

/*
*零件详情
*/
function openDetail(pid){	
	var row = gridParts.getSelected();
    try{
        nui.open({
            url : contextPath + "/com.hsweb.system.epc.partDetail.flow?token="+token,
            title : "零件详情",
            width : "900px",
            height : "600px",
            showHeader:true,
            onload : function() {
                var iframe = this.getIFrameEl();
                row.brandCode = brand;
                iframe.contentWindow.setData(row);
            },
            ondestroy : function(action) {
                //gridParts.reload();
            }
        });
    }finally{}
}
/*
*添加购物车
*/
function addPart(flag){   
    try{
        if(parent.showPanel){
//            parent.showPanel('PART');
        }
        if(parent.addToCartGrid){
            var r = gridParts.getSelected();
            r.flag = flag;
            addToCartGrid('VIN', r);
            parent.addToCartGrid('VIN', r);
        }
    }finally{}
}

function checkVin(){
    if (vin && (vin.length == 17 || vin.length == vin_len)){
        return true;
    }else{
//    	parent.showMsg("请输入" + vin_len + "位或17位VIN编码！","W");
    	parent.showMsg("请输入17位VIN编码！","W");
        return false;
    }
}

/*
*左部grid
*/
function showLeftGrid(gridObj){
    gridMainGroup.hide();
    vinPartImg.hide();
    //$('.part-img-container').hide();
    /*$('.j_part-img').hide();*/
    $('.j_part-img-map').html('');
    $('.j_part-map-rect').html('');
    
    gridObj.show();  
}

/*
*右部grid
*/
function showRightGrid(gridObj){
    if(gridObj==gridCfgT){
        gridCfgT.setData([]);
        if(winCarCfg.visible == true){
            winCarCfg.hide();
        }else{
            winCarCfg.showAtPos("left", "bottom");  
            var data = gridCfg.getData();
            var tdata = nui.clone(data);
            gridCfgT.setData(tdata);  
        }
    }else{     
        gridCfg.hide();
        //gridSubGroup.hide();
        subGroups.hide();
        gridParts.hide();
        
        gridObj.show();
        var num = (gridObj==gridCfg)? 0 : ((gridObj==subGroups)? 1 : 2);
        for(var i=0; i<$(".groupButton").length;i++){
            if(i > num && i != 3){
                $($(".groupButton")[i]).hide();
            }
        }

        $($(".groupButton")[num]).show();
        if(num ==2){

       	 //上一分组
       	 $($(".groupButton")[6]).show();
       	 //下一分组
       	 $($(".groupButton")[7]).show();
       	 if(has_subs!=1){
           	 //上一主组
       		 $($(".groupButton")[4]).show();
//       	 //下一主组
       		 $($(".groupButton")[5]).show(); 
       	 }
       }
        //$($(".groupButton")[num]).click();
        setBgColor($(".groupButton")[num]);
      //分割栏显示
        partPanel.show();
        if(gridObj != gridParts){//非零件
            showLeftGrid(gridMainGroup);
          //分隔栏不显示
            partPanel.hide();
            //上一主组
          	 $($(".groupButton")[4]).hide();
          	 //下一主组
          	 $($(".groupButton")[5]).hide();
          	 //上一分组
          	 $($(".groupButton")[6]).hide();
          	 //下一分组
          	 $($(".groupButton")[7]).hide();
        }

        if(gridObj==gridCfg){
            $($(".groupButton")[3]).show();
        }
    }

}

/*
*子组图/表
*/
function showSubGroups(gridObj){
    $('#imgSubGroup').hide();
    $('#gridSubGroup').hide();
    
    gridObj.show();  
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

/**
*vin包含多品牌(4007)
*/
function selectBrand(data, json){
    var selectForm = new nui.Form("#brandForm");
    
    selectWin.show();
    selectForm.clear();
    var brandTmpl = '<div class="brandsItem" onclick="closeSelectBrand(selectWin);window.parent.queryBrand(\'[brand]\')">'
              + '   <img id="brand_img_[index]" src="">'
              + '   <span>[name]</span>'
              + '</div>'
    $(".brandsContainer").html("");
    var height = (55 + Math.floor(data.length /3) * 95);
    selectWin.setStyle("width:416px;height:" + height + "px");
    for(var i=0; i<data.length; i++){//brand
        $(".brandsContainer").append(brandTmpl.replace("[index]", i).replace("[name]", data[i].brandname).replace("[brand]", data[i].brand));
        document.getElementById("brand_img_" + i).src = llq_pre_url.replace("llqapitm", "cdns") + data[i].img;
    }
}

function closeSelectBrand(obj){
    obj.hide();
}

/**
*vin包含多配置(4005)
*/
function selectConfig(data, json){
    var selectForm = new nui.Form("#configForm");
   
    configWin.show();
    selectForm.clear();
    
    var columns = [
        /*{ type: "indexcolumn", width:40, headerAlign: "center", header: "序号", summaryType: "count"},*/
        { field: "auth", visible: false},
        { field: "brand", visible: false, summaryType: "count"}
    ];
    var titles = json.title;
    for(var i=0; i<titles.length; i++){
        columns.push({ field: "field" + i, width:80, headerAlign: "center", allowSort: false, header: titles[i]});
    }
    
    gridConfig.set({
        columns: columns
    });
    
    var datas = [];
    var rs = json.data;
    var height = rs.length * 80;
    height = height>300 ? 300 : height;
    configWin.setStyle("width:416px;height:" + (40 + height) + "px");
    for(var i=0; i<rs.length; i++){
        var data = rs[i].data;
        var obj = {};
        obj.auth = rs[i].auth;
        obj.brand = json.brand;
        for(var j=0; j<data.length; j++){
            obj["field" + j] = data[j];
        }
        datas.push(obj);
    }
    gridConfig.setData(datas);
    gridConfig.setHeight(height);
}

function setVinLenght(obj){
    var data = final_data_brand.filter(function(v){
        return v.text == obj;
    });
    if(data.length>0){
        vin_len = data[0].value;
        curr_check = data[0].brand;
    }else{
        vin_len = 17;
        curr_check = "all";
    }

    var query_vin = nui.get("vin");
    vin_input.val(null);
    query_vin.setEmptyText(("请输入" + obj + "后" + vin_len + "位VIN码").replace("全部品牌后", ""));
}

/**
*vin包含多品牌(4003)
*/
function selectBrand4003(data, json){
    var vinForm = new nui.Form("#vinForm");
    
    vinWin.show();
    vinForm.clear();
    var brandTmpl = '<div class="search-result-list-item" style="float:left;cursor:pointer;"'
                  + ' onclick="vin_input.val(\'[vin]\'); queryVin(); closeSelectBrand(vinWin);">'
                  + '    <div class="search-result-list-item-title">'
                  + '        VIN：[vin1]<span class="search-result-list-item-title-color">[vin2]</span>'
                  + '    </div>'
                  + '    <div class="search-result-list-item-content">'
                  + '        <img class="search-result-list-item-content-img" src="[img]">'
                  + '        <div class="search-result-list-item-content-detail">'
                  + '            <span></span>'
                  + '            <span></span>'
                  + '        </div>'
                  + '    </div>'
                  + '</div>'
    $(".brandsContainer2").html("");
    for(var i=0; i<data.length; i++){//brand
        $(".brandsContainer2").append(brandTmpl.replace("[vin]", data[i].vin).replace("[img]", data[i].img).replace("[vin1]", (data[i].vin).substr(0, data[i].index)).replace("[vin2]", (data[i].vin).substr(data[i].index, data[i].len)));
    }
}

function addToCartGrid(type, row){
    var data = cartPartGrid.getData();
    var quantity = row.quantity||0;
    quantity = quantity.replace(/\s+/g, "");
    var reg = /^[0-9]*$/;//纯数字
    if(!reg.test(quantity)){
        quantity = 1;
    }
    if(row && row.flag){//1添加；-1删除
        if(row.flag == 1){
            if(data && data.length>0){
                var rows = cartPartGrid.findRows(function(r){
                    if(row.pid == r.pid) return true;
                });
                if(rows && rows.length>0){
                    parent.showMsg("此零件号已经添加到购物车!","W");
                    return;
                }else{
                    var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
                    cartPartGrid.addRow(newRow);       
                }
            }else{
                var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
                cartPartGrid.addRow(newRow);       
            }
        }else{
            var rows = cartPartGrid.findRows(function(r){
                if(row.pid == r.pid) return true;
            });
            if(rows && rows.length>0){
            	cartPartGrid.removeRows(rows,true);
            }
        }
    }else{
        if(data && data.length>0){
            var rows = cartPartGrid.findRows(function(r){
                if(row.pid == r.pid) return true;
            });
            if(rows && rows.length>0){
            	parent.showMsg("此零件号已经添加到购物车!","W");
                return;
            }else{
                var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
                cartPartGrid.addRow(newRow);       
            }
        }else{
            var newRow = {pid: row.pid, label: row.label, orderQty: quantity, orderPrice: 0};
            cartPartGrid.addRow(newRow);       
        }
    }


}

function deleteCartShop(){
    var rows = cartPartGrid.getSelecteds();
    cartPartGrid.removeRows(rows);
}
function openGeneratePop(partList, type, title){
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.cloud.part.common.shopCarPop.flow?token="+token,
        title : title,
        width : 600,
        height : 400,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                storeId: "",
                partList: partList,
                type: type
            };
            iframe.contentWindow.setInitData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                //var data = iframe.contentWindow.getData();
            }
        }
    });
}
function addToPchsCart(){
    var rows = cartPartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "pchsCartEpc", "添加采购车");

    }else{
    	parent.showMsg("请选择配件信息!","w");
        return;
    }
}
function addToSellCart(){
    var rows = cartPartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellCartEpc", "添加销售车");

    }else{
    	parent.showMsg("请选择配件信息!","w");
        return;
    }
}
function generatePchsOrder(){
    var rows = cartPartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "pchsOrderEpc", "生成采购订单");

    }else{
    	parent.showMsg("请选择配件信息!","w");
        return;
    }
}
function generateSellOrder(){
    var rows = cartPartGrid.getSelecteds();
    if(rows && rows.length > 0){

        openGeneratePop(rows, "sellOrderEpc", "生成销售订单");

    }else{
    	parent.showMsg("请选择配件信息!","w");
        return;
    }
}

function copyEmbed() {
    var clipboard = new ClipboardJS('#copyBtn',{
        text: function (trigger) {
//            var value = document.getElementById('bar').value;\
        	var data=cartPartGrid.getData();
        	var value='';
        	for(var i=0;i<data.length;i++){
        		value+=data[i].pid+'\r\n';
        	}
            return value;
        }
    });
    clipboard.on('success',function (e) {
    	parent.showMsg("复制成功","S");
        e.clearSelection();
        clipboard.destroy();
    });
    clipboard.on('error',function (e) {
    	parent.showMsg("复制失败,请重新复制","W");
        clipboard.destroy();
    });
}
function searchStok()
{
	var params={};
	var row=gridParts.getSelected();
	params.partCode=row.pid;
//    if(!params.partId && params.partCode){
//    	stockGrid.setData([]);
//        return;
//    }
    //params.sortField = "b.stock_qty";
    //params.sortOrder = "desc";
    params.notShowAll = 1;
    params.sortField = "a.outable_qty";
    params.sortOrder = "desc";
    stockGrid.load({
        params:params,
        token:token
    });
}

//获取vin输入缓存并组合成数组
function getAvailableTags(){
	//从后遍历，获取最近VIN
	for(var i=localStorage.length-1;i>0;i--){
		var key=localStorage.key(i);
		var value=localStorage.getItem(key);
		//控制最多10条
		if(availableTags.length>0 && availableTags.length < 10){
			for(var j =0;j<availableTags.length;j++){
				//判断是否重复
				if(availableTags.indexOf(value) == -1){
					availableTags.push(value);
				}				
			}			
		}
		//10条时中止遍历
		if(availableTags.length == 10){
			return availableTags;
		}		
		else if(availableTags.length==0){
			availableTags.push(value);
		}
	}
	return availableTags;
}

//用于判断
var has_subs=null;
//主组data
var groupData=null;
//分组data
var subGroupData=null;
//主组序号
var groupIndex="";
//分组序号
var subGroupIndex = "";
//主组标识
var groupnum=null;
//零件号
var subMid=null;
//主组对象
var groupObj=null;
//分组对象
var subGroubObj=null;
//获取零件下标
function getSubGroupIndex(){
	for(var i=0;i<subGroupData.length;i++){
		if(subGroupData[i].mid ==subMid){
			subGroupIndex =i;
		}
	}

}
//获取主组下标
function getGroupIndex(){
	for(var i=0;i<groupData.length;i++){
		if(groupData[i].groupnum ==groupnum){
			groupIndex =i;
		}
	}
}
//上一主组
function lastGroup(){
	//获取下标
	getGroupIndex();
	
	groupIndex = Number(groupIndex)-1;
	if(groupIndex<0){
		parent.showMsg("已到第一主组","W");
		groupIndex =0;
		return;
	}else{
		groupObj=groupData[groupIndex];
		//主组事件
		clickGdMainGroup(groupObj);
		subGroubObj=gridSubGroup.getRow(0);
		clickGdSubGroup(subGroubObj);
	}
	
	
}
//下一主组
function nextGroup(){
	//获取下标	
	getGroupIndex(groupnum);

	groupIndex = Number(groupIndex)+1;
	if(groupIndex >groupData.length-1){
		parent.showMsg("已到最后主组","W");
		groupIndex =groupData.length-1;
		return;
	}else{
		groupObj=groupData[groupIndex];
		//主组事件
		clickGdMainGroup(groupObj);
		subGroubObj=gridSubGroup.getRow(0);
		clickGdSubGroup(subGroubObj);
	}
	
}
//上一分组
function lastSubGroup(){
	//获取分组序号
	getSubGroupIndex();
	subGroupIndex =Number(subGroupIndex)-1;
	if(subGroupIndex<0){
		parent.showMsg("已到第一分组","W");
		subGroupIndex =0;
		return;
	}else{

		subGroubObj=subGroupData[subGroupIndex];
		clickGdSubGroup(subGroubObj);
	}
}
//下一分组
function nextSubGroup(){
	//获取分组序号
	getSubGroupIndex();
	subGroupIndex =Number(subGroupIndex)+1;
	if(subGroupIndex>subGroupData.length-1){
		parent.showMsg("已到最后分组","W");
		subGroupIndex =subGroupData.length-1;
		return;
	}else{

		subGroubObj=subGroupData[subGroupIndex];
		clickGdSubGroup(subGroubObj);
	}
}



