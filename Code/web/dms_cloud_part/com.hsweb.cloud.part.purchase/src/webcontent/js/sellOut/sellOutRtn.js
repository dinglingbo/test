/**
 * Created by Administrator on 2018/2/23.
 */
var baseUrl = apiPath + cloudPartApi + "/";//window._rootUrl||"http://127.0.0.1:8080/default/";
var leftGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterMainList.biz.ext";
var rightGridUrl = baseUrl+"com.hsapi.cloud.part.invoicing.svr.queryPjEnterDetailList.biz.ext";
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
var gsparams = {};
var sEnterDate = null;
var eEnterDate = null;

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

    gsparams.startDate = getNowStartDate();
    gsparams.endDate = addDate(getNowEndDate(), 1);
    gsparams.auditSign = 0;

    sEnterDate = nui.get("sEnterDate");
    eEnterDate = nui.get("eEnterDate");

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

    document.onkeyup=function(event){
        var e=event||window.event;
        var keyCode=e.keyCode||e.which;
      
        if((keyCode==78)&&(event.altKey))  {  //新建
            add();  
        } 
      
        if((keyCode==83)&&(event.altKey))  {   //保存
            save();
        } 
      
        if((keyCode==80)&&(event.altKey))  {   //打印
            onPrint();
        } 
     
    }

    gsparams.auditSign = 0;
    quickSearch(0);
});
function loadMainAndDetailInfo(row)
{
    if(row) {    
       basicInfoForm.setData(row);
       bottomInfoForm.setData(row);
       nui.get("guestId").setText(row.guestFullName);

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

       //加载销售退货明细表信息
       var mainId = row.id;
       loadRightGridData(mainId);
   }else {
        //form.reset();
        //grid_details.clearRows();
   }
}
function onLeftGridBeforeDeselect(e)
{
    var row = leftGrid.getSelected(); 
    if(row.serviceId == '新销售退货'){

        leftGrid.removeRow(row);
    }
}
function onLeftGridSelectionChanged(e)
{    
   var row = leftGrid.getSelected(); 
   
   if(row){
        loadMainAndDetailInfo(row);
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
var currType = 2;
function quickSearch(type){
    var params = {};
    params.enterTypeId = '050102';
    var querysign = 1;
    var queryname = "本日";
    var querytypename = "未审";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            querysign = 1;
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            querysign = 1;
            gsparams.startDate = getPrevStartDate();
            gsparams.endDate = addDate(getPrevEndDate(), 1);
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            querysign = 1;
            gsparams.startDate = getWeekStartDate();
            gsparams.endDate = addDate(getWeekEndDate(), 1);
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            querysign = 1;
            gsparams.startDate = getLastWeekStartDate();
            gsparams.endDate = addDate(getLastWeekEndDate(), 1);
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            querysign = 1;
            gsparams.startDate = getMonthStartDate();
            gsparams.endDate = addDate(getMonthEndDate(), 1);
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            querysign = 1;
            gsparams.startDate = getLastMonthStartDate();
            gsparams.endDate = addDate(getLastMonthEndDate(), 1);
            break;
        case 6:
            params.auditSign = 0;
            querysign = 2;
            gsparams.auditSign = 0;
            break;
        case 7:
            params.auditSign = 1;
            querysign = 2;
            gsparams.auditSign = 1;
            break;
        case 8:
            params.postStatus = 1;
        case 9:
            querytypename = "全部";
            querysign = 2;
            gsparams.auditSign = null;
            break;
        default:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querytypename = "未审";
            gsparams.startDate = getNowStartDate();
            gsparams.endDate = addDate(getNowEndDate(), 1);
            gsparams.auditSign = 0;
            break;
    }
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);
    }else if(querysign == 2){
            var menunametype = nui.get("menunametype");
            menunametype.setText(querytypename);
    }
    doSearch(gsparams);
    doSearch(params);
}
function onSearch(){
    search();
}
function search()
{
    var param = getSearchParam();
    param.enterTypeId = '050102';
    doSearch(param);
}
function getSearchParam(){
	var params = {};
    params = gsparams;
    params.guestId = nui.get("searchGuestId").getValue();
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
        nui.get("selectSupplierBtn").enable();
    }
    else
    {
        nui.get("addPartBtn").disable();
        //nui.get("editPartBtn").disable();
        nui.get("deletePartBtn").disable();
        nui.get("saveBtn").disable();
        nui.get("auditBtn").disable();
        nui.get("printBtn").disable();
        nui.get("selectSupplierBtn").disable();
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
    params.enterTypeId = '050102';
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
    searchData.enterTypeId = '050102';
    //订货日期
    if(searchData.sEnterDate)
    {
        searchData.sEnterDate = searchData.sEnterDate.substr(0,10);
    }
    if(searchData.eEnterDate)
    {
        var date = searchData.eEnterDate;
        searchData.eEnterDate = addDate(date, 1);
        searchData.eEnterDate = searchData.eEnterDate.substr(0,10);
    }
    //创建日期
    if(searchData.sCreateDate)
    {
        searchData.sCreateDate = formatDate(searchData.sCreateDate);
    }
    if(searchData.eCreateDate)
    {
        var date = searchData.eCreateDate;
        searchData.eCreateDate = addDate(date, 1);
        
    }
    //审核日期
    if(searchData.sAuditDate)
    {
        searchData.sAuditDate = formatDate(searchData.sAuditDate);
    }
    if(searchData.eAuditDate)
    {
        var date = searchData.eAuditDate;
        searchData.eAuditDate = addDate(date, 1);
        
    }
    //供应商
    if(searchData.guestId)
    {
        params.guestId = nui.get("guestId").getValue();
    }
    //销售退货单号
    if(searchData.serviceIdList)
    {
        var tmpList = searchData.serviceIdList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/\s+/g, "")+"'";
        }
        searchData.serviceIdList = tmpList.join(",");
    }
    //配件编码
    if(searchData.partCodeList)
    {
        var tmpList = searchData.partCodeList.split("\n");
        for(i=0;i<tmpList.length;i++)
        {
            tmpList[i] = "'"+tmpList[i].replace(/(^\s*)|(\s*$)/g, "")+"'";
        }
        searchData.partCodeList = tmpList.join(",");
    }
  //去除空格
    for(var key in searchData){
    	if(searchData[key]!=null && searchData[key]!="" && typeof(searchData[key])=='string'){    		
    		searchData[key]=searchData[key].replace(/\s+/g, "");
    	}
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
        if(row.serviceId == "新销售退货") return true;
    });
    
    return rows.length;
}

