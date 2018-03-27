/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOutMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjSellOutDetailList.biz.ext";
var advancedSearchWin = null;
var advancedSearchForm = null;
var advancedSearchFormData = null;
var basicInfoForm = null;
var bottomInfoForm = null;
var leftGrid = null;
var rightGrid = null;
var formJson = null;
var brandHash = {};
var brandList = [];
var storehouse = null;

//单据状态
var AuditSignList = [
  {
      customid:'0',
      name:'未审'
  },
  {
      customid:'1',
      name:'已审'
  },
  {
      customid:'2',
      name:'已过账'
  },
  {
      customid:'3',
      name:'已取消'
  }
];
var AuditSignHash = {
  "0":"未审",
  "1":"已审",
  "2":"已过账",
  "3":"已取消"
};
var TaxSignHash = {
  "0":"否",
  "1":"是"
};
$(document).ready(function(v)
{
	leftGrid = nui.get("leftGrid");
    leftGrid.setUrl(leftGridUrl);

    rightGrid = nui.get("rightGrid");
    rightGrid.setUrl(rightGridUrl);
    advancedSearchWin = nui.get("advancedSearchWin");
    advancedSearchForm = new nui.Form("#advancedSearchWin");
    basicInfoForm = new nui.Form("#basicInfoForm");
    bottomInfoForm = new nui.Form("#bottomForm");

    //绑定表单
    //var db = new nui.DataBinding();
    //db.bindForm("basicInfoForm", leftGrid);
    getStorehouse(function(data)
    {
        storehouse = data.storehouse||[];
        nui.get("storeId").setData(storehouse);
    });

    getAllPartBrand(function(data) {
        brandList = data.brand;
        brandList.forEach(function(v) {
            brandHash[v.id] = v;
        });
    });

    quickSearch(0);
});
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
       bottomInfoForm.setData(row);
       //nui.get("guestId").setText(row.guestFullName);

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
        
       //序列化入库主表信息，保存时判断主表信息有没有修改，没有修改则不需要保存
       formJson = nui.encode(basicInfoForm.getData());

       //加载盘亏出库明细表信息
       var mainId = row.id;
       loadRightGridData(mainId);
   }else {
        //form.reset();
        //grid_details.clearRows();
   }
}
function onLeftGridSelectionChanged(){    
   var row = leftGrid.getSelected(); 
   
   loadMainAndDetailInfo(row);
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
function onLeftGridDrawCell(e)
{
    switch (e.field){
        case "auditSign":
            if(AuditSignHash && AuditSignHash[e.value])
            {
                e.cellHtml = AuditSignHash[e.value];
            }
            break;
    }
}
function onRightGridDrawCell(e)
{
    switch (e.field){
        case "taxSign":
            if(TaxSignHash && TaxSignHash[e.value])
            {
                e.cellHtml = TaxSignHash[e.value];
            }
            break;
        case "comPartBrandId":
            if(brandHash[e.value])
            {
                e.cellHtml = brandHash[e.value].name||"";
            }
            else{
                e.cellHtml = "";
            }
            break;
        case "stockOutQty":
            if(e.value > 0)
            {
                e.cellHtml = '<a style="color:red;">' + e.value + '</a>';
            }
            break;
        default:
            break;
    }
}
var currType = 2;
function quickSearch(type){
    var params = {};
    params.enterTypeId = '050203';
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            break;
        case 6:
            params.auditSign = 0;
            break;
        case 7:
            params.auditSign = 1;
            break;
        case 8:
            params.postStatus = 1;
            break;
        default:
        	params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            break;
    }
    currType = type;
    if($("a[id*='type']").length>0)
    {
        $("a[id*='type']").css("color","black");
    }
    if($("#type"+type).length>0)
    {
        $("#type"+type).css("color","blue");
    }
    doSearch(params);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    param.enterTypeId = '050203';
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
        //nui.get("editPartBtn").enable();
        nui.get("deletePartBtn").enable();
        nui.get("saveBtn").enable();
        nui.get("auditBtn").enable();
        nui.get("printBtn").enable();
    }
    else
    {
        nui.get("addPartBtn").disable();
        //nui.get("editPartBtn").disable();
        nui.get("deletePartBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
        nui.get("printBtn").disable();
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
	//目前没有区域盘亏出库，采退入库  params.enterTypeId = '050101';
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
function advancedSearch()
{
    advancedSearchWin.show();
//    advancedSearchForm.clear();
    if(advancedSearchFormData)
    {
        advancedSearchForm.setData(advancedSearchFormData);
    }
}
function onAdvancedSearchOk()
{
    var searchData = advancedSearchForm.getData();
    var i;
    //订货日期
    if(searchData.sOutDate)
    {
        searchData.sOutDate = searchData.sOutDate.substr(0,10);
    }
    if(searchData.eOutDate)
    {
        var date = searchData.eOutDate;
        searchData.eOutDate = addDate(date, 1);
        searchData.eOutDate = searchData.eOutDate.substr(0,10);
    }
    //创建日期
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = searchData.sCreateDate.substr(0,10);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        searchData.eCreateDate = searchData.eCreateDate.substr(0,10);
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = searchData.sAuditDate.substr(0,10);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        searchData.eAuditDate = searchData.eAuditDate.substr(0,10);
    }
    //供应商
    //盘亏单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i]+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
    advancedSearchWin.hide();
    doSearch(searchData);
}
function onAdvancedSearchCancel()
{
//    advancedSearchForm.clear();
    advancedSearchWin.hide();
}
function checkNew() 
{
    var rows = leftGrid.findRows(function(row){
        if(row.serviceId == "新盘亏出库") return true;
    });
    
    return rows.length;
}

function add()
{

    if(checkNew() > 0) 
    {
        nui.alert("请先保存数据！");
        return;
    }

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
    
    var newRow = { serviceId: '新盘亏出库', auditSign: 0};
    leftGrid.addRow(newRow, 0);
    leftGrid.clearSelect(false);
    leftGrid.select(newRow, false);
    
    nui.get("serviceId").setValue("新盘亏出库");
    nui.get("enterTypeId").setValue("050203");
    nui.get("taxRate").setValue(0.17);
    nui.get("taxSign").setValue(1);
    nui.get("outDate").setValue(new Date());
    
    //var guestId = nui.get("guestId");
    //guestId.focus();
}
function onBillTypeIdChanged(e) 
{
    var billTypeId = e.value;
    var taxSign = 0;
    var taxRate = 0;
    switch (billTypeId)
    {
        case '010101':
            taxSign = 0;
            taxRate = 0.07;
            break;
        case '010102':
            taxSign = 1;
            taxRate = 0.07;
            break;
        case '010103':
            taxSign = 1;
            taxRate = 0.17;
            break;
        default:
            taxSign = 0;
            taxRate = 0.07;
            break;
    }
    nui.get("taxRate").setValue(taxRate);
    nui.get("taxSign").setValue(taxSign);
    //税率改变后需要更新明细数据的含税价格和不含税价格
    //calcTaxPriceInfo(taxSign, taxRate);
}
function calcTaxPriceInfo(taxSign, taxRate)
{
    rightGrid.findRow(function(row){
        var sellQty = row.sellQty;
        var sellPrice = row.sellPrice;
        var sellAmt = row.sellAmt;
        var noTaxPrice = 0;
        var noTaxAmt = 0;
        var taxPrice = 0;
        var taxAmt = 0;

        if (taxSign == 0) { //收据
            noTaxAmt = sellAmt;
            noTaxPrice = (sellQty > 0 ? sellAmt / sellQty : 0);
            sellPrice = (sellQty > 0 ? sellAmt / sellQty : 0);
            taxAmt = sellAmt * (1.0 + parseFloat(taxRate));
            taxPrice = sellQty > 0 ? (sellAmt / sellQty) * (1.0 + parseFloat(taxRate)) : 0;
        } else {
            taxAmt = sellAmt;
            taxPrice = (sellQty > 0 ? sellAmt / sellQty : 0);
            sellPrice = (sellQty > 0 ? sellAmt / sellQty : 0);
            noTaxAmt = sellAmt / (1.0 + parseFloat(taxRate));
            noTaxPrice = sellQty > 0 ? (sellAmt / sellQty) / (1.0 + parseFloat(taxRate)) : 0;
        }

        var newRow = {sellPrice: sellPrice, noTaxAmt: noTaxAmt, noTaxPrice: noTaxPrice, 
                      taxAmt: taxAmt, taxPrice: taxPrice, taxSign: taxSign, taxRate: taxRate};
        rightGrid.updateRow(row, newRow);
    });
}
function removeChanges(added, modified, removed, all) {
    for(var i=0; i<added.length; i++) {
    
       var val = added[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<modified.length; i++) {
    
       var val = modified[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }
    
    for(var i=0; i<removed.length; i++) {
    
       var val = removed[i];
       for(var j=0; j<all.length; j++) {
        
           if(all[j] == val)
           all.splice(j, 1);
        }
    }

    return all;
}
function getMainData()
{
    var data = basicInfoForm.getData();
    //汇总明细数据到主表
    data.isFinished = 0;
    data.enterTypeId = '050203';
    data.guestId = 2;
    data.auditSign = 0;
    data.billStatusId = '';
    data.noTaxAmt = 0;
    data.notEnterAmt = 0;
    data.notEnterQty = 0;
    data.outAmt = 0;
    data.outItem = 0;
    data.outQty = 0;
    data.printTimes = 0;
    data.taxAmt = 0;
    data.taxDiff = 0;
    var list = rightGrid.getData();
    for(var i=0;i<list.length;i++)
    {
        var tmp = list[i];
        data.noTaxAmt += parseFloat(tmp.noTaxAmt);
        data.outAmt += parseFloat(tmp.sellAmt);
        data.outQty += parseFloat(tmp.sellQty);
        data.taxAmt += parseFloat(tmp.taxAmt);
    }
    data.taxDiff = data.taxAmt - data.noTaxAmt;

    if(data.operateDate) {
        data.operateDate = format(data.operateDate, 'yyyy-MM-dd HH:mm:ss') + '.0';//用于后台判断数据是否在其他地方已修改
    }

    return data;
}
var requiredField = {
	storeId : "仓库",
    orderMan: "盘点员",
    outDate : "盘点日期",
    taxRate : "开票税点"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjSellOut.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
			nui.alert(requiredField[key] + "不能为空!");
			return;
		}
	}

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已审核!");
            return;
        } 
    }else{
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

    var sellOutDetailAdd = rightGrid.getChanges("added");
    var sellOutDetailUpdate = rightGrid.getChanges("modified");
    var sellOutDetailDelete = rightGrid.getChanges("removed");
    var sellOutDetailList = rightGrid.getData();
    sellOutDetailList = removeChanges(sellOutDetailAdd, sellOutDetailUpdate, sellOutDetailDelete, sellOutDetailList);

    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '保存中...'
    });

	nui.ajax({
		url : saveUrl,
		type : "post",
		data : JSON.stringify({
			sellOutMain : data,
			sellOutDetailAdd : sellOutDetailAdd,
			sellOutDetailUpdate : sellOutDetailUpdate,
			sellOutDetailDelete : sellOutDetailDelete,
            sellOutDetailList : sellOutDetailList,
            token : token
		}),
		success : function(data) {
            nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				nui.alert("保存成功!");
				//onLeftGridRowDblClick({});
                var pjSellOutMainList = data.pjSellOutMainList;
                if(pjSellOutMainList && pjSellOutMainList.length>0) {
                    var leftRow = pjSellOutMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
			} else {
				nui.alert(data.errMsg || "保存失败!");
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
		}
	});
}
var supplier = null;	
//提交单元格编辑数据前激发
function onCellCommitEdit(e) {
    var editor = e.editor;
    var record = e.record;
    
    editor.validate();
    if (editor.isValid() == false) {
        nui.alert("请输入数字！");
        e.cancel = true;
    }else {
        var newRow = {};
        if (e.field == "sellQty") {
            var sellQty = e.value;
            var sellPrice = record.sellPrice;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                sellQty = 0;
            }else if(e.value < 0) {
                e.value = 0;
                sellQty = 0;
            }
            
            var sellAmt = sellQty * sellPrice || 0;                   
                                
            newRow = { sellAmt: sellAmt};
            rightGrid.updateRow(e.row, newRow);
            
            //record.enteramt.cellHtml = enterqty * enterprice;
        }else if (e.field == "sellPrice") {
            var sellQty = record.sellQty;
            var sellPrice = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                sellPrice = 0;
            }else if(e.value < 0) {
                e.value = 0;
                sellPrice = 0;
            }
            
            var sellAmt = sellQty * sellPrice || 0; 
                           
            newRow = { sellAmt: sellAmt};
            rightGrid.updateRow(e.row, newRow);
            
        }else if (e.field == "sellAmt") {
            var sellQty = record.sellQty;
            var sellAmt = e.value;
            
            if(e.value==null || e.value=='') {
                e.value = 0;
                sellAmt = 0;
            }else if(e.value < 0) {
                e.value = 0;
                sellAmt = 0;
            }
            
            //e.cellHtml = enterqty * enterprice;
            var sellPrice = sellAmt*1.0/sellQty || 0;
                          
            if(sellQty) {
                newRow = { sellPrice: sellPrice};
                rightGrid.updateRow(e.row, newRow);
            }
            
        }
    }
}
function selectPart(callback,checkcallback)
{
    /*nui.open({
        targetWindow: window,
        url: "com.hsweb.cloud.part.common.partSelectView.flow",
        title: "配件选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            iframe.contentWindow.setData({},callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });*/
    nui.open({
        targetWindow: window,
        url: "com.hsweb.cloud.part.common.outableEnterSelect.flow",
        title: "入库记录选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {
                storeId: nui.get("storeId").getValue()
            };
            iframe.contentWindow.setData(data,callback,checkcallback);
        },
        ondestroy: function (action)
        {
        }
    });
}
function addSellOutDetail(part)
{
    nui.open({
        targetWindow: window,
        url: "com.hsweb.cloud.part.common.detailQPAPopOperate.flow",
        title: "入库数量金额", width: 430, height:210,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            part.storeId = nui.get("storeId").getValue();
            part.unit = part.enterUnitId;

            part.detailId = part.id;
            part.id = part.partId;
            part.code = part.partCode;
            part.oemCode = part.oemCode;
            part.partBrandId = part.partBrandId;
            part.applyCarModel = part.carModelName;
            part.spec = part.spec;
            part.rootId = part.rootId;
            part.sourceId = part.sourceId;
            part.taxSign = part.taxSign;
            part.taxRate = part.taxRate;
            part.taxPrice = part.taxPrice;
            part.noTaxPrice = part.noTaxPrice;
            part.enterPrice = part.enterPrice;

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
                var outDetail = {};
                outDetail.partId = data.id;
                outDetail.comPartCode = data.code;
                outDetail.comPartName = data.name;
                outDetail.comPartBrandId = data.partBrandId;
                outDetail.comApplyCarModel = data.applyCarModel;
                outDetail.comUnit = data.unit;

                outDetail.sellQty = data.qty;
                outDetail.sellPrice = data.price;
                outDetail.sellAmt = data.amt;
                outDetail.remark = data.remark;
                outDetail.storeId = data.storeId;
                outDetail.sourceId = data.detailId;
                outDetail.rootId = data.rootId == 0 ? data.detailId : data.rootId;
                outDetail.taxSign = data.taxSign;
                outDetail.taxRate = data.taxRate;
                outDetail.noTaxPrice = data.noTaxPrice;
                outDetail.noTaxAmt = data.qty * data.noTaxPrice;
                outDetail.taxPrice = data.taxPrice;
                outDetail.taxAmt = data.qty * data.taxPrice;
                outDetail.enterPrice = data.enterPrice;
                outDetail.enterAmt = data.qty * data.enterPrice;
                outDetail.taxDiff = outDetail.taxAmt - outDetail.noTaxAmt;

                outDetail.comOemCode = data.oemCode;
                outDetail.comSpec = data.spec;
                outDetail.partCode = data.code;
                outDetail.partName = data.name;
                outDetail.fullName = data.fullName;
                outDetail.systemUnitId = data.unit; 
                outDetail.outUnitId = data.unit;

                rightGrid.addRow(outDetail);
            }
        }
    });
}
function addPart() {
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

	selectPart(function(data) {
		var part = data.part;
		addSellOutDetail(part);
	},function(data) {
        var part = data.part;
        var partid = part.partId;
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
        return "配件ID："+partid+"在盘亏出库列表中已经存在，是否继续？";
    }
    
    return null;
    
}
var editPartHash = {
};
function deletePart(){
    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            return;
        } 
    }

    var part = rightGrid.getSelected();
    if(!part)
    {
        return;
    }
    if(part.detailId && editPartHash[part.detailId])
    {
        delete editPartHash[part.detailId];
    }
    rightGrid.removeRow(part,true);
}
function checkRightData()
{
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.sellQty){
            if(row.sellQty <= 0) return true;
        }else{
            return true;
        }
        if(row.sellPrice){
            if(row.sellPrice <= 0) return true;
        }else{
            return true;
        }
        if(row.sellAmt){
            if(row.sellAmt <= 0) return true;
        }else{
            return true;
        }
        
        if(row.storeId){
        }else{
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        msg = "请完善盘亏配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
function checkStockOutQty(){
    var msg = '';
    var rows = rightGrid.findRows(function(row){
        if(row.stockOutQty > 0){
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        var comPartCode = rows[0].comPartCode;
        msg = "配件：" + comPartCode + "缺货，不能审核！";
    }
    return msg;
}
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjSellOut.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            nui.alert(requiredField[key] + "不能为空!");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            nui.alert("此单已审核!");
            return;
        } 
    }else{
        return;
    }

    //审核时，数量，单价，金额，仓库不能为空
    var msg = checkStockOutQty();
    if(msg){
        nui.alert(msg);
        return;
    }
    //审核时，判断是否存在缺货信息
    var msg = checkRightData();
    if(msg){
        nui.alert(msg);
        return;
    }

    data = getMainData();

    var sellOutDetailAdd = rightGrid.getChanges("added");
    var sellOutDetailUpdate = rightGrid.getChanges("modified");
    var sellOutDetailDelete = rightGrid.getChanges("removed");
    var sellOutDetailList = rightGrid.getData();
    if(sellOutDetailList.length <= 0) {
        nui.alert("盘亏明细为空，不能审核！");
        return;
    }
    sellOutDetailList = removeChanges(sellOutDetailAdd, sellOutDetailUpdate, sellOutDetailDelete, sellOutDetailList);


    nui.mask({
        el: document.body,
        cls: 'mini-mask-loading',
        html: '审核中...'
    });

    nui.ajax({
        url : auditUrl,
        type : "post",
        data : JSON.stringify({
            sellOutMain : data,
            sellOutDetailAdd : sellOutDetailAdd,
            sellOutDetailUpdate : sellOutDetailUpdate,
            sellOutDetailDelete : sellOutDetailDelete,
            sellOutDetailList : sellOutDetailList,
            token : token
        }),
        success : function(data) {
            nui.unmask(document.body);
            data = data || {};
            if (data.errCode == "S") {
                nui.alert("审核成功!");
                //onLeftGridRowDblClick({});
                var pjSellOutMainList = data.pjSellOutMainList;
                if(pjSellOutMainList && pjSellOutMainList.length>0) {
                    var leftRow = pjSellOutMainList[0];
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

                    //保存成功后重新加载数据
                    loadMainAndDetailInfo(leftRow);
                }
            } else {
                nui.alert(data.errMsg || "审核失败!");
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            // nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onDrawSummaryCell(e)
{
    var rows = e.data;//rightGrid.getData();
    if (e.field == "sellAmt") { 
        var sellAmt = 0;
        for (var i = 0; i < rows.length; i++) {
            sellAmt += parseFloat(rows[i].sellAmt);
        }
        nui.get("outAmt").setValue(sellAmt);
    }
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    setGuestInfo(params);
}
var getGuestInfo = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";