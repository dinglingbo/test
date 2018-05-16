var vinPartImg;//零件图片
//var gridCfg; //车辆配置
var gridMainGroup; //主组
var gridSubGroup;//分组
var gridParts;//零件
var currDg;
var ntab;

$(document).ready(function(v){
    vinPartImg = $("#vin_part_img");
    //gridCfg = nui.get("gridCfg");
	gridMainGroup = nui.get("gridMainGroup");
    gridSubGroup = nui.get("gridSubGroup");
    gridParts = nui.get("gridParts");
    ntab = nui.get("tabs");
    
    gridMainGroup.on("select", function (e) {//查分组信息rowclick
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        var row = gridMainGroup.getSelected();
        if (row.auth) {
            var params = {
                "url": llq_pre_url + "/ppycars/subgroup",
                "params":{
                    "brand":brand,
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
                "url": llq_pre_url + "/ppycars/parts",
                "params":{
                    "brand":brand,
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
    });
    
    gridParts.on("drawcell", function (e) { //表格绘制
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var value = e.value;
        if(field == "detail"){
            var html = '<a class="icon-hedit" href="javascript:openDetail(\'' + record.pid + '\')">' + value + '</a>';
            e.cellHtml = html;
        }
    });
});

/*
*获取主组列表
*/
//unescape(auth)
function queryGroupByAuth(auth){	
    var params = {
        "url": llq_pre_url + "/ppycars/group",
        "params":{
            "brand":brand,
            "auth":unescape(auth)//
        },
        "token": token
    }
    callAjax(url, params, processAjax, setgridMainGroup);
}

/*
*主组数据处理
*/
function setgridMainGroup(data){    
    showInfoLeftGrid(gridMainGroup);
    gridMainGroup.set({
        columns: [
            { type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},
            { field: "auth", visible: false},
            { field: "name", width:80, headerAlign: "center", allowSort: false, header: "主组名称"}
        ]
    });
    gridMainGroup.setData(data);
    //gridSubGroup.selectFirst();
    gridMainGroup.select(gridMainGroup.getRow(0), true);
    ntab.activeTab(ntab.getTab(1));
    //gridSubGroup.onRowclick();
}

/*
*分组信息
*/
function setSubGroupData(data){
    gridSubGroup.setData(data);
    showInfoRightGrid(gridSubGroup);
}

/*
*零件数据处理
*/
function setGridPartsData(data){
    gridParts.setData(data);
    showInfoRightGrid(gridParts);
    showInfoLeftGrid(vinPartImg);
}

/*
*零件详情
*/
function openDetail(pid){	
    try{
        nui.open({
            url : sysDomain + "/com.hsweb.system.llq.vin.partDetail.flow?brand=" + brand + "&pid=" + pid,
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
*左部grid
*/
function showInfoLeftGrid(gridObj){
    gridMainGroup.hide();
    vinPartImg.hide();
    
    gridObj.show();  
}

/*
*右部grid
*/
function showInfoRightGrid(gridObj){
    //gridCfg.hide();
    gridSubGroup.hide();
    gridParts.hide();
    
    gridObj.show();
    //var num = (gridObj==gridCfg)? 0 : ((gridObj==gridSubGroup)? 1 : 2);
    var num = (gridObj==gridSubGroup)? 1 : 2;
    $($(".groupButton2")[num]).show();
    //$($(".groupButton")[num]).click();
    setBgColor($(".groupButton2")[num]);
    
    if(gridObj != gridParts){//非零件
        showInfoLeftGrid(gridMainGroup);
    }
    
    /* if(gridObj == gridSubGroup){
        $(".groupButton2").attr("style", "background:#ffffff;");
        $($(".groupButton2")[1]).attr("style", "background:#e0d7d7;");
    }else{
        $(".groupButton2").attr("style", "background:#ffffff;");
        $($(".groupButton2")[2]).attr("style", "background:#e0d7d7;");
    } */
}


function setBgColor(obj){
    $(".groupButton2:visible").attr("style", "background:#ffffff;");
    var color = obj.style.background;
    if(color=="red"){
        obj.style.background = "#ffffff";
    }else{
        obj.style.background = "#e0d7d7";
    }
}
