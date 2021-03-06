var vinPartImg;//零件图片
//var gridCfg; //车辆配置
var gridMainGroup; //主组
var subGroups;//分组
var gridSubGroup;//分组
var gridParts;//零件
var currDg;
var ntab;
var partPanel //面板
var cartPartGrid = null; //采购车
var stockGrid =null;
var stockGridUrl= apiPath + cloudPartApi +"/" +"com.hsapi.cloud.part.invoicing.query.queryChainStockByPartId.biz.ext";
var storehouseHash = {};

$(document).ready(function(v){
    vinPartImg = $("#vin_part_img");
    //gridCfg = nui.get("gridCfg");
	gridMainGroup = nui.get("gridMainGroup");
    gridSubGroup = nui.get("gridSubGroup");
    gridParts = nui.get("gridParts");
    ntab = nui.get("tabs");
    subGroups = $("#subGroups");
    partPanel = nui.get("partPanel");
    cartPartGrid = nui.get("cartPartGrid");
    stockGrid = nui.get("stockGrid");
    stockGrid.setUrl(stockGridUrl);
    
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
    gridMainGroup.on("select", function (e) {//查分组信息rowclick
        /* var column = e.column;
        var editor = e.editor;
        field = e.field,
        value = e.value; */
        clickGdMainGroup(e.record);
    });
    
    gridSubGroup.on("rowclick", function (e) {//查零件信息
        clickGdSubGroup(e.record);
    });
    
    gridParts.on("drawcell", function (e) { //表格绘制
        var record = e.record;
        var column = e.column;
        var field = e.field;
        var value = e.value;
        if(field == "detail"){
        	if(record.pid!=""){      		
        		var html = '<a class="icon-hedit" href="javascript:openDetail()">详情</a>';
        		e.cellHtml = html;
        	}
        }else if(field == "opt"){
            var html = '<a class="" href="javascript:addPart()"><i class="fa fa-shopping-cart"></i></a>';
            e.cellHtml = html;
        }
    });
    
    gridParts.on("cellclick",function(e){ 
        var field=e.field;
        var row=e.row;
        if(field=="check" ){
            if(e.row.check==1){
                addPart(1);
                //查询库存分布
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
});

/*
*主组事件
*/
function clickGdMainGroup(row){
    if (row.mcid) {
    	//主组序号
    	groupnum =row.num;
        var params = {
    			url:"llq/vins/cars/subgroup",
    			params:"&mcid="+row.mcid+"&brandCode="+row.brandCode+"&num="+row.num,
    			token:token
        }
        callAjax(url, params, processAjax, setSubGroupData);
    }
}

/*
*分组事件
*/
function clickGdSubGroup(row){
    //var row = gridSubGroup.getSelected();
    if(row.hasChild!=0){
        clickGdMainGroup(row);
        return;
    }
    
    if (row.mid) {
    	//分组零件号
    	subMid=row.mid; 	
        var str = "&brandCode="+row.brandCode+"&num="+row.num+"&mid="+row.mid+"&subGroup="+row.subgroup+"&mcid="+row.mcid;
        str = encodeURI(str) 
        var params = {
    			url:"llq/vins/cars/parts",
    			params:str,
    			token:token
        }
        callAjax(url, params, processAjax, setGridPartsData);
        
/*        params = {
            "url": llq_pre_url + "/ppycars/subimgs",
            "params":{
                "code":brand,
                "auth": row.auth
            },
            "token": token
        }
        callAjax(url, params, processAjax, setPartImg);*/
        
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

/*
*获取主组列表
*/
//unescape(auth)
function queryGroupByAuth(auth){	
    var params = {
			url:"llq/vins/cars/group",
			params:"&mcid="+auth.mcid+"&brandCode="+auth.brand,
			token:token
    }
    callAjax(url, params, processAjax, setgridMainGroup);
}

/*
*主组数据处理
*/
function setgridMainGroup(data){   
	//主组数据
	groupData=data;
    showInfoLeftGrid(gridMainGroup);
    gridMainGroup.set({
        columns: [
            { type: "indexcolumn", width:20, headerAlign: "center", header: "序号", summaryType: "count"},
            { field: "auth", visible: false},
            { field: "label", width:80, headerAlign: "center", allowSort: false, header: "主组名称"}
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
function setSubGroupData(data,json){
	//分组数据
	subGroupData =data;
	for(var i=0;i<data.length;i++){
		data[i].subGroup = data[i].mid;
	}
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
            + '<div class="label">' + data[i].mid + '</div>'
            + '<div class="float-panel">' + data[i].name + '</div>'
        + '</a>';
        imgSubGroup.append(img);
        
    }
    $(".sub-group").bind("click", function(obj){//.sub-group-img
        var rowid = $(this).attr("data");
        var row = gridSubGroup.getRow(parseInt(rowid));
        //gridSubGroup.select(row, true);
        gridSubGroup.setSelected(row);
        clickGdSubGroup(row);
    });
    showInfoRightGrid(subGroups);//123
}

/*
*零件数据处理
*/
function setGridPartsData(data,json){
    var tData = [];
    for(var i=0; i<data.partDetail.length; i++){
        tData = tData.concat(data.partDetail[i]);
    }
    gridParts.setData(tData);
    showInfoRightGrid(gridParts);
    showInfoLeftGrid(vinPartImg);
    data.img = json.img;
    data.img.imgurl= json.img.imagePath;
    setPartImg(data.img,json);
}

/*
*零件详情
*/
function openDetail(){	
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
/*
*左部grid
*/
function showInfoLeftGrid(gridObj){
    gridMainGroup.hide();
    vinPartImg.hide();
    $('.j_part-img-map').html('');
    $('.j_part-map-rect').html('');
    
    gridObj.show();  
}

/*
*右部grid
*/
function showInfoRightGrid(gridObj){
    //gridCfg.hide();
    //$('#imgSubGroup').hide();123
    //gridSubGroup.hide();
    gridParts.hide();
    subGroups.hide();
    
    gridObj.show();
    //var num = (gridObj==gridCfg)? 0 : ((gridObj==gridSubGroup)? 1 : 2);
    var num = (gridObj==gridSubGroup)? 1 : 2;
    $($(".groupButton2")[num]).show();
    if(num ==2){
    	 //上一主组
    	 $($(".groupButton2")[3]).show();
    	 //下一主组
    	 $($(".groupButton2")[4]).show();
    	 //上一分组
    	 $($(".groupButton2")[5]).show();
    	 //下一分组
    	 $($(".groupButton2")[6]).show();
    }
    //$($(".groupButton")[num]).click();
    setBgColor($(".groupButton2")[num]);
    //分割栏显示
    partPanel.show();
    if(gridObj != gridParts){//非零件
        showInfoLeftGrid(gridMainGroup);
        //分隔栏不显示
        partPanel.hide();
        //上一主组
        $($(".groupButton2")[3]).hide();
        //下一主组
	   	$($(".groupButton2")[4]).hide();
	   	//上一分组
	   	$($(".groupButton2")[5]).hide();
	   	//下一分组
	   	$($(".groupButton2")[6]).hide();
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

/*
*添加购物车
// */
// function addPart(){   
//     try{
//         if(parent.showPanel){
//             parent.showPanel('PART');
//         }
//         if(parent.addToCartGrid){
//             parent.addToCartGrid('VIN', gridParts.getSelected());
//         }
//     }finally{}
// }


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

function searchStok(row)
{
	var params={};
//	var row=gridParts.getSelected();
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