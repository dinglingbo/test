var webBaseUrl = webPath + contextPath + "/";
var baseUrl = apiPath + repairApi + "/";
var partUrl = apiPath + partApi + "/";
var saveUrl = apiPath + saleApi + "/sales.base.addCssGiftOutMain.biz.ext";
var updateUrl = apiPath + saleApi + "/sales.base.updateCssGiftOutMain.biz.ext";
var saveItemUrl = apiPath + saleApi + "/sales.base.addCssGiftOutItem.biz.ext";
var mGridUrl = apiPath + saleApi + "/sales.base.searchCssGiftOutMain.biz.ext";
var mItemUrl = apiPath + saleApi + "/sales.base.searchCssGiftOutItem.biz.ext";
var jpDetailGridUrl = apiPath + saleApi + "/sales.search.searchSaleGiftApply.biz.ext";
var repairOutGridUrl =  partUrl + "com.hsapi.part.invoice.partInterface.queryEnbleRtnPart.biz.ext";
var sellTypeArr = [{ id: 1, text: "库存车" }, { id: 2, text: "销售车" }];
var returnSignData = [{id:0,text:"否"},{id:1,text:"是"}];
var costList = [{ id: 0, name: "免费" }, { id: 1, name: "收费" }];
var form = {};
var mainGrid = {};
var itemGrid = {};
var repairOutGrid = null;
var memList = [];
var servieTypeList = [];
var startDateEl = null;
var endDateEl = null;
var jpDetailGrid = null;
var storehouse = null;
var storeHash = {};
$().ready(function (H) {
    form = new nui.Form("form1");
    startDateEl = nui.get("startDate");
    endDateEl = nui.get("endDate");
    mainGrid = nui.get("mainGrid");
    itemGrid = nui.get("itemGrid");
    repairOutGrid = nui.get("repairOutGrid");
    mainGrid.setUrl(mGridUrl);
    itemGrid.setUrl(mItemUrl);
    repairOutGrid.setUrl(repairOutGridUrl);
    jpDetailGrid = nui.get("jpDetailGrid");
    jpDetailGrid.setUrl(jpDetailGridUrl);
    quickSearch(4);

    initMember("worker", function () {
        memList = nui.get("worker").getData();
    });

    initServiceType("serviceTypeId",function(data) {
        servieTypeList = nui.get("serviceTypeId").getData();
    });

    getAllStorehouse(function(data) {
		storehouse = data.storehouse || [];
		if (storehouse && storehouse.length > 0) {
			FStoreId = storehouse[0].id;
			storehouse.forEach(function(v) {
				storeHash[v.id] = v;
			});
		}
    });

    mainGrid.on("rowclick", function (e) {
        var record = e.record;
        form.setData(record);
        nui.get("giftServiceCode").setText(record.serviceCode);
        nui.get("saleCode").setText(record.saleCode);
        nui.get("saleCode").setValue(record.saleCode);
        nui.get("enterId").setText(record.enterId);
        nui.get("enterId").setValue(record.enterId);
        var params = {
            serviceId: record.id
        };
        itemGrid.load({ params: params });
        jpDetailGrid.load({ billType: 2, serviceId: record.saleId });
        repairOutGrid.load({serviceId:record.id,billTypeId:'050208',returnSign:0,token:token});
    });
    mainGrid.on("drawcell", function (e) {
        var value = e.value;
        switch (e.field) {
            case "status":
                e.cellHtml = (value == 0 ? '草稿' : '已审核');
                break;
            case "sellType":
                e.cellHtml = (value == 1 ? '库存车' : '销售车');
                break;
            default:
                break;
        }
    });
    
    itemGrid.on("cellbeginedit", function (e) {
        var editor = e.editor;
        if (e.field == 'worker') {
            editor.setData(memList);
        }
        if (e.field == 'receType') {
            editor.setData(costList);
        }
    });

    itemGrid.on("drawcell", function (e) {
        if (e.field == 'serviceTypeId') {
            e.cellHtml = setColVal('serviceTypeId', 'id', 'name', e.value);
        }
    });


    repairOutGrid.on("drawcell", function (e) {
        var th = '<a class="optbtn" href="javascript:THSave()">退货</a>';
        if (e.field == "storeId") {
        	if (storeHash[e.value]) {
				e.cellHtml = storeHash[e.value].name || "";
			} else {
				e.cellHtml = "";
			}
        }else if(e.field == "action"){
        	 e.cellHtml = th;
        }
    });

    jpDetailGrid.on("drawcell", function(e) {
        var field = e.field;
        if (field == "receType") {
            if (e.value == 0 || e.value == 1) {
                e.cellHtml = costList.find(costList => costList.id == e.value).name;
            }
        }
    });
    
});

