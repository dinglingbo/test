/**
 * Created by Administrator on 2018/5/5.
 */
var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + frmApi + "/";//window._rootUrl || "http://127.0.0.1:8080/default/";
var queryUrl = baseUrl + "com.hsapi.frm.frmService.finance.queryRPAccountDetail.biz.ext";
var mainGrid = null;
var accountIdEl = null;
var beginDateEl = null;
var endDateEl = null;
var isMainEl = null;
var advanceGuestIdEl = null;
var accountList = null;
var accountHash = {};
var enterTypeIdList = [];
var enterTypeIdHash = {};
var pList = [];
var pHash = {};
var orgidsEl = null;
var statusList = [{id:"0",name:"车牌号"},{id:"1",name:"业务单号"}];
var type=0;
var typeRela = [];//用于结算方式
$(document).ready(function(v) {
	mainGrid = nui.get("mainGrid");
	mainGrid.setUrl(queryUrl);

	accountIdEl = nui.get("accountId");
	beginDateEl = nui.get("beginDate");
	endDateEl = nui.get("endDate");
    advanceGuestIdEl = nui.get("advanceGuestId");
    isMainEl = nui.get("isMain");

	beginDateEl.setValue(getMonthStartDate());
	endDateEl.setValue(addDate(getMonthEndDate(), 1));

    //判断是否有兼职门店,是否显示门店选择框
    orgidsEl = nui.get("orgids");
    orgidsEl.setData(currOrgList);
    if(currOrgList.length==1){
    	orgidsEl.hide();
    }else{
    	orgidsEl.setValue(currOrgid);
    }
    
	getAccountList(function(data) {
        accountList = data.settleAccount;
        accountIdEl.setData(accountList);
        accountList.forEach(function(v) {
            accountHash[v.id] = v;
        });
    });

    getItemType(function(data) {
        enterTypeIdList = data.list || [];
        enterTypeIdList.filter(function(v){
            enterTypeIdHash[v.id] = v;
        });

    });
    
    var filter = new HeaderFilter(mainGrid, {  
        columns: [
            { name: 'auditor' },
             {name:'shortName'},
            { name: 'billServiceId' },
            { name: 'billTypeId' },
            { name: 'settAccountName' },
            { name: 'balaTypeCode' },
            {name:'carNo'}
        ],
        callback: function (column, filtered) {
        },
        tranCallBack: function (field) {
        	var value = null;
        	switch(field){
    		case "billTypeId" :
    			var arr = [];
    			for (var i in enterTypeIdHash) {
    			    var o = {};
    			    o.name = enterTypeIdHash[i].name;
    			    o.id = enterTypeIdHash[i].id;
    			    arr.push(o);
    			}
    			value = arr;
    			break;
    		case "balaTypeCode" :
    			var arr = [];
    			for (var i in typeRela) {
    			    var o = {};
    			    o.name = typeRela[i].customName;
    			    o.id = typeRela[i].customId;
    			    arr.push(o);
    			}
    			value = arr;
    			break;    			
	    		default:
	                break;
	    	}
        	return value;
        }
    });

	quickSearch(2);
	queryTypeRela();//查询付款方式
});

function quickSearch(type){
	var params = getSearchParam();
    var querysign = 1;
    var queryname = "本日";
    switch (type)
    {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            querysign = 1;
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            querysign = 1;
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            querysign = 1;
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            querysign = 1;
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            querysign = 1;
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            querysign = 1;
            queryname = "上月";
            break;
        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            querysign = 1;
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            querysign = 1;
            queryname = "上年";
            break;      
        default:
            break;
    }
    beginDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate,-1));
    currType = type;
    if(querysign == 1){
        var menunamedate = nui.get("menunamedate");
        menunamedate.setText(queryname);    
    }
    doSearch(params);
}
function getSearchParam(){
	var params = {};
	params.settAccountId = accountIdEl.getValue();
	params.startDate = beginDateEl.getFormValue();
    params.endDate = addDate(endDateEl.getValue(),1);
    params.guestId = advanceGuestIdEl.getValue();
    params.isMain = isMainEl.getValue();
    params.rpDc = 1;
    var orgidsElValue = orgidsEl.getValue();
    if(orgidsElValue==null||orgidsElValue==""){
    	 params.orgids =  currOrgs;
    }else{
    	params.orgid=orgidsElValue;
    }
    var type = nui.get("search-type").getValue();
    var typeValue = nui.get("carNo-search").getValue();
    if(type==0){
        params.carNo = typeValue;
    }else if(type==1){
        params.billServiceId = typeValue;
    }
    return params;
}

