
var baseUrl = apiPath + partApi + "/";
var partGrid=null;
var protokenEl=null;
var partDetailGrid=null;
var partDetailGrid=null;
var billTypeIdList=[];
var settleTypeIdList=[];
var billTypeIdHash={};
var settleTypeIdHash={};
var guestData=null;
var partData=null;
var classesId=null;
var tree = null;
var brandId =null;
var carId=null;
var protoken = "";
var treeUrl = baseUrl+"com.hsapi.part.invoice.partInterfaceDs.queryPartType.biz.ext";
var dictDefs ={"billTypeIdE":"DDT20130703000008", "settleTypeIdE":"DDT20130703000035",};
var getDetailPartUrl =baseUrl+"com.hsapi.part.invoice.partInterfaceDs.queryDetailStock.biz.ext";
var partGridUrl=baseUrl+"com.hsapi.part.invoice.partInterfaceDs.queryJoinStock.biz.ext";
//var CarplateUrl= baseUrl+"com.hsapi.part.invoice.partInterface.queryCarplate.biz.ext";
var partBrandUrl=baseUrl+"com.hsapi.part.invoice.partInterfaceDs.queryPartBrand.biz.ext";
var signBtn=null;
$(document).ready(function() {
    protokenEl=nui.get('protoken');
	partGrid =nui.get('partGrid');
	partGrid.setUrl(partGridUrl);
	partDetailGrid = nui.get("partDetailGrid");
    partDetailGrid.setUrl(getDetailPartUrl);
//    signBtn=nui.get("signBtn");
//    if(currSrmUserId){
//    	signBtn.setVisible(false);
//    }
    tree = nui.get("tree1");
//    tree.setUrl(treeUrl);
//    initQuery();
    document.onkeyup = function(event) {
		var e = event || window.event;
		var keyCode = e.keyCode || e.which;// 38向上 40向下
		

		if ((keyCode == 13)) { // F9
			onSearch();
		}
	}
       
    protoken = getProToken();
    
    partDetailGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        
        switch (e.field) {
            case "action":
            	e.cellHtml ='<a id="orderCar" href="##" onclick="verifyGuestForCar()">'+'添加到采购车'+'</a>'
            	+"&nbsp;&nbsp;" + '<a id="order" href="##" onclick="verifyGuestForOrder()">'+'生成采购订单'+'</a>';;
                break;
            default:
                break;
        }
    });
    
});

//function initQuery(){
//	tree.load({token:token});
//    queryPartBrand();
//}
//function platformSignIn(){
//	window.open("http://192.168.111.58:8080/srm/supplier/cusRegister.html?id="+currOrgId);  
////	window.open("http://srm.hszb.harsons.cn/srm/supplier/cusRegister.html?id="+currOrgId);     
//}
function setRoleId() {
	return {"token":token,"protoken":protoken};
}
//实际添加到采购车方法
function addOrderCar(guest, part)
{
	var  type = 'pchsCart';
	var data = partDetailGrid.getSelected();
    var detail=[];
	if(!guest.id){
		parent.parent.parent.showMsg("请选择往来单位!","W");
        return;
	}

	data.partId=part.id;
	data.partCode=part.code;
	data.partName=part.name;
	data.fullName=part.fullName;
	data.unit=part.unit;
    data.orderQty=data.qty;
    data.orderPrice=data.price;
    detail.push(data);
   	
	
	var main={};
	main.guestId=guest.id;
	main.guestName=guest.fullName;
	main.shortName=guest.fullName;
	main.storeId='';
	main.shopType = 1;
	main.remark='';
	main.billTypeId=guest.billTypeId;
	main.settleTypeId=guest.settTypeId;
	main.type = "";
	generateOrderByBatch(main, detail, type);
 
}
//新增配件
function addOrEditPart(row)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.part.baseData.partDetail.flow?token=" + token,
        title: "配件资料",
        width: 470, height: 320,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params={};
//            params.qualityTypeIdList=null;
//            params.partBrandIdList=null;
//            params.unitList=null;
//            params.abcTypeList=null;
//            params.applyCarModelList=null;
            if(row)
            {
                params.comPartCode= row.partsCode;
                params.name=row.partsName;
            }
            iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
          	var iframe = this.getIFrameEl();
        	var data = iframe.contentWindow.getData();
        	console.log(data);