function add()
{

    if(checkNew() > 0) 
    {
        showMsg("请先保存数据!","W");
        return;
    }

    var formJsonThis = nui.encode(basicInfoForm.getData());
    var len = rightGrid.getData().length;

    if(formJson != formJsonThis && len > 0)
    {
        nui.confirm("您正在编辑数据,是否要继续?", "友情提示",
            function (action) { 
                if (action == "ok") {

                    setBtnable(true);
                    setEditable(true);

                    basicInfoForm.reset();
                    rightGrid.clearRows();
                    
                    var newRow = { serviceId: '新销售退货', auditSign: 0};
                    leftGrid.addRow(newRow, 0);
                    leftGrid.clearSelect(false);
                    leftGrid.select(newRow, false);
                    
                    nui.get("serviceId").setValue("新销售退货");
                    nui.get("enterTypeId").setValue("050102");
                    nui.get("enterDate").setValue(new Date());
                    
                    var guestId = nui.get("guestId");
                    guestId.focus();

                }else {
                    return;
                }
            }
        );
    }else{
        setBtnable(true);
        setEditable(true);

        basicInfoForm.reset();
        rightGrid.clearRows();
        
        var newRow = { serviceId: '新销售退货', auditSign: 0};
        leftGrid.addRow(newRow, 0);
        leftGrid.clearSelect(false);
        leftGrid.select(newRow, false);
        
        nui.get("serviceId").setValue("新销售退货");
        nui.get("enterTypeId").setValue("050102");
        nui.get("enterDate").setValue(new Date());
        
        var guestId = nui.get("guestId");
        guestId.focus();
    }

    
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
    calcTaxPriceInfo(taxSign, taxRate);
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
    data.enterTypeId = '050102';
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
    guestId : "客户",
	storeId : "仓库",
    enterDate : "退货日期"
};
var saveUrl = baseUrl + "com.hsapi.cloud.part.invoicing.crud.savePjEnter.biz.ext";
function save() {
	var data = basicInfoForm.getData();
	for ( var key in requiredField) {
		if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
			return;
		}
	}

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已审核!","W");
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
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

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
function selectSupplier(elId)
{
	supplier = null;
    nui.open({
        // targetWindow: window,
        url: webPath+contextPath+"/com.hsweb.cloud.part.common.customerSelect.flow",
        title: "客户资料", width: 980, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var params = {
                isSupplier: 0,
                isClient: 1
            };
            //iframe.contentWindow.setData(params);
        },
        ondestroy: function (action)
        {
        	if(action == 'ok')
            {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();
               
                supplier = data.customer;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);

                if(elId == 'guestId') {
                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);
                }
            }
        }
    });
}
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
                                
            newRow = { enterAmt: enterAmt, noTaxAmt: noTaxAmt, taxAmt: taxAmt};
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
            
        }
    }
}
function selectPart(callback,checkcallback)
{
    nui.open({
        // targetWindow: window,
        url: "http://127.0.0.1:8080/default/com.hsweb.cloud.part.common.rtnableOutSelect.flow",
        title: "出库记录选择", width: 930, height: 560,
        allowDrag:true,
        allowResize:true,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            var data = {
                storeId: nui.get("storeId").getValue(),
                guestId: nui.get("guestId").getValue()
            };
            iframe.contentWindow.setData(data,callback,checkcallback);
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
        url: "com.hsweb.cloud.part.common.detailQPAPopOperate.flow",
        title: "退货数量金额", width: 430, height:230,
        allowDrag:true,
        allowResize:false,
        onload: function ()
        {
            var iframe = this.getIFrameEl();
            part.storeId = part.storeId;
            part.unit = part.outUnitId;

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
            part.price = part.sellPrice;
            part.qty = part.rtnableQty;
            part.amt = part.sellPrice * part.rtnableQty;
            part.enterDate = part.enterDate;
            part.editType = 'storeId';
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
                enterDetail.sourceId = data.detailId;
                enterDetail.rootId = data.rootId == 0 ? data.detailId : data.rootId;
                enterDetail.comOemCode = data.oemCode;
                enterDetail.comSpec = data.spec;
                enterDetail.partCode = data.code;
                enterDetail.partName = data.name;
                enterDetail.fullName = data.fullName;
                enterDetail.systemUnitId = data.unit; 
                enterDetail.enterUnitId = data.unit;
                enterDetail.enterDate = format(data.enterDate, 'yyyy-MM-dd HH:mm:ss');
                enterDetail.originId = data.originId;
                enterDetail.originGuestId = data.originGuestId;

                var taxSign = data.taxSign;
                var taxRate = data.taxRate;
                enterDetail.taxSign = taxSign;
                enterDetail.taxRate = taxRate;
                
                enterDetail.noTaxAmt = data.qty * data.noTaxPrice;
                enterDetail.noTaxPrice = data.noTaxPrice;
                enterDetail.enterPrice = data.enterPrice;
                enterDetail.taxAmt = data.taxPrice * data.qty;
                enterDetail.taxPrice = data.taxPrice;
                enterDetail.rtnPrice = data.price;
                enterDetail.rtnAmt = data.amt;
           

                rightGrid.addRow(enterDetail);
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

    var guestId = nui.get("guestId").getValue();
    if(!guestId) {
        showMsg("请选择客户!","W");
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
        return "配件编码："+row.comPartCode+"在销售退货列表中已经存在，是否继续？";
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
        if(row.enterQty){
            if(row.enterQty <= 0) return true;
        }else{
            return true;
        }
        if(row.enterPrice){
            if(row.enterPrice <= 0) return true;
        }else{
            return true;
        }
        if(row.enterAmt){
            if(row.enterAmt <= 0) return true;
        }else{
            return true;
        }
        
        if(row.storeId){
        }else{
            return true;
        }
    });
    
    if(rows && rows.length > 0){
        msg = "请完善退货配件的数量，单价，金额，仓库等信息！";
    }
    return msg;
}
var auditUrl = baseUrl+"com.hsapi.cloud.part.invoicing.crud.auditPjEnter.biz.ext";
function audit()
{
    var data = basicInfoForm.getData();
    for ( var key in requiredField) {
        if (!data[key] || $.trim(data[key]).length == 0) {
            showMsg(requiredField[key] + "不能为空!","W");
            return;
        }
    }

    var row = leftGrid.getSelected();
    if(row){
        if(row.auditSign == 1) {
            showMsg("此单已审核!","W");
            return;
        } 
    }else{
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
                    var row = leftGrid.getSelected();
                    leftGrid.updateRow(row,leftRow);

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
function onDrawSummaryCell(e)
{
    var rows = e.data;//rightGrid.getData();
    if (e.field == "enterAmt") { 
        var enterAmt = 0;
        for (var i = 0; i < rows.length; i++) {
            enterAmt += parseFloat(rows[i].enterAmt);
        }
        nui.get("enterAmt").setValue(enterAmt);
    }
}
function onGuestValueChanged(e)
{
    //供应商中直接输入名称加载供应商信息
    var params = {};
    params.pny = e.value;
    params.isClient = 1;
    setGuestInfo(params);
}
var getGuestInfo = baseUrl+"com.hsapi.cloud.part.baseDataCrud.crud.querySupplierList.biz.ext";
function setGuestInfo(params)
{
    nui.ajax({
        url:getGuestInfo,
        data: {params: params, token: token},
        type:"post",
        success:function(text)
        {
            if(text)
            {
                var supplier = text.suppliers;
                if(supplier && supplier.length>0) {
                    var data = supplier[0];
                    var value = data.id;
                    var text = data.fullName;
                    var el = nui.get('guestId');
                    el.setValue(value);
                    el.setText(text);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: text};
                    leftGrid.updateRow(row,newRow);
                }
                else
                {
                    var el = nui.get('guestId');
                    el.setValue(null);
                    el.setText(null);

                    var row = leftGrid.getSelected();
                    var newRow = {guestFullName: null};
                    leftGrid.updateRow(row,newRow);
                }
            }
            else
            {
                var el = nui.get('guestId');
                el.setValue(null);
                el.setText(null);

                var row = leftGrid.getSelected();
                var newRow = {guestFullName: null};
                leftGrid.updateRow(row,newRow);
            }


        },
        error:function(jqXHR, textStatus, errorThrown){
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
function onPrint() {
    var row = leftGrid.getSelected();
    if (row) {

        nui.open({

            url : "com.hsweb.cloud.part.purchase.sellOutRtnPrint.flow?ID="
                    + row.id,// "view_Guest.jsp",
            title : "销售退货打印",
            width : 900,
            height : 600,
            onload : function() {
                var iframe = this.getIFrameEl();
                // iframe.contentWindow.setInitData(storeId, 'XSD');
            }
        });
    }

}