function onSearch(){
	var params=getSearchParam();
	doSearch(params);
}
function doSearch(params) {
	mainGrid.load({
		params:params,
		token : token
	});
}
var queryAccountUrl = baseUrl + "com.hsapi.frm.frmService.crud.queryFiSettleAccount.biz.ext";
function getAccountList(callback) {
    nui.ajax({
        url : queryAccountUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.settleAccount) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}
var supplier = null;
function selectSupplier(elId) {
    supplier = null;
    nui.open({
        targetWindow : window,
        url : webPath+contextPath+"/com.hsweb.part.common.guestSelect.flow?token="+token,
        title : "客户资料",
        width : 980,
        height : 560,
        allowDrag : true,
        allowResize : true,
        onload : function() {
            var iframe = this.getIFrameEl();
            var params = {
                isClient: 1
            };
            iframe.contentWindow.setGuestData(params);
        },
        ondestroy : function(action) {
            if (action == 'ok') {
                var iframe = this.getIFrameEl();
                var data = iframe.contentWindow.getData();

                supplier = data.supplier;
                var value = supplier.id;
                var text = supplier.fullName;
                var el = nui.get(elId);
                el.setValue(value);
                el.setText(text);
                onSearch();
            }
        }
    });
}
var pList = [{id:1,text:"是"},{id:0,text:"否"}];
var pHash = {"1":"是","0":"否"};
function onDrawCell(e){
    switch (e.field) {
        case "settAccountId":
            if (accountHash[e.value]) {
                if(e.column.header == "账户编码"){
                    e.cellHtml = accountHash[e.value].code || "";
                }else if(e.column.header == "账户名称"){
                    e.cellHtml = accountHash[e.value].name || "";
                }else{
                    e.cellHtml = "";
                }
            } else {
                e.cellHtml = "";
            }
            break;
        case "billTypeId":
            if(enterTypeIdHash && enterTypeIdHash[e.value])
            {
                e.cellHtml = enterTypeIdHash[e.value].name;
            } else {
                e.cellHtml = "";
            }
            break;
        case "isPrimaryBusiness":
            if(pHash && pHash[e.value])
            {
                e.cellHtml = pHash[e.value];
            } else {
                e.cellHtml = "";
            }
            break;
        case "orgid":
        	for(var i=0;i<currOrgList.length;i++){
        		if(currOrgList[i].orgid==e.value){
        			e.cellHtml = currOrgList[i].shortName;
        		}
        	}
        	
            break;
        case "balaTypeCode":
        	for(var i=0;i<typeRela.length;i++){
        		if(typeRela[i].customId==e.value){
        			e.cellHtml = typeRela[i].customName;
        		}
        	}
        	
            break;            

        default:
            break;
    }
}
var typeUrl = baseUrl
        + "com.hsapi.frm.frmService.crud.queryFibInComeExpenses.biz.ext";
function getItemType(callback) {
    nui.ajax({
        url : typeUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if (data && data.list) {
                callback && callback(data);
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}

function openOrderDetail(){
	var row = mainGrid.getSelected();
	if(row){
		if(row.billTypeId==103||row.billTypeId==106||row.billTypeId==108){		
			var data={};
			data.id=row.billMainId;

			if(data.id){
				var item={};
				item.id = "11111";
			    item.text = "应收详情页";
				item.url =webBaseUrl+  "com.hsweb.repair.DataBase.orderDetail.flow?sourceServiceId="+data.id;
				item.iconCls = "fa fa-cog";
				window.parent.activeTabAndInit(item,data);
			}	
		}else{
		showMsg("无详情！","W");
		}
	}else{
		showMsg("请选择单据!", "W");
		return;
	}

}
function print(){
	var msg = checkSettleRow();
	if (msg) {
		showMsg(msg, "W");
		return;
	}
	var rows = mainGrid.getSelecteds();
	var sourceUrl = webPath + contextPath + "/com.hsweb.print.closedmentPrint.flow?token="+token;
	var printName = currOrgName;
	var p = {
		comp : printName,
		partApiUrl:apiPath + partApi + "/",
		frmApiUrl:apiPath + frmApi + "/",
		baseUrl: apiPath + repairApi + "/",
		sysUrl: apiPath + sysApi + "/",
		webUrl:webPath + contextPath + "/",
        bankName: currBankName,
        bankAccountNumber: currBankAccountNumber,
        currCompAddress: currCompAddress,
        currCompTel: currCompTel,
        currSlogan1: currSlogan1,
        currSlogan2: currSlogan2,
        currUserName : currUserName,
        currCompLogoPath: currCompLogoPath,
		token : token
	};
	var businessNumber = "";
	var netInAmt =0;
	for(var i = 0;i<rows.length;i++){
		rows[i].guestName = rows[i].fullName;//打印界面用的是guestName
		if(i==rows.length-1){
			businessNumber = businessNumber+rows[i].billServiceId
			netInAmt = parseFloat(netInAmt)+parseFloat(rows[i].charOffAmt);
			netInAmt = netInAmt.toFixed(2);
			
		}else{
			businessNumber = businessNumber+rows[i].billServiceId+","
			netInAmt = parseFloat(netInAmt)+parseFloat(rows[i].charOffAmt);
			netInAmt = netInAmt.toFixed(2)
		}
		
	}
	//var guestData = [{guestName:rows[0].fullName}]
	params = {
		guestData:rows,
		businessNumber :businessNumber,
		billServiceId : rows[0].billServiceId,
		netInAmt:netInAmt,
		p:p
	};


	nui.open({
        url: sourceUrl,
        title:"打印收款证明单",
		width: "100%",
		height: "100%",
        onload: function () {
            var iframe = this.getIFrameEl();
           iframe.contentWindow.SetData(params);
        },
        ondestroy: function (action){
        }
    });
}

function checkSettleRow() {
	var guestId = null;
	var rows = mainGrid.getSelecteds();
	var msg = "";
	var s = rows.length;

	if (s > 0) {
		for (var i = 0; i < s; i++) {			
			var row = rows[i];
			if (i == 0) {
				firstRow = row;
				guestId = firstRow.guestId;
			} else {
				var rowGuestId = row.guestId;
				if (guestId != rowGuestId) {
					return "请选择相同结算单位的单据!";
				}
			}
		}

	} else {
		msg = "请选择单据!";
	}

	return msg;
}
//查询付款方式
var queryTypeRelaUrl = baseUrl
+ "com.hsapi.frm.frmService.crud.queryfibAccountTypeRela.biz.ext";
function queryTypeRela(){
    nui.ajax({
        url : queryTypeRelaUrl,
        data : {
            token: token
        },
        type : "post",
        success : function(data) {
            if(data.errCode=="S"){
            	typeRela = data.list;
            }
        },
        error : function(jqXHR, textStatus, errorThrown) {
            //  nui.alert(jqXHR.responseText);
            console.log(jqXHR.responseText);
        }
    });
}