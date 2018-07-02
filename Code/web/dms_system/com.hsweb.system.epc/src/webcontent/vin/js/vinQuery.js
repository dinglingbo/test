
var vin; //vin
var vin_len; //vin长度要求
var vin_input;//vin输入
var curr_check;//当前选择品牌
var brand; //品牌
var vinPartImg;//零件图片
var gridCfg; //车辆配置
var gridMainGroup; //主组
var subGroups;//分组
var gridSubGroup;//分组grid
var gridParts;//零件
var panel;

var selectWin;
var configWin;
var gridConfig;
var vinWin;
var winCarCfg = null;
var gridCfgT = null;

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

$(document).ready(function(v){
    selectWin = nui.get("brandWin");
    configWin = nui.get("configWin");
    gridConfig = nui.get("gridConfig");
    vinWin = nui.get("vinWin");
        
    vin_input = nui.get("vin");
    vinPartImg = $("#vin_part_img");
    gridCfg = nui.get("gridCfg");
	gridMainGroup = nui.get("gridMainGroup");
    subGroups = $("#subGroups");
    gridSubGroup = nui.get("gridSubGroup");
    gridParts = nui.get("gridParts");
    panel = nui.get("panel");

    winCarCfg = nui.get("winCarCfg");
    gridCfgT = nui.get("gridCfgT");
    document.getElementById("chainStockIframe").src=webPath + cloudPartDomain + "/common/embedJsp/containBottom.jsp?token="+token;
    
    //panel.hidePane(0);
    panel.hidePane(2); 
    
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
            var html = '<a class="" href="javascript:openDetail(\'' + record.pid + '\')">' + value + '</a>';
            e.cellHtml = html;
        }else if(field == "opt"){
            var html = '<a class="" href="javascript:addPart()"><i class="fa fa-shopping-cart"></i></a>';
            e.cellHtml = html;
        }
    });
    gridParts.on("selectionchanged", function (e) { //表格绘制
        var row = e.selected;
        if(row){ 
            renderMapRect(row.num);

            clearSelectedCls();
            gridParts.addRowCls(row, "select-row");
        }
    });
    gridParts.on("showrowdetail", function (e) { //表格绘制
        var row = e.record;
        var mainId = row.id;
        console.log(row);
        var chainStockForm = document.getElementById("chainStockForm");
        //将editForm元素，加入行详细单元格内
        var td = gridParts.getRowDetailCellEl(row);

        td.appendChild(chainStockForm);
        chainStockForm.style.display = "";

    });
    
    gridConfig.on("select", function (e) {//4005选择配置
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        var row = e.record;
        if (row.auth) {
            var params = {
                "url": llq_pre_url + "/ppyvin/searchvins_v2",
                "params":{
                    "vin":vin,
                    "brand": row.brand,
                    "is_filter":1,
                    "auth":unescape(row.auth)
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
//用于查询库存分布
function setBottomData(row){
	var type = row.type;
	document.getElementById("formIframe").contentWindow.setInitEmbedParams(row);
}
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
function queryVin(){	
    vin = vin_input.getValue();
    brand = curr_check;
    if (checkVin()){
        var params = {
            "url": llq_pre_url + "/ppyvin/searchvins_v2",
            "params":{
                "vin": vin,
                "brand": brand
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

    winCarCfg.hide();
}

/*
*获取主组列表(需要先调用车辆信息接口，再执行)
*/
function queryGroupByVin(){	
    if (checkVin()){
        var params = {
            "url": llq_pre_url + "/ppyvin/group_v2",
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
            /*{ type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},*/
            { field: "auth", visible: false},
            { field: "name", width:80, headerAlign: "center", allowSort: false, header: "主组名称", summaryType: "count"}
        ]
    });
    gridMainGroup.setData(data);
}

/*
*分组信息
*/
function setSubGroupData(data){
    gridSubGroup.setData(data);
    
    //img
    var len = data.length;
    var imgSubGroup = $("#imgSubGroup");
    imgSubGroup.children().remove();
    var img = "";
    for(var i=0;i<len;i++){
        img = '<a class="sub-group" data=' + i + '>'
            + '<div class="LazyLoad is-visible" style="height:140px; width:140px;">'
            + '    <img src="' + data[i].url + '" alt="sub-group-img" class="sub-group-img"/>'
            + '</div>'
            + '<div class="label">' + data[i].mid + '</div>'
            + '<div class="float-panel">' + data[i].subgroupname + '</div>'
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
    if (row.auth) {
        var params = {
            "url": llq_pre_url + "/ppyvin/subgroup",
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
}

/*
*分组事件
*/
function clickGdSubGroup(row){
    if(row.has_subs){
        clickGdMainGroup(row);
        return;
    }
    
    if (row.auth) {
        var params = {
            "url": llq_pre_url + "/ppyvin/parts",
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
            "url": llq_pre_url + "/ppycars/subimgs",
            "params":{
                "brand":brand,
                "auth":unescape(row.auth)
            },
            "token": token
        }
        callAjax(url, params, processAjax, setPartImg);
    }
}

/*
*零件数据处理
*/
function setGridPartsData(data, rs){
    gridParts.setData(data);
    showRightGrid(gridParts);
    showLeftGrid(vinPartImg);
}

/*
*零件详情
*/
function openDetail(pid){	
    try{
        nui.open({
            url : sysDomain + "/com.hsweb.system.epc.partDetail.flow?brand=" + brand + "&pid=" + pid+"&token="+token,
            title : "零件详情",
            width : "900px",
            height : "600px",
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
/*
*添加购物车
*/
function addPart(){   
    try{
        if(parent.showPanel){
            parent.showPanel('PART');
        }
        if(parent.addToCartGrid){
            parent.addToCartGrid('VIN', gridParts.getSelected());
        }
    }finally{}
}

function checkVin(){
    if (vin && (vin.length == 17 || vin.length == vin_len)){
        return true;
    }else{
        nui.alert("请输入" + vin_len + "位或17位VIN编码！");
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
        //$($(".groupButton")[num]).click();
        setBgColor($(".groupButton")[num]);
        
        if(gridObj != gridParts){//非零件
            showLeftGrid(gridMainGroup);
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
    vin_input.setValue(null);
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
                  + ' onclick="vin_input.setValue(\'[vin]\'); queryVin(); closeSelectBrand(vinWin);">'
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