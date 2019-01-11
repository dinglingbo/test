
var baseUrl = apiPath + partApi + "/";
var protoken=null;
var partGrid=null;
var protokenEl=null;
var innerPartGrid=null;
var editFormDetail = null;
var billTypeIdList=[];
var settleTypeIdList=[];
var billTypeIdHash={};
var settleTypeIdHash={};
var dictDefs ={"billTypeIdE":"DDT20130703000008", "settleTypeIdE":"DDT20130703000035"};
var getToeknUrl='http://124.172.221.179:83/srm/router/rest?method=sys.sys.loginIndex&account=000dlb&password=123456&system=0';
var getDetailPartUrl =baseUrl+"com.hsapi.part.invoice.partInterface.queryDetailStock.biz.ext";
var partGridUrl=baseUrl+"com.hsapi.part.invoice.partInterface.queryJoinStock.biz.ext";
$(document).ready(function() {
    protokenEl=nui.get('protoken');
	partGrid =nui.get('partGrid');
	partGrid.setUrl(partGridUrl);
	innerPartGrid = nui.get("innerPartGrid");
    innerPartGrid.setUrl(getDetailPartUrl);
    editFormDetail = document.getElementById("editFormDetail");
    
    initDicts(dictDefs, function(){
    	billTypeIdList=nui.get('billTypeIdE').getData();     		
    	settleTypeIdList=nui.get('settleTypeIdE').getData();
    	billTypeIdList.forEach(function(v){
    		billTypeIdHash[v.customid]=v;
    	});
    	settleTypeIdList.forEach(function(v){
    		settleTypeIdHash[v.customid]=v;
    	});
    	
    });
    innerPartGrid.on("drawcell", function (e) {
        var grid = e.sender;
        var record = e.record;
        var uid = record._uid;
        var rowIndex = e.rowIndex;
        
        switch (e.field) {
            case "action":
            	e.cellHtml ='<a href="##" onclick="addOrderCar()">'+'添加到采购车'+'</a>'
            	+"&nbsp;&nbsp;" + '<a href="##" onclick="addOrder()">'+'生成采购订单'+'</a>';;
                break;
            default:
                break;
        }
    });
    
});

function addOrderCar()
{
	var  type = 'pchsCart';
    var data = innerPartGrid.getSelected();
    var detail=[];
	if(!data.guestId){
		parent.showMsg("请选择往来单位!","W");
        return;
	}
	
	data.partId=data.partId;
	data.partCode=data.code;
	data.partName=data.name;
	data.fullName=data.full_name;
    data.orderQty=data.qty;
    data.orderPrice=data.price;
    detail.push(data);
    
	var main={};
	main.guestId=data.guestId;
	main.guestName=data.guestName;
	main.shortName=data.guestName;
	main.storeId='';
	main.shopType = 1;
	main.remark='';
	main.billTypeId=billTypeIdList[0].customid;
	main.settleTypeId=settleTypeIdList[0].customid;
	main.type = "";
	generateOrderByBatch(main, detail, type);
 


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
                parent.parent.showMsg("操作成功!","S");
                if(type == "pchsOrder" || type == "sellOrder"){
                    //更新采购车或是销售车的状态
                }
                CloseWindow("ok");
            } else {
                parent.showMsg(data.errMsg || "操作失败!","W");
            }

        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function addOrder(){
    var row = innerPartGrid.getSelected();
    row.partId=row.partId;
    row.partCode=row.code;
    row.partName=row.name;
    row.fullName=row.full_name;
    row.orderQty=row.qty;
    row.orderPrice=row.price;
    var rows=[];
    rows.push(row);
    if(rows && rows.length > 0){

    }else{
        nui.alert("请选择配件信息!");
        return;
    }

    openGeneratePop(rows, "fromPchsCart", "新增采购订单");
}
function openGeneratePop(partList, type, title){
    nui.open({
        targetWindow : window,
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
function getToken(){
	nui.ajax({
        url : getToeknUrl,
        type : "post",
        data : '',
        success : function(data) {
            nui.unmask(document.body);
            data = data.data || {};
            if (data.status == "0") {
            	protoken=data.protoken;
            	protokenEl.setValue(protoken);
            }
               
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onSearch (){
	var key =nui.get('key').value;
	if(!key){
		showMsg("请填写关键词！","W");
	}
	protoken =protokenEl.value;
	partGrid.load({
		protoken :protoken,
		key  :key
	});
}


function onShowRowDetail(e) {
    var row = e.record;
    
    //将editForm元素，加入行详细单元格内
    var td = partGrid.getRowDetailCellEl(row);
    td.appendChild(editFormDetail);
    editFormDetail.style.display = "";
    innerPartGrid.setData([]);
    var partId = row.partId;
    innerPartGrid.load({
    	sort :"partId",
    	key:partId,
    	protoken:protoken
    	});
    
}