function onGenderRenderer(e) {
    for (var i = 0, l = returnSignData.length; i < l; i++) {
        var g = returnSignData[i];
        if (g.id == e.value) return g.text;
    }
    return "";
}

function updateMainStatus(e) {
    var row = mainGrid.getSelected();
    var showText = '';
    var showTextErr = '';
    if (!row) {
        showMsg('请先选中一条数据', 'W');
        return;
    }
    if (row.status == e) {
        showMsg('请勿重复操作', 'W');
        return;
    }
    if (e == 1) {
        showText = '审核成功';
        showTextErr = '审核失败';
    } else if (e == 0) {
        showText = '反审成功';
        showTextErr = '反审失败';
    }
    row.status = e;
    nui.ajax({
        url: updateUrl,
        type: 'post',
        data: {
            data:row
        },
        success:function (res) {
            if (res.errCode == 'S') {
                mainGrid.reload();
                showMsg(showText, 'S');
            } else {
                showMsg(showTextErr, 'E');
            }
        }
    })
}

function workChanged(e) {
    var data = e.selected;
    var row = itemGrid.getSelected();
    var newRow = {
        workerId: data.empId
    };
    itemGrid.updateRow(row, newRow);
}

function newAdd() {
    form.clear();
    nui.get("sellType").setValue(2);
    nui.get("enterId").disable();
}

function search() {
    var params = {
        startDate: nui.get("startDate").getFormValue(),
        endDate: nui.get("endDate").getFormValue()+' 23:59:59'
    }
    mainGrid.load({params:params});
}

function save(params) {
    var data = form.getData(true);
    form.validate();
    if (form.isValid() == false) {
        showMsg('请完善信息', 'W');
        return;
    }
        
    nui.ajax({
        url: saveUrl,
        type: 'post',
        data: {
            data:data
        },
        success:function (res) {
            if (res.errCode == 'S') {
                nui.get("id").setValue(res.res.id);
                mainGrid.reload();
                showMsg('保存成功', 'S');
            }
        }
    })
}

function onSaleEdit(params) {
        nui.open({
        url: webPath + contextPath + '/sales/base/selectSellCar.jsp',
        title: '选择销售单',
        width: 1000,
        height: 500,
        onload: function () {
          var iframe = this.getIFrameEl();
          //iframe.contentWindow.setData(row);
        },
        ondestroy: function (action) {
            var iframe = this.getIFrameEl();
            if(action == 'ok'){
                var row = iframe.contentWindow.getRow();
                nui.get("saleId").setValue(row.id);
                nui.get("enterId").setValue(row.enterId);
                nui.get("enterId").setText(row.enterId);
                nui.get("saleCode").setValue(row.serviceCode);
                nui.get("saleCode").setText(row.serviceCode);
                nui.get("carModelName").setValue(row.carModelName);
                nui.get("vin").setValue(row.vin);
                nui.get("carNo").setValue(row.carNo);
                nui.get("guestName").setValue(row.guestFullName);
                nui.get("guestId").setValue(row.guestId);
                jpDetailGrid.load({ billType: 2, serviceId: row.id });
            }
        }
      });

}