//        	var enterDetail={
//        		comPartCode : data.code
//        	};
            if(action == "ok")
            {	
            	verifyGuestForCar();
            	
            }
        }
    });

}
var guestUrl=baseUrl+"com.hsapi.part.invoice.partInterfaceDs.queryGuestAndSKU.biz.ext";
function verifyGuestForCar(){
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '加载中...'
    });
	var jsonData = partDetailGrid.getSelected();
	if(!jsonData.storeCode){
		parent.parent.showMsg("请选择有往来单位的配件！","W");
		nui.unmask(document.body);
		return;
	}
	nui.ajax({
        url : guestUrl,
        type : "post",
        data : {
        	guestId	 :jsonData.storeCode,
    		guestName : jsonData.storeName,
    		partId :jsonData.goodsCode,
    		partCode :jsonData.partsCode,
    		brandId : jsonData.brandCode,
    		brandName :jsonData.brandName,
    		partName :jsonData.partsName,
    		protoken :protoken,
    		token:token
        },
        success : function(data) {
            nui.unmask(document.body);
            data = data.data || {};
            guestData=data.guest;
            partData=data.part;
            if(partData.status==-1){
        		parent.parent.showMsg(partData.msg);
        		addOrEditPart(jsonData);
        	}else{
    			addOrderCar(guestData,partData);      		 
        	}
           
            return true;   
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            return false;
        }
    });
}

