/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";

var basicInfoForm = null;

var rightGrid = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var qualityHash = {};
var qualityList = [];
var compBrandList = [];
var compBrandHash = {};
var storehouse = null;
var gsparams = {};
var sEnterDate = null;
var eEnterDate = null;
var mainTabs = null;
var billmainTab = null;
var FGuestId = null;

$(document).ready(function(v)
{

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);

    basicInfoForm = new nui.Form("#basicInfoForm");
    
    var dictDefs ={"orgCarBrandId": "10444"};
	initDicts(dictDefs, function(){
		
		compBrandList = nui.get("orgCarBrandId").getData();
		compBrandList.forEach(function(v){
			compBrandHash[v.customid]=v;
    	});
		
		getStorehouse(function(data)
	    {
	        storehouse = data.storehouse||[];
	        nui.get("storeId").setData(storehouse);
	        
	        getAllPartBrand(function(data) {
	            brandList = data.brand;
	            brandList.forEach(function(v) {
	                brandHash[v.id] = v;
	            });
	            
	            qualityList = data.quality;
	            qualityList.forEach(function(v) {
	            	qualityHash[v.id] = v;
	            });
	            
	            getGuestId();
	            
	            add();
	        });
	    });    
		
	});


    //绑定表单
    //var db = new nui.DataBinding();
    //db.bindForm("basicInfoForm", leftGrid);
    

});
var guestUrl = baseUrl + "com.hsapi.cloud.part.common.svr.getGuestByInternalId.biz.ext";
function getGuestId() {

    nui.ajax({
        url : guestUrl,
        type : "post",
        data : JSON.stringify({}),
        success : function(data) {
            data = data || {};
            if (data.guest) {
                var guest = data.guest;
                FGuestId = guest.id;

            } else {
                console.log(data.errMsg);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR.responseText);
        }
    });
}
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
     

       if(row.auditSign == 1) {
            document.getElementById("basicInfoForm").disabled=true;
            setBtnable(false);
            setEditable(false);
       }else {
            document.getElementById("basicInfoForm").disabled=false;
            setBtnable(true);
            setEditable(true);
       }
        
       //序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
       formJson = nui.encode(basicInfoForm.getData());

       //加载盘盈入库明细表信息
       var mainId = row.id;
       loadRightGridData(mainId);
   }else {
        //form.reset();
        //grid_details.clearRows();
   }
}
function loadRightGridData(mainId)
{
    editPartHash={};
    var params = {};
    params.mainId = mainId;
    rightGrid.load({
        params:params,
        token:token
    });
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    param.enterTypeId = '050105';
    doSearch(param);
}
function getSearchParam(){
    var params = {};
    //params.guestId = nui.get("searchGuestId").getValue();
    return params;
}
function setBtnable(flag)
{
    if(flag)
    {
        nui.get("addPartBtn").enable();
        nui.get("importPartBtn").enable();
        nui.get("deletePartBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
        //nui.get("printBtn").enable();
    }
    else
    {
        nui.get("addPartBtn").disable();
        nui.get("importPartBtn").disable();
        nui.get("deletePartBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
        //nui.get("printBtn").disable();
    }
}
function setEditable(flag)
{
    if(flag)
    {
        document.getElementById("fd1").disabled = false;
    }
    else
    {
        document.getElementById("fd1").disabled = true;
    }
}
function doSearch(params) 
{
    params.enterTypeId = '050105';
    leftGrid.load({
        params : params,
        token : token
    }, function() {
        //onLeftGridRowDblClick({});
        var data = leftGrid.getData().length;
        if(data <= 0){
            basicInfoForm.reset();
            rightGrid.clearRows();
            
            setBtnable(false);
            setEditable(false);
            
        }else {
            var row = leftGrid.getSelected();
            if(row.auditSign == 1) {
                document.getElementById("basicInfoForm").disabled=true;
                setBtnable(false);
                setEditable(false);
            }else {
                document.getElementById("basicInfoForm").disabled=false;
                setBtnable(true);
                setEditable(true);
            }
        }
    });
}
function checkNew() 
{
    var data = basicInfoForm.getData();
    if(data.serviceId == "期初入库" || data.serviceId == "" || data.serviceId == null) return true;
    
    return rows.length;
}

function add()
{

    var formJsonThis = nui.encode(basicInfoForm.getData());
    var len = rightGrid.getData().length;

    if(formJson != formJsonThis && len > 0)
    {
        nui.confirm("您正在编辑数据,是否要继续?", "友情提示",
            function (action) { 
                if (action == "ok") {
                }else {
                    return;
                }
            }
        );
    }

    setBtnable(true);
    setEditable(true);

    basicInfoForm.reset();
    rightGrid.clearRows();
        
    nui.get("serviceId").setValue("期初入库");
    nui.get("enterTypeId").setValue("050105");
    
}
function calcTaxPriceInfo(taxSign, taxRate)
{
    rightGrid.findRow(function(row){
        var enterQty = row.enterQty;
        var enterPrice = row.enterPrice;
        var enterAmt = row.enterAmt;
        var noTaxPrice = 0;
        var noTaxAmt = 0;
        var taxPrice = 0;
        var taxAmt = 0;

        if (taxSign == 0) { //收据
            noTaxAmt = enterAmt;
            noTaxPrice = (enterQty > 0 ? enterAmt / enterQty : 0);
            enterPrice = (enterQty > 0 ? enterAmt / enterQty : 0);
            taxAmt = enterAmt * (1.0 + parseFloat(taxRate));
            taxPrice = enterQty > 0 ? (enterAmt / enterQty) * (1.0 + parseFloat(taxRate)) : 0;
        } else {
            taxAmt = enterAmt;
            taxPrice = (enterQty > 0 ? enterAmt / enterQty : 0);
            enterPrice = (enterQty > 0 ? enterAmt / enterQty : 0);
            noTaxAmt = enterAmt / (1.0 + parseFloat(taxRate));
            noTaxPrice = enterQty > 0 ? (enterAmt / enterQty) / (1.0 + parseFloat(taxRate)) : 0;
        }

        var newRow = {enterPrice: enterPrice, noTaxAmt: noTaxAmt, noTaxPrice: noTaxPrice, 
                      taxAmt: taxAmt, taxPrice: taxPrice, taxSign: taxSign, taxRate: taxRate};
        rightGrid.updateRow(row, newRow);
    });
}
function getMainData()
{
    var data = basicInfoForm.getData();
    //汇总明细数据到主表
    data.isFinished = 0;
    data.enterTypeId = '050105';
    data.auditSign = 0;
    data.billStatusId = '';
    data.noTaxAmt = 0;
    data.notEnterAmt = 0;
    data.notEnterQty = 0;
    data.enterAmt = 0;
    data.enterItem = 0;
    data.enterQty = 0;
    data.printTimes = 0;
    data.taxAmt = 0;
    data.taxDiff = 0;

    data.guestId = FGuestId;
    data.billTypeId = '010101';
    data.settleTypeId = '020501';

    var list = rightGrid.getData();
    for(var i=0;i<list.length;i++)
    {
        var tmp = list[i];
        data.noTaxAmt += parseFloat(tmp.noTaxAmt);
        data.notEnterAmt += parseFloat(tmp.enterAmt);
        data.notEnterQty += parseFloat(tmp.enterQty);
        data.enterAmt += parseFloat(tmp.enterAmt);
        data.enterQty += parseFloat(tmp.enterQty);
        data.taxAmt += parseFloat(tmp.taxAmt);
    }
    data.taxDiff = data.taxAmt - data.noTaxAmt;

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    return data;
}
var requiredField = {
    storeId : "默认仓库"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.saveQCEnter.biz.ext";
function save() {
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    if(data && data.auditSign && data.auditSign == 1){
        showMsg("此单已审核!","W");
        return;
    }

    data = getMainData();
   
    /*var enterDetailAdd = rightGrid.getChanges("added")||[];
    var enterDetailUpdate = [];
    for(var key in editPartHash)
    {
        if(typeof editPartHash[key] == 'object')
        {
            enterDetailUpdate.push(editPartHash[key]);
        }
    }
    var enterDetailDelete = rightGrid.getChanges("removed")||[];
    enterDetailDelete = enterDetailDelete.filter(function(v)
    {
        return v.detailId;
    });*/

    var enterDetailAdd = rightGrid.getChanges("added");
    var enterDetailUpdate = rightGrid.getChanges("modified");
    var enterDetailDelete = rightGrid.getChanges("removed");

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

    nui.ajax({
        url : saveUrl,
        type : "post",
        data : JSON.stringify({
            enterMain : data,
            enterDetailAdd : enterDetailAdd,
            enterDetailUpdate : enterDetailUpdate,
            enterDetailDelete : enterDetailDelete,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("保存成功!","S");
                //onLeftGridRowDblClick({});
                var pjEnterMainList = data.pjEnterMainList;
                if(pjEnterMainList && pjEnterMainList.length>0) {
                    var leftRow = pjEnterMainList[0];

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
            } else {
                showMsg(data.errMsg || "保存失败!","E");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var supplier = null;    
function onRightGridDraw(e)
{
    switch (e.field)
    {
        case "comPartBrandId":
        	if(brandHash[e.value])
            {
//                e.cellHtml = brandHash[e.value].name||"";
            	if(brandHash[e.value].imageUrl){
            		
            		e.cellHtml = "<img src='"+ brandHash[e.value].imageUrl+ "'alt='配件图片' height='25px' width=' '/><br> "+brandHash[e.value].name||"";
            	}else{
            		e.cellHtml = brandHash[e.value].name||"";
            	}
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "orgCarBrandId":
        	if(compBrandHash[e.value]) {
    			e.cellHtml = compBrandHash[e.value].name;
    		}else {
    			e.cellHtml = "";
    		}
            break;
        default:
            break;
    }
}
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    
    editor.validate();
    if (editor.isValid() == false) {
        showMsg("请输入数字!","W");
        e.cancel = true;
    }else {
        var newRow = {};
        if (e.field == "enterQty") {
            var enterQty = e.value;
            var enterPrice = record.enterPrice;
            var noTaxPrice = record.noTaxPrice;
            var taxPrice = record.taxPrice;
            var taxCostPrice = record.taxCostPrice;
            var expEnterPrice = record.expEnterPrice;
            var setCostPrice = record.setCostPrice;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                enterQty = 0;
            }else if(e.value < 0) {
                e.value = 0;
                enterQty = 0;
            }
            
            var enterAmt = enterQty * enterPrice;
            var noTaxAmt = enterQty * noTaxPrice; 
            var taxAmt = enterQty * taxPrice;   
            var taxCostAmt = enterQty * taxCostPrice;   
            var expEnterAmt = enterQty * expEnterPrice;   
            var setCostAmt = enterQty * setCostPrice;                    
                                
            newRow = { enterAmt: enterAmt, noTaxAmt: noTaxAmt, taxAmt: taxAmt,
            		taxCostAmt: taxCostAmt, expEnterAmt: expEnterAmt, setCostAmt: setCostAmt};
            rightGrid.updateRow(e.row, newRow);
            
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "enterPrice") {
            var enterQty = record.enterQty;
            var enterPrice = e.value;
            var taxSign = record.taxSign;
            var taxRate = record.taxRate;
            var noTaxPrice = 0;
            var taxPrice = 0;
            
            if (taxSign == 0) { //收据
                noTaxPrice = enterPrice;
                taxPrice = enterPrice * (1.0 + parseFloat(taxRate));
            } else {
                taxPrice = enterPrice;
                noTaxPrice = enterPrice / (1.0 + parseFloat(taxRate));
            }
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                enterPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                enterPrice = 0;
            }
            
            var enterAmt = enterQty * enterPrice;
            var noTaxAmt = enterQty * noTaxPrice; 
            var taxAmt = enterQty * taxPrice;  
                           
            newRow = { enterAmt: enterAmt, noTaxAmt: noTaxAmt, taxAmt: taxAmt, noTaxPrice: noTaxPrice, taxPrice: taxPrice};
            rightGrid.updateRow(e.row, newRow);
            
        }else if (e.field == "enterAmt") {
            var enterQty = record.enterQty;
            var enterAmt = e.value;
            var taxSign = record.taxSign;
            var taxRate = record.taxRate;
            var noTaxPrice = 0;
            var taxPrice = 0;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                enterAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                enterAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var enterPrice = enterAmt*1.0/enterQty;

            if (taxSign == 0) { //收据
                noTaxPrice = enterPrice;
                taxPrice = enterPrice * (1.0 + parseFloat(taxRate));
            } else {
                taxPrice = enterPrice;
                noTaxPrice = enterPrice / (1.0 + parseFloat(taxRate));
            }

            var noTaxAmt = enterQty * noTaxPrice; 
            var taxAmt = enterQty * taxPrice;  
                          
            if(enterQty) {
                newRow = { enterPrice: enterPrice, noTaxAmt: noTaxAmt, taxAmt: taxAmt, noTaxPrice: noTaxPrice, taxPrice: taxPrice};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }else if (e.field == "taxCostPrice") {
            var enterQty = record.enterQty;
            var taxCostPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                taxCostPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                taxCostPrice = 0;
            }
            
            var taxCostAmt = enterQty * taxCostPrice;    
                           
            newRow = { taxCostAmt: taxCostAmt};
            rightGrid.updateRow(e.row, newRow);
            
        }else if (e.field == "taxCostAmt") {
            var enterQty = record.enterQty;
            var taxCostAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                taxCostAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                taxCostAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var taxCostPrice = taxCostAmt*1.0/enterQty;
                          
            if(enterQty) {
                newRow = { taxCostPrice: taxCostPrice, taxCostAmt: taxCostAmt};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }else if (e.field == "noTaxCostPrice") {
            var enterQty = record.enterQty;
            var noTaxCostPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                noTaxCostPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                noTaxCostPrice = 0;
            }
            
            var noTaxCostAmt = enterQty * noTaxCostPrice;    
                           
            newRow = { noTaxCostAmt: noTaxCostAmt};
            rightGrid.updateRow(e.row, newRow);
            
        }else if (e.field == "noTaxCostAmt") {
            var enterQty = record.enterQty;
            var noTaxCostAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                noTaxCostAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                noTaxCostAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var noTaxCostPrice = noTaxCostAmt*1.0/enterQty;
                          
            if(enterQty) {
                newRow = { noTaxCostPrice: noTaxCostPrice, noTaxCostAmt: noTaxCostAmt};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }else if (e.field == "expEnterPrice") {
            var enterQty = record.enterQty;
            var expEnterPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                expEnterPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                expEnterPrice = 0;
            }
            
            var expEnterAmt = enterQty * expEnterPrice;    
                           
            newRow = { expEnterAmt: expEnterAmt};
            rightGrid.updateRow(e.row, newRow);
            
        }else if (e.field == "expEnterAmt") {
            var enterQty = record.enterQty;
            var expEnterAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                expEnterAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                expEnterAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var expEnterPrice = expEnterAmt*1.0/enterQty;
                          
            if(enterQty) {
                newRow = { expEnterPrice: expEnterPrice, expEnterAmt: expEnterAmt};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }else if (e.field == "setCostPrice") {
            var enterQty = record.enterQty;
            var setCostPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                setCostPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                setCostPrice = 0;
            }
            
            var setCostAmt = enterQty * setCostPrice;    
                           
            newRow = { setCostAmt: setCostAmt};
            rightGrid.updateRow(e.row, newRow);
            
        }else if (e.field == "setCostAmt") {
            var enterQty = record.enterQty;
            var setCostAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                setCostAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                setCostAmt = 0;
            }
            
            var setCostPrice = setCostAmt*1.0/enterQty;
                          
            if(enterQty) {
                newRow = { setCostPrice: setCostPrice, setCostAmt: setCostAmt};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }
    }
}
function selectPart(callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath +"/com.hsweb.cloud.part.common.partSelectView.flow?token="+token,//"com.hsweb.cloud.part.common.partSelectView.flow",
        title: "配件选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setCloudPartData("cloudPart",callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addEnterDetail(part)
{
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.common.detailQPAPopOperate.flow?token="+token,
        title: "入库数量金额", width: 430, height:230,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            part.storeId = nui.get("storeId").getValue();
            iframe.contentWindow.setData({
                part:part
            });
        },
        ondestroy: function (action)
        {
            if(action == "ok")
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
                var enterDetail = {};
                enterDetail.partId = data.id;
                enterDetail.comPartCode = data.code;
                enterDetail.comPartName = data.name;
                enterDetail.comPartBrandId = data.partBrandId;
                enterDetail.comApplyCarModel = data.applyCarModel;
                enterDetail.comUnit = data.unit;
                enterDetail.enterQty = data.qty;
                enterDetail.enterPrice = data.price;
                enterDetail.enterAmt = data.amt;
                enterDetail.remark = data.remark;
                enterDetail.storeId = data.storeId;
                enterDetail.comOemCode = data.oemCode;
                enterDetail.comSpec = data.spec;
                enterDetail.partCode = data.code;
                enterDetail.partName = data.name;
                enterDetail.fullName = data.fullName;
                enterDetail.systemUnitId = data.unit; 
                enterDetail.enterUnitId = data.unit;

                var taxSign = 0;
                var taxRate = 0.07;
                enterDetail.taxSign = taxSign;
                enterDetail.taxRate = taxRate;
                if (taxSign == 0) { //收据
                    enterDetail.noTaxAmt = data.amt;;
                    enterDetail.noTaxPrice = (data.qty > 0 ? data.amt / data.qty : 0);
                    enterDetail.enterPrice = (data.qty > 0 ? data.amt / data.qty : 0);
                    enterDetail.taxAmt = data.amt * (1.0 + parseFloat(taxRate));
                    enterDetail.taxPrice = data.qty > 0 ? (data.amt / data.qty) * (1.0 + parseFloat(taxRate)) : 0;
                } else {
                    enterDetail.taxAmt = data.amt;
                    enterDetail.taxPrice = (data.qty > 0 ? data.amt / data.qty : 0);
                    enterDetail.enterPrice = (data.qty > 0 ? data.amt / data.qty : 0);
                    enterDetail.noTaxAmt = data.amt / (1.0 + parseFloat(taxRate));
                    enterDetail.noTaxPrice = data.qty > 0 ? (data.amt / data.qty) / (1.0 + parseFloat(taxRate)) : 0;
                }

                rightGrid.addRow(enterDetail);
            }
        }
    });
}
function addPart() {

    var data = basicInfoForm.getData();
    if(data && data.auditSign && data.auditSign == 1){
        showMsg("此单已审核!","W");
        return;
    }

    selectPart(function(data) {
        var part = data.part;
        addEnterDetail(part);
    },function(data) {
        var part = data.part;
        var partid = part.id;
        var rtn = checkPartIDExists(partid);
        return rtn;
    });
}
function checkPartIDExists(partid){
    var row = rightGrid.findRow(function(row){
        if(row.partId == partid) {
            return true;
        }
        return false;
    });
    
    if(row) 
    {
        return "配件ID："+partid+"在盘盈订单列表中已经存在，是否继续？";
    }
    
    return null;
    
}
var editPartHash = {
};
function deletePart(){
    var data = basicInfoForm.getData();
    if(data && data.auditSign && data.auditSign == 1){
        showMsg("此单已审核!","W");
        return;
    }

    var part = rightGrid.getSelecteds();
    if(!part)
    {
        return;
    }
    rightGrid.removeRows(part,true);
}
function checkRightData()
{
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.enterQty){
            if(row.enterQty <= 0) return true;
        }else{
            return true;
        }
        // if(row.enterPrice){
        //     if(row.enterPrice <= 0) return true;
        // }else{
        //     return true;
        // }
        // if(row.enterAmt){
        //     if(row.enterAmt <= 0) return true;
        // }else{
        //     return true;
        // }
        
        if(row.storeId){
        }else{
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        msg = "请完善配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditQCEnter.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    if(data && data.auditSign && data.auditSign == 1){
        showMsg("此单已审核!","W");
        return;
    }

    data = getMainData();

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkRightData();
    if(msg){
        showMsg(msg,"W");
        return;
    }

    var enterDetailAdd = rightGrid.getChanges("added");
    var enterDetailUpdate = rightGrid.getChanges("modified");
    var enterDetailDelete = rightGrid.getChanges("removed");

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            enterMain : data,
            enterDetailAdd : enterDetailAdd,
            enterDetailUpdate : enterDetailUpdate,
            enterDetailDelete : enterDetailDelete,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                showMsg("审核成功!","S");
                //onLeftGridRowDblClick({});
                var pjEnterMainList = data.pjEnterMainList;
                if(pjEnterMainList && pjEnterMainList.length>0) {
                    var leftRow = pjEnterMainList[0];
                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
            } else {
                showMsg(data.errMsg || "审核失败!","W");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    setGuestInfo(params);
}
function open(){
    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.initPartStockSelect.flow?token="+token,
        title: "期初入库单选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData(function(data) {
                var part = data.part;
                initEnterData(part);
            });
        },
        ondestroy: function (action)
        {
        }
    });
}
function initEnterData(part){
    loadMainAndDetailInfo(part);
}
function importPart(){
    var data = basicInfoForm.getData();
    var storeId = data.storeId;
    if(storeId == null || storeId == ""){
        showMsg("请选择默认仓库!","W");
        return;
    }


    var formJsonThis = nui.encode(basicInfoForm.getData());
    var len = rightGrid.getData().length;

    if(formJson != formJsonThis)
    {
        showMsg("请先保存数据!","W");
        return;
    }

    nui.open({
        // targetWindow: window,
        url: webPath + contextPath + "/com.hsweb.cloud.part.basic.initPartStockImport.flow?token="+token,
        title: "库存导入", 
        width: 930, 
        height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.initData(data, storeId, brandList, qualityList, compBrandList);
        },
        ondestroy: function (action)
        {
            var mainId = data.id;
            loadRightGridData(mainId);
        }
    });
}

function onExport(){
	var detail = nui.clone(rightGrid.getData());
	//多级
	exportMultistage(rightGrid.columns);
	//单级
	//exportNoMultistage(rightGrid.columns);
	for(var i=0;i<detail.length;i++){
		if(compBrandHash[detail[i].orgCarBrandId]){
			detail[i].orgCarBrandId=compBrandHash[detail[i].orgCarBrandId].name;
		}
		if(brandHash[detail[i].comPartBrandId]){
			detail[i].comPartBrandId = brandHash[detail[i].comPartBrandId].name;
		}
		
		
	}
	if(detail && detail.length > 0){
		//多级表头类型
		setInitExportData(detail,rightGrid.columns,"入库明细");
		//单级表头类型 与上二选一
		//setInitExportDataNoMultistage( detail,rightGrid.columns,"入库明细");
	}
}