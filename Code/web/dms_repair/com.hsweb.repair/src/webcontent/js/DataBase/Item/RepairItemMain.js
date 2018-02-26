var baseUrl = window._rootUrl||"http://127.0.0.1:8080/default/";
var treeUrl = baseUrl+"com.hsapi.repair.baseData.item.getRepairTree.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.repair.baseData.item.queryRepairItemList.biz.ext";
var tree1 = null;
var rightGrid = null;

//var dataItems = data.dataItems||[];
//var typeList = dataItems.filter(function(v)
//        {
//    if(v.customid == "DDT20130703000064")
//    {
//        enterTypeIdHash[v.customid] = v;
//        return true;
//    }
//});

$(document).ready(function() {
	//queryForm = new nui.Form("#queryForm");
	tree1 = nui.get("tree1");
	tree1.setUrl(treeUrl);
	//右边区域
	rightGrid = nui.get("rightGrid");
	rightGrid.setUrl(rightGridUrl);
	
	loadTreeData({});
	loadRightGridData({});

});
function onRepairGridRowClick(e){
	var row = e.record;
	loadRightGridData(row.customid);
}
function loadTreeData(params){
	rightGrid.setData([]);
	tree1.load(params,function(){
		var row = tree1.getSelected();
		if(row){
			loadRightGridData(row.customid);
		}
	});
}
function loadRightGridData(type){
	rightGrid.load({
		type:type
	});
	
}
//function onDrawCell(e){
//	 switch (e.field)
//	    {
//	        case "billStatus":
//	            if(billStatusHash && billStatusHash[e.value])
//	            {
//	                e.cellHtml = billStatusHash[e.value];
//	            }
//	            break;
//	        case "type":
//	            if(enterTypeIdHash && enterTypeIdHash[e.value])
//	            {
//	                e.cellHtml = enterTypeIdHash[e.value].name;
//	            }
//	            break;
//	        case "settType":
//	            if(settTypeIdHash && settTypeIdHash[e.value])
//	            {
//	                e.cellHtml = settTypeIdHash[e.value].name;
//	            }
//	            break;
//	        case "storeId":
//	            if(storehouseHash && storehouseHash[e.value])
//	            {
//	                e.cellHtml = storehouseHash[e.value].name;
//	            }
//	            break;
//	        case "backReasonId":
//	            if(backReasonIdHash && backReasonIdHash[e.value])
//	            {
//	                e.cellHtml = backReasonIdHash[e.value].name;
//	            }
//	            break;
//	        case "enterDayCount":
//	            var row = e.record;
//	            var enterTime = (new Date(row.enterDate)).getTime();
//	            var nowTime = (new Date()).getTime();
//	            var dayCount = parseInt((nowTime - enterTime) / 1000 / 60 / 60 / 24);
//	            e.cellHtml = dayCount+1;
//	            break;
//	        default:
//	            break;
//	    }
//}	   

function addOrEdit(item){
	nui.open({
		targetWindow: window,
		url:"RepairItemDetail.jsp",
		title:"维修项目",
		width:450,
		height:500,
		allowResize:false,
		onload: function(){
			if(item){
				var iframe = this.getIFrameEl();
				iframe.contentWindow.setData({
					item:item
				});
			}
		},
		ondestroy:function(action){
	    	if(action == "ok"){
	    		rightGrid.reload();
	    	}	
		}
	});
}
function add(){
	addOrEdit();
}
function edit(){
	var row = rightGrid.getSelected();
	if(row){
		addOrEdit(row);
	}
}