function onEnterIdEdit(params) {
    nui.open({
    url: webPath + contextPath + '/sales/sales/selectCar.jsp',
    title: '选择库存车',
    width: 1000,
    height: 500,
    onload: function () {
        var iframe = this.getIFrameEl();
        var data = {
            billStatus:1,
            carStatus: 1, 
            carLock: 0
        }
      iframe.contentWindow.SetData(data,1);
    },
    ondestroy: function (action) {
        var iframe = this.getIFrameEl();
      if(action == 'ok'){
        var row = iframe.contentWindow.getSelectedValue();
        nui.get("enterId").setValue(row.id);
        nui.get("enterId").setText(row.id);
        nui.get("vin").setValue(row.vin);
        nui.get("carModelName").setValue(row.carModelName);
        // nui.get("serviceCode").setValue(row.serviceCode);
        // nui.get("serviceCode").setText(row.serviceCode);
      }
    }
  });

}

function sellTypeChanged(e) {
    var value = e.value;
    nui.get("saleCode").disable();
    nui.get("enterId").disable();
    nui.get("saleCode").setValue(null);
    nui.get("saleCode").setText(null);
    nui.get("enterId").setValue(null);
    nui.get("enterId").setText(null);
    nui.get("saleCode").setRequired(true);
    nui.get("enterId").setRequired(true);
    if (value == 1) {//库存车
        nui.get("enterId").enable();
        nui.get("saleCode").disable();
        nui.get("saleCode").setRequired(false);
    } else if (value == 2) {//销售车
        nui.get("enterId").disable();
        nui.get("saleCode").enable();
    }
}



function quickSearch(type) {
    var params = {};
    var queryname = "本日";
    switch (type) {
        case 0:
            params.today = 1;
            params.startDate = getNowStartDate();
            params.endDate = addDate(getNowEndDate(), 1);
            queryname = "本日";
            break;
        case 1:
            params.yesterday = 1;
            params.startDate = getPrevStartDate();
            params.endDate = addDate(getPrevEndDate(), 1);
            queryname = "昨日";
            break;
        case 2:
            params.thisWeek = 1;
            params.startDate = getWeekStartDate();
            params.endDate = addDate(getWeekEndDate(), 1);
            queryname = "本周";
            break;
        case 3:
            params.lastWeek = 1;
            params.startDate = getLastWeekStartDate();
            params.endDate = addDate(getLastWeekEndDate(), 1);
            queryname = "上周";
            break;
        case 4:
            params.thisMonth = 1;
            params.startDate = getMonthStartDate();
            params.endDate = addDate(getMonthEndDate(), 1);
            queryname = "本月";
            break;
        case 5:
            params.lastMonth = 1;
            params.startDate = getLastMonthStartDate();
            params.endDate = addDate(getLastMonthEndDate(), 1);
            queryname = "上月";
            break;

        case 10:
            params.thisYear = 1;
            params.startDate = getYearStartDate();
            params.endDate = getYearEndDate();
            queryname = "本年";
            break;
        case 11:
            params.lastYear = 1;
            params.startDate = getPrevYearStartDate();
            params.endDate = getPrevYearEndDate();
            queryname = "上年";
            break;
        default:
            break;
    }
    startDateEl.setValue(params.startDate);
    endDateEl.setValue(addDate(params.endDate, -1));
    var menunamedate = nui.get("menunamedate");
    menunamedate.setText(queryname);
    mainGrid.load({
        params: params
    });
}


function addItem() {
    if (!nui.get("id").value) {
        showMsg('请先保存本单，再进行添加操作','W');
        return;
    }
    var row = mainGrid.getSelected();
    if (row.status == 1) {
        showMsg('本单已审核，不允许此操作','W');
        return;
    }
    nui.open({
		url : webPath + contextPath + "/com.hsweb.repair.DataBase.itemChoose.flow?token=" + token,
		title : "维修项目",
		width : 1000,
		height : 560,
		allowDrag : true,
		allowResize : true,
		onload : function() {
			var iframe = this.getIFrameEl();
            iframe.contentWindow.giftSetData(1);//显示该显示的功能
            //iframe.contentWindow.setViewData(dock, dodelck, docck);
		},
		ondestroy : function(action) {
            var iframe = this.getIFrameEl();
            var data = iframe.contentWindow.getData();
            data = data || {};
            if (action == 'ok') {
                //debugger;
                var newRow = {
                    itemId: data.id,
                    itemCode:data.code,
                    itemName: data.name,
                    itemTime: data.itemTime,
                    amt: data.unitPrice,
                    serviceTypeId:data.serviceTypeId
                    
                }
                itemGrid.addRow(newRow);
            }
		}
	});
}