function verifyGuestForOrder(){
	nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '加载中...'
    });
	var jsonData = partDetailGrid.getSelected();
	if(!jsonData.storeCode){
		nui.unmask(document.body);
		parent.parent.showMsg("请选择有往来单位的配件！","W");
		return;
	}
	nui.ajax({
        url : guestUrl,
        type : "post",
        data : {
        	guestId	 :jsonData.storeCode,
    		guestName : jsonData.storeName,
    		partId :jsonData.goodsCode,
    		partCode :jsonData.partsCode,
    		brandId : jsonData.brandCode,
    		brandName :jsonData.brandName,
    		partName :jsonData.partsName,
    		protoken :protoken,
    		token:token
        },
        success : function(data) {
            nui.unmask(document.body);
            data = data.data || {};
            guestData=data.guest;
            partData=data.part;
            
            if(partData.status==-1){
        		parent.parent.showMsg(partData.msg);
        		addOrEditPart(jsonData);
        	}else{
    			addOrder();      		 
        	}
           
            return true;   
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
            return false;
        }
    });
}
var generateOrderUrl = baseUrl
+ "com.hsapi.part.invoice.paramcrud.generateOrderByBatch.biz.ext";
function generateOrderByBatch(main,detail,type){
    nui.mask({
        el : document.body,
        cls : 'mini-mask-loading',
        html : '保存中...'
    });
    nui.ajax({
        url : generateOrderUrl,
        type : "post",
        async: false,
        data : {
            main: main,
            detail: detail,
            type: "pchsCart",
            token:token
        },
        success : function(data) {
            nui.unmask(document.body);
            var errCode = data.errCode;
            if(errCode == "S"){
                parent.parent.parent.parent.showMsg("操作成功!","S");
                if(type == "pchsOrder" || type == "sellOrder"){
                    //更新采购车或是销售车的状态
                }
                //CloseWindow("ok");
            } else {
                parent.parent.parent.showMsg(data.errMsg || "操作失败!","W");
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addOrder(){
    var row = partDetailGrid.getSelected();
    row.partId=partData.id;;
    row.partCode=partData.code;
    row.partName=partData.name;
    row.fullName=partData.fullName;
    row.unit=partData.unit;
    row.orderQty=row.qty;
    row.orderPrice=row.price;
    row.guestId=guestData.id;
    row.guestName=guestData.fullName;
    var rows=[];
    rows.push(row);
    if(rows && rows.length > 0){

    }else{
        parent.parent.showMsg("请选择配件信息!");
        return;
    }

    openGeneratePop(rows, "fromPchsCart", "新增采购订单");
}
function openGeneratePop(partList, type, title){
    nui.open({
        // targetWindow: window,,
        url : webPath+contextPath+"/com.hsweb.part.manage.shopCarPop.flow?token="+token,
        title : title,
        width : 600,
        height : 400,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                storeId: '',
                partList: partList,
                type: type
            };
            iframe.contentWindow.setInitData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                //var data = iframe.contentWindow.getData();
                updateOrderCart(partList);
            }
        }
    });
}

function getProToken(){
	var systoken = "";
    nui.ajax({
        url : webPath + contextPath + "/com.hs.common.sysService.srmAuth.biz.ext",
        type : "post",
        async: true,
        data : {
        },
        success : function(data) {
            var errCode = data.errCode;
            if(errCode == "S"){
            	systoken = data.systoken;
            	protoken = systoken;
            	//获取额度
            	getDsUserMoney();
            	//品牌
            	queryPartBrand();

//            	tree.load({
//            		protoken:protoken
//            	});
            	
            	var url = treeUrl+"?token="+token+"&protoken="+protoken;
            	tree.load(url);
            	
            }else {
            	systoken = "";
            }
            
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
    
    
	
    return systoken;
}


function onSearch (){

	var partCode =nui.get('partCode').value;
	var brandCode =nui.get('partBrandId').value;
	var partName =nui.get('partName').value;
//	if(!key){
//		parent.parent.showMsg("请填写关键词！","W");
//	}
	
	partGrid.load({
		brandCode :brandCode ||"",
		partsCode :partCode || "",
		partsName :partName ||"",
		classesId:classesId || "",
		protoken:protoken,
		token:token
	});
}



function onGridSelectionChanged(){
	 var data = partGrid.getSelected();
	 var  goodsCode = data.goodsCode;
	 partDetailGrid.load({
		goodsCode:goodsCode,
		protoken:protoken,
    	token:token
	 })
}

function onDrawNode(e)
{
    var node = e.node;
    e.nodeHtml = node.code + " " + node.name;
}
function onNodeDblClick(e)
{
    var currTree = e.sender;
    var currNode = e.node;
//    var level = currTree.getLevel(currNode);
//    var list = [];
//    var tmpNode = currNode;
//    do{
//        list[level] = tmpNode.id;
//        tmpNode = currTree.getParentNode(tmpNode);
//        level = currTree.getLevel(tmpNode);
//    }while(tmpNode&&tmpNode.id);

    classesId = currNode.id||"";
//    var categoryS = list[1]||"";
//    var categoryT = list[2]||"";

    onSearch();
}
var partTypeHash = null;

//
//function reloadData()
//{
//    if(partGrid)
//    {
//        partGrid.reload();
//    }
//    var tab = mainTabs.getActiveTab();
//    if(tab.name == "main"){
//        if(partGrid)
//        {
//            partGrid.reload();
//        }
//    }else if(tab.name == "local"){
//        if(partLoalGrid)
//        {
//            partLoalGrid.reload();
//        } 
//    }
//}

//function queryCarplate(){
//	nui.ajax({
//        url : CarplateUrl,
//        type : "post",
//        data : {protoken:protoken,token:token},
//        success : function(data) {
//            nui.unmask(document.body);
//            var list = data.data || {};
//            if (data.errCode == "S") {
//            	nui.get('Carplate').setData(list);
//                carId=nui.get("Carplate").value;
//            }
//               
//        },
//        error : function(jqXHR, textStatus, errorThrown) {
//            // nui.alert(jqXHR.responseText);
//            console.log(jqXHR.responseText);
//        }
//    });
//}

function queryPartBrand(){
	nui.ajax({
        url : partBrandUrl,
        type : "post",
        data : {protoken:protoken,token:token},
        success : function(data) {
            nui.unmask(document.body);
            list = data.data || {};
        	if (data.errCode == "S") {
            	nui.get('partBrandId').setData(list);
                brandId=nui.get("partBrandId").value;
            }
               
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var getMoneryUrl=baseUrl+"com.hsapi.part.invoice.partInterfaceDs.getDsUserMoney.biz.ext"
function getDsUserMoney(){
	nui.ajax({
        url : getMoneryUrl,
        type : "post",
        data : {protoken:protoken,token:token},
        success : function(data) {
            nui.unmask(document.body);
            list = data.data || {};
        	if (data.errCode == "S") {
            	var data=data.data;
            	var useMoney =data.useMoney;
            	$('#useMoney').text("电商额度:"+useMoney);
            }
               
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}