function removeItem() {
    var row = mainGrid.getSelected();
    if (row.status == 1) {
        showMsg('本单已审核，不允许此操作','W');
        return;
    }
    var row = itemGrid.getSelected();
    itemGrid.removeRow(row);
}

function saveItem() {
    if (!nui.get("id").value) {
        showMsg('请先保存本单，再进行保存工时操作','W');
        return;
    }
    var row = mainGrid.getSelected();
    if (row.status == 1) {
        showMsg('本单已审核，不允许此操作','W');
        return;
    }
    var addArr = [];
    var addList = itemGrid.getChanges("added");
	var updateList = itemGrid.getChanges("modified");
    var delArr = itemGrid.getChanges('removed');

    for (var i = 0; i < addList.length; i++) {
        var data = addList[i];
        var temp = {
            serviceId: nui.get("id").value,
            itemId:data.itemId,
            itemCode:data.itemCode,
            itemName:data.itemName,
            serviceTypeId:data.serviceTypeId,
            itemTime:data.itemTime,
            unitPrice:data.unitPrice,
            amt:data.amt,
            deductAmt:data.deductAmt,
            workerId:data.workerId,
            worker:data.worker,
            status:data.status,
            remark:data.remark
        };
        addArr.push(temp);
    }

    nui.mask({
		el : document.body,
		cls : 'mini-mask-loading',
		html : '保存中...'
	});

	nui.ajax({
		url : saveItemUrl,
		type : "post",
		data : JSON.stringify({
			addList : addArr,
            updateList: updateList,
            removeList:delArr,
			token: token
		}),
		success : function(data) {
			nui.unmask(document.body);
			data = data || {};
			if (data.errCode == "S") {
				showMsg("保存成功!","S");
			} else {
				showMsg(data.errMsg || "保存失败!","E");
            }
            var params = {
                serviceId: nui.get("id").value
            };
            itemGrid.load({ params: params });
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log(jqXHR.responseText);
		}
	});
}

function selectGift() {
    var row = mainGrid.getSelected();
    if (row.status == 1) {
        showMsg('本单已审核，不允许此操作','W');
        return;
    }
    var row = mainGrid.getSelected();
    row.carNo = nui.get("carNo").value;
    row.carId = nui.get("enterId").value;
    row.vin = nui.get("vin").value;
	nui.open({
		url: webBaseUrl + "repair/RepairBusiness/Reception/partSelectB.jsp?token="+token,
		title:"选择精品",
		height:"400px",
		width:"1150px",
		onload:function(){
			var iframe = this.getIFrameEl();
			//iframe.contentWindow.SetData(par,type,id,row,srow,pickType);
			iframe.contentWindow.SetData('','','',row,'','');
		},
		ondestroy:function(action){ 
            repairOutGrid.load({
                serviceId: nui.get("id").value,
                billTypeId: '050208',
                returnSign: 0,
                token: token
            });
        }

    });
}

var getStorehouseUrl = apiPath + partApi 
+ "/com.hsapi.part.baseDataCrud.crud.getStorehouse.biz.ext";
function getAllStorehouse(callback) {
	doPost({
		url : getStorehouseUrl,
		data : {token: token},
		success : function(data) {
			callback && callback(data);
		},
		error : function(jqXHR, textStatus, errorThrown) {
			// nui.alert(jqXHR.responseText);
			console.log(jqXHR.responseText);
			callback && callback({});
		}
	});
}


function THSave(){
	// if(status==2){
	// 	showMsg("单据已完工，维修出库不能退货","W");
	// 	return;
	// }
	// if(status==0){
	// 	showMsg("草稿状态下的单据不能领料","W");
	// 	return;
	// }
	var rows = repairOutGrid.getSelecteds();
	if (rows.length > 0) {
		for (var i = 0; i < rows.length; i++) {
			if(rows[i].returnSign == 0){
				memberSelect(rows[i]);
			}else{
				showMsg('该条数据已归库!','W');
				return;
			}
		}
	}else{
		showMsg('请先选择需要归库的精品!','W');
	}

}

function memberSelect(row){
    // if(status==2){
    //     showMsg("本工单已完工,配件不能归库","W");
    //     return;
    // }
    nui.open({
        url: webBaseUrl + "com.hsweb.RepairBusiness.partSelectMember.flow?token="+token,
        title:"精品归库",
        height:"300px",
        width:"600px",
        onload:function(){
            var iframe = this.getIFrameEl();
            iframe.contentWindow.SetData("th");
        },
        ondestroy:function(action){
            if (action == "ok") {
                var iframe = this.getIFrameEl();
                var childdata = iframe.contentWindow.GetFormData();
                savepartOutRtn(row,childdata);
                //savePartOut();     //如果点击“确定”
                //CloseWindow("close");
            }
            
        }

    });

}


function  savepartOutRtn(data,childdata){
	if(data){
		var paramsDataArr = [];
        //var paramsData = nui.clone(data);
        var paramsData = {};
        paramsData.serviceId = data.serviceId;
        paramsData.id = data.id;
        paramsData.mainId = data.mainId;
        paramsData.sourceId = data.id;
        paramsData.serviceId = nui.get("id").value;
        paramsData.serviceCode = nui.get("giftServiceCode").value;
        paramsData.carNo = nui.get("carNo").value;
        paramsData.carId = nui.get("enterId").value;
        paramsData.vin = nui.get("vin").value;
        paramsData.partId = data.partId;
        paramsData.partCode = data.partCode;
        paramsData.oemCode = data.oemCode;
        paramsData.partName = data.partName;
        paramsData.partNameId = data.partNameId;
        paramsData.partFullName = data.partFullName;
        paramsData.stockQty = data.stockQty;
        paramsData.outQty = data.outQty;
        paramsData.enterPrice = data.enterPrice;
        paramsData.billTypeId = '050208';
        paramsData.storeId = data.storeId;
        paramsData.unit = data.systemUnitId;
        paramsData.pickMan = data.pickMan;
        paramsData.returnMan=childdata.mtAdvisor;
        paramsData.returnRemark = childdata.remark;
        //paramsData.pickType = "维修出库-领料";
        paramsData.taxUnitPrice = data.taxUnitPrice;
        paramsData.taxAmt = data.taxAmt;
        paramsData.noTaxUnitPrice = data.noTaxUnitPrice;
        paramsData.noTaxAmt = data.noTaxAmt;
        paramsData.trueUnitPrice = data.trueUnitPrice;
        paramsData.trueCost = data.trueCost;
        paramsData.sellUnitPrice = data.sellUnitPrice; 
        paramsData.sellAmt = data.sellAmt;
        paramsData.guestId = nui.get("guestId").value;
        paramsData.guestName = nui.get("guestName").value;
        
        if(!paramsData.partNameId){
            paramsData.partNameId = "0";
        }
        paramsDataArr.push(paramsData);

        nui.mask({
            el: document.body,
            cls: 'mini-mask-loading',
            html: '数据处理中...'
        });
        nui.ajax({
            url:baseUrl + "com.hsapi.repair.repairService.work.repairOutRtn.biz.ext",
            type:"post",
            data:{
                data:paramsDataArr,
                billTypeId:"050208", 
                token:token
            },
            success:function(text){
                var errCode = text.errCode;
                nui.unmask(document.body);
                if(errCode == "S"){
                    repairOutGrid.load({
                        serviceId: nui.get("id").value,
                        billTypeId: '050208',
                        returnSign: 0,
                        token: token
                    });
                    showMsg('归库成功!','S');
                }else{
                    showMsg(text.errMsg ||'归库失败!','W');
                }
            }
        });
    }else{
        showMsg('没有需要归库的精品!','W');
    }
}
